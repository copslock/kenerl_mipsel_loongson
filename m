Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Apr 2004 09:17:49 +0100 (BST)
Received: from europa.et.put.poznan.pl ([IPv6:::ffff:150.254.29.138]:37527
	"EHLO europa.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225951AbUDXIRs>; Sat, 24 Apr 2004 09:17:48 +0100
Received: from europa (europa.et.put.poznan.pl [150.254.29.138])
	by europa.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3O8HiN13000
	for <linux-mips@linux-mips.org>; Sat, 24 Apr 2004 10:17:44 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by europa.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Sat, 24 Apr 2004 10:17:43 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3O8HgZ16205
	for <linux-mips@linux-mips.org>; Sat, 24 Apr 2004 10:17:42 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Sat, 24 Apr 2004 10:17:42 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: linux-mips@linux-mips.org
Subject: Re: 32-bit ABI
In-Reply-To: <20040424081405.GA26165@linux-mips.org>
Message-ID: <Pine.GSO.4.10.10404241015150.15622-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4884
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

> The first kernel was built with the stock Makefile; the second was modified
> to use 64-bit ELF using gcc 2.95.4 / binutils 2.13.2.1.  So I'd call those
> 817559 bytes kernel obesity ;)

Yeah, true. It's really appalling. Make it a config option then, default
'n'. I will set it to 'y' for SGI_IP30. The Octane firmware has no
problems booting ELF64 (don't know about ELF32 though).

> > Yeah. The weirdness is not in that part; what's weird is placing the rest
> > of memory somewhere else.
> Not uncommon on SGI systems.  The Indy's memory also starts at 128MB; only
> a few kB for exeption vectors are mirrored to physical address 0.

They made a habit of this. The bastards. ;)

Stanislaw
