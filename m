Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Apr 2004 21:51:20 +0100 (BST)
Received: from europa.et.put.poznan.pl ([IPv6:::ffff:150.254.29.138]:6125 "EHLO
	europa.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225226AbUDLUvS>; Mon, 12 Apr 2004 21:51:18 +0100
Received: from europa (europa.et.put.poznan.pl [150.254.29.138])
	by europa.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3CKpGf28591
	for <linux-mips@linux-mips.org>; Mon, 12 Apr 2004 22:51:16 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by europa.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Mon, 12 Apr 2004 22:51:15 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3CKpDM09112
	for <linux-mips@linux-mips.org>; Mon, 12 Apr 2004 22:51:13 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Mon, 12 Apr 2004 22:51:13 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: linux-mips@linux-mips.org
Subject: Work on IP30
Message-ID: <Pine.GSO.4.10.10404122244110.8735-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

My Octane got as far as 'Calibrating delay loop... ' now. It works with
ARCS graphical console, which is a Good Thing. Memory identification is
correct. Caches work OK. I'm going to do the IRQs tomorrow, but I foresee
it will be really hard as there is no documentation for the HEART. Well,
we shall experiment.

Fortunately, the Octane has one really nice feature: the power button is
hooked up to an interrupt source. It may prove quite useful for debugging.

Interesting note: the ARCS console breaks when I change KSEG0 cache
coherence in the CP0_CONFIG register (in c-r4k.c). Of course, it breaks
sooner or later, not exactly afterwards, unless I flush cache exactly
after changing; it breaks immediately then. I don't give a hoot, because
IP30 has almost no RAM in KSEG0 and the kernel runs in XKPHYS, always
cached copy-on-write. But those of you with another machines might be
interested.

Stanislaw Skowronek

--<=>--
  Paranoid: one who is truly in touch with reality.
