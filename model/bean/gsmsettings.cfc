component extends="mura.bean.beanORM" table="gsm_gsmsettings" entityName="gsmsettings" displayName="Google Sitemaps Settings" orderby="siteid" {

	property name="gsmsettingsid" fieldtype="id";

	property name="siteid" displayname="siteid" orderno="1" datatype="varchar" rendertype="textfield" list=true filter=true;
	property name="isenabled" displayname="Enabled" orderno="2" datatype="int" rendertype="numeric" default="0";
	property name="isnewsenabled" displayname="Enabled" orderno="2" datatype="int" rendertype="numeric" default="0";
	property name="location" displayname="Location" orderno="3" length="250" datatype="varchar" rendertype="textfield";
	property name="customlocation" displayname="Custom Location" orderno="3" length="250" datatype="varchar" rendertype="textfield";
	property name="newssource" displayname="newssource" orderno="3" length="35" datatype="varchar" rendertype="textfield";
	property name="frequency" displayname="Frequency" orderno="4" length="250" datatype="varchar" rendertype="textfield";
	property name="timeofday" displayname="Time Of Day" orderno="5" length="50" datatype="varchar" rendertype="textfield";
	property name="notifyemail" displayname="Notification Email" orderno="5" length="150" datatype="varchar" rendertype="email";
	property name="criteriajson" displayname="News Criteria" orderno="6" datatype="text" rendertype="textarea";
	property name="sitelist" displayname="Site List" orderno="6" length="250" datatype="varchar" rendertype="textfield";
	property name="datelastgenerate" displayname="Last Generated" datatype="Date";

}
