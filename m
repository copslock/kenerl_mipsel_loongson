Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA36324 for <linux-archive@neteng.engr.sgi.com>; Wed, 17 Jun 1998 11:19:36 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA06547
	for linux-list;
	Wed, 17 Jun 1998 11:19:11 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA82172
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 17 Jun 1998 11:19:08 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id LAA22114
	for <linux@cthulhu.engr.sgi.com>; Wed, 17 Jun 1998 11:19:04 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id OAA11038
	for <linux@cthulhu.engr.sgi.com>; Wed, 17 Jun 1998 14:19:02 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 17 Jun 1998 14:19:02 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Stuff that needs to be done.
Message-ID: <Pine.LNX.3.95.980617141204.8736C-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


In a fury of organization and managment, I wrote down a list of packages
and things that need to be fixed.  Please discuss, or take one of them on.
Or, tell me what else needs to go on this list or what we can cross off.
I'm operating on the assumption that I have the most up to date packages.
If you have something newer send it to the list, or at least me.

They are roughly in order of priority.

Packages that are currently broken in some way:
-----------------------------------------------
- termcap appears to be broken in the current install.  I know I have a
functioning one on my machine, but that doesn't preclude the RPMified one
being broken. (Thanks to Mike Shaver for reporting this)

- something appears to be wrong with mkswap


Components that we definitely intend on fixing for inclusion:
-------------------------------------------------------------

The install program and distribution
     Lots wrong here... the comps list, we need an initrd, etc.

XFree86-75dpi-fonts
XFree86-libs
XFree86
     Huge problems here with building the X server itself, although
     both Ralf and Mike are working on this.  There's a good chance
     of creating a .src.rpm for the fonts and libs, though. Ralf has
     released an up to date patch that lets you build the libraries.

libstdc++
libstdc++-devel
egcs
egcs-c++
     We have both rths and Ralf's sources for egcs that appear to work.
     All that needs to be done is packaging.

gcc
     For inclusion in the packaging, it should really be regenerated from
     the source RPM.  Needs lots of building time.

kernel
kernel-source
kernel-headers
     The entire kernel source package needs to be regenerated.

modutils
     Easy, just need to package the functional modutils that's in
     the CVS on linus.

netscape-common
netscape-communicator
     The whole thing needs to be patched, I haven't even started
     to think about it.  Obviously we will have to include Mozilla.

strace
     Even the CVS version of this dies on compile.

xxgdb
    This requires gdb to work first.

binutils
     This should be regenerated from the source RPM for 5.1.

glibc
     This should be updated for pthreads (Ralf).

emacs
emacs-X11
emacs-nox
     What a pain. We need to setup some configurations, and debugging
     anything takes 4 hours to rebuild.  This needs patience.

clock
     Needs to be completely redone because there's no clock on the ISA
     bus.


Applications that really should be fixed before we release the final
version:
--------------------------------------------------------------------

mkinitrd
     Architecture not currently supported, should be easy to fix.

xpm
xpm-devel

xv
    This can't compile because it needs csh in the building, and
    tcsh currently hangs.
    
ical
     Ical thinks it is compiling on Irix, and so dies on with
     strncasecmp().

fvwm2
fvwm2-icons
     Somehow, fvwm2 doesn't compile everything on a build.

postgresql
postgresql-clients
postgresql-data
postgresql-devel
     This is huge, and the source is broken for mipseb.  I think
     it thinks this is IRIX.

ppp
     Gets problems with compiling, dies with FD_ZERO problems.

quota
     Architecture not supported.

smbfs
     Architecture support not included.

mawk
    This dies on compile with floating point errors.

mars-nwe
     Architecture specific.

ypserv
    Problems linking on gdbm; for some reason -lgdbm isnt' set.

ncpfs
    Problems with socket.h.

acm
     Thinks it is Irix in the configure.

dip
     Unknown.

xlispstat
     Architecture unsupported.


smbfs
     Architecture not supported.

xosview
     Architecture unsupported.

kaffe
     Architecture unsupported.


ElectricFence
     Source level architecture problems.

ImageMagick
     Has problems building, and finishes with:
         install -m 0755 utils/fvwmrc_c5 utils/fvwmrc_cntize_pixmaps \n
            /vntize_pixmaps /vt/usr/X11R6/bin
     in %install

cmu-snmp
cmu-snmp-utils
     Problems compiling, and finishes with conflicting internal types.

ipxutils
     This is byte order dependant.  I suspect the Sparc folks would like
     this.  We should investigate both m68k and sparc patches.


Things that don't belong in this architecture
---------------------------------------------
aout-libs
     I'm not sure.

bin86
     Too difficult to do.

kernel-pcmcia-cs
     No SGIs with PCMCIA, I suspect.

lilo
     We need a different boot loader.

sndconfig
     There is no sound support at all yet.

zgv
SVGATextMode
svgalib
svgalib-devel
vga_cardgames
vga_gamespack
      My SGI doesn't have VGA...


xdosemu
dosemu
      Emulate DOS on a MIPS?  Not right away.

mkboodisk
     SGI's don't have bootdisks, never mind.

aboot
     I'm not sure what this is.

isapnptools
     No ISA bus on an SGI.

ld.so
libc
     Mipseb is only glibc.

minlabel
     This is for Alpha disk labels.

mouseconfig
     There's only ever one type of mouse...

quickstrip
     I don't remember what this is.

rhs-hwdiag
     This requires a lot of hacking to get it to handle non-i386.

    
