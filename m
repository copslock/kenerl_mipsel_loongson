Received:  by oss.sgi.com id <S553725AbQJRROl>;
	Wed, 18 Oct 2000 10:14:41 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:12785 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553717AbQJRROY>;
	Wed, 18 Oct 2000 10:14:24 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e9IHCNx21657;
	Wed, 18 Oct 2000 10:12:23 -0700
Message-ID: <39EDDA98.9C21949D@mvista.com>
Date:   Wed, 18 Oct 2000 10:15:04 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: The initial results (Re: stable binutils, gcc, glibc ...
References: <Pine.LNX.4.10.10010181340380.841-100000@cassiopeia.home>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Geert Uytterhoeven wrote:
> 
> On Tue, 17 Oct 2000, Jun Sun wrote:
> > If you have NEC DDB5476 board, you can also try out my kernel on the
> > following place.  This kernel supports nfs rootfs through on-board ether
> 
> Was it difficult to get the builtin Ethernet working? I mean, is it now
> trivial to get it to work on the ddb5074 as well? I'm still not at work, so I
> cannot play with^H^H^H^H^H^H^H^H^Hwork on it myself.
> 

It was a tough problem, and it took me a long time to figure out. 
Basically, the srom only contains mac address - no check sum nor media
tables.  You need to by pass the checksum checking and eeprom parsing in
the driver code.  In addition, I have to reset the tulip chip at the
board startup time.  I use pmon to do the downloading.  Pmon must have
set the chip in some state that the linux driver cannot successfully
re-initialize it by default.

I also layout the PCI memory space idential to the physical memory
space, ie., system ram starts from 0.  I was concerned some drivers
don't do address translations between these two address spaces.

I actually have a DDB5074 board myself.  I can try it out myself, but I
am a little lazy to do that - not sure if anybody is still interested in
that board.

> > port, IDE disk, PS/2 keyboard/mouse, Voodoo3 2000/3000 PCI graphic cards
> > (framebuffer driver).
> 
> Cool! Graphics!
>

It is fun to have graphics.  Yesterday I got hold of a MediaQ 200 card
and a fb driver for it.  It works like a charm.

Jun
