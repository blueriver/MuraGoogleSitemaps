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

			rc.gsmsettings.set('isEnabled',form.isEnabled == 1 ? 1 : 0);
			rc.gsmsettings.set('location',form.location);
			rc.gsmsettings.set('frequency',form.frequency);

			if(structKeyExists(form,"notifyemail") and len(form.notifyemail)) {
				rc.gsmsettings.set('notifyemail',form.notifyemail);
			}

			if(form.location eq "custom") {
				 if(len(form.customlocation)) {
					rc.gsmsettings.set('customlocation',form.customlocation);
				}
				else {
					rc.gsmsettings.set('customlocation',"");
					rc.gsmsettings.set('location',"site");
				}
			}

			rc.gsmsettings.save();
			rc.gsmsettings = $.getBean('gsmsettings').loadBy(siteid = session.siteid);

			if(rc.gsmsettings.get('isEnabled')) {
				rc.$.getBean('GoogleSitemapsManager').schedule(rc.$,session.siteid,true);
			}
			else {
				rc.$.getBean('GoogleSitemapsManager').schedule(rc.$,session.siteid,false);
			}

		}



	}

}
