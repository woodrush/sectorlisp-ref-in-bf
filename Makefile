all:
	$(MAKE) elvm_out
	$(MAKE) build

elvm_out:
	cd elvm && make tinycc/tcc out/bfopt all

build-bf:
	./tools/buildbf.sh

test:
	./tools/testbf.sh

test-executable:
	./tools/test-executable.sh
