Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Feb 2016 03:15:20 +0100 (CET)
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36529 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012458AbcBDCPDjuCrx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Feb 2016 03:15:03 +0100
Received: by mail-pf0-f170.google.com with SMTP id n128so26675751pfn.3;
        Wed, 03 Feb 2016 18:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xpIpEzYLUxKB6Xgo0QXD0Qm3h1YTJeJvw2FylkIluTk=;
        b=CRY3e+aTIR34ioleWM/7R1L90z796jRGKOpQrsohYBS6VwtHesfkP8dmliPivNjUh+
         q47GT5fR9xmIOP1bi/aBH3aZzKNVRy3ICOFVcFHe7eQN+zFynmFtgj9vDDzhYd/1NIq9
         Na3kmqD6bGTdxBCbhBJpQ9EGtw2u4Wlg4a88bAxcaDrhb5FWIZMsJIPOYLo6ol1XJKAx
         13t097qbGYZC/qbTfkU/Hvlk8C/KcYRJx42eBJWUCyZpMpYUtuSj42w68fIn8NyT2DPk
         /GaKmF5EFWVK3ly6qlD279gOwYdbEF7C07XdflLjwj2ZqIX7tRsg1H6kE2DydirAdGlV
         iCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xpIpEzYLUxKB6Xgo0QXD0Qm3h1YTJeJvw2FylkIluTk=;
        b=c3YB5El7ECa5WIerjqTybuhXL3bSlbXyvOzEv6kVJHLQWk0Dm2r9n7gqN4ngSKBsQV
         TqihcV/JOmKAamRuJZLxN3YULfwAXE13IS5bNhpv3Z97JrkbFnwAaN1hppPvw3J1KWCd
         ig1kCgG93xqKis63m5ZWAmm38hSST5IZx4TajnDt9Cwp94miQjgZz00woCWmFqgedHQq
         JemyXNkd/lg1vQQI7meKmYEQ042Q0UXzI2MjcKYRgRBFn7lNrZ+MLlrZYFzmVAvm9QQ6
         gZLStpOvbZwW5A3K8qvK2fOZtIyk1LedaahmrO5c5RI8puzC8T3wuHeiUWsMGDaGczkH
         G1Yg==
X-Gm-Message-State: AG10YORDb+OKU/HbbkiMpyAN+44bferEkNtR0y5GV++HVozrZ4PNGT+8VJeiZiolt8sXew==
X-Received: by 10.98.42.74 with SMTP id q71mr7283976pfq.18.1454552097770;
        Wed, 03 Feb 2016 18:14:57 -0800 (PST)
Received: from stb-bld-03.irv.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id l14sm12646282pfb.73.2016.02.03.18.14.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 18:14:57 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jon.fraser@broadcom.com, jaedon.shin@gmail.com,
        dragan.stancevic@gmail.com, jogo@openwrt.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 1/4] MIPS: BMIPS: Add Whirlwind (BMIPS5200) initialization code
Date:   Wed,  3 Feb 2016 18:14:50 -0800
Message-Id: <1454552093-17897-2-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1454552093-17897-1-git-send-email-f.fainelli@gmail.com>
References: <1454552093-17897-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Import bmips_5xxx_init.S from the stblinux-3.3 tree, and to make sure that this
would work nicely with a BMIPS multiplatform kernel (with BMIPS330, BMIPS43XX
and BMIPS5000 enabled), update soft_reset to check for the BMIPS5200 processor
id (PRID_IMP_BMIPS5200) and execute bmips_5xxx_init for these processors to
bring them online.

Tested on 7425, 7429 and 7435 with CPU hotplug. 7435 SMP still needs some
additional changes in the L1 interrupt area to work properly with interrupt
affinity.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/kernel/Makefile          |   2 +-
 arch/mips/kernel/bmips_5xxx_init.S | 753 +++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/bmips_vec.S       |  41 +-
 3 files changed, 792 insertions(+), 4 deletions(-)
 create mode 100644 arch/mips/kernel/bmips_5xxx_init.S

diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 68e2b7db9348..47c5412f4ca0 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -44,7 +44,7 @@ obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= r4k_fpu.o octeon_switch.o
 
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_SMP_UP)		+= smp-up.o
-obj-$(CONFIG_CPU_BMIPS)		+= smp-bmips.o bmips_vec.o
+obj-$(CONFIG_CPU_BMIPS)		+= smp-bmips.o bmips_vec.o bmips_5xxx_init.o
 
 obj-$(CONFIG_MIPS_MT)		+= mips-mt.o
 obj-$(CONFIG_MIPS_MT_FPAFF)	+= mips-mt-fpaff.o
