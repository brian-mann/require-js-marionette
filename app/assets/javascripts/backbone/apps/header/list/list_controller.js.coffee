@IA.module "HeaderApp.List", (List, App) ->

	class List.Controller extends App.Controllers.Base
	
		initialize: ->
			view = new List.View
			App.mainRegion.show view