Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Apr 2004 08:46:54 +0100 (BST)
Received: from europa.et.put.poznan.pl ([IPv6:::ffff:150.254.29.138]:46485
	"EHLO europa.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225397AbUDXHqx>; Sat, 24 Apr 2004 08:46:53 +0100
Received: from europa (europa.et.put.poznan.pl [150.254.29.138])
	by europa.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3O7kmN12684;
	Sat, 24 Apr 2004 09:46:48 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by europa.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Sat, 24 Apr 2004 09:46:47 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3O7klS14381;
	Sat, 24 Apr 2004 09:46:47 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Sat, 24 Apr 2004 09:46:46 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: Re: 32-bit ABI
In-Reply-To: <20040424073802.GA25515@linux-mips.org>
Message-ID: <Pine.GSO.4.10.10404240945500.14182-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

> > Ah, so it's like that. Great. Is the ELF64 support still not correct?
> No, it's supposed to be working now.

OK. File it away under 'compatibility cruft' then ;)

> > Well, as far as I know, and I'm probably right, it _does_ have some memory
> > there. A whopping 16 kilobytes of memory mirrored by the HEART to allow
> > placing exception vectors there (what a weird idea).
> That's what the processor expects.

Yeah. The weirdness is not in that part; what's weird is placing the rest
of memory somewhere else.

Stanislaw