diff --git a/arch/mips/kernel/bmips_5xxx_init.S b/arch/mips/kernel/bmips_5xxx_init.S
new file mode 100644
index 000000000000..788ebf9a365d
--- /dev/null
+++ b/arch/mips/kernel/bmips_5xxx_init.S
@@ -0,0 +1,753 @@
+
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2011-2012 by Broadcom Corporation
+ *
+ * Init for bmips 5000.
+ * Used to init second core in dual core 5000's.
+ */
+
+#include <linux/init.h>
+
+#include <asm/asm.h>
+#include <asm/asmmacro.h>
+#include <asm/cacheops.h>
+#include <asm/regdef.h>
+#include <asm/mipsregs.h>
+#include <asm/stackframe.h>
+#include <asm/addrspace.h>
+#include <asm/hazards.h>
+#include <asm/bmips.h>
+
+#ifdef CONFIG_CPU_BMIPS5000
+
+
+#define cacheop(kva, size, linesize, op) 	\
+	.set noreorder			;	\
+	addu		t1, kva, size   ;	\
+        subu		t2, linesize, 1 ;	\
+        not		t2		;	\
+        and		t0, kva, t2     ;	\
+        addiu		t1, t1, -1      ;    	\
+        and		t1, t2          ;	\
+9:	cache		op, 0(t0)       ;	\
+        bne		t0, t1, 9b	;	\
+        addu		t0, linesize    ;	\
+        .set reorder			;
+
+
+
+#define	IS_SHIFT	22
+#define	IL_SHIFT	19
+#define	IA_SHIFT	16
+#define	DS_SHIFT	13
+#define	DL_SHIFT	10
+#define	DA_SHIFT	 7
+#define	IS_MASK		 7
+#define	IL_MASK		 7
+#define	IA_MASK		 7
+#define	DS_MASK		 7
+#define	DL_MASK		 7
+#define	DA_MASK		 7
+#define	ICE_MASK	0x80000000
+#define	DCE_MASK	0x40000000
+
+#define CP0_BRCM_CONFIG0	$22, 0
+#define CP0_BRCM_MODE		$22, 1
+#define	CP0_CONFIG_K0_MASK	7
+
+#define CP0_ICACHE_TAG_LO       $28
+#define CP0_ICACHE_DATA_LO      $28, 1
+#define CP0_DCACHE_TAG_LO       $28, 2
+#define CP0_D_SEC_CACHE_DATA_LO	$28, 3
+#define CP0_ICACHE_TAG_HI       $29
+#define CP0_ICACHE_DATA_HI      $29, 1
+#define CP0_DCACHE_TAG_HI       $29, 2
+
+#define CP0_BRCM_MODE_Luc_MASK		(1 << 11)
+#define	CP0_BRCM_CONFIG0_CWF_MASK	(1 << 20)
+#define	CP0_BRCM_CONFIG0_TSE_MASK	(1 << 19)
+#define CP0_BRCM_MODE_SET_MASK		(1 << 7)
+#define CP0_BRCM_MODE_ClkRATIO_MASK	(7 << 4)
+#define CP0_BRCM_MODE_BrPRED_MASK 	(3 << 24)
+#define CP0_BRCM_MODE_BrPRED_SHIFT	24
+#define CP0_BRCM_MODE_BrHIST_MASK 	(0x1f << 20)
+#define CP0_BRCM_MODE_BrHIST_SHIFT	20
+
+/* ZSC L2 Cache Register Access Register Definitions */
+#define BRCM_ZSC_ALL_REGS_SELECT                0x7 << 24
+
+#define BRCM_ZSC_CONFIG_REG			0 << 3
+#define BRCM_ZSC_REQ_BUFFER_REG			2 << 3
+#define BRCM_ZSC_RBUS_ADDR_MAPPING_REG0		4 << 3
+#define BRCM_ZSC_RBUS_ADDR_MAPPING_REG1		6 << 3
+#define BRCM_ZSC_RBUS_ADDR_MAPPING_REG2		8 << 3
+
+#define BRCM_ZSC_SCB0_ADDR_MAPPING_REG0		0xa << 3
+#define BRCM_ZSC_SCB0_ADDR_MAPPING_REG1		0xc << 3
+
+#define BRCM_ZSC_SCB1_ADDR_MAPPING_REG0		0xe << 3
+#define BRCM_ZSC_SCB1_ADDR_MAPPING_REG1		0x10 << 3
+
+#define BRCM_ZSC_CONFIG_LMB1En			1 << (15)
+#define BRCM_ZSC_CONFIG_LMB0En			1 << (14)
+
+/* branch predition values */
+
+#define BRCM_BrPRED_ALL_TAKEN		(0x0)
+#define BRCM_BrPRED_ALL_NOT_TAKEN	(0x1)
+#define BRCM_BrPRED_BHT_ENABLE		(0x2)
+#define BRCM_BrPRED_PREDICT_BACKWARD	(0x3)
+
+
+
+.align 2
+/*
+ * Function: 	size_i_cache
+ * Arguments: 	None
+ * Returns:	v0 = i cache size, v1 = I cache line size
+ * Description: compute the I-cache size and I-cache line size
+ * Trashes:	v0, v1, a0, t0
+ *
+ *	pseudo code:
+ *
+ */
+
+LEAF(size_i_cache)
+	.set    noreorder
+
+	mfc0    a0, CP0_CONFIG, 1
+	move	t0, a0
+
+	/*
+	 * Determine sets per way: IS
+	 *
+	 * This field contains the number of sets (i.e., indices) per way of
+	 * the instruction cache:
+	 * i) 0x0: 64, ii) 0x1: 128, iii) 0x2: 256, iv) 0x3: 512, v) 0x4: 1k
+	 * vi) 0x5 - 0x7: Reserved.
+	 */
+
+	srl     a0, a0, IS_SHIFT
+	and     a0, a0, IS_MASK
+
+	/* sets per way = (64<<IS) */
+
+	li	v0, 0x40
+	sllv    v0, v0, a0
+
+	/*
+	 * Determine line size
+	 *
+	 * This field contains the line size of the instruction cache:
+	 * i) 0x0: No I-cache present, i) 0x3: 16 bytes, ii) 0x4: 32 bytes, iii)
+	 * 0x5: 64 bytes, iv) the rest: Reserved.
+	 */
+
+	move	a0, t0
+
+	srl	a0, a0, IL_SHIFT
+	and	a0, a0, IL_MASK
+
+	beqz	a0, no_i_cache
+	nop
+
+	/* line size = 2 ^ (IL+1) */
+
+	addi	a0, a0, 1
+	li	v1, 1
+	sll	v1, v1, a0
+
+	/* v0 now have sets per way, multiply it by line size now
+	 * that will give the set size
+	 */
+
+	sll	v0, v0, a0
+
+	/*
+	 * Determine set associativity
+	 *
+	 * This field contains the set associativity of the instruction cache.
+	 * i) 0x0: Direct mapped, ii) 0x1: 2-way, iii) 0x2: 3-way, iv) 0x3:
+	 * 4-way, v) 0x4 - 0x7: Reserved.
+	 */
+
+	move	a0, t0
+
+	srl	a0, a0, IA_SHIFT
+	and	a0, a0, IA_MASK
+	addi	a0, a0, 0x1
+
+	/* v0 has the set size, multiply it by
+	 * set associativiy, to get the cache size
+	 */
+
+	multu	v0, a0	/*multu is interlocked, so no need to insert nops */
+	mflo    v0
+	b	1f
+	nop
+
+no_i_cache:
+	move    v0, zero
+	move	v1, zero
+1:
+	jr       ra
+	nop
+	.set    reorder
+
+END(size_i_cache)
+
+/*
+ * Function: 	size_d_cache
+ * Arguments: 	None
+ * Returns:	v0 = d cache size, v1 = d cache line size
+ * Description: compute the D-cache size and D-cache line size.
+ * Trashes:	v0, v1, a0, t0
+ *
+ */
+
+LEAF(size_d_cache)
+	.set    noreorder
+
+	mfc0    a0, CP0_CONFIG, 1
+	move	t0, a0
+
+	/*
+	 * Determine sets per way: IS
+	 *
+	 * This field contains the number of sets (i.e., indices) per way of
+	 * the instruction cache:
+	 * i) 0x0: 64, ii) 0x1: 128, iii) 0x2: 256, iv) 0x3: 512, v) 0x4: 1k
+	 * vi) 0x5 - 0x7: Reserved.
+	 */
+
+	srl     a0, a0, DS_SHIFT
+	and     a0, a0, DS_MASK
+
+	/* sets per way = (64<<IS) */
+
+	li	v0, 0x40
+	sllv    v0, v0, a0
+
+	/*
+	 * Determine line size
+	 *
+	 * This field contains the line size of the instruction cache:
+	 * i) 0x0: No I-cache present, i) 0x3: 16 bytes, ii) 0x4: 32 bytes, iii)
+	 * 0x5: 64 bytes, iv) the rest: Reserved.
+	 */
+	move	a0, t0
+
+	srl	a0, a0, DL_SHIFT
+	and	a0, a0, DL_MASK
+
+	beqz	a0, no_d_cache
+	nop
+
+	/* line size = 2 ^ (IL+1) */
+
+	addi	a0, a0, 1
+	li	v1, 1
+	sll	v1, v1, a0
+
+	/* v0 now have sets per way, multiply it by line size now
+	 * that will give the set size
+	 */
+
+	sll	v0, v0, a0
+
+	/* determine set associativity
+	 *
+	 * This field contains the set associativity of the instruction cache.
+	 * i) 0x0: Direct mapped, ii) 0x1: 2-way, iii) 0x2: 3-way, iv) 0x3:
+	 * 4-way, v) 0x4 - 0x7: Reserved.
+	 */
+
+	move	a0, t0
+
+	srl	a0, a0, DA_SHIFT
+	and	a0, a0, DA_MASK
+	addi	a0, a0, 0x1
+
+	/* v0 has the set size, multiply it by
+	 * set associativiy, to get the cache size
+	 */
+
+	multu	v0, a0	/*multu is interlocked, so no need to insert nops */
+	mflo    v0
+
+	b	1f
+	nop
+
+no_d_cache:
+	move    v0, zero
+	move	v1, zero
+1:
+	jr	ra
+	nop
+	.set    reorder
+
+END(size_d_cache)
+
+
+/*
+ * Function: enable_ID
+ * Arguments: 	None
+ * Returns:	None
+ * Description: Enable I and D caches, initialize I and D-caches, also set
+ *                 hardware delay for d-cache (TP0).
+ * Trashes:	t0
+ *
+ */
+	.global	enable_ID
+	.ent	enable_ID
+	.set    noreorder
+enable_ID:
+	mfc0    t0, CP0_BRCM_CONFIG0
+	or	t0, t0, (ICE_MASK | DCE_MASK)
+	mtc0    t0, CP0_BRCM_CONFIG0
+	jr	ra
+	nop
+
+	.end	enable_ID
+	.set    reorder
+
+
+/*
+ * Function: l1_init
+ * Arguments: 	None
+ * Returns:	None
+ * Description: Enable I and D caches, and initialize I and D-caches
+ * Trashes:	a0, v0, v1, t0, t1, t2, t8
+ *
+ */
+	.globl	l1_init
+	.ent	l1_init
+	.set    noreorder
+l1_init:
+
+	/* save return address */
+	move    t8, ra
+
+
+	/* initialize I and D cache Data and Tag registers.  */
+	mtc0    zero, CP0_ICACHE_TAG_LO
+	mtc0    zero, CP0_ICACHE_TAG_HI
+	mtc0	zero, CP0_ICACHE_DATA_LO
+	mtc0	zero, CP0_ICACHE_DATA_HI
+	mtc0	zero, CP0_DCACHE_TAG_LO
+	mtc0	zero, CP0_DCACHE_TAG_HI
+
+	/* Enable Caches before Clearing. If the caches are disabled
+	 * then the cache operations to clear the cache will be ignored
+	 */
+
+	jal	enable_ID
+	nop
+
+	jal	size_i_cache	/* v0 = i-cache size, v1 = i-cache line size */
+	nop
+
+	/* run uncached in kseg 1 */
+	la	k0, 1f
+	lui	k1, 0x2000
+	or	k0, k1, k0
+	jr	k0
+	nop
+1:
+
+	/*
+	 * set K0 cache mode
+	 */
+
+	mfc0    t0, CP0_CONFIG
+	and     t0, t0, ~CP0_CONFIG_K0_MASK
+	or      t0, t0, 3	/* Write Back mode */
+	mtc0    t0, CP0_CONFIG
+
+	/*
+	 * Initialize  instruction cache.
+	 */
+
+	li	a0, KSEG0
+	cacheop(a0, v0, v1, Index_Store_Tag_I)
+
+	/*
+	 * Now we can run from I-$, kseg 0
+	 */
+	la	k0, 1f
+	lui	k1, 0x2000
+	or	k0, k1, k0
+	xor	k0, k1, k0
+	jr	k0
+	nop
+1:
+	/*
+	 * Initialize  data cache.
+	 */
+
+	jal	size_d_cache	/* v0 = d-cache size, v1 = d-cache line size */
+	nop
+
+
+	li      a0, KSEG0
+	cacheop(a0, v0, v1, Index_Store_Tag_D)
+
+	jr	t8
+	nop
+
+	.end 	l1_init
+	.set    reorder
+
+
+/*
+ * Function: 	set_other_config
+ * Arguments:	none
+ * Returns:	None
+ * Description: initialize other remainder configuration to defaults.
+ * Trashes:	t0, t1
+ *
+ *	pseudo code:
+ *
+ */
+LEAF(set_other_config)
+	.set noreorder
+
+        /* enable Bus error for I-fetch */
+        mfc0	t0, CP0_CACHEERR, 0
+        li	t1, 0x4
+        or	t0, t1
+	mtc0	t0, CP0_CACHEERR, 0
+
+        /* enable Bus error for Load */
+        mfc0	t0, CP0_CACHEERR, 1
+        li	t1, 0x4
+        or	t0, t1
+	mtc0	t0, CP0_CACHEERR, 1
+
+	/* enable Bus Error for Store */
+        mfc0	t0, CP0_CACHEERR, 2
+	li	t1, 0x4
+	or	t0, t1
+        mtc0	t0, CP0_CACHEERR, 2
+
+	jr	ra
+	nop
+	.set reorder
+END(set_other_config)
+
+/*
+ * Function: 	set_branch_pred
+ * Arguments:	none
+ * Returns:	None
+ * Description:
+ * Trashes:	t0, t1
+ *
+ *	pseudo code:
+ *
+ */
+
+LEAF(set_branch_pred)
+	.set noreorder
+	mfc0    t0, CP0_BRCM_MODE
+	li	t1, ~(CP0_BRCM_MODE_BrPRED_MASK | CP0_BRCM_MODE_BrHIST_MASK )
+	and	t0, t0, t1
+
+	/* enable Branch prediction */
+	li	t1, BRCM_BrPRED_BHT_ENABLE
+	sll	t1, CP0_BRCM_MODE_BrPRED_SHIFT
+	or	t0, t0, t1
+
+	/* set history count to 8 */
+	li	t1, 8
+	sll	t1, CP0_BRCM_MODE_BrHIST_SHIFT
+	or	t0, t0, t1
+
+	mtc0    t0, CP0_BRCM_MODE
+	jr	ra
+	nop
+	.set    reorder
+END(set_branch_pred)
+
+
+/*
+ * Function: 	set_luc
+ * Arguments:	set link uncached.
+ * Returns:	None
+ * Description:
+ * Trashes:	t0, t1
+ *
+ */
+LEAF(set_luc)
+	.set noreorder
+	mfc0    t0, CP0_BRCM_MODE
+	li	t1, ~(CP0_BRCM_MODE_Luc_MASK)
+	and	t0, t0, t1
+
+	/* set Luc */
+        ori	t0, t0, CP0_BRCM_MODE_Luc_MASK
+
+	mtc0    t0, CP0_BRCM_MODE
+	jr	ra
+	nop
+	.set    reorder
+END(set_luc)
+
+/*
+ * Function: 	set_cwf_tse
+ * Arguments:	set CWF and TSE bits
+ * Returns:	None
+ * Description:
+ * Trashes:	t0, t1
+ *
+ */
+LEAF(set_cwf_tse)
+	.set noreorder
+	mfc0    t0, CP0_BRCM_CONFIG0
+	li	t1, (CP0_BRCM_CONFIG0_CWF_MASK | CP0_BRCM_CONFIG0_TSE_MASK)
+	or	t0, t0, t1
+
+	mtc0    t0, CP0_BRCM_CONFIG0
+	jr	ra
+	nop
+	.set    reorder
+END(set_cwf_tse)
+
+/*
+ * Function: 	set_clock_ratio
+ * Arguments:   set clock ratio specified by a0
+ * Returns:	None
+ * Description:
+ * Trashes:	v0, v1, a0, a1
+ *
+ *	pseudo code:
+ *
+ */
+LEAF(set_clock_ratio)
+	.set noreorder
+
+	mfc0    t0, CP0_BRCM_MODE
+	li	t1, ~(CP0_BRCM_MODE_SET_MASK | CP0_BRCM_MODE_ClkRATIO_MASK)
+	and	t0, t0, t1
+	li	t1, CP0_BRCM_MODE_SET_MASK
+	or	t0, t0, t1
+	or	t0, t0, a0
+	mtc0    t0, CP0_BRCM_MODE
+	jr	ra
+	nop
+	.set    reorder
+END(set_clock_ratio)
+/*
+ * Function: set_zephyr
+ * Arguments:   None
+ * Returns:     None
+ * Description: Set any zephyr bits
+ * Trashes:     t0 & t1
+ *
+ */
+LEAF(set_zephyr)
+        .set    noreorder
+
+        /* enable read/write of CP0 #22 sel. 8 */
+        li      t0, 0x5a455048
+	.word	0x4088b00f      /* mtc0    t0, $22, 15 */
+
+	.word	0x4008b008      /* mfc0    t0, $22, 8 */
+        li      t1, 0x09008000	/* turn off pref, jtb */
+        or      t0, t0, t1
+	.word	0x4088b008      /* mtc0    t0, $22, 8 */
+        sync
+
+	/* disable read/write of CP0 #22 sel 8 */
+        li      t0, 0x0
+	.word	0x4088b00f      /* mtc0    t0, $22, 15 */
+
+
+        jr      ra
+        nop
+	.set reorder
+
+END(set_zephyr)
+
+
+/*
+ * Function:    set_llmb
+ * Arguments:   a0=0 disable llmb, a0=1 enables llmb
+ * Returns:     None
+ * Description:
+ * Trashes:     t0, t1, t2
+ *
+ *      pseudo code:
+ *
+ */
+LEAF(set_llmb)
+	.set noreorder
+
+	li	t2, 0x90000000 | BRCM_ZSC_ALL_REGS_SELECT | BRCM_ZSC_CONFIG_REG
+	sync
+	cache	0x7, 0x0(t2)
+	sync
+	mfc0	t0, CP0_D_SEC_CACHE_DATA_LO
+	li	t1, ~(BRCM_ZSC_CONFIG_LMB1En | BRCM_ZSC_CONFIG_LMB0En)
+	and	t0, t0, t1
+
+	beqz	a0, svlmb
+	nop
+
+enable_lmb:
+	li	t1, (BRCM_ZSC_CONFIG_LMB1En | BRCM_ZSC_CONFIG_LMB0En)
+	or	t0, t0, t1
+
+svlmb:
+	mtc0	t0, CP0_D_SEC_CACHE_DATA_LO
+	sync
+	cache	0xb, 0x0(t2)
+	sync
+
+	jr      ra
+	nop
+	.set reorder
+
+END(set_llmb)
+/*
+ * Function: 	core_init
+ * Arguments:	none
+ * Returns:	None
+ * Description: initialize core related configuration
+ * Trashes:	v0,v1,a0,a1,t8
+ *
+ *	pseudo code:
+ *
+ */
+	.globl	core_init
+	.ent    core_init
+	.set	noreorder
+core_init:
+	move	t8, ra
+
+	/* set Zephyr bits. */
+	bal	set_zephyr
+	nop
+
+#if ENABLE_FPU==1
+	/* initialize the Floating point unit (both TPs) */
+	bal	init_fpu
+	nop
+#endif
+
+	/* set low latency memory bus */
+	li      a0, 1
+	bal     set_llmb
+	nop
+
+	/* set branch prediction (TP0 only) */
+	bal	set_branch_pred
+	nop
+
+	/* set link uncached */
+	bal	set_luc
+	nop
+
+	/* set CWF and TSE */
+	bal     set_cwf_tse
+	nop
+
+	/*
+	 *set clock ratio by setting 1 to 'set'
+	 * and 0 to ClkRatio, (TP0 only)
+	 */
+	li	a0, 0
+	bal	set_clock_ratio
+	nop
+
+	/* set other configuration to defaults */
+	bal	set_other_config
+	nop
+
+	move	ra, t8
+	jr	ra
+	nop
+
+	.set reorder
+	.end	core_init
+
+/*
+ * Function: 	clear_jump_target_buffer
+ * Arguments:   None
+ * Returns:     None
+ * Description:
+ * Trashes:     t0, t1, t2
+ *
+ */
+#define RESET_CALL_RETURN_STACK_THIS_THREAD             (0x06<<16)
+#define RESET_JUMP_TARGET_BUFFER_THIS_THREAD    	(0x04<<16)
+#define JTB_CS_CNTL_MASK				(0xFF<<16)
+
+	.globl  clear_jump_target_buffer
+	.ent    clear_jump_target_buffer
+	.set    noreorder
+clear_jump_target_buffer:
+
+        mfc0    t0, $22, 2
+        nop
+        nop
+
+        li	t1, ~JTB_CS_CNTL_MASK
+        and	t0, t0, t1
+        li	t2, RESET_CALL_RETURN_STACK_THIS_THREAD
+        or	t0, t0, t2
+        mtc0    t0, $22, 2
+        nop
+        nop
+
+        and	t0, t0, t1
+        li	t2, RESET_JUMP_TARGET_BUFFER_THIS_THREAD
+        or	t0, t0, t2
+        mtc0	t0, $22, 2
+        nop
+        nop
+        jr      ra
+        nop
+
+	.end    clear_jump_target_buffer
+	.set    reorder
+/*
+ * Function: 	bmips_cache_init
+ * Arguments: 	None
+ * Returns:	None
+ * Description: Enable I and D caches, and initialize I and D-caches
+ * Trashes:	v0, v1, t0, t1, t2, t5, t7, t8
+ *
+ */
+	.globl	bmips_5xxx_init
+	.ent	bmips_5xxx_init
+	.set    noreorder
+bmips_5xxx_init:
+
+	/* save return address  and A0 */
+	move    t7, ra
+	move	t5, a0
+
+	jal	l1_init
+	nop
+
+	jal	core_init
+	nop
+
+	jal	clear_jump_target_buffer
+	nop
+
+        mtc0    zero, CP0_CAUSE
+
+	move 	a0, t5
+	jr	t7
+	nop
+
+	.end 	bmips_5xxx_init
+	.set    reorder
+
+
+#endif
diff --git a/arch/mips/kernel/bmips_vec.S b/arch/mips/kernel/bmips_vec.S
index d9495f3f3fad..921a5fa55da6 100644
--- a/arch/mips/kernel/bmips_vec.S
+++ b/arch/mips/kernel/bmips_vec.S
@@ -88,7 +88,7 @@ NESTED(bmips_reset_nmi_vec, PT_SIZE, sp)
 	li	k1, (1 << 19)
 	mfc0	k0, CP0_STATUS
 	and	k0, k1
