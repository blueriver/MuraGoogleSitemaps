<cfsilent>
<!---

This file is part of the BlueRiver Inc. Google Sitemaps Plugin

Copyright 2017 BlueRiver Inc.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

--->
</cfsilent>
<cfoutput>
	<h2>Settings</h2>
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
							<select name="location" id="sitemap_location">
								<option value="site" <cfif rc.gsmsettings.get('location') eq "site">selected="selected"</cfif>>Site Folder</option>
								<option value="web" <cfif rc.gsmsettings.get('location') eq "web">selected="selected"</cfif>>Web Root</option>
								<option value="custom" <cfif rc.gsmsettings.get('location') eq "custom">selected="selected"</cfif>>Custom</option>
							</select>
					</div>
					<div class="mura-control-group" id="custom_location" style="display: none;">
							<label for="customlocation">Custom Location</label>
							<input type="text" name="customlocation" id="customlocation" value="#rc.gsmsettings.get('customlocation')#">
					</div>
					<div class="mura-control-group">
							<label for="frequency">Update Frequency</label>
							<select name="frequency">
								<option value="daily" <cfif rc.gsmsettings.get('frequency') eq "daily">selected="selected"</cfif>>Daily</option>
								<option value="weekly" <cfif rc.gsmsettings.get('frequency') eq "weekly">selected="selected"</cfif>>Weekly</option>
								<option value="monthly" <cfif rc.gsmsettings.get('frequency') eq "monthly">selected="selected"</cfif>>Monthly</option>
							</select>
					</div>
					<!---
					<div class="mura-control-group">
							<label for="notifyemail">Notification</label>
							<input name="notifyemail" type="text" value="#rc.gsmsettings.get('notifyemail')#">
					</div>
					--->
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
</cfoutput>

<script>
$( document ).ready( function() {
	$("#sitemap_location").change( function() {
		showHideCustom();
	});

	function showHideCustom() {
		if( $("#sitemap_location").val() === "custom" ) {
			$("#custom_location").show();
		}
		else {
			$("#custom_location").hide();
		}
	}

	showHideCustom();

});
</script>
