Received:  by oss.sgi.com id <S305194AbQDCJSM>;
	Mon, 3 Apr 2000 02:18:12 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:25899 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305164AbQDCJSG>;
	Mon, 3 Apr 2000 02:18:06 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id CAA26760; Mon, 3 Apr 2000 02:13:24 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA33495
	for linux-list;
	Mon, 3 Apr 2000 02:09:16 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA31768
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 3 Apr 2000 02:09:14 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA08127
	for <linux@cthulhu.engr.sgi.com>; Mon, 3 Apr 2000 02:09:11 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from dandelion.sonytel.be (dandelion.sonytel.be [193.74.243.153])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id LAA16365;
	Mon, 3 Apr 2000 11:09:01 +0200 (MET DST)
Date:   Mon, 3 Apr 2000 11:09:00 +0200 (MET DST)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     Florian Lohoff <flo@rfc822.org>
cc:     linux@cthulhu.engr.sgi.com
Subject: Re: mips config.in patch 1 of N - Check for completeness
In-Reply-To: <20000403103944.A278@paradigm.rfc822.org>
Message-ID: <Pine.GSO.4.10.10004031105420.22512-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, 3 Apr 2000, Florian Lohoff wrote:
> On Mon, Apr 03, 2000 at 10:29:31AM +0200, Geert Uytterhoeven wrote:
> > On Sun, 2 Apr 2000, Florian Lohoff wrote:
> > > +	#Architectures possibly having pcmcia should include this
> > > +        #source drivers/pcmcia/Config.in
> > 
> > i.e. CONFIG_PCI || CONFIG_ISA
> 
> I didnt want to do that because i dont think anyone has seen
> a RM200C with PCMCIA ? So i thought architectures explecitely 
> having a PCMCIA (Like probably the Handhelds like Aero, Cassiopaia etc)
> would enable it with "CONFIG_AERO" or something.

If it has PCI slots, you can insert a PCMCIA or Cardbus bridging card.
Furthermore many wireless networking cards are just PCMCIA/Cardbus bridges with
PC-card socket containing a standard wireless PC-card.

> > > +	#Architectures having PC Style Parports - please include
> > > +        #source drivers/parport/Config.in
> > 
> > i.e. CONFIG_ISA
> > 
> > Note that here are also non-PC style parport drivers (e.g. for Amiga), but for
> > MIPS I think the PC-style parports are the only ones that matter.
> 
> Are they represented in the above config ? ...

Yes. There's even support for ATARI, Archimedes and SBUS. Unlike other
subsystems, `PC-style hardware' is only a small section of the Config.in.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248638 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
