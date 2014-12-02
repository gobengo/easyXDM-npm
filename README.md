# easyxdm-npm

This project hosts a CommonJS-compatible version of [easyXDM](https://github.com/oyvindkinsey/easyXDM) that can easily be rebuilt with `make`.

The official repo includes a version of easyXDM that is not CommonJS-compatible and always defines `window.easyXDM`. The one built here should never define a global.

## Example

```javascript
var easyxdm = require('easyxdm');
var iframeRpc = new easyxdm.Rpc({
  remote: apiHost + "/easyxdm.html"
},
{
  remote: {
    request: {}
  }
});
```

## Debugging

EasyXDM comes with a 'debug' mode which console.logs (or a window.opened log in IE9) a lot of what's going on as it passes messages around. To use this mode, `var easyxdm = require('easyxdm/debug')`.

## make

The default `make` target in the Makefile is `build`. Build does a few things:

1. Parse the version from this package.json, assume that this is the version of easyXDM that should get built.
    * You can override this by setting the `VERSION` environment variable before running make. e.g. `make VERSION='2.14.9'`.
2. Clone the tag with that version string from [the canonical easyXDM repo](https://github.com/oyvindkinsey/easyXDM) into /easyXDM/
3. Concatenate all the JavaScript files that make up easyXDM. (if these get stale, consult the main repo's [build.xml](https://github.com/oyvindkinsey/easyXDM/blob/master/build.xml#L46))
4. Use `sed` to insert the version number.
5. Output to lib/easyXDM.js
    * The 'main' module of this package is 'lib/easyXDM.js', so node and browserify should look there.

## Use it node

Requiring this module will throw an Error if the following globals are not defined: `window`, `document`, `location`. Browserify does this for you. If, for some reason, you need to require this module in vanilla node, you can use [jsdom](http://npm.im/jsdom):

```javascript
var document = require('jsdom').jsdom();
var window = document.parentWindow;
var location = window.location;
var easyxdm = require('easyxdm');
```
