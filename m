Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id HAA535522 for <linux-archive@neteng.engr.sgi.com>; Fri, 28 Nov 1997 07:11:33 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id HAA14531 for linux-list; Fri, 28 Nov 1997 07:10:44 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA14526 for <linux@cthulhu.engr.sgi.com>; Fri, 28 Nov 1997 07:10:42 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id HAA03227
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 Nov 1997 07:10:41 -0800
	env-from (ralf@mailhost.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id QAA15430;
	Fri, 28 Nov 1997 16:10:38 +0100 (MET)
Received: by thoma (SMI-8.6/KO-2.0)
	id QAA13069; Fri, 28 Nov 1997 16:10:37 +0100
Message-ID: <19971128161036.24017@thoma.uni-koblenz.de>
Date: Fri, 28 Nov 1997 16:10:36 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ralf Baechle <ralf@mailhost.uni-koblenz.de>, ralf@mailhost.uni-koblenz.de,
        linux@cthulhu.engr.sgi.com
Subject: Re: Bintuils
References: <19971128145410.36065@thoma.uni-koblenz.de> <m0xbRqY-0005FvC@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <m0xbRqY-0005FvC@lightning.swansea.linux.org.uk>; from Alan Cox on Fri, Nov 28, 1997 at 02:56:45PM +0000
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Nov 28, 1997 at 02:56:45PM +0000, Alan Cox wrote:
> >   - manually rebuild binutils 2.8.1 + patch.  When configuring binutils
> >     2.8.1 do not use the --enable-shared option, it will make binutils
> >     2.7 generate bad libraries.
> 
> Done that. I get a static and apparently workable binutils if I also turn
> gcc optimisation off (otherwise gcc dumps)
> 
> >   - install the binutils just built
> 
> Done that
> 
> >   - You should now be able to rebuild the rpm without problems
> 
> gcc still dumps, if I fix that I get back to the original problem. This
> is the 2.8.1 off sgi.com and has a "mips patch" listed in the spec file.
> 
> Im guessing the gcc one is a link bug that damaged gcc just slightly - zsh
> also dumps gcc.

In that case you are probably the victim of an older libc.  I'll rebuild
libc for my sources for big endian machines asap.

  Ralf
