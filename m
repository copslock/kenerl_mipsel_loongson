Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Apr 2003 21:26:25 +0100 (BST)
Received: from vopmail.sfo.interquest.net ([IPv6:::ffff:66.135.128.69]:2061
	"EHLO micaiah.rwc.iqcicom.com") by linux-mips.org with ESMTP
	id <S8225203AbTD2U0V>; Tue, 29 Apr 2003 21:26:21 +0100
Received: from Muruga.localdomain (unverified [66.135.134.124]) by micaiah.rwc.iqcicom.com
 (Vircom SMTPRS 2.0.244) with ESMTP id <B0006012496@micaiah.rwc.iqcicom.com>;
 Tue, 29 Apr 2003 13:26:17 -0700
Received: from localhost (muthu@localhost)
	by Muruga.localdomain (8.11.6/8.11.2) with ESMTP id h3TK63I09419;
	Tue, 29 Apr 2003 13:06:03 -0700
Date: Tue, 29 Apr 2003 13:06:03 -0700 (PDT)
From: Muthukumar Ratty <muthu@iqmail.net>
To: Michael Anburaj <michaelanburaj@hotmail.com>
cc: <linux-mips@linux-mips.org>
Subject: Re: Linux for MIPS Atlas 4Kc board
In-Reply-To: <BAY1-F39ahdtT8esYrJ0000a53e@hotmail.com>
Message-ID: <Pine.LNX.4.33.0304291305150.9198-100000@Muruga.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <muthu@iqmail.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2230
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: muthu@iqmail.net
Precedence: bulk
X-list: linux-mips



>
> It displayed a window with lot of options. But under processor I could only
> find flavors of x86 core.


where did you get the src? try the one at linux-mips.

>
> I thought there would be options to choose the board & then another to
> choose the processor.
>
> Let me know how to configure the linux build for MIPS Atlas 4Kc board & then
> actually to do a slim (or a lean) build (just the necessary drivers &
> packages).
>
> Also point me to documents regarding the configuration aspect of Linux for
> processors other than the x86 (like the ARM core, MIPS, PPC & like).
>
> Thanks a lot,
> -Mike.
>
>
>
>
> >From: Geert Uytterhoeven <geert@linux-m68k.org>
> >To: Michael Anburaj <michaelanburaj@hotmail.com>
> >CC: Linux/MIPS Development <linux-mips@linux-mips.org>
> >Subject: Re: Linux for MIPS Atlas 4Kc board
> >Date: Fri, 11 Apr 2003 12:04:03 +0200 (MEST)
> >
> >On Fri, 11 Apr 2003, Michael Anburaj wrote:
> > > linux-mips & mips-linux... did not catch my eyes, sorry.
> > >
> > > Let me know if mips-linux-gcc binaries for Windows is available for
> >free? If
> > > so, can you point me to the URL?
> > >
> > > Or is it easy to build it on the cygwin env. on windows following
> > > instructions given on the web? URL for the same?
> >
> >No idea, I use real Unices only. Follow the instructions to build a
> >cross-compiler on http://www.linux-mips.org/.
> >
> > > Thanks a lot, Thanks every body for helping me learn embedded-Linux.
> > >
> > > >From: Geert Uytterhoeven <geert@linux-m68k.org>
> > > >To: Michael Anburaj <michaelanburaj@hotmail.com>
> > > >CC: Ralf Baechle <ralf@linux-mips.org>,        Linux/MIPS Development
> > > ><linux-mips@linux-mips.org>
> > > >Subject: Re: Linux for MIPS Atlas 4Kc board
> > > >Date: Fri, 11 Apr 2003 11:28:51 +0200 (MEST)
> > > >
> > > >On Fri, 11 Apr 2003, Michael Anburaj wrote:
> > > > > Thanks Ralf.
> > > > >
> > > > > I want this question to be answered.
> > > > >
> > > > > Can I build linux on my Win98 machine for MIPS 4Kc Atlas board using
> > > > > mipsisa32-elf-gcc & make?
> > > >
> > > >No, you need mips-linux-gcc instead of mipsisa32-elf-gcc, as Ralf
> >already
> > > >told
> > > >you. mipsisa32-elf-gcc is not configured for building Linux kernels.
> > > >
> > > > > >From: Ralf Baechle <ralf@linux-mips.org>
> > > > > >To: Michael Anburaj <michaelanburaj@hotmail.com>
> > > > > >CC: linux-mips@linux-mips.org
> > > > > >Subject: Re: Linux for MIPS Atlas 4Kc board
> > > > > >Date: Thu, 10 Apr 2003 03:25:29 +0200
> > > > > >
> > > > > >On Wed, Apr 09, 2003 at 02:32:03PM -0700, Michael Anburaj wrote:
> > > > > >
> > > > > > > I am new to Linux. But I have a strong ARM & MIPS background
> >with
> > > >kernel
> > > > > > > porting & other stuff.
> > > > > > >
> > > > > > > I want to get a higher-level view of the essential components of
> > > >Linux
> > > > > >for
> > > > > > > MIPS & documentation about the kernel. Please point me to
> >documents
> > > >on
> > > > > >the
> > > > > > > net.
> > > > > >
> > > > > >I suggest http://www.linux-mips.org to get started.
> > > > > >
> > > > > > > Question 2:
> > > > > > > Does Linux-MIPS support the MIPS Atlas board with 4Kc processor
> > > >using
> > > > > > > mipsisa32-elf build tool chain (Contain the appropriate HAL or
> >BSP)?
> > > >Is
> > > > > >so,
> > > > > > > please point me to documents that gives the exact build steps
> >for
> > > >the
> > > > > >same.
> > > > > >
> > > > > >No.  You must use a Linux configuration of the tools, that's
> > > >mips-linux.
> > > > > >
> > > > > > > Also do let me know if Cygwin over Win98 dev. environment is
> >good
> > > >for
> > > > > > > building & developing with Linux-MIPS or do I need to have Linux
> > > > > >installed
> > > > > > > on my dev. machine?
> > > > > >
> > > > > >I've never use Cygwin myself.  The reports I've received are a
> >mixed
> > > >bag
> > > > > >ranging from extremly bad to very good.
> >
> >Gr{oetje,eeting}s,
> >
> >						Geert
> >
> >--
> >Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
> >geert@linux-m68k.org
> >
> >In personal conversations with technical people, I call myself a hacker.
> >But
> >when I'm talking to journalists I just say "programmer" or something like
> >that.
> >							    -- Linus Torvalds
> >
>
>
> _________________________________________________________________
> Help STOP SPAM with the new MSN 8 and get 2 months FREE*
> http://join.msn.com/?page=features/junkmail
>
>
