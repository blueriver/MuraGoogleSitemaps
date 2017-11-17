/*

This file is part of the BlueRiver Inc. Google Sitemaps Plugin

Copyright 2017 BlueRiver Inc.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

*/
component persistent="false" accessors="true" output="false" extends="controller" {

	// *********************************  PAGES  *******************************************

	public any function default(required rc) {
		// rc.varName = 'whatever';

		if(structCount(form)) {
			generateSitemap( rc );
		}

	}

	private function generateSitemap( required rc ) {

		rc.siteid					= session.siteid;

		var siteid					= session.siteid;
		var siteConfig			= rc.$.getBean('settingsManager').getSite(siteid);
		var mailer				= rc.$.getBean("mailer");
		var tickCount			= getTickCount();
		var msg					= "";
		var fileName				= "";
		var sitemapManager		= $.getBean('GoogleSitemapsManager');
		var sitemapXML			= sitemapManager.getSitemap(rc.$,rc.siteid);

		rc.gsmsettings.setValue('datelastgenerate',now());
		rc.gsmsettings.save();

		if(rc.gsmsettings.getValue('location') eq "web") {
			filename = "#expandPath(application.configBean.getContext() & '/')#sitemap.xml";
			rc.fileURL	= "http://#siteConfig.getDomain()##rc.$.globalConfig().getServerPort()##rc.$.globalConfig().getContext()#/sitemap.xml";
		}
		else if(rc.gsmsettings.getValue('location') eq "site") {

			if(directoryExists("#expandPath(application.configBean.getContext() & '/')##siteid#")) {
				filename ="#expandPath(application.configBean.getContext() & '/')##siteid#/sitemap.xml";
				rc.fileURL	= "http://#siteConfig.getDomain()##rc.$.globalConfig().getServerPort()##rc.$.globalConfig().getContext()#/#siteid#/sitemap.xml";
			}
			else {
				filename ="#expandPath(application.configBean.getContext() & '/')#/sites/#siteid#/sitemap.xml";
				rc.fileURL	= "http://#siteConfig.getDomain()##rc.$.globalConfig().getServerPort()##rc.$.globalConfig().getContext()#/sites/#siteid#/sitemap.xml";
			}
		}
		else {
			filename =expandPath("#rc.gsmsettings.getValue('customlocation')#/sitemap.xml");
			rc.fileURL	= "";
		}

		try {
			file action="write" file="#filename#" output="#sitemapXML#";
		}
		catch(any e) {
			if(rc.gsmsettings.getValue('location') eq "web") {
				filename = expandPath("./../../sitemap.xml");
			}
			else {
				if(directoryExists(expandPath("./../../#siteid#/"))) {
					filename = expandPath("./../../#siteid#/sitemap.xml");
				}
				else {
					filename = expandPath("./../../sites/#siteid#/sitemap.xml");
				}
			}
			file action="write" file="#filename#" output="#sitemapXML#";
		}

			<!---
			<cftry>
			<cfset mailer.sendHTML(msg,
				#rc.gsmsettings.getValue('Email')#,
				"",
				"Google Sitemap for #siteConfig.getDomain()# - #site# complete.",
				site,
				siteConfig.getContactEmail() ) />
			<cfcatch></cfcatch>
			</cftry>
		</cfif>
		--->
		rc.time = (getTickCount()-tickCount);
	}

}
