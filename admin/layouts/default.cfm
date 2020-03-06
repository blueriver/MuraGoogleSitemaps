<cfsilent>
<!---

This file is part of the BlueRiver Inc. Google Sitemaps Plugin

Copyright 2017 BlueRiver Inc.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

--->
	
	<cfsavecontent variable="local.alerts">
		<cfif StructKeyExists(rc, 'errors') and IsArray(rc.errors) and ArrayLen(rc.errors)>
			<div class="alert alert-error">
				<button type="button" class="close" data-dismiss="alert"><i class="mi-close"></i></button>
				<h2>Alert!</h2>
				<h3>Please note the following message<cfif ArrayLen(rc.errors) gt 1>s</cfif>:</h3>
				<ul>
					<cfloop from="1" to="#ArrayLen(rc.errors)#" index="local.e">
						<li>
							<cfif IsSimpleValue(rc.errors[local.e])>
								<cfoutput>#rc.errors[local.e]#</cfoutput>
							<cfelse>
								<cfdump var="#rc.errors[local.e]#" />
							</cfif>
						</li>
					</cfloop>
				</ul>
			</div><!--- /.alert --->

		<!--- if no errors --->
		<cfelseif structCount(form)>
			<div class="alert alert-success">
				<cfif rc.action eq 'admin:generate.default'>
					<span>Sitemap generated!</span>
				<cfelse>
					<span>Settings saved!</span>
				</cfif>
			</div>	
		</cfif>
	
	</cfsavecontent>
	<cfscript>
		param name="rc.compactDisplay" default="false";
	</cfscript>

	<cfsavecontent variable="local.cssinclude">
	<cfoutput>
		<script>
		Mura(function(m) {
			m.loader()
			.loadcss('#rc.$.globalConfig('context')#/plugins/MuraGoogleSitemaps/assets/css/gsm.css');
		});
		</script>
	</cfoutput>
	</cfsavecontent>
	<cfset local.pluginPath = GetDirectoryFromPath(GetCurrentTemplatePath()) />
	<cfset local.muraroot = Left(local.pluginPath, Find('plugins', local.pluginPath) - 1) />
</cfsilent>

<cfsavecontent variable="local.newBody">
	<cfoutput>
		<script src="/plugins/MuraGoogleSitemaps/assets/js/vue.js" type="text/javascript"></script>

			#trim(local.alerts)#

			<div class="mura-header">
				<h1>Google Sitemaps</h1>
			</div>
			<div class="block block-constrain">
		    <ul class="mura-tab-links nav-tabs">
					<li<cfif rc.action eq 'admin:main.default'> class="active"</cfif>>
						<a href="#buildURL(action='', path='./')#">Home</a>
					</li>
					<li<cfif rc.action eq 'admin:generate.default'> class="active"</cfif>>
						<a href="#buildURL(action='admin:generate', path='./')#">Generate</a>
					</li>
					<li<cfif rc.action eq 'admin:news.default'> class="active"</cfif>>
						<a href="#buildURL(action='admin:news', path='./')#">News</a>
					</li>
					<cfif rc.hasTranslationManager>
						<li<cfif rc.action eq 'admin:translations.default'> class="active"</cfif>>
							<a href="#buildURL(action='admin:translations', path='./')#">Translations</a>
						</li>
					</cfif>
					<li<cfif rc.action eq 'admin:settings.default'> class="active"</cfif>>
						<a href="#buildURL(action='admin:settings', path='./')#">Settings</a>
					</li>
		    </ul>
		    <div class="block-content tab-content">
		        <div class="tab-pane active" id="tabA"> 
		            <div class="block block-bordered"> 
		                <div class="block-content">
		                   #body#            
		                </div> <!-- /.block-content -->
		            </div> <!-- /.block-bordered -->
		        </div> <!-- /.tab-pane -->
		    </div> <!-- /.block-content.tab-content -->			 
			</div> <!-- /.block.block-constrain -->

		<cfif DirectoryExists(local.muraroot & 'core')>
			<!--- Using 7.1 --->
			#local.cssinclude#
		<cfelse>
			<!--- Pre 7.1 --->
			<cfhtmlhead text="<link href=""#rc.$.globalConfig('context')#/plugins/MuraGoogleSitemaps/assets/css/gsm.css"" rel=""stylesheet"" type=""text/css"" />" />
		</cfif>
	</cfoutput>
</cfsavecontent>
<cfoutput>
	#application.pluginManager.renderAdminTemplate(
		body=local.newBody
		,pageTitle=rc.pc.getName()
		,compactDisplay=rc.compactDisplay
	)#
</cfoutput>
