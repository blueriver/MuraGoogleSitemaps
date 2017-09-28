<cfsilent>
<!---

This file is part of the BlueRiver Inc. Google Sitemaps Plugin

Copyright 2017 BlueRiver Inc.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

--->
</cfsilent>
<cfoutput>
	<cfif not	rc.gsmsettings.get("isEnabled")>
		<div class="alert alert-error">
			Note that Google Sitemaps is not currently enabled for this site.
		</div>
	</cfif>

	<h1>Google Sitemaps</h1>
	<h3>About</h3>
	<p>Google Sitemaps is a plugin that automates sitemap generation for your Mura CMS website.</p>

	<p>The plugin will generate on demand or on a scheduled basis a sitemap.xml (as well as other specialized sitemap files) based upon the configuration information you have set for each page.
		By default all pages are included in the Google sitemap, but you can configure these settings under the "Sitemap" tab for each content page.</p>


</cfoutput>
