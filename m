Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA02510; Fri, 26 Apr 1996 14:59:44 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id OAA02310; Fri, 26 Apr 1996 14:59:36 -0700
Received: from neteng.engr.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id OAA02303; Fri, 26 Apr 1996 14:59:34 -0700
Received: from localhost (lm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via SMTP id OAA02500 for <linux@engr>; Fri, 26 Apr 1996 14:59:33 -0700
Message-Id: <199604262159.OAA02500@neteng.engr.sgi.com>
To: linux@cthulhu.engr.sgi.com
Subject: Linux/MIPS status on non-SGI boxes
Date: Fri, 26 Apr 1996 14:59:33 -0700
From: Larry McVoy <lm@neteng.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Looks like we may have help...

------- Forwarded Message

Date:    Fri, 26 Apr 1996 20:14:24 +0200
From:    Ralf Baechle <ralf@Julia.DE>
To:      lm, davem@caip.rutgers.edu, linux-mips@fnet.fr
Subject: Re: Linux/SGI coming

Hi all,

> So, can someone provide a quick summary of the current status?  All the
> usual stuff, like what compilers are used, what linker, what are you
> doing for userland, etc.

OK.  There is a bootloader available for ARC conformant systems.  This
implies little endian byte order.  Some time ago we redesigned the interface
to pass bootinformation to the kernel.  The new interface uses a tagged list
and can also be used to pass big information like ramdisks or fonts from the
bootloader to the kernel.  Due to the byteorder Milo isn't really of interest.
Furthermore the Milo distribution is crippled due to (C) problems.  Since
you, Larry, probably have signed an NDA with SGI ;-) you can however get the
complete sources, it you wish.  Otherwise the crippled distribution is
available via ftp.fnet.fr.  What is missing are the lowlevel interfaces
between the pseudo libc implementation that Milo uses and the ARC BIOS.
This was required due to M$ holding the (C) for the information Milo is based
on.

The crosscompiler environment is based on GCC 2.7.2 and Binutils 2.6.  The
required patches that fix lots of bugs and add Linux/MIPS support for
a.out, ELF little/big endian byte order are available on ftp.fnet.fr.
Their installation isn't easy but Dave shouldn't have to much trouble
with this.

There are some binary packages on ftp.fnet.fr for Linux/i386 host.  I'd like
to have packages for more hosts, so if someone sends me binaries we'll put
the online.  (I could create packages for Stun's OSes if someone wants them)

The libc implementation is based on the GNU libc which is available only
as ELF.  My home sources are based on snapshot 960210; upgrading to the
newest libc will be the next thing for me to do when I sent my kernel
patches to Linus.  There is an older Linux libc port available - don't
use it!  I changed the low level kernel interfaces for 1.3 so that they
should now look much more like IRIX 5.3 / RISC/os 5.01 which breaks this
old (a.out ...) port completly.  The distribution is still available via
ftp to help building the a.out crosscompiler.

The quality of the libc port to Linux is good enough to build most user stuff.
GNU libc is however very aggresive to bad code; quite some packages need
to be patched to compile.  I'll put patches online as soon as I can.

Most of the userland stuff available via ftp is based on the GNU or Debian
source distributions.

The kernel itself runs pretty solid for me.  It currently supports the PC
versions of R4000 and R4400 CPUs but probably doesn't work for SC and MC
versions.  I tried to support R2000/R3000/R6000/R8000/R10000 as good as
possible without having hardware, so a port shouldn't be too hard.  For
R4000 and better many of the lowlevel functions have been written to be
SMP proof but again without SMP hardware and at this point of the project
SMP is nothing really invest my time in.

One of the kernel features that are still missing is the special kernel
code to handle denormalized numbers - not of interest for you -
FPU emulation, branch delay emulation.  Also there is no support for
ptrace(2), therefore no debugger.

The supported machines are the Mips Magnum 4000, Olivetti M700-10 (a OEM
Magnum version) and Acer Pica 61, which is a kind of a successor type for
the Magnum built by Acer.  All these machines have a similar DMA engine,
Floppy, NCR53C94 SCSI and Sonic Ethernet onboard.  This SCSI/Ethernet
hardware is currently not supported.  I thought it would be better to
use (E)ISA hardware where drivers are very easy to port and to put my
time on the other parts of the system.

Paul Antoine is working on DECstation/R3000 support.

> Also, the handhold on information has loosened quite a bit.  If there is
> specific information you are looking for, let me know.  In particular,
> I have access to all the chip errata, something that our internal people
> use a lot.

I think it would be great to have all this stuff on our ftp server as it
could especially help peoples with ancient CPUs.  Andy's R4000 2.2 was
driving me crazy ...

This should answer many of your questions but probably not all, so feel
free to mail me.

  Ralf

------- End of Forwarded Message
