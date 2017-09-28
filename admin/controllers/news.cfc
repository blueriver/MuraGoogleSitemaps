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
		rc.gsmsettings = $.getBean('gsmsettings').loadBy(siteid = session.siteid);

		rc.feedlist = $.getBean('GoogleSitemapsManager').getFeedList(rc.$,session.siteid);

//writeDump(rc.gsmsettings.getAllValues());abort;

		if(StructCount(form)) {
			rc.gsmsettings.set('isnewsenabled',form.isnewsenabled);
			rc.gsmsettings.set('newssource',form.newssource);
			rc.gsmsettings.save();
			rc.gsmsettings = $.getBean('gsmsettings').loadBy(siteid = session.siteid);
		}

		rc.criteriajson = rc.gsmsettings.get('criteriajson');
	}

}
