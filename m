Received:  by oss.sgi.com id <S553725AbQJTSAg>;
	Fri, 20 Oct 2000 11:00:36 -0700
Received: from styx.cs.kuleuven.ac.be ([134.58.40.3]:46758 "EHLO
        styx.cs.kuleuven.ac.be") by oss.sgi.com with ESMTP
	id <S553694AbQJTSAV>; Fri, 20 Oct 2000 11:00:21 -0700
Received: from cassiopeia.home (root@dialup001.cs.kuleuven.ac.be [134.58.47.130])
	by styx.cs.kuleuven.ac.be (8.10.1/8.10.1) with ESMTP id e9KHxu325315;
	Fri, 20 Oct 2000 19:59:58 +0200 (MET DST)
Received: from localhost (geert@localhost)
	by cassiopeia.home (8.9.3/8.9.3/Debian/GNU) with ESMTP id QAA20751;
	Fri, 20 Oct 2000 16:55:44 +0200
X-Authentication-Warning: cassiopeia.home: geert owned process doing -bs
Date:   Fri, 20 Oct 2000 16:55:44 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Jun Sun <jsun@mvista.com>
cc:     linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: The initial results (Re: stable binutils, gcc, glibc ...
In-Reply-To: <39EDDA98.9C21949D@mvista.com>
Message-ID: <Pine.LNX.4.10.10010201653150.405-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 18 Oct 2000, Jun Sun wrote:
> Geert Uytterhoeven wrote:
> > On Tue, 17 Oct 2000, Jun Sun wrote:
> > > If you have NEC DDB5476 board, you can also try out my kernel on the
> > > following place.  This kernel supports nfs rootfs through on-board ether
> > 
> > Was it difficult to get the builtin Ethernet working? I mean, is it now
> > trivial to get it to work on the ddb5074 as well? I'm still not at work, so I
> > cannot play with^H^H^H^H^H^H^H^H^Hwork on it myself.
> 
> It was a tough problem, and it took me a long time to figure out. 
> Basically, the srom only contains mac address - no check sum nor media
> tables.  You need to by pass the checksum checking and eeprom parsing in

Having worked on Tulip drivers for the DDB (for another OS), I was already 
ware of that.

> the driver code.  In addition, I have to reset the tulip chip at the
> board startup time.  I use pmon to do the downloading.  Pmon must have
> set the chip in some state that the linux driver cannot successfully
> re-initialize it by default.

Ah, so  that's the big problem! I never bothered to try resetting the Tulip.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
