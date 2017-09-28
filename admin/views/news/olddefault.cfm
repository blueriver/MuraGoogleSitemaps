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
				<criteria-box :criteria="criteria"></criteria-box>
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
						<div class="tab-content block-content">
							<div class="mura-actions">
								<textarea name="criteriajson" id="criteriajson">#rc.criteriajson#</textarea>
								<input type="hidden" name="foo" value="bar">
								<div class="form-actions">
									<button type="button" @click="saveJSON()" class="btn mura-primary"><i class="mi-check-circle"></i>Save</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<template id="criteria-box">
		<div class="block block-constrain">
		<div class="block block-bordered">
			<div class="block-header">
				<h3 class="block-title">Advanced Filters</h3>
			</div> <!-- /.block header -->
			<div class="block-content">
				<div class="mura-control-group" id="searchParams">
					<label>Choose Advanced Filters</label>
					<div v-for="(item,index) in criteria">
						<criteria-add :item="item" :index="index"></criteria-add>
					</div>
			</div> <!-- /.block-content -->
		</div> <!-- /.block-content -->
		</div> <!-- /.block-content -->
	</template>

	<!-- block header -->
	<template id="criteria-add">
			<div class="mura-control justify">
				<select name="paramrelationship" v-if="index > 0"  v-model="item.paramrelationship" :value="item.paramrelationship">
					<option value="and">And</option>
					<option value="or">Or</option>
				</select>
				<input type="hidden" name="param" value="1">
				<select name="paramfield" v-model="item.paramfield">
					<option value="">Select Field</option>
					<option value="tcontent.lastupdate" data-type="date">Last Update</option>
					<option value="tcontent.releaseDate" data-type="date">Official Release Date</option>
					<option value="tcontent.created" data-type="date">Created</option>
					<option value="tcontent.menuTitle" data-type="varchar">Navigation Title</option>
					<option value="tcontent.title" data-type="varchar">Title</option>
					<option value="tcontent.Credits" data-type="varchar">Credits</option>
					<option value="tcontent.summary" data-type="varchar">Summary</option>
					<option value="tcontent.body" data-type="varchar">Body</option>
					<option value="tcontent.metaDesc" data-type="varchar">Meta Description</option>
					<option value="tcontent.metaKeywords" data-type="varchar">Meta Keywords</option>
					<option value="tcontent.type" data-type="varchar">Type</option>
					<option value="tcontent.subType" data-type="varchar">Subtype</option>
					<option value="tcontenttags.tag" data-type="varchar">Tag</option>
					<option value="tcontent.displayStart" data-type="timestamp">Start Date / Time</option>
					<option value="tcontent.displayStop" data-type="timestamp">Stop Date / Time</option>
					<option value="tcontent.expires" data-type="timestamp">Content Expiration</option>
					<option value="tcontent.contentID" data-type="varchar">Content ID</option>
					<option value="tcontent.parentID" data-type="varchar">Parent ID</option>
					<option value="tcontent.path" data-type="varchar">Path</option>
					<option value="tcontentcategoryassign.categoryID" data-type="varchar">Category ID</option>
				</select>
				<select name="paramcondition" v-model="item.paramcondition">
					<option value="EQ">Equals</option>
					<option value="GT">Greater Than</option>
					<option value="GTE">Greater Than or Equal To</option>
					<option value="LT">Less Than</option>
					<option value="LTE">Less Than or Equal To</option>
					<option value="NEQ">Not Equal To</option>
					<option value="Begins">Begins With</option>
					<option value="Contains">Contains</option>
					<option value="IN">In</option>
					<option value="NOT IN">Not In</option>
				</select>
				<input type="text" name="paramfield" v-model="item.paramcriteria" :value="item.paramcriteria">
				<a class="criteria-remove" v-if="index > 0" @click="removeCriteria(index)"><i class="mi-minus-circle"></i></a>
				<a class="criteria-add" @click="addCriteria()"><i class="mi-plus-circle"></i></a>
			</div>
	</template>
<script>

	m.loader()
			.loadjs('#rc.$.globalConfig('context')#/plugins/googlesitemaps/assets/js/gsmnews.js');


</script>

</cfoutput>
