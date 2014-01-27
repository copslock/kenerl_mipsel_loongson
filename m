Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:37:23 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:44806 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827441AbaA0U01gCzGp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:26:27 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 51/58] MIPS: malta: Configure Segment Control registers for EVA boot
Date:   Mon, 27 Jan 2014 20:19:38 +0000
Message-ID: <1390853985-14246-52-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_26_22
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

The Malta board aliases 0x80000000 - 0xffffffff to 0x00000000
- 0x7fffffff ignoring the 256 MB IO hole in 0x10000000.
The physical memory is shifted to 0x80000000 so up to 2GB
can be used. Kuseg is expanded to 3GB (due to board limitations
only 2GB can be accessed) and lowmem (kernel space) is expanded to 2GB.

The Segment Control registers are programmed as follows:

Virtual memory           Physical memory           Mapping
0x00000000 - 0x7fffffff  0x80000000 - 0xfffffffff   MUSUK (kuseg)
0x80000000 - 0x9fffffff  0x00000000 - 0x1ffffffff   MUSUK (kseg0)
0xa0000000 - 0xbf000000  0x00000000 - 0x1ffffffff   MUSUK (kseg1)
0xc0000000 - 0xdfffffff             -                 MK  (kseg2)
0xe0000000 - 0xffffffff             -                 MK  (kseg3)

The location of exception vectors remain the same since 0xbfc00000
(traditional exception base) still maps to 0x1fc00000 physical.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 .../include/asm/mach-malta/kernel-entry-init.h     | 109 ++++++++++++++++++++-
 arch/mips/mti-malta/malta-setup.c                  |   4 +
 2 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mach-malta/kernel-entry-init.h b/arch/mips/include/asm/mach-malta/kernel-entry-init.h
index 0b793e7..9bace9c 100644
--- a/arch/mips/include/asm/mach-malta/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-malta/kernel-entry-init.h
@@ -5,10 +5,80 @@
  *
  * Chris Dearman (chris@mips.com)
  * Copyright (C) 2007 Mips Technologies, Inc.
+ * Copyright (C) 2014 Imagination Technologies Ltd.
  */
 #ifndef __ASM_MACH_MIPS_KERNEL_ENTRY_INIT_H
 #define __ASM_MACH_MIPS_KERNEL_ENTRY_INIT_H
 
