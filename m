Received:  by oss.sgi.com id <S553720AbQJRQ2B>;
	Wed, 18 Oct 2000 09:28:01 -0700
Received: from styx.cs.kuleuven.ac.be ([134.58.40.3]:62444 "EHLO
        styx.cs.kuleuven.ac.be") by oss.sgi.com with ESMTP
	id <S553712AbQJRQ2A>; Wed, 18 Oct 2000 09:28:00 -0700
Received: from cassiopeia.home (root@dialup004.cs.kuleuven.ac.be [134.58.47.133])
	by styx.cs.kuleuven.ac.be (8.10.1/8.10.1) with ESMTP id e9IGRin06144;
	Wed, 18 Oct 2000 18:27:44 +0200 (MET DST)
Received: from localhost (geert@localhost)
	by cassiopeia.home (8.9.3/8.9.3/Debian/GNU) with ESMTP id NAA01143;
	Wed, 18 Oct 2000 13:42:21 +0200
X-Authentication-Warning: cassiopeia.home: geert owned process doing -bs
Date:   Wed, 18 Oct 2000 13:42:20 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Jun Sun <jsun@mvista.com>
cc:     linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: The initial results (Re: stable binutils, gcc, glibc ...
In-Reply-To: <39ED2166.9B5F970@mvista.com>
Message-ID: <Pine.LNX.4.10.10010181340380.841-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 17 Oct 2000, Jun Sun wrote:
> If you have NEC DDB5476 board, you can also try out my kernel on the
> following place.  This kernel supports nfs rootfs through on-board ether

Was it difficult to get the builtin Ethernet working? I mean, is it now
trivial to get it to work on the ddb5074 as well? I'm still not at work, so I
cannot play with^H^H^H^H^H^H^H^H^Hwork on it myself.

> port, IDE disk, PS/2 keyboard/mouse, Voodoo3 2000/3000 PCI graphic cards
> (framebuffer driver).

Cool! Graphics!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
