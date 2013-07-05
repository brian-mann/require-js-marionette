require ["app", "marionette"], (App, Marionette) ->

	App.module "Views", (Views) ->
		
		class Views.CompositeView extends Marionette.CompositeView
			itemViewEventPrefix: "childview"