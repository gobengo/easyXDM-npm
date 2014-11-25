# easyxdm-npm

This project hosts a CommonJS-compatible version of [easyXDM](https://github.com/oyvindkinsey/easyXDM) that can easily be rebuilt with `make`.

The official repo includes a version of easyXDM that is not CommonJS-compatible and always defines `window.easyXDM`. The one built here should never define a global.

## Make

The default `make` target in the Makefile is `build`. Build does a few things:

1. Parse the version from this package.json, assume that this is the version of easyXDM that should get built.
    * You can override this by setting the `VERSION` environment variable before running make. e.g. `make VERSION='2.14.9'`.
2. Clone the tag with that version string from [the canonical easyXDM repo](https://github.com/oyvindkinsey/easyXDM) into /easyXDM/
3. Concatenate all the JavaScript files that make up easyXDM. (if these get stale, consult the main repo's [build.xml](https://github.com/oyvindkinsey/easyXDM/blob/master/build.xml#L46))
4. Use `sed` to insert the version number.
5. Output to lib/easyXDM.js
    * The 'main' module of this package is 'lib/easyXDM.js', so node and browserify should look there.
