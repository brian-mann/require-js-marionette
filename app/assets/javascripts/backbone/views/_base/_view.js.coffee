do (Marionette) ->
	
	@IA.module "Views", (Views) ->

		_.extend Marionette.View::,

			templateHelpers: ->