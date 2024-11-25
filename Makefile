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

ifndef BUILDROOT
  BUILDROOT = BUILDROOT
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

install:
    -mkdir -p ${BUILDROOT}/${BINDIR}/
    -cp -f ${BUILD}/${NAME} ${BUILDROOT}/${BINDIR}/
    -chmod 755 ${BUILDROOT}/${BINDIR}/${NAME}
