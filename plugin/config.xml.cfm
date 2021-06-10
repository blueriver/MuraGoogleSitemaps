<!---

This file is part of the BlueRiver Inc. Google Sitemaps Plugin

Copyright 2017 BlueRiver Inc.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

--->
<cfinclude template="../includes/fw1config.cfm" />
<cfoutput>
	<plugin>
		<name>MuraGoogleSitemaps</name>
		<package>#variables.framework.package#</package>
		<directoryFormat>packageOnly</directoryFormat>
		<version>#variables.framework.packageVersion#</version>
		<loadPriority>5</loadPriority>
		<provider>blueriver</provider>
		<providerURL>http://blueriver.com</providerURL>
		<category>Application</category>

		<!-- Event Handlers -->
		<eventHandlers>
			<!-- only need to register the eventHandler.cfc via onApplicationLoad() -->
			<eventHandler
					event="onApplicationLoad"
					component="includes.eventHandler"
					persist="false" />
			<eventHandler
					event="onApplicationLoad"
					component="model.handlers.core"
					persist="false" />
		</eventHandlers>

		<!-- Required for Mura 6.2 installation -->
		<displayobjects></displayobjects>
		<settings></settings>

		<extensions>
			<extension type="Base" subtype="Default">
				<attributeset name="Google Sitemaps">
					<attribute name="exclude"
						label="Exclude From Sitemap"
						hint="Exclude this page from the sitemap"
						type="SelectBox"
						defaultValue="inherit"
						required="false"
						validation=""
						regex=""
						message=""
						optionList="inherit^no^yes"
						optionLabelList="Inherit^No^Yes" />
					<attribute name="changefrequency"
						label="Change Frequency"
						hint="The change frequency for the page"
						type="SelectBox"
						defaultValue="monthly"
						required="false"
						validation=""
						regex=""
						message=""
						optionList="daily^weekly^monthly^yearly"
						optionLabelList="Daily^Weekly^Monthly^Yearly" />
					<attribute name="priority"
						label="Priority"
						hint="The relative importance of the page to the site"
						type="SelectBox"
						defaultValue="0.1"
						required="false"
						validation=""
						regex=""
						message=""
						optionList="0.1^0.2^0.3^0.4^0.5^0.6^0.7^0.8^0.9^1.0"
						optionLabelList="0.1^0.2^0.3^0.4^0.5^0.6^0.7^0.8^0.9^1.0" />
				</attributeset>
			</extension>
		</extensions>

	</plugin>
</cfoutput>
