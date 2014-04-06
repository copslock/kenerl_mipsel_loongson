Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Apr 2014 23:42:52 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:32909 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816288AbaDFVms710AX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Apr 2014 23:42:48 +0200
Date:   Sun, 6 Apr 2014 22:42:48 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH] DEC: Document the R4k MB ASIC mini interrupt controller
Message-ID: <alpine.LFD.2.11.1404062232070.15266@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

There's an alternative 5-line mini interrupt controller in the R4k MB ASIC 
used on the KN04 and KN05 CPU daughtercards.  The controller is cascaded 
from the CPU interrupt input that would be used for the Halt button on the 
corresponding R3k systems.  This change documents the findings so far.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-dec-r4k-mb-irq.patch
Index: linux-20140404-4maxp64/arch/mips/include/asm/dec/kn05.h
===================================================================
--- linux-20140404-4maxp64.orig/arch/mips/include/asm/dec/kn05.h
+++ linux-20140404-4maxp64/arch/mips/include/asm/dec/kn05.h
@@ -49,12 +49,20 @@
 #define KN4K_RES_15	(15*IOASIC_SLOT_SIZE)	/* unused? */
 
 /*
+ * MB ASIC interrupt bits.
+ */
+#define KN4K_MB_INR_MB		4	/* ??? */
+#define KN4K_MB_INR_MT		3	/* memory, I/O bus read/write errors */
+#define KN4K_MB_INR_RES_2	2	/* unused */
+#define KN4K_MB_INR_RTC		1	/* RTC */
+#define KN4K_MB_INR_TC		0	/* I/O ASIC cascade */
+
+/*
  * Bits for the MB interrupt register.
  * The register appears read-only.
  */
-#define KN4K_MB_INT_TC		(1<<0)		/* TURBOchannel? */
-#define KN4K_MB_INT_RTC		(1<<1)		/* RTC? */
-#define KN4K_MB_INT_MT		(1<<3)		/* I/O ASIC cascade */
+#define KN4K_MB_INT_IRQ		(0x1f<<0)	/* CPU Int[4:0] status. */
+#define KN4K_MB_INT_IRQ_N(n)	(1<<(n))	/* Individual status bits. */
 
 /*
  * Bits for the MB control & status register.
@@ -70,6 +78,7 @@
 #define KN4K_MB_CSR_NC		(1<<14)		/* ??? */
 #define KN4K_MB_CSR_EE		(1<<15)		/* (bus) Exception Enable? */
 #define KN4K_MB_CSR_MSK		(0x1f<<16)	/* CPU Int[4:0] mask */
+#define KN4K_MB_CSR_MSK_N(n)	(1<<((n)+16))	/* Individual mask bits. */
 #define KN4K_MB_CSR_FW		(1<<21)		/* ??? */
 #define KN4K_MB_CSR_W		(1<<31)		/* ??? */
 
