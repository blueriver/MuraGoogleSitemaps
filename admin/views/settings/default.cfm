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
	<h3>Settings</h3>
	<form method="post" action="?gsm=settings">
		<div class="block block-constrain" style="min-height: 532px;">
		<div class="tab-content block-content">
			<div class="block block-bordered">
					<!-- block header -->
				<div class="block-header">
					<h3 class="block-title">Basic Settings</h3>
				</div> <!-- /.block header -->
				<div class="block-content">
					<div class="mura-control-group">
							<label for="isEnabled">Enabled</label>
							<label class="radio inline">
								<input name="isEnabled" type="radio" value="1" class="radio inline" <cfif rc.gsmsettings.get('isenabled') eq 1>checked="checked"</cfif>> Yes
							</label>
							<label class="radio inline">
							<input name="isEnabled" type="radio" value="0" class="radio inline" <cfif rc.gsmsettings.get('isenabled') neq 1>checked="checked"</cfif>> No
						</label>
					</div>
					<div class="mura-control-group">
							<label for="location">Location</label>
							<select name="location">
								<option value="site" <cfif rc.gsmsettings.get('location') eq "site">selected="selected"</cfif>>Site Folder</option>
								<option value="web" <cfif rc.gsmsettings.get('location') eq "web">selected="selected"</cfif>>Web Root</option>
							</select>
					</div>
					<div class="mura-control-group">
							<label for="frequency">Update Frequency</label>
							<select name="frequency">
								<option value="daily" <cfif rc.gsmsettings.get('frequency') eq "daily">selected="selected"</cfif>>Daily</option>
								<option value="weekly" <cfif rc.gsmsettings.get('frequency') eq "weekly">selected="selected"</cfif>>Weekly</option>
								<option value="monthly" <cfif rc.gsmsettings.get('frequency') eq "monthly">selected="selected"</cfif>>Monthly</option>
							</select>
					</div>
					<div class="mura-control-group">
							<label for="notifyemail">Notification</label>
							<input name="notifyemail" type="text" value="#rc.gsmsettings.get('notifyemail')#">
					</div>
				</div> <!-- /.block-content -->
				<div class="mura-actions">
					<div class="form-actions">

							<button type="submit" class="btn mura-primary""><i class="mi-check-circle"></i>Save</button>

					</div>
				</div>
			</div>
		</div>
	</div>
	</form>
<cfdump var="#form#" />
</cfoutput>
