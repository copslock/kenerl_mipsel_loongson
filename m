Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id XAA667103 for <linux-archive@neteng.engr.sgi.com>; Sat, 29 Nov 1997 23:20:18 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id XAA12341 for linux-list; Sat, 29 Nov 1997 23:11:49 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id XAA12330 for <linux@engr.sgi.com>; Sat, 29 Nov 1997 23:11:39 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id XAA12941
	for <linux@engr.sgi.com>; Sat, 29 Nov 1997 23:11:37 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-13.uni-koblenz.de [141.26.249.13])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id IAA00493
	for <linux@engr.sgi.com>; Sun, 30 Nov 1997 08:11:35 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id IAA00710;
	Sun, 30 Nov 1997 08:08:35 +0100
Message-ID: <19971130080835.57467@uni-koblenz.de>
Date: Sun, 30 Nov 1997 08:08:35 +0100
To: linux@cthulhu.engr.sgi.com, msalter@cygnus.com
Subject: Indy interrupt latencies & performance
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

five minutes starring at the wd33c93 driver solved the problem.  When
applying Linus' patches a superfluous disable_irq() was left over in
wd33c93.c:wd33c93_queuecommand().  Removing the line makes the box feel
like a computer again.  This should also explain the ultralong times
measured by Mark during which interrupt were disabled.  Patch appended below.

  Ralf

--- drivers/scsi/wd33c93.c.orig	Sun Nov 30 07:12:08 1997
+++ drivers/scsi/wd33c93.c	Sun Nov 30 07:53:27 1997
@@ -292,7 +292,6 @@
 	Scsi_Cmnd *tmp;
 	unsigned long flags;
 
-	disable_irq(cmd->host->irq);
 	DB(DB_QCMD,printk("Q-%d-%02x-%ld( ",cmd->target,cmd->cmnd[0],cmd->pid));
 
 	/* Set up a few fields in the Scsi_Cmnd structure for our own use:
