Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Apr 2004 18:14:42 +0100 (BST)
Received: from europa.et.put.poznan.pl ([IPv6:::ffff:150.254.29.138]:18611
	"EHLO europa.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225964AbUDXROl>; Sat, 24 Apr 2004 18:14:41 +0100
Received: from europa (europa.et.put.poznan.pl [150.254.29.138])
	by europa.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3OHEYN17551
	for <linux-mips@linux-mips.org>; Sat, 24 Apr 2004 19:14:34 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by europa.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Sat, 24 Apr 2004 19:14:33 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3OHEWB10499
	for <linux-mips@linux-mips.org>; Sat, 24 Apr 2004 19:14:32 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Sat, 24 Apr 2004 19:14:32 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: linux-mips@linux-mips.org
Subject: Xtalk bridge IRQs
Message-ID: <Pine.GSO.4.10.10404241914160.10450-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

Hello!

I've got a problem with Xtalk-PCI bridge IRQs. The IOC3 should send an
interrupt before transmitting a packet. I don't know if it sends it or
not, but for sure it does not arrive to me. The power button interrupt,
which is also routed via the bridge, works OK, so the IRQ router part of
the bridge is correctly services. However, I can't get any PCI interrupts.

Stanislaw Skowronek

--<=>--
  Paranoid: one who is truly in touch with reality.
