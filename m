Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jul 2005 15:05:52 +0100 (BST)
Received: from athena.et.put.poznan.pl ([IPv6:::ffff:150.254.29.137]:44188
	"EHLO athena.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8226468AbVGLOF3>; Tue, 12 Jul 2005 15:05:29 +0100
Received: from athena (athena.et.put.poznan.pl [150.254.29.137])
	by athena.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j6CE6TT29354
	for <linux-mips@linux-mips.org>; Tue, 12 Jul 2005 16:06:29 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by athena.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Tue, 12 Jul 2005 16:06:29 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j6CE6Sg09506
	for <linux-mips@linux-mips.org>; Tue, 12 Jul 2005 16:06:28 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date:	Tue, 12 Jul 2005 16:06:28 +0200 (MET DST)
From:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To:	linux-mips@linux-mips.org
Subject: Looking for a MIPS64 device
Message-ID: <Pine.GSO.4.10.10507121559350.8704-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

%hi16(all),

I'm looking for a MIPS64 device with FPU, and 40-bit physical address
space. I need I/O coherency (this is important!). I'd be glad if the
performance was good, but I'm not really bent on it.

This is for a research project in reconfigurable computing. I'd prefer
MIPS devices because they are elegant (the other choice is probably either
PowerPC or x86_64, which is really scary) and power-efficient. The project
is partially supported by Xilinx Inc.

I tried contacting Broadcom, when the project was conducted at the Poznan
University of Technology (my employer), however no contact was established
(not even a "go away, you're ugly"). Same went for PMC-Sierra.

Do you know of any MIPS64 device with FPU (and MMU, but it goes without
saying) that can be purchased in small quantities for a project like this?

Cheers,

Stanislaw Skowronek
