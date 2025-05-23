.POSIX:
PREFIX ?= /usr/local
CXX ?= g++
CXXFLAGS = -fPIC -I$(PREFIX)/include -std=c++17
LDFLAGS = -L$(PREFIX)/lib
LDLIBS = -lxapian

# Dylib extensions.
ifeq ($(OS),Windows_NT)
	SOEXT = dll
else ifeq ($(shell uname),Darwin)
	SOEXT = dylib
else
	SOEXT = so
endif

xapian-lite.$(SOEXT): xapian-lite.cc
	$(CXX) $< -o $@ -shared $(CXXFLAGS) $(LDFLAGS) $(LDLIBS)

standalone: xapian-lite.cc
	$(CXX) -o xapian-lite.$(SOEXT) -shared $(CXXFLAGS) $< libxapian.a -lz

clean:
	rm -f *.so *.o *.dylib *.dll
