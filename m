Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2002 09:49:26 +0200 (CEST)
Received: from [212.74.13.151] ([212.74.13.151]:56305 "EHLO dell.zee2.com")
	by linux-mips.org with ESMTP id <S1122961AbSIRHt0>;
	Wed, 18 Sep 2002 09:49:26 +0200
Received: from zee2.com (localhost [127.0.0.1])
	by dell.zee2.com (8.11.6/8.11.6) with ESMTP id g8I7mqM13757
	for <linux-mips@linux-mips.org>; Wed, 18 Sep 2002 08:48:55 +0100
Message-ID: <3D882FE4.54787C25@zee2.com>
Date: Wed, 18 Sep 2002 08:48:52 +0100
From: Stuart Hughes <seh@zee2.com>
Organization: Zee2 Ltd
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: cannot debug multi-threaded programs with gdb/gdbserver
References: <3D876053.C2CD1D8C@zee2.com> <3D87653E.9030702@realitydiluted.com> <20020917182536.GA25012@nevyn.them.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <seh@zee2.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: seh@zee2.com
Precedence: bulk
X-list: linux-mips

Hi Steve/Daniel,

Thanks very much for your help ! I've now got a few days "homework" to
try out :-)

Regards, Stuart


Daniel Jacobowitz wrote:
> 
> On Tue, Sep 17, 2002 at 12:24:14PM -0500, Steven J. Hill wrote:
> > Stuart Hughes wrote:
> > >
> > >Does anyone know whether there is some special setup needed on
> > >gdb/gdbserver to use the multi-threaded gdbserver ??
> > >
> > Wow, there are so many things to tell you...where to start...
> 
> Steve, have you started memorizing my responses again? :)
> 
> > >My environment is as follows:
> > >
> > >CPU:         NEC VR5432
> > >kernel:      linux-2.4.18 + patches
> > >glibc:               2.2.3 + patches
> > >gdb:         5.2/3 from CVS
> > >
> > Has to be the gdb-5.3 branch...go look at http://sources.redhat.com/gdb
> >
> > >gcc:         3.1
> > >binutils:    Version 2.11.90.0.25
> > >
> > Don't use H.J. Lu's binutils, use the released one. Use gcc-3.2 and
> > binutils-2.13 as they have fixes for the MIPS debugging symbols with
> > regards to DWARF.
> >
> > >cross-gdb configured using:
> > >
> > >configure --prefix=/usr --target=mipsel-linux --disable-sim
> > >--disable-tcl --enable-threads --enable-shared
> > >
> > Use '--target=mips-linux' and you'll be better off. Don't worry, it
> > will support both endians.
> 
> Except for this one - where'd that come from?  It should make no
> functional difference either way, at least assuming you always give GDB
> a binary.
> 
> > >gdbserver configured using:
> > >
> > >configure --prefix=/usr --host=mipsel-linux --target=mipsel-linux
> > >--enable-threads --enable-shared
> > >
> > I would also try 'CC=mipsel-linux-gcc configure <...>'.
> 
> Definitely.
> 
> --
> Daniel Jacobowitz
> MontaVista Software                         Debian GNU/Linux Developer
