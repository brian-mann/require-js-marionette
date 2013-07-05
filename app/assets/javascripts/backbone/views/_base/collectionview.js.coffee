do (Marionette) ->

	@IA.module "Views", (Views) ->

		class Views.CollectionView extends Marionette.CollectionView
			itemViewEventPrefix: "childview"