require ["app", "marionette"], (App, Marionette) ->

	App.module "Views", (Views) ->

		class Views.ItemView extends Marionette.ItemView