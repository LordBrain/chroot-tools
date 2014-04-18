all: update-chroot-mtabs chroot-mtab

ALLTARGS := update-chroot-mtabs chroot-mtab

# 
SRCS := update-chroot-mtabs.hs chroot-mtab.hs

LINK := gcc
CC := gcc
CFLAGS :=-g 

OBJS := $(SRCS:.hs=.o)
HIS := $(SRCS:.hs=.hi)


update-chroot-mtabs: update-chroot-mtabs.hs
	ghc $^

chroot-mtab: chroot-mtab.hs
	ghc $^

clean:
	$(RM) $(ALLTARGS) $(OBJS) $(HIS)

.PHONY: clean all




