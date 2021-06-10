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

		var siteid					= structKeyExists(url,"site") ? url.site : session.siteid;
		var siteConfig			= rc.$.getBean('settingsManager').getSite(siteid);
		var mailer				= rc.$.getBean("mailer");
		var tickCount			= getTickCount();
		var msg					= "";
		var fileName				= "";
		var sitemapManager		= $.getBean('GoogleSitemapsManager');
		var sitemapXML			= sitemapManager.getSitemap(rc.$,siteid);


		rc.gsmsettings.setValue('datelastgenerate',now());

		rc.gsmsettings.save();


		if(rc.gsmsettings.getValue('location') eq "web") {
			filename = "#expandPath(application.configBean.getContext() & '/')#sitemap.xml";
			rc.fileURL	= "http://#siteConfig.getDomain()##rc.$.globalConfig().getServerPort()##rc.$.globalConfig().getContext()#/sitemap.xml";
		}
		else {
			filename ="#expandPath(application.configBean.getContext() & '/')##siteid#/sitemap.xml";
			rc.fileURL	= "http://#siteConfig.getDomain()##rc.$.globalConfig().getServerPort()##rc.$.globalConfig().getContext()#/#siteid#/sitemap.xml";
		}
		try {
			fileWrite(filename,sitemapXML);
		}
		catch(any e) {
			// writeDump(e);abort;
			if(rc.gsmsettings.getValue('location') eq "web") {
				filename = expandPath("../../sitemap.xml");
			}
			else {
				filename = expandPath("../../#siteid#/sitemap.xml");
			}
			fileWrite(filename,sitemapXML);
		}

		if( len( rc.gsmsettings.getValue('notifyemail') ) )  {

			try {
				mailer.sendHTML(msg,
					#rc.gsmsettings.getValue('notifyemail')#,
					"",
					"Google Sitemap for #siteConfig.getDomain()# - #siteid# complete.",
					siteid,
					siteConfig.getContactEmail() );
			}
			catch( any e ) {
					// writeDump(e);
					// abort;
			}
		}


		rc.time = (getTickCount()-tickCount);


	}

}
