# Debugging

Debugging on the client side can be done with any Browser or JS-Tool. The real cool thing is, that debugging on the server side also works with [node-inspector](https://github.com/node-inspector/node-inspector). Even with full coffee-script support!

## Requirements - what you need

You need Blink-based Browser (i.e. Google Chrome)

##ä Install node-inspector

You should install node-inspector globally

    npm install -g node-inspector 


## Enable debug mode in the node process

    coffee --nodejs --debug server.coffee

or, to pause the server script on the first line

    coffee --nodejs --debug-brk server.coffee

## Start and attach node-inspector

1.  run node-inspector

    node-inspector &

2.  open (http://127.0.0.1:8080/debug?port=5858) in Chrome

3.  you should now see the javascript source from node. If you don't, click the scripts tab. select a script and set some breakpoints (far left line numbers)


