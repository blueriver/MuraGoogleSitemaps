
<cfcomponent component extends="mura.cfobject" displayname="GoogleSitemapsManager" output="false" hint="Google Sitemaps Manager">
	<cffunction name="getSitemapXML" returntype="xml" access="public" output="false">
		<cfargument name="$" type="any" required="true" />
		<cfargument name="siteID" type="string" required="false" />

		<cfreturn xmlParse( getSiteMap( argumentCollection=arguments ) ) />
	</cffunction>

	<cffunction name="getFeedList" returntype="query" access="public" output="false">
		<cfargument name="$" type="any" required="true" />
		<cfargument name="siteID" type="string" required="false" />

		<cfset qFeedList = "" />

		<cfquery name="qFeedList" datasource="#$.GlobalConfig().get('datasource')#" username="#$.GlobalConfig().get('dbusername')#" password="#$.GlobalConfig().get('dbpassword')#">
			SELECT * from tcontentfeeds
		</cfquery>

		<cfreturn qFeedList />
	</cffunction>

	<cffunction name="schedule" access="public" output="false">
		<cfargument name="$" type="any" required="true" />
		<cfargument name="siteID" type="string" required="false" />
		<cfargument name="enable" type="boolean" required="false" default="true" />

		<cfset var settings = arguments.$.getBean('gsmsettings').loadBy(siteid = arguments.siteid) />
		<cfset var pluginConfig = arguments.$.getPlugin("MuraGoogleSitemaps") />
		<cfset var timeOfDay			= createDateTime(2011,1,1,3,0,0) />

		<cfset var processURL		= "http://#arguments.$.siteConfig('domain')##arguments.$.globalConfig().getServerPort()##arguments.$.globalConfig('context')#/plugins/#pluginConfig.getDirectory()#/?gsm=process:&site=#siteID#" />
		
		<cfif arguments.enable>
			<cfschedule
				action="update"
				task="Mura Google Sitemaps #arguments.$.siteConfig('domain')# - #arguments.siteID#"
				interval="#settings.get("frequency")#"
				url="#processURL#"
				operation="HTTPRequest"
				startdate="#dateFormat(now(),"mm/dd/yy")#"
				starttime="#timeFormat( timeOfDay,"hh:mm TT" )#"
				resolveurl="true"
				requesttimeout="1000"
				>
		<cfelse>
			<cfschedule
				action="delete"
				task="Mura Google Sitemaps #arguments.$.siteConfig('domain')# - #arguments.siteID#">
		</cfif>
	</cffunction>


	<cffunction name="getSitemap" returntype="string" access="public" output="false">
		<cfargument name="$" type="any" required="true" />
    <cfargument name="siteID" type="string" required="false" />
    <cfargument name="isNews" type="boolean" required="false" default="false" />

		<cfset var site = $.getBean('site').loadby(siteid=siteid)>
		<cfset var gsmsettings = $.getBean('gsmsettings').loadby(siteid=siteid)>
		<cfset var translations = $.getPlugin('muratranslations')>
		<cfset var translationsid = translations.getPluginID()>

		<cfset var useSiteID	= iif( structKeyExists(arguments,"siteID"),de(arguments.siteID),de(session.siteid) ) />
		<cfset var qAtts		= "" />
		<cfset var qList		= "" />
		<cfset var qValues		= "" />
		<cfset var sValues		= StructNew() />
		<cfset var xmlStr		= "" />
		<cfset var isExempt		= false />
		<cfset var strXML		= "" />
		<cfset var strXMLBlock	= "" />
		<cfset var sitemapXML 	= XmlNew(true)>
		<cfset var exemptHash	= StructNew()>
		<cfset var valueHash	= StructNew()>
		<cfset var langoutput = "" />
		<cfset var langcontent = "" />
		<cfset var sites = {} />
		<cfset var siteProtocol = $.getBean('settingsManager').getSite(arguments.siteID).getUseSSL() ? 'https://' : 'http://'>

		<cfif useSiteID neq arguments.$.event().getValue('siteid')>
			<cfset arguments.$ = application.serviceFactory.getBean('muraScope').init(useSiteID) />
		</cfif>

