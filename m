Received:  by oss.sgi.com id <S42408AbQI2QFU>;
	Fri, 29 Sep 2000 09:05:20 -0700
Received: from styx.cs.kuleuven.ac.be ([134.58.40.3]:27580 "EHLO
        styx.cs.kuleuven.ac.be") by oss.sgi.com with ESMTP
	id <S42190AbQI2QEv>; Fri, 29 Sep 2000 09:04:51 -0700
Received: from cassiopeia.home (root@dialup006.cs.kuleuven.ac.be [134.58.47.135])
	by styx.cs.kuleuven.ac.be (8.10.1/8.10.1) with ESMTP id e8TG4TZ27773;
	Fri, 29 Sep 2000 18:04:30 +0200 (MET DST)
Received: from localhost (geert@localhost)
	by cassiopeia.home (8.9.3/8.9.3/Debian/GNU) with ESMTP id NAA00770;
	Fri, 29 Sep 2000 13:14:07 +0200
X-Authentication-Warning: cassiopeia.home: geert owned process doing -bs
Date:   Fri, 29 Sep 2000 13:14:07 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Florian Lohoff <flo@rfc822.org>
cc:     linux-mips@oss.sgi.com
Subject: Re: R3k Decstation broken
In-Reply-To: <20000928205359.A767@paradigm.rfc822.org>
Message-ID: <Pine.LNX.4.10.10009291312170.383-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 28 Sep 2000, Florian Lohoff wrote:
> it seems the r3k decstation stuff is broken 

> Calibrating delay loop... 
> 
> Full Stop !

Probably timer interrupts are no longer coming through, so jiffies never gets
incremented.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
