require ["app", "marionette"], (App, Marionette) ->

	App.module "Views", (Views) ->

		class Views.CollectionView extends Marionette.CollectionView
			itemViewEventPrefix: "childview"