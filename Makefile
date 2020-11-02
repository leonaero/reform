# Inspired from https://github.com/fhammerschmidt/bucklescript-monorepo/blob/master/Makefile

ifeq ($(OS), Windows_NT) 
	detected_OS := Windows
else
	detected_OS := $(shell sh -c 'uname 2>/dev/null || echo Unknown')
endif

ifeq ($(detected_OS), Windows)
	BSB := ./node_modules/bs-platform/win32/bsb.exe
endif
ifeq ($(detected_OS), Linux)
	BSB := ./node_modules/bs-platform/linux/bsb.exe
endif
ifeq ($(detected_OS), Darwin)
	BSB := ./node_modules/bs-platform/darwin/bsb.exe
endif

BSEXTENSIONS := "ml,mli,re,rei"
BSB_ARGS := -make-world
SOURCE_DIRS_JSON := lib/bs/.sourcedirs.json
BSDIRS = "$(shell jq -r 'include "./dirs"; dirs' $(SOURCE_DIRS_JSON))"

all: serve

serve:
	trap 'kill %1' INT TERM
	# BuckleScript doesn't like being run first.
	$(MAKE) demo & $(MAKE) watch

demo:
	yarn workspace demo server

$(SOURCE_DIRS_JSON): bsconfig.json
	$(BSB) -install

bs:
	$(BSB) $(BSB_ARGS) 2>/dev/null || echo Hang

watch: bs
	./node_modules/.bin/redemon --paths=$(BSDIRS) --verbose -e re $(MAKE) bs

print-%: ; @echo $*=$($*)

clean:
	$(BSB) -clean-world

.PHONY: bs bsdirs all clean watch
