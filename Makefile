CFLAGS += `pkg-config libhid --cflags` -pedantic -Wall -D_GNU_SOURCE
LIBS += `pkg-config libhid --libs` -lpthread

NAME = wmr100
BINDIR = usr/bin

ifndef CC
  CC = cc
endif

ifndef BUILD
  BUILD = .
endif

wmr100: wmr100.c
	${CC} ${CFLAGS} ${LIBS} -o ${BUILD}/${NAME} wmr100.c

clean:
	-rm ${BUILD}/${NAME}

setup_osx:
	sudo cp -r osx/wmr100.kext /System/Library/Extensions/wmr100.kext
	sudo kextload -vt /System/Library/Extensions/wmr100.kext
	sudo touch /System/Library/Extensions

unsetup_osx:
	sudo rm -r -i /System/Library/Extensions/wmr100.kext
	sudo touch /System/Library/Extensions
	echo Please reboot for changes to take effect.

ifdef PREFIX

install:
	-mkdir -p ${PREFIX}/bin
	-cp -f ${BUILD}/${NAME} ${PREFIX}/bin/
	-chmod 755 ${PREFIX}/bin/${NAME}

endif
