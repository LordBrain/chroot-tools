chroot-tools
============

Some tools to make living in a chroot nicer

I made this program mainly to make the df tool work inside a chroot.
This is accomplished by copying appropriate lines from /proc/mounts to 
the chrootdir/etc/mtab file.


These tools were specifically made to work with the schroot program.

I have tested only on my system, Debian wheezy with a jessie chroot.


== chroot-mtab ==
              `chroot-mtab` performs a transformation on a single fstab 
              file, outputing to a specified mtab file.
              The paths are specified as arguments.
              
              
== update-chroot-mtabs ==
                      Takes no arguments. Actually looks at the output of

                        schroot -i --all-sessions
                        
                      to determine what schroot mounts need to be updated
                      and what fstab files need to be used to update htem.
                      It then peforms the updates. 
                      
                      The idea being that you could copy this to /usr/local/bin
                      and then set up a udev rule to invoke it whenever 
                      a block device is mounted.
                      
                      
Warning
=======
This is in no way meant to be an aid in isolating the host environment 
from would be hackers.  Remember the term "Chroot Jail" is a misnomer. If a
jail is what you need, then a chroot is not.

