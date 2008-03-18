Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2008 21:48:04 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:4051 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28640765AbYCRVsB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 18 Mar 2008 21:48:01 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1Jbjf6-0002n7-00; Tue, 18 Mar 2008 22:48:00 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id D7E77C2816; Tue, 18 Mar 2008 22:47:56 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] IP28: switch to "normal" mode after PROM no longer needed
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080318214756.D7E77C2816@solo.franken.de>
Date:	Tue, 18 Mar 2008 22:47:56 +0100 (CET)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

SGI-IP28 is running in so called slow mode, when kernel is started
from the PROM. PROM calls must be done in slow mode otherwise the
PROM will issue an error. To get better memory performance we now
switch to normal mode, when the PROM is no longer needed.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/sgi-ip22/ip22-mc.c |   26 ++++++++++++++++++++++++++
 include/asm-mips/barrier.h   |   14 ++++++++++++++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/mips/sgi-ip22/ip22-mc.c b/arch/mips/sgi-ip22/ip22-mc.c
index 3f35d63..5268ac1 100644
--- a/arch/mips/sgi-ip22/ip22-mc.c
+++ b/arch/mips/sgi-ip22/ip22-mc.c
@@ -208,4 +208,30 @@ void __init sgimc_init(void)
 void __init prom_meminit(void) {}
 void __init prom_free_prom_memory(void)
 {
+#ifdef CONFIG_SGI_IP28
+	u32 mconfig1;
+	unsigned long flags;
+	spinlock_t lock;
+
+	/*
+	 * because ARCS accesses memory uncached we wait until ARCS
+	 * isn't needed any longer, before we switch from slow to
+	 * normal mode
+	 */
+	spin_lock_irqsave(&lock, flags);
+	mconfig1 = sgimc->mconfig1;
+	/* map ECC register */
+	sgimc->mconfig1 = (mconfig1 & 0xffff0000) | 0x2060;
+	iob();
+	/* switch to normal mode */
+	*(unsigned long *)PHYS_TO_XKSEG_UNCACHED(0x60000000) = 0;
+	iob();
+	/* reduce WR_COL */
+	sgimc->cmacc = (sgimc->cmacc & ~0xf) | 4;
+	iob();
+	/* restore old config */
+	sgimc->mconfig1 = mconfig1;
+	iob();
+	spin_unlock_irqrestore(&lock, flags);
+#endif
 }
diff --git a/include/asm-mips/barrier.h b/include/asm-mips/barrier.h
index 9d8cfbb..8e9ac31 100644
--- a/include/asm-mips/barrier.h
+++ b/include/asm-mips/barrier.h
@@ -92,11 +92,25 @@
 #define fast_wmb()	__sync()
 #define fast_rmb()	__sync()
 #define fast_mb()	__sync()
+#ifdef CONFIG_SGI_IP28
+#define fast_iob()				\
+	__asm__ __volatile__(			\
+		".set	push\n\t"		\
+		".set	noreorder\n\t"		\
+		"lw	$0,%0\n\t"		\
+		"sync\n\t"			\
+		"lw	$0,%0\n\t"		\
+		".set	pop"			\
+		: /* no output */		\
+		: "m" (*(int *)CKSEG1ADDR(0x1fa00004)) \
+		: "memory")
+#else
 #define fast_iob()				\
 	do {					\
 		__sync();			\
 		__fast_iob();			\
 	} while (0)
+#endif
 
 #ifdef CONFIG_CPU_HAS_WB
 
