Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Apr 2004 19:07:35 +0100 (BST)
Received: from europa.et.put.poznan.pl ([IPv6:::ffff:150.254.29.138]:26821
	"EHLO europa.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8226045AbUD0SHc>; Tue, 27 Apr 2004 19:07:32 +0100
Received: from europa (europa.et.put.poznan.pl [150.254.29.138])
	by europa.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3RI7PN03302
	for <linux-mips@linux-mips.org>; Tue, 27 Apr 2004 20:07:25 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by europa.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Tue, 27 Apr 2004 20:07:24 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3RI7Oo15129
	for <linux-mips@linux-mips.org>; Tue, 27 Apr 2004 20:07:24 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Tue, 27 Apr 2004 20:07:23 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: linux-mips@linux-mips.org
Subject: TLB on R10k
Message-ID: <Pine.GSO.4.10.10404272004460.14972-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

Why, in tlb-andes.c, all exception handlers are prefixed with an
ampersand (&) when copying them to main memory, only the r10k fill handler
isn't? I'm getting a blackhole-style crash (no messages, no panic,
interrupts dead as a doornail, nobody knows what is happening) as soon as
I try to jump to usermode.

Stanislaw Skowronek

--<=>--
  Paranoid: one who is truly in touch with reality.
