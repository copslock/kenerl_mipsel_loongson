Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Apr 2014 16:37:22 +0200 (CEST)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:5264 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6854768AbaD2OcVcAYbv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Apr 2014 16:32:21 +0200
X-IronPort-AV: E=Sophos;i="4.97,951,1389772800"; 
   d="scan'208";a="26655026"
Received: from irvexchcas07.broadcom.com (HELO IRVEXCHCAS07.corp.ad.broadcom.com) ([10.9.208.55])
  by mail-gw3-out.broadcom.com with ESMTP; 29 Apr 2014 07:52:03 -0700
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Tue, 29 Apr 2014 07:31:54 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP Server id
 14.3.174.1; Tue, 29 Apr 2014 07:31:55 -0700
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 575E051E81;    Tue, 29 Apr 2014 07:31:53 -0700 (PDT)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>, <ralf@linux-mips.org>
Subject: [PATCH 07/17] MIPS: Netlogic: Reduce size of reset code
Date:   Tue, 29 Apr 2014 20:07:46 +0530
Message-ID: <40e8d817112e1f870b0a3be98e3b46109df1d4f0.1398780013.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1398780013.git.jchandra@broadcom.com>
References: <cover.1398780013.git.jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39983
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

Update thread wakeup function to use scratch registers for saving SP and
RA. Move the register restore code needed for thread 0 to the calling
function. This reduces the size of code copied to the reset vector.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/common/reset.S   |   15 ++++++++-------
 arch/mips/netlogic/common/smpboot.S |    6 ++++--
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/mips/netlogic/common/reset.S b/arch/mips/netlogic/common/reset.S
index b231fe1..fda772a 100644
--- a/arch/mips/netlogic/common/reset.S
+++ b/arch/mips/netlogic/common/reset.S
@@ -197,6 +197,9 @@ FEXPORT(nlm_reset_entry)
 EXPORT(nlm_boot_siblings)
 	/* core L1D flush before enable threads */
 	xlp_flush_l1_dcache
+	/* save ra and sp, will be used later (only for boot cpu) */
+	dmtc0	ra, $22, 6
+	dmtc0	sp, $22, 7
 	/* Enable hw threads by writing to MAP_THREADMODE of the core */
 	li	t0, CKSEG1ADDR(RESET_DATA_PHYS)
 	lw	t1, BOOT_THREAD_MODE(t0)	/* t1 <- thread mode */
@@ -238,14 +241,12 @@ EXPORT(nlm_boot_siblings)
 	nop
 
 	/*
-	 * For the boot CPU, we have to restore registers and
-	 * return
+	 * For the boot CPU, we have to restore ra and sp and return, rest
+	 * of the registers will be restored by the caller
 	 */
-4:	dmfc0	t0, $4, 2	/* restore SP from UserLocal */
-	li	t1, 0xfadebeef
-	dmtc0	t1, $4, 2	/* restore SP from UserLocal */
-	PTR_SUBU sp, t0, PT_SIZE
-	RESTORE_ALL
+4:
+	dmfc0	ra, $22, 6
+	dmfc0	sp, $22, 7
 	jr	ra
 	nop
 EXPORT(nlm_reset_entry_end)
diff --git a/arch/mips/netlogic/common/smpboot.S b/arch/mips/netlogic/common/smpboot.S
index 8597657..d9b456b 100644
--- a/arch/mips/netlogic/common/smpboot.S
+++ b/arch/mips/netlogic/common/smpboot.S
@@ -55,7 +55,6 @@
 	.set	arch=xlr		/* for mfcr/mtcr, XLR is sufficient */
 
 FEXPORT(xlp_boot_core0_siblings)	/* "Master" cpu starts from here */
-	dmtc0	sp, $4, 2		/* SP saved in UserLocal */
 	SAVE_ALL
 	sync
 	/* find the location to which nlm_boot_siblings was relocated */
@@ -65,7 +64,10 @@ FEXPORT(xlp_boot_core0_siblings)	/* "Master" cpu starts from here */
 	dsubu	t2, t1
 	daddu	t2, t0
 	/* call it */
-	jr	t2
+	jalr	t2
+	nop
+	RESTORE_ALL
+	jr	ra
 	nop
 	/* not reached */
 
-- 
1.7.9.5
