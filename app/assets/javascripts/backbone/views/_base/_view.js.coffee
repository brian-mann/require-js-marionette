require ["app", "marionette"], (App, Marionette) ->
	
	App.module "Views", (Views) ->

		_.extend Marionette.View::,

			templateHelpers: ->