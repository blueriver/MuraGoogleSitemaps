<cfsilent>
<!---

This file is part of the BlueRiver Inc. Google Sitemaps Plugin

Copyright 2017 BlueRiver Inc.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

--->
</cfsilent>
<cfoutput>
	<h1>Google Sitemaps</h1>
	<h3>Translations</h3>
	<form method="post" action="?gsm=translations">
		<div class="block block-constrain" style="min-height: 532px;">
		<div class="tab-content block-content">
			<div class="block block-bordered">
					<!-- block header -->
				<div class="block-header">
					<h3 class="block-title">Translation Settings</h3>
				</div> <!-- /.block header -->
				<div class="block-content">
					<cfset rc.assignedsites = rc.translations.getAssignedSites() />
					<p>With Mura Translations installed, you can include reference links to translated pages.<p>
					<p>Include reference links to the following sites:</p>
					<cfloop query="#rc.assignedsites#">
						<cfif rc.assignedsites.siteid[currentrow] neq session.siteid>
							<cfset site = $.getBean('site').loadby(siteid=siteid)>
							<div class="mura-control-group">
								<label for="isEnabled">#site.get('site')# (#siteid#)</label>
								<label class="checkbox inline">
									<input name="sitelist" type="checkbox" value="#siteid#" class="radio inline" <cfif listContains(rc.gsmsettings.get('sitelist'),siteid)>checked="checked"</cfif>> Yes
								</label>
							</div>
						</cfif>
					</cfloop>
				<div class="mura-actions">
					<div class="form-actions">
						<button type="submit" class="btn mura-primary"><i class="mi-check-circle"></i>Save</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<input type="hidden" name="issubmitted" value="true">
	</form>
</cfoutput>
