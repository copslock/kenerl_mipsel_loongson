Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 May 2004 20:22:06 +0100 (BST)
Received: from athena.et.put.poznan.pl ([IPv6:::ffff:150.254.29.137]:28670
	"EHLO athena.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225722AbUEJTWF>; Mon, 10 May 2004 20:22:05 +0100
Received: from athena (athena [150.254.29.137])
	by athena.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i4AJM3g09192
	for <linux-mips@linux-mips.org>; Mon, 10 May 2004 21:22:03 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by athena (MailMonitor for SMTP v1.2.2 ) ;
	Mon, 10 May 2004 21:22:02 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i4AJM2305583
	for <linux-mips@linux-mips.org>; Mon, 10 May 2004 21:22:02 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Mon, 10 May 2004 21:22:02 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: linux-mips@linux-mips.org
Subject: Octane port - discoveries
Message-ID: <Pine.GSO.4.10.10405102119440.5439-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

Well, I've just noticed that get_saved_sp (in asm.h) is purely 32-bit.
After making a 64-bit-clean version (well, the Octane has its kernel_sp in
xkphys, not in ckseg0) the system boots a little farther. Still, it gets a
flagrant SIGSEGV, but at least it does not disappear without trace after
going usermode.

In fact it gets _infinite_ SIGSEGVs in mm/fault.c.

Time to get back to work.

Stanislaw Skowronek

--<=>--
  "You're not as old as the trees, not as young as the leaves.
   Not as free as the breeze, not as open as the seas."
