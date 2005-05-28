Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 May 2005 08:30:44 +0100 (BST)
Received: from corvus.et.put.poznan.pl ([IPv6:::ffff:150.254.11.9]:8873 "EHLO
	corvus.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225234AbVE1Ha1>; Sat, 28 May 2005 08:30:27 +0100
Received: from corvus (corvus.et.put.poznan.pl [150.254.11.9])
	by corvus.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j4S7UOe01942;
	Sat, 28 May 2005 09:30:24 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by corvus.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Sat, 28 May 2005 09:30:23 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j4S7ULs26955;
	Sat, 28 May 2005 09:30:22 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date:	Sat, 28 May 2005 09:30:21 +0200 (MET DST)
From:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
cc:	linux-mips@linux-mips.org
Subject: Re: Porting To New System
In-Reply-To: <1117235565.5730.255.camel@localhost.localdomain>
Message-ID: <Pine.GSO.4.10.10505280852210.25329-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

> > Rest assured, there will be no MMU interface. 
> You seem remarkably confident for someone who has never taken one apart.

Hi.

Sorry if you felt it was overconfident. However I can't think of a really
good reason to give developers a MMU interface, and if I was a Sony
designer I would not do anything that might endanger the "trusted system"
position - so the KISS principle would be my guiding light.

Xen-style MMU access is not KISS at all. This is why I think that there
would be no such thing. The DMA is handled by kernel, so no need for
user-level physical memory access. I would assume that the VRAM is
probably constantly mapped in userspace or something like that - in a
gaming system it would be only natural. And so on. Especially, they are
not interested at all in emulators/virtual machines. Communicating with 3D
engine is done by sceGe* functions that take display lists, so you don't
even have to send them by hand. In the leaked parts of SDK there are few
candidates for functions that might influence the MMU (granted, one is
enough).

I would really like to do the h/w hack. It seems that it will be doable
(although not really easy). And having real-time access to external SDRAM
of the PSP might solve most of our problems. There is exactly one trouble:
time (I have the required hardware, and I can do a FPGA design that would
mirror PSP's SDRAM in external memory, and I can find somebody to do the
tricky BGA soldering). But I don't have the time.

The h/w hack would work unless the PSP is capable of decoding code on it's
way from SDRAM to cache (which would be very wasteful, but if they are
really paranoid, quite justified). However, on published block-diagrams,
the crypto hardware is on a DMA bus, and quite far from the DDR SDRAM in
question. Other dire possibility would be of the kernel never being placed
in external memory (always in internal eDRAM). I don't know how to counter
that.

I think the ucLinux way is the best thing to do right now. It will be
quite impressive. Pity 1.5 won't take it :/

Cheers,

Stanislaw

PS. Besides, does taking one apart actually impart any knowledge? I looked
at the photos, if that helps ;)
