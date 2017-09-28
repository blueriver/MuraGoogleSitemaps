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
	<h3>News</h3>

	<div id="container-gsmnews">
		<div>
			<div>
				<form method="post" action="?gsm=news" id="newsform">
					<div class="block block-constrain" style="min-height: 532px;">
						<div class="mura-control-group">
							<label for="isEnabled">News Sitemap Enabled</label>
							<label class="radio inline">
								<input name="isnewsenabled" type="radio" value="1" class="radio inline" <cfif rc.gsmsettings.get('isnewsenabled') eq 1>checked="checked"</cfif>> Yes
							</label>
							<label class="radio inline">
							<input name="isnewsenabled" type="radio" value="0" class="radio inline" <cfif rc.gsmsettings.get('isnewsenabled') neq 1>checked="checked"</cfif>> No
						</label>
						</div>
						<div class="mura-control-group">
							<label for="newsSource">News Source</label>
							<select name="newsSource">
								<option value="">Pick One</option>
								<cfloop query="#rc.feedlist#">
									<option value="#rc.feedlist.feedid[currentrow]#" <cfif rc.gsmsettings.get('newssource') eq rc.feedlist.feedid[currentrow]>selected="selected"</cfif>>#rc.feedlist.name[currentrow]#</option>
								</cfloop>
							</select>
						</label>
						</div>
						<div class="tab-content block-content">
							<div class="mura-actions">
								<div class="form-actions">
									<button type="submit" class="btn mura-primary"><i class="mi-check-circle"></i>Save</button>
								</div>
							</div>
							<h3>Note:</h3>
								<p>The news sitemap generator will only include content less than two days old (as per Google guidelines). It bases this off of (in order of preference):</p>
								<ul>
										<li>Official Publish Date</li>
										<li>Display Date</li>
										<li>Publish Date (Created)</li>
								</ul>
								<p>You must pick a feed for the news sitemap to be generated.
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

</cfoutput>