<cfsavecontent variable="strXML"><cfoutput><?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
  xmlns:xhtml="http://www.w3.org/1999/xhtml"></cfoutput></cfsavecontent>

		<cfquery name="qAtts" datasource="#$.GlobalConfig().get('datasource')#" username="#$.GlobalConfig().get('dbusername')#" password="#$.GlobalConfig().get('dbpassword')#">
			SELECT
				tclassextenddata.baseID,tclassextenddata.attributeID,tclassextenddata.attributeValue,tclassextendattributes.name
			FROM
				tclassextenddata
			JOIN
				tclassextendattributes
				ON
					tclassextendattributes.attributeID = tclassextenddata.attributeID
			JOIN
				tclassextendsets
				ON
					tclassextendsets.extendSetID = tclassextendattributes.extendSetID
			JOIN
				tclassextend
				ON
					tclassextend.subTypeID = tclassextendsets.subTypeID
				AND
					tclassextend.subtype = 'Default'
			AND
				(
					tclassextend.type = 'Page'
				OR
					tclassextend.type = 'Portal'
				OR
					tclassextend.type = 'Folder'
				OR
					tclassextend.type = 'Calendar'
				OR
					tclassextend.type = 'Gallery'
				OR
					tclassextend.type = 'File'
				)
			WHERE
				tclassextendattributes.siteid = <cfqueryparam value="#useSiteID#" cfsqltype="cf_sql_varchar" maxlength="25">
			AND
				tclassextenddata.baseID != <cfqueryparam value="#useSiteID#" cfsqltype="cf_sql_varchar" maxlength="25">
		</cfquery>

		<cfquery name="qList" datasource="#$.GlobalConfig().get('datasource')#" username="#$.GlobalConfig().get('dbusername')#" password="#$.GlobalConfig().get('dbpassword')#">
			SELECT
				tcontent.contentID,tcontent.contentHistID,tcontent.filename,tcontent.lastupdate,attributeValue AS isExclude,tcontent.path
			FROM
				tcontent
			JOIN
				tclassextend
				ON
					tclassextend.siteID = <cfqueryparam value="#useSiteID#" cfsqltype="cf_sql_varchar" maxlength="25">
				AND
					tcontent.type = tclassextend.type
				AND
					tclassextend.subtype = 'Default'
			JOIN
				tclassextendsets
				ON
					tclassextend.subTypeID = tclassextendsets.subTypeID
			JOIN
				tclassextendattributes
				ON
					tclassextendsets.extendsetID = tclassextendattributes.extendsetID
				AND
					tclassextendattributes.name = 'exclude'
			LEFT JOIN
				tclassextenddata
				ON
					tclassextendattributes.attributeID = tclassextenddata.attributeID
				AND
					tclassextenddata.baseID = tcontent.contentHistID
			WHERE
				tcontent.siteid = <cfqueryparam value="#useSiteID#" cfsqltype="cf_sql_varchar" maxlength="25">
			AND
				(
					tclassextend.type = 'Page'
				OR
					tclassextend.type = 'Portal'
				OR
					tclassextend.type = 'Folder'
				OR
					tclassextend.type = 'Calendar'
				OR
					tclassextend.type = 'Gallery'
				OR
					tclassextend.type = 'File'
				)
			AND
				tcontent.approved = 1
			AND
				tcontent.active = 1
			AND
				(
				tcontent.display = 1
				OR
					(
						tcontent.display = 2
						AND
						<cfif application.configBean.getDbType() eq "mysql">
							tcontent.displaystart <= CURDATE()
						<cfelse>
							tcontent.displaystart <= #CreateODBCDateTime( now() )#
						</cfif>
					)
				)
		</cfquery>

		<cfloop query="qList">
			<cfset sValues = StructNew() />
			<cfif len(qList.isExclude)>
				<cfif qList.isExclude eq 'inherit'>
					<cfif qList.path eq qList.contentID>
						<cfset isExempt = qList.contentHistID />
					<cfelse>
						<cfset isExempt = getInherit( qAtts,qList,qList.path,exemptHash )>
					</cfif>
				<cfelseif qList.isExclude eq 'no'>
					<cfset isExempt = false />
					<cfset sValues = getValues( qAtts,qList.contentHistID,valueHash ) />
				<cfelse>
					<cfset isExempt = true />
				</cfif>
			<cfelse>
				<cfset isExempt = getInherit( qAtts,qList,qList.path,exemptHash )>
			</cfif>

			<cfif isExempt eq true>
				<!--- skip, do nothing --->
			<cfelseif isExempt eq false>
				<cfset sValues = getValues( qAtts,qList.contentHistID,valueHash ) />
			<cfelse>
				<cfset sValues = getValues( qAtts,isExempt,valueHash ) />
			</cfif>

			<cfif not StructKeyExists( sValues,'priority' )>
				<cfset sValues.priority = "0.5" />
			</cfif>
			<cfif not StructKeyExists( sValues,'changefrequency' )>
				<cfset sValues.changefrequency = "monthly" />
			</cfif>

			<cfif len(gsmsettings.getSiteList())>
				<cfquery name="qTrans" datasource="#$.GlobalConfig().get('datasource')#" username="#$.GlobalConfig().get('dbusername')#" password="#$.GlobalConfig().get('dbpassword')#">
						SELECT
							remoteid,remotesiteid
						FROM
							p#translationsid#_translationmaps
						WHERE
							p#translationsid#_translationmaps.localid =
							<cfqueryparam value="#contentid#" cfsqltype="CF_SQL_VARCHAR" maxlength="35">
						AND
							p#translationsid#_translationmaps.remotesiteid IN
							(<cfqueryparam value="#gsmsettings.getSiteList()#" cfsqltype="CF_SQL_VARCHAR" maxlength="250" list="true">)
				</cfquery>

				<cfset langcontent = "">
				<cfset langoutput = "">

				<cfif qTrans.recordcount>
					<cfloop query="qTrans">
						<cfset langcontent = $.getBean('content').loadBy(contentid = remoteid,siteid=remotesiteid)>
						<cfif not structKeyExists(sites,remotesiteid)>
							<cfset sites[remotesiteid] = $.getBean('site').loadBy(siteid = remotesiteid) />
						</cfif>

	<cfsavecontent variable="langoutput"><cfoutput>#langoutput#
		<xhtml:link rel="alternate" hreflang = "#sites[remotesiteid].getJavaLocale()#" href="#langcontent.getAssocURL()#" /></cfoutput></cfsavecontent>
					</cfloop>
				</cfif>
			</cfif>

			<cfif isExempt neq true>
