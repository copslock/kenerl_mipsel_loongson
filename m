Received:  by oss.sgi.com id <S553720AbRCDSMk>;
	Sun, 4 Mar 2001 10:12:40 -0800
Received: from hermes.cs.kuleuven.ac.be ([134.58.40.3]:38318 "EHLO
        hermes.cs.kuleuven.ac.be") by oss.sgi.com with ESMTP
	id <S553715AbRCDSM3>; Sun, 4 Mar 2001 10:12:29 -0800
Received: from cassiopeia.home (root@dialup004.cs.kuleuven.ac.be [134.58.47.133])
	by hermes.cs.kuleuven.ac.be (A_Good_MTA/8.11.1) with ESMTP id f24ICQT21536;
	Sun, 4 Mar 2001 19:12:26 +0100 (MET)
Received: from localhost (geert@localhost)
	by cassiopeia.home (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id QAA01687;
	Sat, 3 Mar 2001 16:15:07 +0100
X-Authentication-Warning: cassiopeia.home: geert owned process doing -bs
Date:   Sat, 3 Mar 2001 16:15:05 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Carsten Langgaard <carstenl@mips.com>, linux-mips@oss.sgi.com
Subject: Re: Bug in get_insn_opcode.
In-Reply-To: <20010303082115.B5750@bacchus.dhis.org>
Message-ID: <Pine.LNX.4.10.10103031614440.455-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, 3 Mar 2001, Ralf Baechle wrote:
> On Fri, Mar 02, 2001 at 05:56:48PM +0100, Carsten Langgaard wrote:
> > Index: arch/mips/kernel/traps.c
> > ===================================================================
> > RCS file: /home/repository/sw/linux-2.4.0/arch/mips/kernel/traps.c,v
> > retrieving revision 1.10
> > diff -u -r1.10 traps.c
> > --- traps.c     2001/02/28 13:46:43     1.10
> > +++ traps.c     2001/03/02 16:50:27
> 
> Patch will behave (un-)funny on a cvs diff generated patch like this which
> lacks full pathnames in the --- and +++ lines.  Patches for this
> behaviour are available on ftp.cyclic.com (so it still exists ...) or in
> more recent cvs rpms.

Isn't patch supposed to look at the `Index' line?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
