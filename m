Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Nov 2005 23:37:41 +0000 (GMT)
Received: from smtp6-g19.free.fr ([212.27.42.36]:2528 "EHLO smtp6-g19.free.fr")
	by ftp.linux-mips.org with ESMTP id S8133894AbVKLXgg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 12 Nov 2005 23:36:36 +0000
Received: from groumpf (str90-1-82-238-123-182.fbx.proxad.net [82.238.123.182])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 1D3B99544;
	Sun, 13 Nov 2005 00:38:19 +0100 (CET)
Received: from jekyll.groumpf.homeip.net ([192.168.1.1] helo=jekyll)
	by groumpf with esmtp (Exim 4.50)
	id 1Eb4ws-0003IT-GO; Sun, 13 Nov 2005 00:38:18 +0100
Received: from arnaud by jekyll with local (Exim 4.50)
	id 1Eb4ws-000076-3T; Sun, 13 Nov 2005 00:38:18 +0100
To:	ralf@linux-mips.org
Subject: [PATCH] Fix and complete IP32 parport definitions
Cc:	linux-mips@linux-mips.org
Message-Id: <E1Eb4ws-000076-3T@jekyll>
From:	Arnaud Giersch <arnaud.giersch@free.fr>
Date:	Sun, 13 Nov 2005 00:38:18 +0100
Return-Path: <arnaud.giersch@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnaud.giersch@free.fr
Precedence: bulk
X-list: linux-mips

Fix, complete, and indent IP32 parport definitions.
Definition were wrong for CTXINUSE and DMACTIVE (1-bit shift).
Add macros DATA_BOUND, DATALEN_SHIFT, and CTRSHIFT.

Signed-off-by: Arnaud Giersch <arnaud.giersch@free.fr>
---

 mace.h |   42 ++++++++++++++++++++++++++----------------
 1 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/include/asm-mips/ip32/mace.h b/include/asm-mips/ip32/mace.h
--- a/include/asm-mips/ip32/mace.h
+++ b/include/asm-mips/ip32/mace.h
@@ -150,24 +150,34 @@ struct mace_audio {
 
 /* register definitions for parallel port DMA */
 struct mace_parport {
-/* 0 - do nothing, 1 - pulse terminal count to the device after buffer is drained */ 
-#define MACEPAR_CONTEXT_LASTFLAG BIT(63)
-/* Should not cross 4K page boundary */
-#define MACEPAR_CONTEXT_DATALEN_MASK 0xfff00000000
-/* Can be arbitrarily aligned on any byte boundary on output, 64 byte aligned on input */
-#define MACEPAR_CONTEXT_BASEADDR_MASK 0xffffffff
+	/* 0 - do nothing,
+	 * 1 - pulse terminal count to the device after buffer is drained */
+#define MACEPAR_CONTEXT_LASTFLAG	BIT(63)
+	/* Should not cross 4K page boundary */
+#define MACEPAR_CONTEXT_DATA_BOUND	0x0000000000001000UL
+#define MACEPAR_CONTEXT_DATALEN_MASK	0x00000fff00000000UL
+#define MACEPAR_CONTEXT_DATALEN_SHIFT	32
+	/* Can be arbitrarily aligned on any byte boundary on output,
+	 * 64 byte aligned on input */
+#define MACEPAR_CONTEXT_BASEADDR_MASK	0x00000000ffffffffUL
 	volatile u64 context_a;
 	volatile u64 context_b;
-#define MACEPAR_CTLSTAT_DIRECTION BIT(0) /* 0 - mem->device, 1 - device->mem */
-#define MACEPAR_CTLSTAT_ENABLE BIT(1) /* 0 - channel frozen, 1 - channel enabled */
-#define MACEPAR_CTLSTAT_RESET BIT(2) /* 0 - channel active, 1 - complete channel reset */
-#define MACEPAR_CTLSTAT_CTXB_VALID BIT(3)
-#define MACEPAR_CTLSTAT_CTXA_VALID BIT(4)
-	volatile u64 cntlstat; /* Control/Status register */
-#define MACEPAR_DIAG_CTXINUSE BIT(1)
-#define MACEPAR_DIAG_DMACTIVE BIT(2) /* 1 - Dma engine is enabled and processing something */
-#define MACEPAR_DIAG_CTRMASK 0x3ffc /* Counter of bytes left */
-	volatile u64 diagnostic; /* RO: diagnostic register */
+	/* 0 - mem->device, 1 - device->mem */
+#define MACEPAR_CTLSTAT_DIRECTION	BIT(0)
+	/* 0 - channel frozen, 1 - channel enabled */
+#define MACEPAR_CTLSTAT_ENABLE		BIT(1)
+	/* 0 - channel active, 1 - complete channel reset */
+#define MACEPAR_CTLSTAT_RESET		BIT(2)
+#define MACEPAR_CTLSTAT_CTXB_VALID	BIT(3)
+#define MACEPAR_CTLSTAT_CTXA_VALID	BIT(4)
+	volatile u64 cntlstat;		/* Control/Status register */
+#define MACEPAR_DIAG_CTXINUSE		BIT(0)
+	/* 1 - Dma engine is enabled and processing something */
+#define MACEPAR_DIAG_DMACTIVE		BIT(1)
+	/* Counter of bytes left */
+#define MACEPAR_DIAG_CTRMASK		0x0000000000003ffcUL
+#define MACEPAR_DIAG_CTRSHIFT		2
+	volatile u64 diagnostic;	/* RO: diagnostic register */
 };
 
 /* ISA Control and DMA registers */
