dgram = require 'dgram'
colors = require 'colors'

root = exports ? this

class server
	constructor: (port) ->
		@port = port || 554
		@address = '0.0.0.0'

	init: ->
		@socket = null

	start: (socketType)->
		socketType = 'udp4' if socketType isnt 'udp4' and socketType isnt 'udp6'
		@socket = require('dgram').createSocket 'udp4'

		@socket.on 'message', @parseRequest.bind(@)
		@socket.on 'listening', @listening.bind(@)
		@socket.on 'close', @close.bind(@)

		@socket.bind @port

	parseRequest: (msg, rinfo) ->
		console.log '[event][msg] - RTSP server got message ' + msg

	listening: ->
		console.log '[event][listen] - RTSP server listening on ' + server.address().address + ':' + @port

	close: ->
		console.log '[event][close] - RTSP server close'


root.server = server
root.createServer = (fn) ->
	return new server()