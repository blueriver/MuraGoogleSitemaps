component extends="mura.plugin.pluginGenericEventHandler" {
	variables.package = "";
	variables.groupStudent = "";
	variables.groupProvider = "";
	$ = "";
	variables.pluginpath = "";

	public void function onApplicationLoad(required struct $) {

		var ioc=getServiceFactory();
		var bean = "";

		variables.$ = arguments.$;

		var beanArray=[
			'gsmsettings'
			];

		var checkSchema=isDefined('url.applydbupdates') || !ioc.containsBean('gsmsettings');

		variables.package = arguments.$.getPlugin("MuraGoogleSitemaps");

		variables.pluginPath =
			variables.$.globalConfig('context')
			& '/plugins/'
			& variables.package.getPackage();

		for(var item in beanArray){
			try {
				ioc.declareBean(beanName=item, dottedPath='MuraGoogleSitemaps.model.bean.#item#', isSingleton = false );

			// call instance
				bean = ioc.getBean(item);
			}
			catch( any e ) {
				writeDump(item);
				writeDump(e);
				abort;
			}

			// check schema on each bean first
			if(checkSchema){
				try {
					bean.checkSchema();
				}
				catch( any e ) {
					writeDump(item);
					writeDump(e);
					abort;
				}
			}
		}

		ioc.declareBean(beanName='GoogleSitemapsManager', dottedPath='MuraGoogleSitemaps.model.manager.googlesitemapsmanager', isSingleton = true );

		variables.pluginConfig.addEventHandler(this);
		validateSession();

		var assignedSites=variables.pluginConfig.getAssignedSites();
		var pluginManager=getBean('pluginManager');

		for(var s=1;s <=assignedSites.recordcount;s++){
			var site=getBean('settingsManager').getSite(assignedSites.siteid[s]);

			var APIUtility=site.getApi('json','v1');

			APIUtility.secureRequest = this.secureRequest;
			APIUtility.registerMethod('echo',echo);

			for(var item in beanArray){
				var config={
						moduleid=variables.pluginConfig.getModuleID(),
						public=false
					};

				APIUtility.registerEntity(item,config);
			}
		}
		validateSession();

		arguments.$.announceEvent('GSMApplicationLoad');

	}

	remote function echo() {
		arguments['echo'] = true;
		return arguments;
	}

	function onSiteAsyncRequestStart($){
		$.announceEvent('GSMGlobalRequestStart');


//		$.setCustomMuraScopeKey(variables.package.getPackage(), new scopeFunctions().setScope($));
	}

	function onGlobalRequestStart($){
		$.announceEvent('GSMGlobalRequestStart');

//		$.setCustomMuraScopeKey(variables.package.getPackage(), new scopeFunctions().setScope($));
	}

	function onContentEdit ( $ ) {
	}

	function onSiteRequestStart($){
		$.announceEvent('GSMSiteRequestStart');

//		$.setCustomMuraScopeKey(variables.package.getPackage(), new scopeFunctions().setScope($));
	}

	function onSiteLogin($) {
		validateSession();

	}

	function onAICSiteRequestStart($){
		$.announceEvent('AICConnectionReset');
	}

	function onAfterSiteLogout($){
	}

	function onRenderStart($) {

		validateSession();
	}

	function onAdminHTMLHeadRender( $ ) {

		var jsAdded = "";

		savecontent variable="jsAdded" {
//			writeOutput("<script type='text/javascript' src='#variables.pluginPath#/includes/assets/js/admin.js'></script>");
		}

		return jsAdded;

	}

	function onSiteSessionEnd($){
		onGlobalSessionEnd(argumentCollection=arguments);
	}

	function onBeforeUserSave( any $,any event ) {
	}

	function onBeforeUserUpdate(any $,any event) {
		onBeforeUserSave( argumentCollection=arguments );
	}

	function onAfterUserSave( any $,any event ) {

	}

	function onAfterUserUpdate(any $,any event) {
		onAfterUserSave( argumentCollection=arguments );
	}

	function secureRequest( $ ) {
		return false;
	}

	private function validateSession() {
		if( !isDefined("session") )
			return;

		if( !structKeyExists( session,'GSM')) {
			session['GSM'] = {};
		}
	}


}
