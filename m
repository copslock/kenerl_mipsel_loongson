Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 09:42:07 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:1196 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822969Ab3FJHkF5TSA5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Jun 2013 09:40:05 +0200
Received: from [10.9.208.53] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 10 Jun 2013 00:34:09 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 10 Jun 2013 00:39:50 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 10 Jun 2013 00:39:50 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id CE56BF2D73; Mon, 10
 Jun 2013 00:39:48 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 02/11] MIPS: Netlogic: Split reset code out of smpboot.S
Date:   Mon, 10 Jun 2013 13:11:01 +0530
Message-ID: <1370850070-5127-3-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370850070-5127-1-git-send-email-jchandra@broadcom.com>
References: <1370850070-5127-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7DAB5EFB1R029041190-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

The reset and core initialization code should be available for
uniprocessor as well. This changes is just to take out the code
into a different file, without any change to the logic.

The change for  uniprocessor initialization code is in a later patch.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/common.h |    1 +
 arch/mips/netlogic/common/Makefile      |    2 +-
 arch/mips/netlogic/common/reset.S       |  249 +++++++++++++++++++++++++++++++
 arch/mips/netlogic/common/smpboot.S     |  187 +----------------------
 arch/mips/netlogic/xlp/wakeup.c         |    1 +
 5 files changed, 253 insertions(+), 187 deletions(-)
 create mode 100644 arch/mips/netlogic/common/reset.S

diff --git a/arch/mips/include/asm/netlogic/common.h b/arch/mips/include/asm/netlogic/common.h
index 70351b9..d4ede12 100644
--- a/arch/mips/include/asm/netlogic/common.h
+++ b/arch/mips/include/asm/netlogic/common.h
@@ -71,6 +71,7 @@ nlm_set_nmi_handler(void *handler)
 /*
  * Misc.
  */
+void nlm_init_boot_cpu(void);
 unsigned int nlm_get_cpu_frequency(void);
 void nlm_node_init(int node);
 extern struct plat_smp_ops nlm_smp_ops;
diff --git a/arch/mips/netlogic/common/Makefile b/arch/mips/netlogic/common/Makefile
index b295497..a396a39 100644
--- a/arch/mips/netlogic/common/Makefile
+++ b/arch/mips/netlogic/common/Makefile
@@ -1,4 +1,4 @@
 obj-y				+= irq.o time.o
 obj-y				+= nlm-dma.o
-obj-$(CONFIG_SMP)		+= smp.o smpboot.o
+obj-$(CONFIG_SMP)		+= smp.o smpboot.o reset.o
 obj-$(CONFIG_EARLY_PRINTK)	+= earlycons.o
