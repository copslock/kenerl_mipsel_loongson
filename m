Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jul 2003 15:41:02 +0100 (BST)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([IPv6:::ffff:212.242.58.113]:16430
	"EHLO brian.localnet") by linux-mips.org with ESMTP
	id <S8224802AbTGEOlA>; Sat, 5 Jul 2003 15:41:00 +0100
Received: from brm by brian.localnet with local (Exim 3.36 #1 (Debian))
	id 19YoDK-0002jK-00; Sat, 05 Jul 2003 16:40:34 +0200
To: ralf@linux-mips.org
Subject: [PATCH 2.4] nile4 pci typo
Cc: linux-mips@linux-mips.org
Message-Id: <E19YoDK-0002jK-00@brian.localnet>
From: Brian Murphy <brm@murphy.dk>
Date: Sat, 05 Jul 2003 16:40:34 +0200
Return-Path: <brm@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brm@murphy.dk
Precedence: bulk
X-list: linux-mips

Hi Ralf,
	another typo for you...

/Brian

Index: arch/mips/pci/ops-nile4.c
===================================================================
RCS file: /cvs/linux/arch/mips/pci/Attic/ops-nile4.c,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 ops-nile4.c
--- arch/mips/pci/ops-nile4.c	5 Jul 2003 13:17:03 -0000	1.1.2.1
+++ arch/mips/pci/ops-nile4.c	5 Jul 2003 14:10:53 -0000
@@ -5,7 +5,7 @@
 #include <linux/spinlock.h>
 #include <asm/bootinfo.h>
 
-#include <asm/nile4_.h>
+#include <asm/nile4.h>
 #include <asm/lasat/lasat.h>
 
 #define PCI_ACCESS_READ  0
