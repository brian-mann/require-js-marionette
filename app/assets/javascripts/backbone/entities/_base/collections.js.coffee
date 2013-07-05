require ["app", "backbone"], (App, Backbone) ->
	
	App.module "Entities", (Entities) ->
		
		class Entities.Collection extends Backbone.Collection