diff --git a/arch/mips/netlogic/common/reset.S b/arch/mips/netlogic/common/reset.S
new file mode 100644
index 0000000..8fa25c2
--- /dev/null
+++ b/arch/mips/netlogic/common/reset.S
@@ -0,0 +1,249 @@
+/*
+ * Copyright 2003-2013 Broadcom Corporation.
+ * All Rights Reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the Broadcom
+ * license below:
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY BROADCOM ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL BROADCOM OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/init.h>
+
+#include <asm/asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/regdef.h>
+#include <asm/mipsregs.h>
+#include <asm/stackframe.h>
+#include <asm/asmmacro.h>
+#include <asm/addrspace.h>
+
+#include <asm/netlogic/common.h>
+
+#include <asm/netlogic/xlp-hal/iomap.h>
+#include <asm/netlogic/xlp-hal/xlp.h>
+#include <asm/netlogic/xlp-hal/sys.h>
+#include <asm/netlogic/xlp-hal/cpucontrol.h>
+
+#define CP0_EBASE	$15
+#define SYS_CPU_COHERENT_BASE(node)	CKSEG1ADDR(XLP_DEFAULT_IO_BASE) + \
+			XLP_IO_SYS_OFFSET(node) + XLP_IO_PCI_HDRSZ + \
+			SYS_CPU_NONCOHERENT_MODE * 4
+
+#define XLP_AX_WORKAROUND	/* enable Ax silicon workarounds */
+
+/* Enable XLP features and workarounds in the LSU */
+.macro xlp_config_lsu
+	li	t0, LSU_DEFEATURE
+	mfcr	t1, t0
+
+	lui	t2, 0xc080	/* SUE, Enable Unaligned Access, L2HPE */
+	or	t1, t1, t2
+#ifdef XLP_AX_WORKAROUND
+	li	t2, ~0xe	/* S1RCM */
+	and	t1, t1, t2
+#endif
+	mtcr	t1, t0
+
+	li	t0, ICU_DEFEATURE
+	mfcr	t1, t0
+	ori	t1, 0x1000	/* Enable Icache partitioning */
+	mtcr	t1, t0
+
+
+#ifdef XLP_AX_WORKAROUND
+	li	t0, SCHED_DEFEATURE
+	lui	t1, 0x0100	/* Disable BRU accepting ALU ops */
+	mtcr	t1, t0
+#endif
+.endm
+
+/*
+ * Low level flush for L1D cache on XLP, the normal cache ops does
+ * not do the complete and correct cache flush.
+ */
+.macro	xlp_flush_l1_dcache
+	li	t0, LSU_DEBUG_DATA0
+	li	t1, LSU_DEBUG_ADDR
+	li	t2, 0		/* index */
+	li	t3, 0x1000	/* loop count */
+1:
+	sll	v0, t2, 5
+	mtcr	zero, t0
+	ori	v1, v0, 0x3	/* way0 | write_enable | write_active */
+	mtcr	v1, t1
+2:
+	mfcr	v1, t1
+	andi	v1, 0x1		/* wait for write_active == 0 */
+	bnez	v1, 2b
+	nop
+	mtcr	zero, t0
+	ori	v1, v0, 0x7	/* way1 | write_enable | write_active */
+	mtcr	v1, t1
+3:
+	mfcr	v1, t1
+	andi	v1, 0x1		/* wait for write_active == 0 */
+	bnez	v1, 3b
+	nop
+	addi	t2, 1
+	bne	t3, t2, 1b
+	nop
+.endm
+
+/*
+ * nlm_reset_entry will be copied to the reset entry point for
+ * XLR and XLP. The XLP cores start here when they are woken up. This
+ * is also the NMI entry point.
+ *
+ * We use scratch reg 6/7 to save k0/k1 and check for NMI first.
+ *
+ * The data corresponding to reset/NMI is stored at RESET_DATA_PHYS
+ * location, this will have the thread mask (used when core is woken up)
+ * and the current NMI handler in case we reached here for an NMI.
+ *
+ * When a core or thread is newly woken up, it marks itself ready and
+ * loops in a 'wait'. When the CPU really needs waking up, we send an NMI
+ * IPI to it, with the NMI handler set to prom_boot_secondary_cpus
+ */
+	.set	noreorder
+	.set	noat
+	.set	arch=xlr	/* for mfcr/mtcr, XLR is sufficient */
+
+FEXPORT(nlm_reset_entry)
+	dmtc0	k0, $22, 6
+	dmtc0	k1, $22, 7
+	mfc0	k0, CP0_STATUS
+	li	k1, 0x80000
+	and	k1, k0, k1
+	beqz	k1, 1f		/* go to real reset entry */
+	nop
+	li	k1, CKSEG1ADDR(RESET_DATA_PHYS) /* NMI */
+	ld	k0, BOOT_NMI_HANDLER(k1)
+	jr	k0
+	nop
+
+1:	/* Entry point on core wakeup */
+	mfc0	t0, CP0_EBASE, 1
+	mfc0	t1, CP0_EBASE, 1
+	srl	t1, 5
+	andi	t1, 0x3			/* t1 <- node */
+	li	t2, 0x40000
+	mul	t3, t2, t1		/* t3 = node * 0x40000 */
+	srl	t0, t0, 2
+	and	t0, t0, 0x7		/* t0 <- core */
+	li	t1, 0x1
+	sll	t0, t1, t0
+	nor	t0, t0, zero		/* t0 <- ~(1 << core) */
+	li	t2, SYS_CPU_COHERENT_BASE(0)
+	add	t2, t2, t3		/* t2 <- SYS offset for node */
+	lw	t1, 0(t2)
+	and	t1, t1, t0
+	sw	t1, 0(t2)
+
+	/* read back to ensure complete */
+	lw	t1, 0(t2)
+	sync
+
+	/* Configure LSU on Non-0 Cores. */
+	xlp_config_lsu
+	/* FALL THROUGH */
+
+/*
+ * Wake up sibling threads from the initial thread in
+ * a core.
+ */
+EXPORT(nlm_boot_siblings)
+	/* core L1D flush before enable threads */
+	xlp_flush_l1_dcache
+	/* Enable hw threads by writing to MAP_THREADMODE of the core */
+	li	t0, CKSEG1ADDR(RESET_DATA_PHYS)
+	lw	t1, BOOT_THREAD_MODE(t0)	/* t1 <- thread mode */
+	li	t0, ((CPU_BLOCKID_MAP << 8) | MAP_THREADMODE)
+	mfcr	t2, t0
+	or	t2, t2, t1
+	mtcr	t2, t0
+
+	/*
+	 * The new hardware thread starts at the next instruction
+	 * For all the cases other than core 0 thread 0, we will
+	* jump to the secondary wait function.
+	*/
+	mfc0	v0, CP0_EBASE, 1
+	andi	v0, 0x3ff		/* v0 <- node/core */
+
+	/* Init MMU in the first thread after changing THREAD_MODE
+	 * register (Ax Errata?)
+	 */
+	andi	v1, v0, 0x3		/* v1 <- thread id */
+	bnez	v1, 2f
+	nop
+
+	li	t0, MMU_SETUP
+	li	t1, 0
+	mtcr	t1, t0
+	_ehb
+
+2:	beqz	v0, 4f		/* boot cpu (cpuid == 0)? */
+	nop
+
+	/* setup status reg */
+	move	t1, zero
+#ifdef CONFIG_64BIT
+	ori	t1, ST0_KX
+#endif
+	mtc0	t1, CP0_STATUS
+	/* mark CPU ready */
+	PTR_LA	t1, nlm_cpu_ready
+	sll	v1, v0, 2
+	PTR_ADDU t1, v1
+	li	t2, 1
+	sw	t2, 0(t1)
+	/* Wait until NMI hits */
+3:	wait
+	j	3b
+	nop
+
+	/*
+	 * For the boot CPU, we have to restore registers and
+	 * return
+	 */
+4:	dmfc0	t0, $4, 2	/* restore SP from UserLocal */
+	li	t1, 0xfadebeef
+	dmtc0	t1, $4, 2	/* restore SP from UserLocal */
+	PTR_SUBU sp, t0, PT_SIZE
+	RESTORE_ALL
+	jr	ra
+	nop
+EXPORT(nlm_reset_entry_end)
+
+LEAF(nlm_init_boot_cpu)
+#ifdef CONFIG_CPU_XLP
+	xlp_config_lsu
+#endif
+	jr	ra
+	nop
+END(nlm_init_boot_cpu)
diff --git a/arch/mips/netlogic/common/smpboot.S b/arch/mips/netlogic/common/smpboot.S
index 0265174..7c7e884 100644
--- a/arch/mips/netlogic/common/smpboot.S
+++ b/arch/mips/netlogic/common/smpboot.S
@@ -50,197 +50,12 @@
 #include <asm/netlogic/xlp-hal/cpucontrol.h>
 
 #define CP0_EBASE	$15
