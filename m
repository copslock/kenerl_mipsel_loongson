Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Apr 2004 06:37:16 +0100 (BST)
Received: from europa.et.put.poznan.pl ([IPv6:::ffff:150.254.29.138]:27872
	"EHLO europa.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8224933AbUD1FhP>; Wed, 28 Apr 2004 06:37:15 +0100
Received: from europa (europa.et.put.poznan.pl [150.254.29.138])
	by europa.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3S5b7N07749;
	Wed, 28 Apr 2004 07:37:08 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by europa.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Wed, 28 Apr 2004 07:37:07 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3S5b6n09347;
	Wed, 28 Apr 2004 07:37:06 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Wed, 28 Apr 2004 07:37:06 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: Re: TLB on R10k
In-Reply-To: <20040427192828.GA7739@linux-mips.org>
Message-ID: <Pine.GSO.4.10.10404280734480.9183-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

> Have you verified that the UX bit is set correctly by your kernel?  BEV
> also plays a role but since you survive BogoMIPS it should be right.

From what I remember, the UX bit is fixed set. I have made the machine
print a '*' (no, I didn't use printk, but since it's my own console
driver I'm pretty sure it can work in interrupts - all it does is
hardware writes) whenever it gets a TLB refill and flushed the TLB before
entering usermode. Guess what, I didn't get a single '*' after ERET. To
verify my method, I've made a single read from the usermode PC from the
kernel, and the '*' appeared. I don't know what's up.

Stanislaw
