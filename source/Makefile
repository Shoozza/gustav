all: neko

neko:
	@cd .. && @lime test neko
flash:
	@cd .. && @lime test flash
html:
	@cd .. && @lime test html5

clean:
	@cd .. && @lime clean neko  \
	       && @lime clean flash \
	       && @lime clean html5

.PHONY: all neko flash html clean
