Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4AITvb10250
	for linux-mips-outgoing; Thu, 10 May 2001 11:29:57 -0700
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4AITtF10247
	for <linux-mips@oss.sgi.com>; Thu, 10 May 2001 11:29:56 -0700
Received: from rose.sonytel.be (rose.sonytel.be [10.17.0.5])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id UAA05139;
	Thu, 10 May 2001 20:24:23 +0200 (MET DST)
Date: Thu, 10 May 2001 20:23:41 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Wayne Gowcher <wgowcher@yahoo.com>
cc: Pete Popov <ppopov@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: Configuration of PCI Video card on a BIOS-less board
In-Reply-To: <20010510175339.83183.qmail@web11904.mail.yahoo.com>
Message-ID: <Pine.GSO.4.10.10105102021160.14224-100000@rose.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 10 May 2001, Wayne Gowcher wrote:
> The original card i had a problem had an ATI Rage
> chip. I am now experimenting with a VGA card with a
> Cirrus Logic chip. I've got this card to accept the
> programmed base address and am in teh process of
> studying clgenfb.c to see if I can modify it to my
> needs. 
> On first inspection clgenfb.c is written for the
> Amiga??? and so I am trying to weed out the
> dependencies. If anyone knows of a more generic driver
> it would be much appreciated.

Clgenfb supports both Amiga Zorro cards with a Cirrus Logic chip and PCI cards.
Note that it may depend on some chip initialisation already been done.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
