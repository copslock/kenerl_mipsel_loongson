Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Apr 2003 11:04:03 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:31651 "EHLO
	mail.sonytel.be") by linux-mips.org with ESMTP id <S8225211AbTDKKED>;
	Fri, 11 Apr 2003 11:04:03 +0100
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0p/8.8.6) with ESMTP id MAA11373;
	Fri, 11 Apr 2003 12:03:50 +0200 (MET DST)
Date: Fri, 11 Apr 2003 12:04:03 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Anburaj <michaelanburaj@hotmail.com>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Linux for MIPS Atlas 4Kc board
In-Reply-To: <BAY1-F124jn04x29xDb00011e0b@hotmail.com>
Message-ID: <Pine.GSO.4.21.0304111203070.16390-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 11 Apr 2003, Michael Anburaj wrote:
> linux-mips & mips-linux... did not catch my eyes, sorry.
> 
> Let me know if mips-linux-gcc binaries for Windows is available for free? If 
> so, can you point me to the URL?
> 
> Or is it easy to build it on the cygwin env. on windows following 
> instructions given on the web? URL for the same?

No idea, I use real Unices only. Follow the instructions to build a
cross-compiler on http://www.linux-mips.org/.

> Thanks a lot, Thanks every body for helping me learn embedded-Linux.
> 
> >From: Geert Uytterhoeven <geert@linux-m68k.org>
> >To: Michael Anburaj <michaelanburaj@hotmail.com>
> >CC: Ralf Baechle <ralf@linux-mips.org>,        Linux/MIPS Development 
> ><linux-mips@linux-mips.org>
> >Subject: Re: Linux for MIPS Atlas 4Kc board
> >Date: Fri, 11 Apr 2003 11:28:51 +0200 (MEST)
> >
> >On Fri, 11 Apr 2003, Michael Anburaj wrote:
> > > Thanks Ralf.
> > >
> > > I want this question to be answered.
> > >
> > > Can I build linux on my Win98 machine for MIPS 4Kc Atlas board using
> > > mipsisa32-elf-gcc & make?
> >
> >No, you need mips-linux-gcc instead of mipsisa32-elf-gcc, as Ralf already 
> >told
> >you. mipsisa32-elf-gcc is not configured for building Linux kernels.
> >
> > > >From: Ralf Baechle <ralf@linux-mips.org>
> > > >To: Michael Anburaj <michaelanburaj@hotmail.com>
> > > >CC: linux-mips@linux-mips.org
> > > >Subject: Re: Linux for MIPS Atlas 4Kc board
> > > >Date: Thu, 10 Apr 2003 03:25:29 +0200
> > > >
> > > >On Wed, Apr 09, 2003 at 02:32:03PM -0700, Michael Anburaj wrote:
> > > >
> > > > > I am new to Linux. But I have a strong ARM & MIPS background with 
> >kernel
> > > > > porting & other stuff.
> > > > >
> > > > > I want to get a higher-level view of the essential components of 
> >Linux
> > > >for
> > > > > MIPS & documentation about the kernel. Please point me to documents 
> >on
> > > >the
> > > > > net.
> > > >
> > > >I suggest http://www.linux-mips.org to get started.
> > > >
> > > > > Question 2:
> > > > > Does Linux-MIPS support the MIPS Atlas board with 4Kc processor 
> >using
> > > > > mipsisa32-elf build tool chain (Contain the appropriate HAL or BSP)? 
> >Is
> > > >so,
> > > > > please point me to documents that gives the exact build steps for 
> >the
> > > >same.
> > > >
> > > >No.  You must use a Linux configuration of the tools, that's 
> >mips-linux.
> > > >
> > > > > Also do let me know if Cygwin over Win98 dev. environment is good 
> >for
> > > > > building & developing with Linux-MIPS or do I need to have Linux
> > > >installed
> > > > > on my dev. machine?
> > > >
> > > >I've never use Cygwin myself.  The reports I've received are a mixed 
> >bag
> > > >ranging from extremly bad to very good.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
