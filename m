Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Apr 2004 08:31:18 +0100 (BST)
Received: from athena.et.put.poznan.pl ([IPv6:::ffff:150.254.29.137]:58557
	"EHLO athena.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225397AbUDXHbR>; Sat, 24 Apr 2004 08:31:17 +0100
Received: from athena (athena [150.254.29.137])
	by athena.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3O7VFu17128;
	Sat, 24 Apr 2004 09:31:15 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by athena (MailMonitor for SMTP v1.2.2 ) ;
	Sat, 24 Apr 2004 09:31:14 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3O7VE313604;
	Sat, 24 Apr 2004 09:31:14 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Sat, 24 Apr 2004 09:31:14 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: Re: 32-bit ABI
In-Reply-To: <20040424071751.GA561@linux-mips.org>
Message-ID: <Pine.GSO.4.10.10404240927450.13336-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

> So there is no relation at all to modules.  You btw. can load 64-bit ELF
> modules into a kernel which was built using above trick as 32-bit ELF.
> That's necessary because modules are currently allocated through vmalloc
> which allocates space in XKSEG.

Ah, so it's like that. Great. Is the ELF64 support still not correct?

> > I have changed it to 64-bit abi in my Octane kernel, because it won't even
> > compile otherwise. I've got gcc 3.3.2, gas 2.14.
> Octane has no memory at all in CKSEG0?

Well, as far as I know, and I'm probably right, it _does_ have some memory
there. A whopping 16 kilobytes of memory mirrored by the HEART to allow
placing exception vectors there (what a weird idea).

And you can't remap, I repeat, can't remap anything under 0x20000000
because there are the small Xtalk windows and HEART registers and God only
knows what else.

Stanislaw Skowronek
