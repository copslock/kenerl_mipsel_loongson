Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id TAA04452 for <linux-archive@neteng.engr.sgi.com>; Wed, 17 Jun 1998 19:19:22 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA65820
	for linux-list;
	Wed, 17 Jun 1998 19:18:46 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA19587
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 17 Jun 1998 19:18:43 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id TAA17056
	for <linux@cthulhu.engr.sgi.com>; Wed, 17 Jun 1998 19:18:41 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-27.uni-koblenz.de [141.26.249.27])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id EAA15226
	for <linux@cthulhu.engr.sgi.com>; Thu, 18 Jun 1998 04:18:37 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id EAA00861;
	Thu, 18 Jun 1998 04:18:08 +0200
Message-ID: <19980618041807.C517@uni-koblenz.de>
Date: Thu, 18 Jun 1998 04:18:07 +0200
To: Alex deVries <adevries@engsoc.carleton.ca>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Stuff that needs to be done.
References: <Pine.LNX.3.95.980617141204.8736C-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <Pine.LNX.3.95.980617141204.8736C-100000@lager.engsoc.carleton.ca>; from Alex deVries on Wed, Jun 17, 1998 at 02:19:02PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jun 17, 1998 at 02:19:02PM -0400, Alex deVries wrote:

> XFree86-75dpi-fonts
> XFree86-libs
> XFree86
>      Huge problems here with building the X server itself, although
>      both Ralf and Mike are working on this.  There's a good chance
>      of creating a .src.rpm for the fonts and libs, though. Ralf has
>      released an up to date patch that lets you build the libraries.

I'm desperately trying to package this thing, but it takes __time__, a
R5000 Indy is annoyingly slow for doing this, so I end up every couple
of hours in front of my Indy's console, type a few keys and let it
compile for another few hours.

On the positive side: with just a few keystrokes I made the XF68_FBDev
server compile, so combining this with the framebuffer device which just
has been written for the Magnum 4000 G364 board by Thomas we should
have the first X server for a Linux/MIPS box.

> libstdc++
> libstdc++-devel
> egcs
> egcs-c++
>      We have both rths and Ralf's sources for egcs that appear to work.
>      All that needs to be done is packaging.

> gcc
>      For inclusion in the packaging, it should really be regenerated from
>      the source RPM.  Needs lots of building time.

Actually we might consider droping gcc in favor of egcs.

> kernel
> kernel-source
> kernel-headers
>      The entire kernel source package needs to be regenerated.
> 
> modutils
>      Easy, just need to package the functional modutils that's in
>      the CVS on linus.

Modules are currently one of the more efficient ways to crash the machine,
don't know why.

> netscape-common
> netscape-communicator
>      The whole thing needs to be patched, I haven't even started
>      to think about it.  Obviously we will have to include Mozilla.
> 
> strace
>      Even the CVS version of this dies on compile.

Kernel bug, fixed in my private version.  I could commit the patches,
but I'd have to reboot into IRIX, anybody got a XFS kernel module
handy ... ;-)

> xxgdb
>     This requires gdb to work first.
> 
> binutils
>      This should be regenerated from the source RPM for 5.1.
> 
> glibc
>      This should be updated for pthreads (Ralf).
> 
> emacs
> emacs-X11
> emacs-nox
>      What a pain. We need to setup some configurations, and debugging
>      anything takes 4 hours to rebuild.  This needs patience.

I once build patches for this and even published the srpms.

> clock
>      Needs to be completely redone because there's no clock on the ISA
>      bus.

The clock data sheets are on the Dallas Semiconductor webserver at
www.dalsemi.com.  Only the PC architecture garbage needs to be disabled,
/dev/rtc is a quite sane and portable interface to the RTC.

Add to the list ncompress which makes stupid assumptions about the
machines byteorder.  Works fine on both byte orders but on the one it
cannot exchange files with the other.

> Applications that really should be fixed before we release the final
> version:
> --------------------------------------------------------------------
> 
> xpm
> xpm-devel

Builds and installs without modifications for me.

> xv
>     This can't compile because it needs csh in the building, and
>     tcsh currently hangs.

> postgresql
> postgresql-clients
> postgresql-data
> postgresql-devel
>      This is huge, and the source is broken for mipseb.  I think
>      it thinks this is IRIX.

It's a quite common problem with older sources that the preprocessor
symbol __mips__ get missrecognized as either Risc/OS or IRIX.

> ppp
>      Gets problems with compiling, dies with FD_ZERO problems.

> kaffe
>      Architecture unsupported.

This is nontrivial, as Miguel explained to me this'd require writing
a JIT.

> ElectricFence
>      Source level architecture problems.

Known kernel bug, the definition of PROT_NONE needs to be fixed.

> ImageMagick
>      Has problems building, and finishes with:
>          install -m 0755 utils/fvwmrc_c5 utils/fvwmrc_cntize_pixmaps \n
>             /vntize_pixmaps /vt/usr/X11R6/bin
>      in %install

Rebuilds for me.

> Things that don't belong in this architecture
> ---------------------------------------------
> aout-libs
>      I'm not sure.

We don't want this.

> bin86
>      Too difficult to do.

We don't want this :-)

> kernel-pcmcia-cs
>      No SGIs with PCMCIA, I suspect.

Wrong idea, think in terms of MIPS machines in general, not just SGI.

> zgv
> SVGATextMode
> svgalib
> svgalib-devel
> vga_cardgames
> vga_gamespack
>       My SGI doesn't have VGA...

Thanks god.

> isapnptools
>      No ISA bus on an SGI.

But RM200.  And Mips Magnum.  And Acer PICA.  And Deskstation Tyne.  And ...

  Ralf
