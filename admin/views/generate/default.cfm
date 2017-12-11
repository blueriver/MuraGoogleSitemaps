<cfsilent>
<!---

This file is part of the BlueRiver Inc. Google Sitemaps Plugin

Copyright 2017 BlueRiver Inc.
Licensed under the Apache License, Version v2.0
http://www.apache.org/licenses/LICENSE-2.0

--->
</cfsilent>
<cfoutput>
	<h2>Generate Site Map</h2>
	<p>Click on the "Generate" button to generate an updated sitemap.</p>
	<form method="post" action="?gsm=generate">
		<input type="hidden" name="doprocess" value="1">
		<div class="mura-control-group">
			<cfif structKeyExists(rc,"time")>
				<p>Processing Time: #rc.time# ms</p>
				<p>Location: <a target="new" href="#rc.fileURL#">#rc.fileURL#</a></p>
			</cfif>
		</div>
		<div class="mura-actions">
			<div class="form-actions">
				<button type="submit" class="btn mura-primary"><i class="mi-check-circle"></i>Generate</button>
			</div>
		</div>
</form>
</cfoutput>
