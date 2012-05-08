Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2012 14:42:52 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:2768 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903640Ab2EHMmo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 May 2012 14:42:44 +0200
Received: from [10.9.200.131] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 08 May 2012 05:42:52 -0700
X-Server-Uuid: 72204117-5C29-4314-8910-60DB108979CB
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Tue, 8 May 2012 05:42:28 -0700
Received: from hqcas01.netlogicmicro.com (unknown [10.65.50.14]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 1747A9F9F5; Tue, 8
 May 2012 05:42:28 -0700 (PDT)
Received: from jayachandranc.netlogicmicro.com (10.7.0.77) by
 hqcas01.netlogicmicro.com (10.65.50.14) with Microsoft SMTP Server id
 14.1.339.1; Tue, 8 May 2012 05:42:27 -0700
From:   "Jayachandran C" <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jayachandranc@netlogicmicro.com>
Subject: [PATCH 05/14] MIPS: Netlogic: Update comments in smpboot.S
Date:   Tue, 8 May 2012 18:11:59 +0530
Message-ID: <1336480928-18887-6-git-send-email-jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1336480928-18887-1-git-send-email-jayachandranc@netlogicmicro.com>
References: <1336480928-18887-1-git-send-email-jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
X-Originating-IP: [10.7.0.77]
X-WSS-ID: 63B7CB4644G1245195-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 33196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

No change in logic, comments update and whitespace cleanup.

* A few comments in the file were in assembler style and the rest
  int C style, convert all of them to C style.
* Mark workarounds for Ax silicon with a macro XLP_AX_WORKAROUND
* Whitespace fixes - use tabs consistently
* rename __config_lsu macro to xlp_config_lsu

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/netlogic/common/smpboot.S |  112 +++++++++++++++++++----------------
 1 file changed, 61 insertions(+), 51 deletions(-)

diff --git a/arch/mips/netlogic/common/smpboot.S b/arch/mips/netlogic/common/smpboot.S
index c138b1a..bfe9060 100644
--- a/arch/mips/netlogic/common/smpboot.S
+++ b/arch/mips/netlogic/common/smpboot.S
@@ -54,28 +54,36 @@
 			XLP_IO_SYS_OFFSET(node) + XLP_IO_PCI_HDRSZ + \
 			SYS_CPU_NONCOHERENT_MODE * 4
 
-.macro __config_lsu
-	li      t0, LSU_DEFEATURE
-	mfcr    t1, t0
+#define	XLP_AX_WORKAROUND	/* enable Ax silicon workarounds */
 
-	lui     t2, 0x4080  /* Enable Unaligned Access, L2HPE */
-	or      t1, t1, t2
-	li	t2, ~0xe    /* S1RCM */
+/* Enable XLP features and workarounds in the LSU */
+.macro xlp_config_lsu
+	li	t0, LSU_DEFEATURE
+	mfcr	t1, t0
+
+	lui	t2, 0x4080	/* Enable Unaligned Access, L2HPE */
+	or	t1, t1, t2
+#ifdef XLP_AX_WORKAROUND
+	li	t2, ~0xe	/* S1RCM */
 	and	t1, t1, t2
+#endif
 	mtcr    t1, t0
 
-	li      t0, SCHED_DEFEATURE
-	lui     t1, 0x0100  /* Experimental: Disable BRU accepting ALU ops */
-	mtcr    t1, t0
+#ifdef XLP_AX_WORKAROUND
+	li	t0, SCHED_DEFEATURE
+	lui	t1, 0x0100	/* Disable BRU accepting ALU ops */
+	mtcr	t1, t0
+#endif
 .endm
 
 /*
- * The cores can come start when they are woken up. This is also the NMI
- * entry, so check that first.
+ * This is the code that will be copied to the reset entry point for
+ * XLR and XLP. The XLP cores start here when they are woken up. This
+ * is also the NMI entry point.
  *
- * The data corresponding to reset is stored at RESET_DATA_PHYS location,
- * this will have the thread mask (used when core is woken up) and the
- * current NMI handler in case we reached here for an NMI.
+ * The data corresponding to reset/NMI is stored at RESET_DATA_PHYS
+ * location, this will have the thread mask (used when core is woken up)
+ * and the current NMI handler in case we reached here for an NMI.
  *
  * When a core or thread is newly woken up, it loops in a 'wait'. When
  * the CPU really needs waking up, we send an NMI to it, with the NMI
@@ -89,12 +97,12 @@
 FEXPORT(nlm_reset_entry)
 	dmtc0	k0, $22, 6
 	dmtc0	k1, $22, 7
-	mfc0    k0, CP0_STATUS
-	li      k1, 0x80000
-	and     k1, k0, k1
-	beqz    k1, 1f         /* go to real reset entry */
+	mfc0	k0, CP0_STATUS
+	li	k1, 0x80000
+	and	k1, k0, k1
+	beqz	k1, 1f		/* go to real reset entry */
 	nop
-	li	k1, CKSEG1ADDR(RESET_DATA_PHYS)   /* NMI */
+	li	k1, CKSEG1ADDR(RESET_DATA_PHYS)	/* NMI */
 	ld	k0, BOOT_NMI_HANDLER(k1)
 	jr	k0
 	nop
@@ -114,21 +122,23 @@ FEXPORT(nlm_reset_entry)
 	li	t2, SYS_CPU_COHERENT_BASE(0)
 	add	t2, t2, t3		/* t2 <- SYS offset for node */
 	lw	t1, 0(t2)
-	and     t1, t1, t0
-	sw      t1, 0(t2)
+	and	t1, t1, t0
+	sw	t1, 0(t2)
 
 	/* read back to ensure complete */
-	lw      t1, 0(t2)
+	lw	t1, 0(t2)
 	sync
 
 	/* Configure LSU on Non-0 Cores. */
-	__config_lsu
+	xlp_config_lsu
+	/* FALL THROUGH */
 
 /*
  * Wake up sibling threads from the initial thread in
  * a core.
  */
 EXPORT(nlm_boot_siblings)
+	/* Enable hw threads by writing to MAP_THREADMODE of the core */
 	li	t0, CKSEG1ADDR(RESET_DATA_PHYS)
 	lw	t1, BOOT_THREAD_MODE(t0)	/* t1 <- thread mode */
 	li	t0, ((CPU_BLOCKID_MAP << 8) | MAP_THREADMODE)
@@ -139,24 +149,24 @@ EXPORT(nlm_boot_siblings)
 	/*
 	 * The new hardware thread starts at the next instruction
 	 * For all the cases other than core 0 thread 0, we will
-         * jump to the secondary wait function.
-         */
+	* jump to the secondary wait function.
+	*/
 	mfc0	v0, CP0_EBASE, 1
 	andi	v0, 0x7f		/* v0 <- node/core */
 
-#if 1
-	/* A0 errata - Write MMU_SETUP after changing thread mode register. */
+	/* Init MMU in the first thread after changing THREAD_MODE
+	 * register (Ax Errata?)
+	 */
 	andi	v1, v0, 0x3		/* v1 <- thread id */
 	bnez	v1, 2f
 	nop
 
-        li	t0, MMU_SETUP
-        li	t1, 0
-        mtcr	t1, t0
+	li	t0, MMU_SETUP
+	li	t1, 0
+	mtcr	t1, t0
 	ehb
-#endif
 
-2:	beqz	v0, 4f
+2:	beqz	v0, 4f		/* boot cpu (cpuid == 0)? */
 	nop
 
 	/* setup status reg */
@@ -183,9 +193,9 @@ EXPORT(nlm_boot_siblings)
 	 * For the boot CPU, we have to restore registers and
 	 * return
 	 */
-4:	dmfc0	t0, $4, 2       /* restore SP from UserLocal */
+4:	dmfc0	t0, $4, 2	/* restore SP from UserLocal */
 	li	t1, 0xfadebeef
-	dmtc0	t1, $4, 2       /* restore SP from UserLocal */
+	dmtc0	t1, $4, 2	/* restore SP from UserLocal */
 	PTR_SUBU sp, t0, PT_SIZE
 	RESTORE_ALL
 	jr   ra
@@ -193,7 +203,7 @@ EXPORT(nlm_boot_siblings)
 EXPORT(nlm_reset_entry_end)
 
 FEXPORT(xlp_boot_core0_siblings)	/* "Master" cpu starts from here */
-	__config_lsu
+	xlp_config_lsu
 	dmtc0   sp, $4, 2		/* SP saved in UserLocal */
 	SAVE_ALL
 	sync
@@ -234,36 +244,36 @@ END(nlm_boot_secondary_cpus)
  */
 	__CPUINIT
 NESTED(nlm_rmiboot_preboot, 16, sp)
-	mfc0	t0, $15, 1	# read ebase
-	andi	t0, 0x1f	# t0 has the processor_id()
-	andi	t2, t0, 0x3	# thread no
-	sll	t0, 2		# offset in cpu array
+	mfc0	t0, $15, 1	/* read ebase */
+	andi	t0, 0x1f	/* t0 has the processor_id() */
+	andi	t2, t0, 0x3	/* thread num */
+	sll	t0, 2		/* offset in cpu array */
 
-	PTR_LA	t1, nlm_cpu_ready # mark CPU ready
+	PTR_LA	t1, nlm_cpu_ready /* mark CPU ready */
 	PTR_ADDU t1, t0
 	li	t3, 1
 	sw	t3, 0(t1)
 
-	bnez	t2, 1f		# skip thread programming
-	nop			# for non zero hw threads
+	bnez	t2, 1f		/* skip thread programming */
+	nop			/* for thread id != 0 */
 
 	/*
-	 * MMU setup only for first thread in core
+	 * XLR MMU setup only for first thread in core
 	 */
 	li	t0, 0x400
 	mfcr	t1, t0
-	li	t2, 6 		# XLR thread mode mask
+	li	t2, 6 		/* XLR thread mode mask */
 	nor	t3, t2, zero
-	and	t2, t1, t2	# t2 - current thread mode
+	and	t2, t1, t2	/* t2 - current thread mode */
 	li	v0, CKSEG1ADDR(RESET_DATA_PHYS)
-	lw	v1, BOOT_THREAD_MODE(v0) # v1 - new thread mode
+	lw	v1, BOOT_THREAD_MODE(v0) /* v1 - new thread mode */
 	sll	v1, 1
-	beq	v1, t2, 1f 	# same as request value
-	nop			# nothing to do */
+	beq	v1, t2, 1f 	/* same as request value */
+	nop			/* nothing to do */
 
-	and	t2, t1, t3	# mask out old thread mode
-	or	t1, t2, v1	# put in new value
-	mtcr	t1, t0		# update core control
+	and	t2, t1, t3	/* mask out old thread mode */
+	or	t1, t2, v1	/* put in new value */
+	mtcr	t1, t0		/* update core control */
 
 1:	wait
 	j	1b
-- 
1.7.9.5
