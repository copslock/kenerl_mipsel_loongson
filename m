Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Dec 2013 12:12:20 +0100 (CET)
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:33332 "EHLO
        mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822902Ab3LULK4gywkP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Dec 2013 12:10:56 +0100
X-IronPort-AV: E=Sophos;i="4.95,527,1384329600"; 
   d="scan'208";a="4602643"
Received: from irvexchcas06.broadcom.com (HELO IRVEXCHCAS06.corp.ad.broadcom.com) ([10.9.208.53])
  by mail-gw2-out.broadcom.com with ESMTP; 21 Dec 2013 03:17:30 -0800
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP Server
 (TLS) id 14.1.438.0; Sat, 21 Dec 2013 03:10:49 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP Server id
 14.1.438.0; Sat, 21 Dec 2013 03:10:49 -0800
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 1580B246A3;    Sat, 21 Dec 2013 03:10:47 -0800 (PST)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>, <ralf@linux-mips.org>
Subject: [PATCH 03/18] MIPS: Netlogic: Some cleanups for assembly code
Date:   Sat, 21 Dec 2013 16:52:15 +0530
Message-ID: <1387624950-31297-4-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1387624950-31297-1-git-send-email-jchandra@broadcom.com>
References: <1387624950-31297-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38777
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

No change in logic, the changes are:
* cleanup some whitespace and comments
* remove confusing argument of SYS_CPU_COHERENT_BASE macro
* make the numerical labels in macros consistent

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/common/reset.S   |   29 +++++++++++++++--------------
 arch/mips/netlogic/common/smpboot.S |    3 ++-
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/mips/netlogic/common/reset.S b/arch/mips/netlogic/common/reset.S
index adb1828..06381e1 100644
--- a/arch/mips/netlogic/common/reset.S
+++ b/arch/mips/netlogic/common/reset.S
@@ -50,8 +50,8 @@
 #include <asm/netlogic/xlp-hal/cpucontrol.h>
 
 #define CP0_EBASE	$15
-#define SYS_CPU_COHERENT_BASE(node)	CKSEG1ADDR(XLP_DEFAULT_IO_BASE) + \
-			XLP_IO_SYS_OFFSET(node) + XLP_IO_PCI_HDRSZ + \
+#define SYS_CPU_COHERENT_BASE	CKSEG1ADDR(XLP_DEFAULT_IO_BASE) + \
+			XLP_IO_SYS_OFFSET(0) + XLP_IO_PCI_HDRSZ + \
 			SYS_CPU_NONCOHERENT_MODE * 4
 
 /* Enable XLP features and workarounds in the LSU */
@@ -82,26 +82,26 @@
 	li	t1, LSU_DEBUG_ADDR
 	li	t2, 0		/* index */
 	li	t3, 0x1000	/* loop count */
-1:
+11:
 	sll	v0, t2, 5
 	mtcr	zero, t0
 	ori	v1, v0, 0x3	/* way0 | write_enable | write_active */
 	mtcr	v1, t1
-2:
+12:
 	mfcr	v1, t1
 	andi	v1, 0x1		/* wait for write_active == 0 */
-	bnez	v1, 2b
+	bnez	v1, 12b
 	nop
 	mtcr	zero, t0
 	ori	v1, v0, 0x7	/* way1 | write_enable | write_active */
 	mtcr	v1, t1
-3:
+13:
 	mfcr	v1, t1
 	andi	v1, 0x1		/* wait for write_active == 0 */
-	bnez	v1, 3b
+	bnez	v1, 13b
 	nop
 	addi	t2, 1
-	bne	t3, t2, 1b
+	bne	t3, t2, 11b
 	nop
 .endm
 
@@ -149,7 +149,7 @@ FEXPORT(nlm_reset_entry)
 	li	t1, 0x1
 	sll	t0, t1, t0
 	nor	t0, t0, zero		/* t0 <- ~(1 << core) */
-	li	t2, SYS_CPU_COHERENT_BASE(0)
+	li	t2, SYS_CPU_COHERENT_BASE
 	add	t2, t2, t3		/* t2 <- SYS offset for node */
 	lw	t1, 0(t2)
 	and	t1, t1, t0
@@ -164,8 +164,7 @@ FEXPORT(nlm_reset_entry)
 	/* FALL THROUGH */
 
 /*
- * Wake up sibling threads from the initial thread in
- * a core.
+ * Wake up sibling threads from the initial thread in a core.
  */
 EXPORT(nlm_boot_siblings)
 	/* core L1D flush before enable threads */
@@ -181,8 +180,10 @@ EXPORT(nlm_boot_siblings)
 	/*
 	 * The new hardware thread starts at the next instruction
 	 * For all the cases other than core 0 thread 0, we will
-	* jump to the secondary wait function.
-	*/
+	 * jump to the secondary wait function.
+
+	 * NOTE: All GPR contents are lost after the mtcr above!
+	 */
 	mfc0	v0, CP0_EBASE, 1
 	andi	v0, 0x3ff		/* v0 <- node/core */
 
@@ -196,7 +197,7 @@ EXPORT(nlm_boot_siblings)
 #endif
 	mtc0	t1, CP0_STATUS
 
-	/* mark CPU ready, careful here, previous mtcr trashed registers */
+	/* mark CPU ready */
 	li	t3, CKSEG1ADDR(RESET_DATA_PHYS)
 	ADDIU	t1, t3, BOOT_CPU_READY
 	sll	v1, v0, 2
diff --git a/arch/mips/netlogic/common/smpboot.S b/arch/mips/netlogic/common/smpboot.S
index aa6cff0..db3b894 100644
--- a/arch/mips/netlogic/common/smpboot.S
+++ b/arch/mips/netlogic/common/smpboot.S
@@ -98,7 +98,7 @@ END(nlm_boot_secondary_cpus)
  * In case of RMIboot bootloader which is used on XLR boards, the CPUs
  * be already woken up and waiting in bootloader code.
  * This will get them out of the bootloader code and into linux. Needed
- *  because the bootloader area will be taken and initialized by linux.
+ * because the bootloader area will be taken and initialized by linux.
  */
 NESTED(nlm_rmiboot_preboot, 16, sp)
 	mfc0	t0, $15, 1	/* read ebase */
@@ -133,6 +133,7 @@ NESTED(nlm_rmiboot_preboot, 16, sp)
 	or	t1, t2, v1	/* put in new value */
 	mtcr	t1, t0		/* update core control */
 
+	/* wait for NMI to hit */
 1:	wait
 	b	1b
 	nop
-- 
1.7.9.5
