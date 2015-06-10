all:
	@cd source && @${MAKE} all --no-print-directory
neko:
	@cd source && @${MAKE} neko --no-print-directory
flash:
	@cd source && @${MAKE} flash --no-print-directory
html:
	@cd source && @${MAKE} html --no-print-directory

clean:
	@cd source && @${MAKE} clean --no-print-directory

.PHONY: all neko flash html clean
