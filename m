Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Apr 2004 08:48:02 +0100 (BST)
Received: from athena.et.put.poznan.pl ([IPv6:::ffff:150.254.29.137]:22719
	"EHLO athena.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225397AbUDXHsC>; Sat, 24 Apr 2004 08:48:02 +0100
Received: from athena (athena [150.254.29.137])
	by athena.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3O7lvu17216
	for <linux-mips@linux-mips.org>; Sat, 24 Apr 2004 09:47:57 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by athena (MailMonitor for SMTP v1.2.2 ) ;
	Sat, 24 Apr 2004 09:47:57 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3O7lv114450
	for <linux-mips@linux-mips.org>; Sat, 24 Apr 2004 09:47:57 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Sat, 24 Apr 2004 09:47:56 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: linux-mips@linux-mips.org
Subject: Re: 32-bit ABI
In-Reply-To: <20040424074407.GA25730@linux-mips.org>
Message-ID: <Pine.GSO.4.10.10404240946510.14182-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

> > True, the kernel is *huge* (some 7 MB). But there *will* be pointer crops
> > if I'm using the xkphys, and I can't use ckseg0 because there are only 16
> > kilobytes of RAM mapped there for exceptions. So I have to use abi=64. It
> > does work for me, anyway.
> You could use a mapped address space, CKSEG2/3.

Yes, I could. I even know how to do that (thanks to Ralf's IP27 support),
however I think that making the kernel 64-bit-clean would benefit us all.

Stanislaw
