define ["app", "marionette"], (App, Marionette) ->
	
	App.module "HeaderApp", (HeaderApp) ->
		@startWithParent = false
	
		API =
			list: ->
				require ["manifests/header"], ->
					new HeaderApp.List.Controller
						region: App.headerRegion
	
		HeaderApp.on "start", ->
			API.list()