Received:  by oss.sgi.com id <S42424AbQJAJsF>;
	Sun, 1 Oct 2000 02:48:05 -0700
Received: from styx.cs.kuleuven.ac.be ([134.58.40.3]:52690 "EHLO
        styx.cs.kuleuven.ac.be") by oss.sgi.com with ESMTP
	id <S42232AbQJAJro>; Sun, 1 Oct 2000 02:47:44 -0700
Received: from cassiopeia.home (root@dialup004.cs.kuleuven.ac.be [134.58.47.133])
	by styx.cs.kuleuven.ac.be (8.10.1/8.10.1) with ESMTP id e919lTZ04773;
	Sun, 1 Oct 2000 11:47:29 +0200 (MET DST)
Received: from localhost (geert@localhost)
	by cassiopeia.home (8.9.3/8.9.3/Debian/GNU) with ESMTP id LAA00384;
	Sun, 1 Oct 2000 11:40:41 +0200
X-Authentication-Warning: cassiopeia.home: geert owned process doing -bs
Date:   Sun, 1 Oct 2000 11:40:41 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Florian Lohoff <flo@rfc822.org>
cc:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: Decstation broken Was: CVS Update@oss.sgi.com: linux
In-Reply-To: <20000929220103.A396@paradigm.rfc822.org>
Message-ID: <Pine.LNX.4.10.10010011140080.377-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 29 Sep 2000, Florian Lohoff wrote:
> tty00 at 0xbf900001 (irq = 4) is a Z85C30 SCC
> tty01 at 0xbf900009 (irq = 4) is a Z85C30 SCC
> tty02 at 0xbf980001 (irq = 4) is a Z85C30 SCC
> tty03 at 0xbf980009 (irq = 4) is a Z85C30 SCC

Shouldn't these be reported as ttyS0[0-3]?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
