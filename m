Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 May 2004 05:25:19 +0100 (BST)
Received: from europa.et.put.poznan.pl ([IPv6:::ffff:150.254.29.138]:9926 "EHLO
	europa.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8224827AbUEOEZR>; Sat, 15 May 2004 05:25:17 +0100
Received: from europa (europa.et.put.poznan.pl [150.254.29.138])
	by europa.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i4F4PFb18263
	for <linux-mips@linux-mips.org>; Sat, 15 May 2004 06:25:15 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by europa.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Sat, 15 May 2004 06:25:14 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i4F4PDN02960
	for <linux-mips@linux-mips.org>; Sat, 15 May 2004 06:25:13 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Sat, 15 May 2004 06:25:13 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: linux-mips@linux-mips.org
Subject: CONFIG_MDULES (?)
Message-ID: <Pine.GSO.4.10.10405150622100.2828-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

Hello,

long-standing bug: in arch/mips/kernel/traps.c we've got an '#ifdef
CONFIG_MDULES". As there is no config by this name, the dbe handling code
for modules will never get compiled.

As it is, it won't compile anyway, because some necessary variables are
static in kernel/module.c (modlist_lock and modules). After making them
non-static and making correct 'extern's in traps.c it's OK. A small change
to include/asm-mips/module.h was needed (add num_dbeentries field).

All these will be included in my XKPHYS_KERNEL patch in a few days.

Stanislaw Skowronek

--<=>--
  "You're not as old as the trees, not as young as the leaves.
   Not as free as the breeze, not as open as the seas."
