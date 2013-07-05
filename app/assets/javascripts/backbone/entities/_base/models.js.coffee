require ["app", "backbone"], (App, Backbone) ->
	
	App.module "Entities", (Entities) ->
		
		class Entities.Model extends Backbone.Model