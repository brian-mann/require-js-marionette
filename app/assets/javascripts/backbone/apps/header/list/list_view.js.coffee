@IA.module "HeaderApp.List", (List, App) ->

	class List.View extends App.Views.ItemView
		template: "header/list/header"
	
		initialize: ->
			console.log "list item view!"