Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2005 21:36:05 +0000 (GMT)
Received: from port535.ds1-van.adsl.cybercity.dk ([IPv6:::ffff:217.157.140.228]:37482
	"EHLO valis.murphy.dk") by linux-mips.org with ESMTP
	id <S8225546AbVCQVft>; Thu, 17 Mar 2005 21:35:49 +0000
Received: from brian.localnet (root@[10.0.0.2])
	by valis.murphy.dk (8.13.2/8.13.2/Debian-1) with ESMTP id j2HLZcAG028503;
	Thu, 17 Mar 2005 22:35:38 +0100
Received: from brian.localnet (brm@localhost [127.0.0.1])
	by brian.localnet (8.12.11/8.12.11/Debian-5) with ESMTP id j2HLZcj2006194;
	Thu, 17 Mar 2005 22:35:38 +0100
Received: (from brm@localhost)
	by brian.localnet (8.12.11/8.12.11/Debian-5) id j2HLZcFc006193;
	Thu, 17 Mar 2005 22:35:38 +0100
Date:	Thu, 17 Mar 2005 22:35:38 +0100
From:	Brian Murphy <brm@murphy.dk>
Message-Id: <200503172135.j2HLZcFc006193@brian.localnet>
To:	ralf@linux-mips.org
Subject: [PATCH 2.6] Lasat cleanups (setup.c)
Cc:	linux-mips@linux-mips.org
Return-Path: <brm@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brm@murphy.dk
Precedence: bulk
X-list: linux-mips

Hi Ralf,
	long time no see ;-). This is of course because you are
doing such a good job of maintaining the Lasat machines kernel
code for me.  This patch just removes some unused and ancient
filler.

Please apply.

/Brian

Index: arch/mips/lasat/setup.c
===================================================================
RCS file: /cvs/linux/arch/mips/lasat/setup.c,v
retrieving revision 1.15
diff -u -r1.15 setup.c
--- arch/mips/lasat/setup.c	14 Jul 2004 16:58:59 -0000	1.15
+++ arch/mips/lasat/setup.c	17 Mar 2005 18:45:44 -0000
@@ -25,7 +25,6 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/sched.h>
-#include <linux/pci.h>
 #include <linux/interrupt.h>
 #include <linux/tty.h>
 #include <linux/serial.h>
@@ -54,9 +53,6 @@
 void lasatint_init(void);
 
 extern void lasat_reboot_setup(void);
-extern void pcisetup(void);
-extern void edhac_init(void *, void *, void *);
-extern void addrflt_init(void);
 
 struct lasat_misc lasat_misc_info[N_MACHTYPES] = {
 	{(void *)KSEG1ADDR(0x1c840000), (void *)KSEG1ADDR(0x1c800000), 2},