-#define SYS_CPU_COHERENT_BASE(node)	CKSEG1ADDR(XLP_DEFAULT_IO_BASE) + \
-			XLP_IO_SYS_OFFSET(node) + XLP_IO_PCI_HDRSZ + \
-			SYS_CPU_NONCOHERENT_MODE * 4
-
-#define XLP_AX_WORKAROUND	/* enable Ax silicon workarounds */
-
-/* Enable XLP features and workarounds in the LSU */
-.macro xlp_config_lsu
-	li	t0, LSU_DEFEATURE
-	mfcr	t1, t0
-
-	lui	t2, 0xc080	/* SUE, Enable Unaligned Access, L2HPE */
-	or	t1, t1, t2
-#ifdef XLP_AX_WORKAROUND
-	li	t2, ~0xe	/* S1RCM */
-	and	t1, t1, t2
-#endif
-	mtcr	t1, t0
-
-	li	t0, ICU_DEFEATURE
-	mfcr	t1, t0
-	ori	t1, 0x1000	/* Enable Icache partitioning */
-	mtcr	t1, t0
-
-
-#ifdef XLP_AX_WORKAROUND
-	li	t0, SCHED_DEFEATURE
-	lui	t1, 0x0100	/* Disable BRU accepting ALU ops */
-	mtcr	t1, t0
-#endif
-.endm
-
-/*
- * This is the code that will be copied to the reset entry point for
- * XLR and XLP. The XLP cores start here when they are woken up. This
- * is also the NMI entry point.
- */
-.macro	xlp_flush_l1_dcache
-	li	t0, LSU_DEBUG_DATA0
-	li	t1, LSU_DEBUG_ADDR
-	li	t2, 0		/* index */
-	li	t3, 0x1000	/* loop count */
-1:
-	sll	v0, t2, 5
-	mtcr	zero, t0
-	ori	v1, v0, 0x3	/* way0 | write_enable | write_active */
-	mtcr	v1, t1
-2:
-	mfcr	v1, t1
-	andi	v1, 0x1		/* wait for write_active == 0 */
-	bnez	v1, 2b
-	nop
-	mtcr	zero, t0
-	ori	v1, v0, 0x7	/* way1 | write_enable | write_active */
-	mtcr	v1, t1
-3:
-	mfcr	v1, t1
-	andi	v1, 0x1		/* wait for write_active == 0 */
-	bnez	v1, 3b
-	nop
-	addi	t2, 1
-	bne	t3, t2, 1b
-	nop
-.endm
-
-/*
- * The cores can come start when they are woken up. This is also the NMI
- * entry, so check that first.
- *
- * The data corresponding to reset/NMI is stored at RESET_DATA_PHYS
- * location, this will have the thread mask (used when core is woken up)
- * and the current NMI handler in case we reached here for an NMI.
- *
- * When a core or thread is newly woken up, it loops in a 'wait'. When
- * the CPU really needs waking up, we send an NMI to it, with the NMI
- * handler set to prom_boot_secondary_cpus
- */
 
 	.set	noreorder
 	.set	noat
