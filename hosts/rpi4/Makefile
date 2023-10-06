DISK=/dev/sdb

all: build

image: configuration.sdImage.nix
	nix-build '<nixpkgs/nixos>' \
		-A config.system.build.sdImage \
		-I nixos-config=$^ \
		--option sandbox false > $@

flash: image
	IMAGE="$(shell ls -1 $(shell cat $^)/sd-image/*.img)"; \
	dd if=$${IMAGE} of=$(DISK) status=progress bs=64K

