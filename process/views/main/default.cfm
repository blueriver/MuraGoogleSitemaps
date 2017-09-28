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
	<h3>Generate Site Map</h3>
	<div class="mura-control-group">
			<cfif structKeyExists(rc,"time")>
				<p>Processing Time: #rc.time# ms</p>
				<p>Location: <a target="new" href="#rc.fileURL#">#rc.fileURL#</a></p>
			</cfif>
	</div>

</cfoutput>
