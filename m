Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Apr 2004 10:00:49 +0100 (BST)
Received: from athena.et.put.poznan.pl ([IPv6:::ffff:150.254.29.137]:6347 "EHLO
	athena.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225951AbUDXJAq>; Sat, 24 Apr 2004 10:00:46 +0100
Received: from athena (athena [150.254.29.137])
	by athena.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3O90iu18014
	for <linux-mips@linux-mips.org>; Sat, 24 Apr 2004 11:00:44 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by athena (MailMonitor for SMTP v1.2.2 ) ;
	Sat, 24 Apr 2004 11:00:44 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3O90i218419
	for <linux-mips@linux-mips.org>; Sat, 24 Apr 2004 11:00:44 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Sat, 24 Apr 2004 11:00:44 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: linux-mips@linux-mips.org
Subject: pci-ip27 memory ranges
Message-ID: <Pine.GSO.4.10.10404241059030.18252-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

Why does the pci-ip27 driver register all memory resources (0UL - ~0UL)? I
had to change it to the appropriate Xtalk window to get the kernel to
recognize PCI at all.

Now, the IOC3 makes a kernel panic. Will see...

Stanislaw Skowronek

--<=>--
  Paranoid: one who is truly in touch with reality.