-	.set	arch=xlr	/* for mfcr/mtcr, XLR is sufficient */
-
-FEXPORT(nlm_reset_entry)
-	dmtc0	k0, $22, 6
-	dmtc0	k1, $22, 7
-	mfc0	k0, CP0_STATUS
-	li	k1, 0x80000
-	and	k1, k0, k1
-	beqz	k1, 1f		/* go to real reset entry */
-	nop
-	li	k1, CKSEG1ADDR(RESET_DATA_PHYS) /* NMI */
-	ld	k0, BOOT_NMI_HANDLER(k1)
-	jr	k0
-	nop
-
-1:	/* Entry point on core wakeup */
-	mfc0	t0, CP0_EBASE, 1
-	mfc0	t1, CP0_EBASE, 1
-	srl	t1, 5
-	andi	t1, 0x3			/* t1 <- node */
-	li	t2, 0x40000
-	mul	t3, t2, t1		/* t3 = node * 0x40000 */
-	srl	t0, t0, 2
-	and	t0, t0, 0x7		/* t0 <- core */
-	li	t1, 0x1
-	sll	t0, t1, t0
-	nor	t0, t0, zero		/* t0 <- ~(1 << core) */
-	li	t2, SYS_CPU_COHERENT_BASE(0)
-	add	t2, t2, t3		/* t2 <- SYS offset for node */
-	lw	t1, 0(t2)
-	and	t1, t1, t0
-	sw	t1, 0(t2)
-
-	/* read back to ensure complete */
-	lw	t1, 0(t2)
-	sync
-
-	/* Configure LSU on Non-0 Cores. */
-	xlp_config_lsu
-	/* FALL THROUGH */
-
-/*
- * Wake up sibling threads from the initial thread in
- * a core.
- */
-EXPORT(nlm_boot_siblings)
-	/* core L1D flush before enable threads */
-	xlp_flush_l1_dcache
-	/* Enable hw threads by writing to MAP_THREADMODE of the core */
-	li	t0, CKSEG1ADDR(RESET_DATA_PHYS)
-	lw	t1, BOOT_THREAD_MODE(t0)	/* t1 <- thread mode */
-	li	t0, ((CPU_BLOCKID_MAP << 8) | MAP_THREADMODE)
-	mfcr	t2, t0
-	or	t2, t2, t1
-	mtcr	t2, t0
-
-	/*
-	 * The new hardware thread starts at the next instruction
-	 * For all the cases other than core 0 thread 0, we will
-	* jump to the secondary wait function.
-	*/
-	mfc0	v0, CP0_EBASE, 1
-	andi	v0, 0x3ff		/* v0 <- node/core */
-
-	/* Init MMU in the first thread after changing THREAD_MODE
-	 * register (Ax Errata?)
-	 */
-	andi	v1, v0, 0x3		/* v1 <- thread id */
-	bnez	v1, 2f
-	nop
-
-	li	t0, MMU_SETUP
-	li	t1, 0
-	mtcr	t1, t0
-	_ehb
-
-2:	beqz	v0, 4f		/* boot cpu (cpuid == 0)? */
-	nop
-
-	/* setup status reg */
-	move	t1, zero
-#ifdef CONFIG_64BIT
-	ori	t1, ST0_KX
-#endif
-	mtc0	t1, CP0_STATUS
-	/* mark CPU ready */
-	PTR_LA	t1, nlm_cpu_ready
-	sll	v1, v0, 2
-	PTR_ADDU t1, v1
-	li	t2, 1
-	sw	t2, 0(t1)
-	/* Wait until NMI hits */
-3:	wait
-	j	3b
-	nop
-
-	/*
-	 * For the boot CPU, we have to restore registers and
-	 * return
-	 */
-4:	dmfc0	t0, $4, 2	/* restore SP from UserLocal */
-	li	t1, 0xfadebeef
-	dmtc0	t1, $4, 2	/* restore SP from UserLocal */
-	PTR_SUBU sp, t0, PT_SIZE
-	RESTORE_ALL
-	jr   ra
-	nop
-EXPORT(nlm_reset_entry_end)
+	.set	arch=xlr		/* for mfcr/mtcr, XLR is sufficient */
 
 FEXPORT(xlp_boot_core0_siblings)	/* "Master" cpu starts from here */
-	xlp_config_lsu
 	dmtc0	sp, $4, 2		/* SP saved in UserLocal */
 	SAVE_ALL
 	sync
diff --git a/arch/mips/netlogic/xlp/wakeup.c b/arch/mips/netlogic/xlp/wakeup.c
index abb3e08..1a7d529 100644
--- a/arch/mips/netlogic/xlp/wakeup.c
+++ b/arch/mips/netlogic/xlp/wakeup.c
@@ -137,6 +137,7 @@ void xlp_wakeup_secondary_cpus()
 	 * In case of u-boot, the secondaries are in reset
 	 * first wakeup core 0 threads
 	 */
+	nlm_init_boot_cpu();
 	xlp_boot_core0_siblings();
 
 	/* now get other cores out of reset */
-- 
1.7.9.5
