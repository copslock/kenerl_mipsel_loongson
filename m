Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2002 20:26:17 +0200 (CEST)
Received: from crack.them.org ([65.125.64.184]:1544 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S1122987AbSIQS0Q>;
	Tue, 17 Sep 2002 20:26:16 +0200
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 17rNya-0004Em-00; Tue, 17 Sep 2002 14:25:36 -0500
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 17rN2W-0006XY-00; Tue, 17 Sep 2002 14:25:36 -0400
Date: Tue, 17 Sep 2002 14:25:36 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: Stuart Hughes <seh@zee2.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: cannot debug multi-threaded programs with gdb/gdbserver
Message-ID: <20020917182536.GA25012@nevyn.them.org>
References: <3D876053.C2CD1D8C@zee2.com> <3D87653E.9030702@realitydiluted.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D87653E.9030702@realitydiluted.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 17, 2002 at 12:24:14PM -0500, Steven J. Hill wrote:
> Stuart Hughes wrote:
> >
> >Does anyone know whether there is some special setup needed on
> >gdb/gdbserver to use the multi-threaded gdbserver ??
> >
> Wow, there are so many things to tell you...where to start...

Steve, have you started memorizing my responses again? :)

> >My environment is as follows:
> >
> >CPU:		NEC VR5432
> >kernel: 	linux-2.4.18 + patches
> >glibc:		2.2.3 + patches
> >gdb:		5.2/3 from CVS
> >
> Has to be the gdb-5.3 branch...go look at http://sources.redhat.com/gdb
> 
> >gcc:		3.1
> >binutils:	Version 2.11.90.0.25
> >
> Don't use H.J. Lu's binutils, use the released one. Use gcc-3.2 and
> binutils-2.13 as they have fixes for the MIPS debugging symbols with
> regards to DWARF.
> 
> >cross-gdb configured using: 
> >
> >configure --prefix=/usr --target=mipsel-linux --disable-sim
> >--disable-tcl --enable-threads --enable-shared
> >
> Use '--target=mips-linux' and you'll be better off. Don't worry, it
> will support both endians.

Except for this one - where'd that come from?  It should make no
functional difference either way, at least assuming you always give GDB
a binary.

> >gdbserver configured using:
> >
> >configure --prefix=/usr --host=mipsel-linux --target=mipsel-linux
> >--enable-threads --enable-shared
> >
> I would also try 'CC=mipsel-linux-gcc configure <...>'.

Definitely.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
