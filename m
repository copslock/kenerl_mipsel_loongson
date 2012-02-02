Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2012 15:41:12 +0100 (CET)
Received: from smtpgw2.netlogicmicro.com ([12.203.210.54]:52724 "EHLO
        smtpgw2.netlogicmicro.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904110Ab2BBOjU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2012 15:39:20 +0100
Received: from pps.filterd (smtpgw2 [127.0.0.1])
        by smtpgw2.netlogicmicro.com (8.14.5/8.14.5) with SMTP id q12EcpTm028764;
        Thu, 2 Feb 2012 06:39:13 -0800
Received: from hqcas02.netlogicmicro.com (hqcas02.netlogicmicro.com [10.65.50.15])
        by smtpgw2.netlogicmicro.com with ESMTP id 11pcrwt2a8-1
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 02 Feb 2012 06:39:13 -0800
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     Jayachandran C <jayachandranc@netlogicmicro.com>
Subject: [PATCH 05/11] MIPS: Netlogic: SMP wakeup code update
Date:   Thu, 2 Feb 2012 20:12:59 +0530
Message-ID: <a5879133671a87ef5fe33900b26f29772da565fd.1328189941.git.jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1328189941.git.jayachandranc@netlogicmicro.com>
References: <cover.1328189941.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.7.0.77]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.6.7361,1.0.211,0.0.0000
 definitions=2012-01-28_02:2012-01-27,2012-01-28,1970-01-01 signatures=0
X-archive-position: 32388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Update for core intialization code.  Initialize status register
after receiving NMI for CPU wakeup. Add the low level L1D flush
code before enabling threads in core.

Also convert the ehb to _ehb so that it works under more GCC
versions.

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 .../mips/include/asm/netlogic/xlp-hal/cpucontrol.h |    4 +-
 arch/mips/netlogic/common/smpboot.S                |   47 +++++++++++++++++--
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/cpucontrol.h b/arch/mips/include/asm/netlogic/xlp-hal/cpucontrol.h
index bf7d41d..7b63a6b 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/cpucontrol.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/cpucontrol.h
@@ -47,7 +47,9 @@
 #define CPU_BLOCKID_MAP		10
 
 #define LSU_DEFEATURE		0x304
-#define LSU_CERRLOG_REGID	0x09
+#define LSU_DEBUG_ADDR		0x305
+#define LSU_DEBUG_DATA0		0x306
+#define LSU_CERRLOG_REGID	0x309
 #define SCHED_DEFEATURE		0x700
 
 /* Offsets of interest from the 'MAP' Block */
diff --git a/arch/mips/netlogic/common/smpboot.S b/arch/mips/netlogic/common/smpboot.S
index bfe9060..aa86590 100644
--- a/arch/mips/netlogic/common/smpboot.S
+++ b/arch/mips/netlogic/common/smpboot.S
@@ -77,6 +77,38 @@
 .endm
 
 /*
+ * Low level L1 d-cache flush for core, needs to be called before
+ * threads are enabled
+ */
+.macro	xlp_flush_l1_dcache
+	li	t0, LSU_DEBUG_DATA0
+	li      t1, LSU_DEBUG_ADDR
+	li	t2, 0		/* index */
+	li 	t3, 0x200	/* loop count, 512 sets */
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
+	mtcr    zero, t0
+	ori	v1, v0, 0x7	/* way1 | write_enable | write_active */
+	mtcr    v1, t1
+3:
+	mfcr    v1, t1
+	andi    v1, 0x1		/* wait for write_active == 0 */
+	bnez    v1, 3b
+	nop
+	addi	t2, 1
+	bne	t3, t2, 1b
+	nop
+.endm
+
+/*
  * This is the code that will be copied to the reset entry point for
  * XLR and XLP. The XLP cores start here when they are woken up. This
  * is also the NMI entry point.
@@ -138,6 +170,8 @@ FEXPORT(nlm_reset_entry)
  * a core.
  */
 EXPORT(nlm_boot_siblings)
+	/* core L1D flush before enable threads */
+	xlp_flush_l1_dcache
 	/* Enable hw threads by writing to MAP_THREADMODE of the core */
 	li	t0, CKSEG1ADDR(RESET_DATA_PHYS)
 	lw	t1, BOOT_THREAD_MODE(t0)	/* t1 <- thread mode */
@@ -164,16 +198,13 @@ EXPORT(nlm_boot_siblings)
 	li	t0, MMU_SETUP
 	li	t1, 0
 	mtcr	t1, t0
-	ehb
+	_ehb
 
 2:	beqz	v0, 4f		/* boot cpu (cpuid == 0)? */
 	nop
 
 	/* setup status reg */
-	mfc0	t1, CP0_STATUS
-	li	t0, ST0_BEV
-	or	t1, t0
-	xor	t1, t0
+	move	t1, zero
 #ifdef CONFIG_64BIT
 	ori	t1, ST0_KX
 #endif
@@ -220,6 +251,12 @@ FEXPORT(xlp_boot_core0_siblings)	/* "Master" cpu starts from here */
 
 	__CPUINIT
 NESTED(nlm_boot_secondary_cpus, 16, sp)
+	/* Initialize CP0 Status */
+	move	t1, zero
+#ifdef CONFIG_64BIT
+	ori	t1, ST0_KX
+#endif
+	mtc0	t1, CP0_STATUS
 	PTR_LA	t1, nlm_next_sp
 	PTR_L	sp, 0(t1)
 	PTR_LA	t1, nlm_next_gp
-- 
1.7.5.4