+	/*
+	 * Prepare segments for EVA boot:
+	 *
+	 * This is in case the processor boots in legacy configuration
+	 * (SI_EVAReset is de-asserted and CONFIG5.K == 0)
+	 *
+	 * On entry, t1 is loaded with CP0_CONFIG
+	 *
+	 * ========================= Mappings =============================
+	 * Virtual memory           Physical memory           Mapping
+	 * 0x00000000 - 0x7fffffff  0x80000000 - 0xfffffffff   MUSUK (kuseg)
+	 *                          Flat 2GB physical memory
+	 *
+	 * 0x80000000 - 0x9fffffff  0x00000000 - 0x1ffffffff   MUSUK (kseg0)
+	 * 0xa0000000 - 0xbf000000  0x00000000 - 0x1ffffffff   MUSUK (kseg1)
+	 * 0xc0000000 - 0xdfffffff             -                 MK  (kseg2)
+	 * 0xe0000000 - 0xffffffff             -                 MK  (kseg3)
+	 *
+	 *
+	 * Lowmem is expanded to 2GB
+	 */
+	.macro	eva_entry
+	/*
+	 * Get Config.K0 value and use it to program
+	 * the segmentation registers
+	 */
+	andi	t1, 0x7 /* CCA */
+	move	t2, t1
+	ins	t2, t1, 16, 3
+	/* SegCtl0 */
+	li      t0, ((MIPS_SEGCFG_MK << MIPS_SEGCFG_AM_SHIFT) |		\
+		(0 << MIPS_SEGCFG_PA_SHIFT) |				\
+		(1 << MIPS_SEGCFG_EU_SHIFT)) |				\
+		(((MIPS_SEGCFG_MK << MIPS_SEGCFG_AM_SHIFT) |		\
+		(0 << MIPS_SEGCFG_PA_SHIFT) |				\
+		(1 << MIPS_SEGCFG_EU_SHIFT)) << 16)
+	or	t0, t2
+	mtc0	t0, $5, 2
+
+	/* SegCtl1 */
+	li      t0, ((MIPS_SEGCFG_MUSUK << MIPS_SEGCFG_AM_SHIFT) |	\
+		(0 << MIPS_SEGCFG_PA_SHIFT) |				\
+		(2 << MIPS_SEGCFG_C_SHIFT) |				\
+		(1 << MIPS_SEGCFG_EU_SHIFT)) |				\
+		(((MIPS_SEGCFG_MUSUK << MIPS_SEGCFG_AM_SHIFT) |		\
+		(0 << MIPS_SEGCFG_PA_SHIFT) |				\
+		(1 << MIPS_SEGCFG_EU_SHIFT)) << 16)
+	ins	t0, t1, 16, 3
+	mtc0	t0, $5, 3
+
+	/* SegCtl2 */
+	li	t0, ((MIPS_SEGCFG_MUSUK << MIPS_SEGCFG_AM_SHIFT) |	\
+		(6 << MIPS_SEGCFG_PA_SHIFT) |				\
+		(1 << MIPS_SEGCFG_EU_SHIFT)) |				\
+		(((MIPS_SEGCFG_MUSUK << MIPS_SEGCFG_AM_SHIFT) |		\
+		(4 << MIPS_SEGCFG_PA_SHIFT) |				\
+		(1 << MIPS_SEGCFG_EU_SHIFT)) << 16)
+	or	t0, t2
+	mtc0	t0, $5, 4
+
+	jal	mips_ihb
+	mfc0    t0, $16, 5
+	li      t2, 0x40000000      /* K bit */
+	or      t0, t0, t2
+	mtc0    t0, $16, 5
+	sync
+	jal	mips_ihb
+	.endm
+
 	.macro	kernel_entry_setup
 #ifdef CONFIG_MIPS_MT_SMTC
 	mfc0	t0, CP0_CONFIG
@@ -39,8 +109,45 @@
 nonmt_processor:
 	.asciz	"SMTC kernel requires the MT ASE to run\n"
 	__FINIT
-0:
 #endif
+
+#ifdef CONFIG_EVA
+	sync
+	ehb
+
+	mfc0    t1, CP0_CONFIG
+	bgez    t1, 9f
+	mfc0	t0, CP0_CONFIG, 1
+	bgez	t0, 9f
+	mfc0	t0, CP0_CONFIG, 2
+	bgez	t0, 9f
+	mfc0	t0, CP0_CONFIG, 3
+	sll     t0, t0, 6   /* SC bit */
+	bgez    t0, 9f
+
+	eva_entry
+	b       0f
+9:
+	/* Assume we came from YAMON... */
+	PTR_LA	v0, 0x9fc00534	/* YAMON print */
+	lw	v0, (v0)
+	move	a0, zero
+	PTR_LA  a1, nonsc_processor
+	jal	v0
+
+	PTR_LA	v0, 0x9fc00520	/* YAMON exit */
+	lw	v0, (v0)
+	li	a0, 1
+	jal	v0
+
+1:	b	1b
+	nop
+	__INITDATA
+nonsc_processor:
+	.asciz  "EVA kernel requires a MIPS core with Segment Control implemented\n"
+	__FINIT
+#endif /* CONFIG_EVA */
+0:
 	.endm
 
 /*
diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index c72a069..35057a8 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -247,6 +247,10 @@ void __init plat_mem_setup(void)
 {
 	unsigned int i;
 
+	if (config_enabled(CONFIG_EVA))
+		/* EVA has already been configured in mach-malta/kernel-init.h */
+		pr_info("Enhanced Virtual Addressing (EVA) activated\n");
+
 	mips_pcibios_init();
 
 	/* Request I/O space for devices used on the Malta board. */
-- 
1.8.5.3
