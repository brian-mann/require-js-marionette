@IA.module "HeaderApp", (HeaderApp, App) ->
	@startWithParent = false

	API =
		list: ->
			head.js "assets/manifests/header", ->
				new HeaderApp.List.Controller
					region: App.headerRegion

	HeaderApp.on "start", ->
		API.list()