<cfsavecontent variable="strXMLBlock"><cfoutput>
	<url><loc>#siteProtocol##arguments.$.getBean('settingsManager').getSite(arguments.siteID).getDomain()##arguments.$.globalConfig().getServerPort()##arguments.$.globalConfig().getContext()##arguments.$.getContentRenderer().getURLStem(useSiteID,qList.filename)#</loc>#langoutput#<lastmod>#dateformat(lastupdate,"yyyy-mm-dd")#</lastmod><changefreq>#sValues.changefrequency#</changefreq><priority>#sValues.priority#</priority></url></cfoutput></cfsavecontent>
				<cfset strXML = strXML & strXMLBlock />
			</cfif>
		</cfloop>

		<cfset strXML = strXML & "
</urlset>" />
		<cfreturn trim(strXML) />
	</cffunction>

	<cffunction name="getValues" returntype="Struct" access="public" output="false">
		<cfargument name="qAtts" type="query" required="true" />
		<cfargument name="contentHistID" type="string" required="true" />
		<cfargument name="valueHash" type="struct" required="true" />

		<cfset var qValues	= "" />
		<cfset var sValues	= StructNew() />

		<cfquery name="qStatus" dbtype="query">
			SELECT
				attributeValue,name
			FROM
				arguments.qAtts
			WHERE
				baseID = <cfqueryparam value="#arguments.contentHistID#" cfsqltype="cf_sql_varchar" maxlength="35">
		</cfquery>

		<cfif qStatus.RecordCount>
			<cfloop query="qStatus">
				<cfset sValues[qStatus.name] = qStatus.attributeValue />
			</cfloop>
		</cfif>

		<cfreturn sValues />
	</cffunction>

	<cffunction name="getInherit" returntype="string" access="public" output="false">
		<cfargument name="qAtts" type="query" required="true" />
		<cfargument name="qList" type="query" required="true" />
		<cfargument name="contentHistIDList" type="string" required="true" />
		<cfargument name="exemptHash" type="struct" required="true" />

		<cfset var aIDList		= listToArray( arguments.contentHistIDList ) />
		<cfset var iiX			= "" />
		<cfset var qContentID	= "" />
		<cfset var qStatus		= "" />
		<cfset var isExempt		= "" />

		<cfloop from="#ArrayLen(aIDList)#" to="1" step="-1" index="iiX">
			<cfif StructKeyExists( exemptHash,aIDList[iiX] )>
				<cfset isExempt = exemptHash[ aIDList[iiX] ] />
			<cfelse>
				<cfquery name="qContentID" dbtype="query" maxrows="1">
					SELECT
						contentHistID
					FROM
						arguments.qList
					WHERE
						contentID = <cfqueryparam value="#aIDList[iiX]#" cfsqltype="cf_sql_varchar" maxlength="35">
				</cfquery>
				<cfquery name="qStatus" dbtype="query" maxrows="1">
					SELECT
						attributeValue AS isExclude
					FROM
						arguments.qAtts
					WHERE
						baseID = <cfqueryparam value="#qContentID.contentHistID#" cfsqltype="cf_sql_varchar" maxlength="35">
					AND
						name = 'exclude'
				</cfquery>
				<cfif qStatus.recordCount>
					<cfset exemptHash[ aIDList[iiX] ] = qStatus.isExclude />
				<cfelse>
					<cfset exemptHash[ aIDList[iiX] ] = "null" />
				</cfif>
			</cfif>

			<cfset isExempt = exemptHash[ aIDList[iiX] ] />

			<cfif isExempt neq "null">
				<cfif isExempt eq 'Yes'>
					<cfreturn true />
					<cfbreak />
				<cfelseif isExempt eq 'No'>
					<cfreturn isExempt />
					<cfbreak />
				</cfif>
			</cfif>
		</cfloop>
		<cfreturn false />
	</cffunction>

</cfcomponent>
