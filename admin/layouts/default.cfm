<cfsilent>
<!---

This file is part of the BlueRiver Inc. Google Sitemaps Plugin

Copyright 2017 BlueRiver Inc.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

--->
	<cfsavecontent variable="local.errors">
		<cfif StructKeyExists(rc, 'errors') and IsArray(rc.errors) and ArrayLen(rc.errors)>
			<div class="alert alert-error">
				<button type="button" class="close" data-dismiss="alert"><i class="icon-remove-sign"></i></button>
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
		</cfif>
	</cfsavecontent>
	<cfscript>
		param name="rc.compactDisplay" default="false";
		body = local.errors & body;
	</cfscript>
</cfsilent>
<cfsavecontent variable="local.newBody">
	<cfoutput>
		<script src="/plugins/googlesitemaps/assets/js/vue.js" type="text/javascript"></script>
		<div class="container-murafw1">

			<div class="mura-header">
				<h1>Google Sitemaps</h1>
			</div>

			<!--- PRIMARY NAV --->
			<div class="row-fluid">
				<div class="navbar navbar-murafw1">
					<div class="navbar-inner">

						<div>
							<ul class="nav nav-tabs" role="tablist">
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
						</div>

					</div><!--- /.navbar-inner --->
				</div><!--- /.navbar --->
			</div><!--- /.row --->

			<!--- MAIN CONTENT AREA --->
			<div class="row-fluid">
					<!--- BODY --->
					<div class="span12">
						#body#
					</div>
			</div><!--- /.row --->
		</div><!--- /.container-murafw1 --->
	</cfoutput>
</cfsavecontent>
<cfoutput>
	#application.pluginManager.renderAdminTemplate(
		body=local.newBody
		,pageTitle=rc.pc.getName()
		,compactDisplay=rc.compactDisplay
	)#
	<script>
    Mura(function(m) {
      m.loader()
        .loadcss('#rc.$.globalConfig('context')#/plugins/googlesitemaps/assets/css/gsm.css');

    });
  </script>
</cfoutput>
