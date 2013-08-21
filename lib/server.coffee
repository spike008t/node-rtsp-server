util = require 'util'
dgram = require 'dgram'
net = require 'net'
http = require 'http'
colors = require 'colors'

root = exports ? this

class server
	constructor: (port) ->
		@port = parseInt port, 10 if typeof port is 'string'
		@port = port || 554
		@address = '0.0.0.0'
		@init()

	init: ->
		@socket = null

	start: (socketType)->

		@socket = net.createServer (c) =>
			@listening()

			c.on 'end', @close.bind @

			c.on 'connection', (sock) =>

			c.on 'data', @onData.bind @

		@socket.listen @port, @listening.bind @

		# socketType = 'udp4' if socketType isnt 'udp4' and socketType isnt 'udp6'
		# @socket = dgram.createSocket 'udp4'

		# @socket.on 'message', @parseRequest.bind(@)
		# @socket.on 'listening', @listening.bind(@)
		# @socket.on 'close', @close.bind(@)
		# @socket.on 'error', @error.bind(@)

		# @socket.bind @port


	onData: (buff) ->

		buffStr = buff.toString()
		console.log '----- REQUEST START -----'
		console.log buffStr
		console.log '----- REQUEST END -----'

		lines = buffStr.split /\r?\n/
		console.log 'line - ' + line for line in lines

		words = lines[0].split ' '

		switch words[0]
			when "OPTIONS" then @onRequestOptions()
			else
				console.log 'Request ' + words[0] + ' not supported'


	onRequestOptions: ->
		console.log 'Options request'

	onRequestDescribe: ->




	parseRequest: (msg, rinfo) ->
		console.log '[event][msg]'.green + ' - RTSP server got message ' + msg

	listening: ->
		console.log '[event][listen]'.yellow + ' - RTSP server listening on ' + @socket.address().address + ':' + @port

	close: ->
		console.log '[event][close]'.yellow + ' - RTSP server close'

	error: (ex)->
		console.log '[event][error]'.red + ' - ' + util.inspect(ex)


root.server = server
root.createServer = () ->
	return new server()