PREFIX = /usr
GOPATH_DIR = gopath

GOPKG_PREFIX = pkg.deepin.io/dde/go-example
 
ifndef USE_GCCGO
        GOLDFLAGS = -ldflags '-s -w'
else
        GOLDFLAGS = -s -w  -Os -O2 
endif
 
ifdef GODEBUG
        GOLDFLAGS =
endif
 
ifndef USE_GCCGO
        GOBUILD = go build ${GOLDFLAGS}
else
        GOLDFLAGS += $(shell pkg-config --libs gio-2.0 gtk+-3.0 gdk-pixbuf-xlib-2.0 x11 libcanberra xi)
        GOBUILD = go build -compiler gccgo -gccgoflags "${GOLDFLAGS}"
endif

all: build

prepare:
	@if [ ! -d ${GOPATH_DIR}/src/${GOPKG_PREFIX} ]; then \
                mkdir -p ${GOPATH_DIR}/src/$(dir ${GOPKG_PREFIX}); \
                ln -sf ../../../.. ${GOPATH_DIR}/src/${GOPKG_PREFIX}; \
                fi

go-example:
	env GOPATH="${CURDIR}/${GOPATH_DIR}:${GOPATH}" ${GOBUILD} -v -o go-example

build: prepare go-example

install:
	install -Dm755 go-example ${DESTDIR}${PREFIX}/bin/go-example

clean:
	-rm -rf ${GOPATH_DIR}
	-rm -f go-example

rebuild: clean build
