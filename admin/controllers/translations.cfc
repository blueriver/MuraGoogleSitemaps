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

			rc.gsmsettings.set('sitelist',form.sitelist);

			rc.gsmsettings.save();
			rc.gsmsettings = $.getBean('gsmsettings').loadBy(siteid = session.siteid);

		}


	}

}
