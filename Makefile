all: $(ALLTARGS)

ALLTARGS := update-chroot-mtab chroot-mtab

# 
SRCS := randomsound.c bitbuffer.c debias.c micfill.c
HDRS := bitbuffer.h debias.h micfill.h

LINK := gcc
CC := gcc
CFLAGS :=-g 

OBJS := $(SRCS:.hs=.o)
HIS := $(SRCS:.hs=.hi)


update-chroot-mtab: update-chroot-mtab.hs
	ghc $^

chroot-mtab: chroot-mtab.hs
	ghc $^

clean:
	$(RM) $(ALLTARGS) $(OBJS) $(HIS)

.PHONY: clean all




