.PHONY: build
VERSION=$(shell node -e "process.stdout.write(require('./package.json').version)")
SRC_DIR=easyXDM/src

build: lib/easyXDM.js lib/easyXDM.debug.js

clean:
	rm -rf lib/ easyXDM/ node_modules/

easyXDM/:
	git clone -b "$(VERSION)" git@github.com:oyvindkinsey/easyXDM.git

lib/:
	mkdir -p lib

lib/easyXDM.debug.js: easyXDM/ lib/
	cat $(SRC_DIR)/begin_scope.txt \
	    $(SRC_DIR)/Core.js \
	    $(SRC_DIR)/Debug.js \
	    $(SRC_DIR)/DomHelper.js \
	    $(SRC_DIR)/Fn.js \
	    $(SRC_DIR)/Socket.js \
	    $(SRC_DIR)/Rpc.js \
	    $(SRC_DIR)/stack/SameOriginTransport.js \
	    $(SRC_DIR)/stack/FlashTransport.js \
	    $(SRC_DIR)/stack/PostMessageTransport.js \
	    $(SRC_DIR)/stack/FrameElementTransport.js \
	    $(SRC_DIR)/stack/NameTransport.js \
	    $(SRC_DIR)/stack/HashTransport.js \
	    $(SRC_DIR)/stack/ReliableBehavior.js \
	    $(SRC_DIR)/stack/QueueBehavior.js \
	    $(SRC_DIR)/stack/VerifyBehavior.js \
	    $(SRC_DIR)/stack/RpcBehavior.js \
	    build/end_scope_commonjs.txt \
		| sed -l -e "s/%%version%%/$(VERSION)/g" \
		> lib/easyXDM.debug.js

lib/easyXDM.js: lib/easyXDM.debug.js
	cat lib/easyXDM.debug.js \
	| sed -e '/#ifdef debug/,/#endif/d' \
	> lib/easyXDM.js
