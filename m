Received:  by oss.sgi.com id <S554085AbRA1S4W>;
	Sun, 28 Jan 2001 10:56:22 -0800
Received: from hermes.cs.kuleuven.ac.be ([134.58.40.3]:26310 "EHLO
        hermes.cs.kuleuven.ac.be") by oss.sgi.com with ESMTP
	id <S554064AbRA1S4G>; Sun, 28 Jan 2001 10:56:06 -0800
Received: from cassiopeia.home (root@dialup001.cs.kuleuven.ac.be [134.58.47.130])
	by hermes.cs.kuleuven.ac.be (A_Good_MTA/8.11.1) with ESMTP id f0SItrr00985;
	Sun, 28 Jan 2001 19:55:54 +0100 (MET)
Received: from localhost (geert@localhost)
	by cassiopeia.home (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id TAA01176;
	Sun, 28 Jan 2001 19:30:40 +0100
X-Authentication-Warning: cassiopeia.home: geert owned process doing -bs
Date:   Sun, 28 Jan 2001 19:30:40 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Florian Lohoff <flo@rfc822.org>,
        Pete Popov <ppopov@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: Cross compiling RPMs
In-Reply-To: <20010127105018.D867@bacchus.dhis.org>
Message-ID: <Pine.LNX.4.10.10101281927430.1105-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, 27 Jan 2001, Ralf Baechle wrote:
> I recently was told there is some m68k VME system out there which needs
> approx. 3 days to rebuild it's kernel.

Since even my 25 MHz 68040 only ca. 6 hours to build a complete 2.4.0 kernel
(incl. lots of modules) these days, that's probably an underclocked 68020 or
so? :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
