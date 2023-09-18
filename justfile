VERSION := "3.0.1"

build:
  #!/usr/bin/env bash
  meson setup build
  ninja -C build

clean:
  #!/usr/bin/env bash
  rm -rf ./build
  rm -rf ./debian
  rm -rf ./obj-*
  rm -rf "./howdy_{{VERSION}}"

deb: clean build && clean
  #!/usr/bin/env bash
  VERSION="3.0.1"
  mkdir -p "howdy_{{VERSION}}"
  dh_make --createorig -p "howdy_{{VERSION}}"
  dh_auto_configure --buildsystem=meson
  cp -r ./howdy/debian/* ./"howdy_{{VERSION}}"/
  dpkg-buildpackage -rfakeroot -us -uc -b

install: clean build
  #!/usr/bin/env bash
  ninja -C build install

uninstall: install
  #!/usr/bin/env bash
  sudo ninja -C build uninstall
  
