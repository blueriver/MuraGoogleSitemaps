/*

This file is part of the BlueRiver Inc. Google Sitemaps Plugin

Copyright 2017 BlueRiver Inc.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

	NOTES:
		All ADMIN controllers should EXTEND this file.

*/
component persistent="false" accessors="true" output="false" extends="mura.cfobject" {

	property name='$';
	property name='fw';

	public any function init (required any fw) {
		setFW(arguments.fw);
	}

	public any function before(required struct rc) {
		if ( StructKeyExists(rc, '$') ) {
			var $ = rc.$;
			var plugin = $.getPlugin("MuraTranslations");

			set$(rc.$);

			$.addToHTMLHeadQueue(
			    '#plugin.getFullPath()#/admin/layouts/header.cfm'
			);

		}
		rc.gsmsettings = $.getBean('gsmsettings').loadBy(siteid = session.siteid);
		if(rc.gsmsettings.getIsNew()) {
			rc.gsmsettings.save();
			rc.gsmsettings = $.getBean('gsmsettings').loadBy(siteid = session.siteid);
		}

		rc.hasTranslationManager = false;

		rc.translations = $.getPlugin("MuraTranslations");

		if(rc.translations.getPluginID() != 0)
			rc.hasTranslationManager = true;

		if ( rc.isFrontEndRequest ) {
			location(url='#rc.$.globalConfig('context')#/', addtoken=false);
		}

	}

}
