Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Dec 2009 02:49:33 +0100 (CET)
Received: from sj-iport-5.cisco.com ([171.68.10.87]:60945 "EHLO
        sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1495136AbZLVBt3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Dec 2009 02:49:29 +0100
Authentication-Results: sj-iport-5.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEANK0L0urRN+J/2dsb2JhbADAF5ZChC4EgWQ
X-IronPort-AV: E=Sophos;i="4.47,434,1257120000"; 
   d="scan'208";a="123484493"
Received: from sj-core-3.cisco.com ([171.68.223.137])
  by sj-iport-5.cisco.com with ESMTP; 22 Dec 2009 01:49:22 +0000
Received: from dvomlehn-lnx2.corp.sa.net ([64.101.20.155])
        by sj-core-3.cisco.com (8.13.8/8.14.3) with ESMTP id nBM1nMdi012933;
        Tue, 22 Dec 2009 01:49:22 GMT
Date:   Mon, 21 Dec 2009 17:49:22 -0800
From:   David VomLehn <dvomlehn@cisco.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH] powertv: Fix support for timer interrupts when using >64
        external IRQs
Message-ID: <20091222014922.GA30164@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

The MIPS processor is limited to 64 external interrupt sources. Using a
greater number without IRQ sharing requires reading platform-specific
registers. On such platforms, reading the IntCtl register to determine
which interrupt corresponds to a timer interrupt will not work.

On MIPSR2 systems there is a solution--the TI bit in the Cause register,
specifically indicates that a timer interrupt has occured. This patch
uses that bit to detect interrupts for MIPSR2 processors, which may be
expected to work regardless of how the timer interrupt may be routed
in the hardware.

Signed-off-by: David VomLehn (dvomlehn@cisco.com)
---
 arch/mips/include/asm/irq.h      |    1 +
 arch/mips/include/asm/mipsregs.h |   12 ++++++++++++
 arch/mips/kernel/cevt-r4k.c      |    2 +-
 arch/mips/kernel/traps.c         |    6 ++++--
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
index 0696036..dea4aed 100644
--- a/arch/mips/include/asm/irq.h
+++ b/arch/mips/include/asm/irq.h
@@ -135,6 +135,7 @@ extern void free_irqno(unsigned int irq);
 #define CP0_LEGACY_COMPARE_IRQ 7
 
 extern int cp0_compare_irq;
+extern int cp0_compare_irq_shift;
 extern int cp0_perfcount_irq;
 
 #endif /* _ASM_IRQ_H */
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index a581d60..f4ab313 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -406,6 +406,16 @@
 #define ST0_XX			0x80000000	/* MIPS IV naming */
 
 /*
+ * Bitfields and bit numbers in the coprocessor 0 IntCtl register. (MIPSR2)
+ *
+ * Refer to your MIPS R4xx0 manual, chapter 5 for explanation.
+ */
+#define INTCTLB_IPPCI		26
+#define INTCTLF_IPPCI		(_ULCAST_(7) << INTCTLB_IPPCI)
+#define INTCTLB_IPTI		29
+#define INTCTLF_IPTI		(_ULCAST_(7) << INTCTLB_IPTI)
+
+/*
  * Bitfields and bit numbers in the coprocessor 0 cause register.
  *
  * Refer to your MIPS R4xx0 manual, chapter 5 for explanation.
@@ -434,6 +444,8 @@
 #define  CAUSEF_IV		(_ULCAST_(1)   << 23)
 #define  CAUSEB_CE		28
 #define  CAUSEF_CE		(_ULCAST_(3)   << 28)
+#define  CAUSEB_TI		30
+#define  CAUSEF_TI		(_ULCAST_(1)   << 30)
 #define  CAUSEB_BD		31
 #define  CAUSEF_BD		(_ULCAST_(1)   << 31)
 
diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index b469ad0..0b2450c 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -97,7 +97,7 @@ void mips_event_handler(struct clock_event_device *dev)
  */
 static int c0_compare_int_pending(void)
 {
-	return (read_c0_cause() >> cp0_compare_irq) & 0x100;
+	return (read_c0_cause() >> cp0_compare_irq_shift) & (1ul << CAUSEB_IP);
 }
 
 /*
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 308e434..338dfe8 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1403,6 +1403,7 @@ extern void flush_tlb_handlers(void);
  * Timer interrupt
  */
 int cp0_compare_irq;
+int cp0_compare_irq_shift;
 
 /*
  * Performance counter IRQ or -1 if shared with timer
@@ -1493,8 +1494,9 @@ void __cpuinit per_cpu_trap_init(void)
 	 *  o read IntCtl.IPPCI to determine the performance counter interrupt
 	 */
 	if (cpu_has_mips_r2) {
-		cp0_compare_irq = (read_c0_intctl() >> 29) & 7;
-		cp0_perfcount_irq = (read_c0_intctl() >> 26) & 7;
+		cp0_compare_irq_shift = CAUSEB_TI - CAUSEB_IP;
+		cp0_compare_irq = (read_c0_intctl() >> INTCTLB_IPTI) & 7;
+		cp0_perfcount_irq = (read_c0_intctl() >> INTCTLB_IPPCI) & 7;
 		if (cp0_perfcount_irq == cp0_compare_irq)
 			cp0_perfcount_irq = -1;
 	} else {
