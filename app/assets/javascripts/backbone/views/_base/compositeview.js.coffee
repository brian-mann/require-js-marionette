do (Marionette) ->

	@IA.module "Views", (Views) ->
		
		class Views.CompositeView extends Marionette.CompositeView
			itemViewEventPrefix: "childview"