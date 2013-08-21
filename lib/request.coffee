class request
	constructor: ->
		@verb = null
		@protocol = null
		@version = null
		@uri = null
		@headers = {}


	parse: (buffer) ->