-	beqz	k0, bmips_smp_entry
+	beqz	k0, soft_reset
 
 #if defined(CONFIG_CPU_BMIPS5000)
 	mfc0	k0, CP0_PRID
@@ -126,13 +126,48 @@ NESTED(bmips_reset_nmi_vec, PT_SIZE, sp)
 	.set	arch=r4000
 	eret
 
+#ifdef CONFIG_SMP
+soft_reset:
+
+#if defined(CONFIG_CPU_BMIPS5000)
+	mfc0	k0, CP0_PRID
+	andi	k0, 0xff00
+	li	k1, PRID_IMP_BMIPS5200
+	bne	k0, k1, bmips_smp_entry
+
+        /* if running on TP 1, jump  to  bmips_smp_entry */
+        mfc0    k0, $22
+        li      k1, (1 << 24)
+        and     k1, k0
+        bnez    k1, bmips_smp_entry
+        nop
+
+        /*
+         * running on TP0, can not be core 0 (the boot core).
+         * Check for soft reset.  Indicates a warm boot
+         */
+        mfc0    k0, $12
+        li      k1, (1 << 20)
+        and     k0, k1
+        beqz    k0, bmips_smp_entry
+
+        /*
+         * Warm boot.
+         * Cache init is only done on TP0
+         */
+        la      k0, bmips_5xxx_init
+        jalr    k0
+        nop
+
+        b       bmips_smp_entry
+        nop
+#endif
+
 /***********************************************************************
  * CPU1 reset vector (used for the initial boot only)
  * This is still part of bmips_reset_nmi_vec().
  ***********************************************************************/
 
-#ifdef CONFIG_SMP
-
 bmips_smp_entry:
 
 	/* set up CP0 STATUS; enable FPU */
-- 
2.1.0
