Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Apr 2004 18:18:33 +0100 (BST)
Received: from athena.et.put.poznan.pl ([IPv6:::ffff:150.254.29.137]:62145
	"EHLO athena.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225457AbUDYRSa>; Sun, 25 Apr 2004 18:18:30 +0100
Received: from athena (athena [150.254.29.137])
	by athena.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3PHIJu03166
	for <linux-mips@linux-mips.org>; Sun, 25 Apr 2004 19:18:19 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by athena (MailMonitor for SMTP v1.2.2 ) ;
	Sun, 25 Apr 2004 19:18:19 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3PHIIo04098
	for <linux-mips@linux-mips.org>; Sun, 25 Apr 2004 19:18:18 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Sun, 25 Apr 2004 19:18:16 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: linux-mips@linux-mips.org
Subject: Work on IP30
Message-ID: <Pine.GSO.4.10.10404251914350.3916-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

Hello!

I have placed a alpha version of my patch for Octane at:

  http://www.et.put.poznan.pl/~sskowron/ip30/

Things currently unsupported:
  * SMP will not work,
  * qLogic SCSI driver oopses at the start,
  * keyboard is not written yet,
  * VPro (Odyssey) graphics,
  * ARCS console,
  * serial console,
  * PCI card cage (trivial, but I can't test it as I don't have one)

Things not yet tested:
  * new Octanes and Octane2s,
  * user mode (yes! I don't have yet a MIPS glibc to cross-compile for
    user mode),
  * almost everything

Stanislaw Skowronek

--<=>--
  Paranoid: one who is truly in touch with reality.
