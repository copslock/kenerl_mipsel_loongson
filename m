Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 May 2005 20:43:55 +0100 (BST)
Received: from corvus.et.put.poznan.pl ([IPv6:::ffff:150.254.11.9]:32149 "EHLO
	corvus.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8224793AbVE0Tnk>; Fri, 27 May 2005 20:43:40 +0100
Received: from corvus (corvus.et.put.poznan.pl [150.254.11.9])
	by corvus.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j4RJhbe27443;
	Fri, 27 May 2005 21:43:37 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by corvus.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Fri, 27 May 2005 21:43:34 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j4RJhXS02115;
	Fri, 27 May 2005 21:43:33 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date:	Fri, 27 May 2005 21:43:32 +0200 (MET DST)
From:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To:	Cameron Cooper <developer@phatlinux.com>
cc:	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-mips@linux-mips.org
Subject: Re: Porting To New System
In-Reply-To: <1117218075.2921.2.camel@phatbox>
Message-ID: <Pine.GSO.4.10.10505272130200.1499-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

Rest assured, there will be no MMU interface. The machine is so incredibly
well-locked-down, especially the newer versions, that they must have done
that for a purpose (probably to stop pirated/cracked games from running).

All software that is going to run on the PSP is cryptographically signed
(probably also encrypted). The kernel is signed and encrypted, too. There
were some loopholes in 1.0 but nobody found any in 1.5 or later.

I'd suggest attacking the hardware to see what goes on in SDRAM. This is
going to be (relatively) expensive and (very) complex, and the result is
not guaranteed as there is some embedded DRAM inside the processors
(scary). However, if any kernel code is ever placed in external SDRAM, it
would be pretty doable to subvert it (would require stopping the CPU
accesses to the SDRAM, which we can probably do, more or less - for
instance running in a tight loop will probably place everything, including
parts of the timer IRQ, in cache, so no external accesses will be
happening). We can perform some writes to SDRAM then. I see a problem with
this method that it requires overpowering some signals on the bus.
Alternatively, we might want to multiplex those signals although it's not
gonna be easy with DDR at 100-200 MHz (probably - the routing on PCB looks
vaguely high-speedey and there is a nice differential clock pair, so DDR
is likely, and the memory chip itself is rated 6 ns, so DDR333).

Mucking with DDR is a hell of a job, even if you have really good hardware
at your disposal. I wonder how much would it be possible to slow it down
by changing the clock oscillator (probably less than 2x, unfortunately).
Monitoring DDR333 is doable but it is not easy.

That said, I'm seriously thinking about getting myself a PSP. I've already
got some serious digital hardware...

Hmmm.

Stanislaw
