Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2004 09:26:51 +0100 (BST)
Received: from europa.et.put.poznan.pl ([IPv6:::ffff:150.254.29.138]:22965
	"EHLO europa.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8224912AbUHRI0r>; Wed, 18 Aug 2004 09:26:47 +0100
Received: from europa (europa.et.put.poznan.pl [150.254.29.138])
	by europa.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i7I8Qjd09001
	for <linux-mips@linux-mips.org>; Wed, 18 Aug 2004 10:26:45 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by europa.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Wed, 18 Aug 2004 10:26:45 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i7I8Qie17098
	for <linux-mips@linux-mips.org>; Wed, 18 Aug 2004 10:26:44 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Wed, 18 Aug 2004 10:26:44 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: linux-mips@linux-mips.org
Subject: Octane gfx works; SCSI woes
Message-ID: <Pine.GSO.4.10.10408181020010.16699-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

Hi again!

A new graphics driver for Octane is in order. This driver allows writing
user-mode gfx applications through register mapping and DMA. I would like
to ask anyone with an Octane to help me test this driver.

Currently, the only user-mode application taking advantage of this driver
is MPlayer, which works quite fine (if a bit slowly as there is no
assembly for MIPS - hint, hint!).

Especially wanted:
 * someone with SE/SI card (it is possible that the current driver is
   for double-RSS people only - MX*, SS* as I use RSS switching at some
   point - this has to be auto-detected and fixed!)
 * someone knowledgeable about SCSI (currently the ISP1040 controllers
   found in Octane bomb in a strange way with HCH's patched SCSI driver;
   they don't work at all with the QLISP driver).

Have fun,

Stanislaw Skowronek

--<=>--
  "You're not as old as the trees, not as young as the leaves.
   Not as free as the breeze, not as open as the seas."
