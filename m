Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Apr 2014 16:34:30 +0200 (CEST)
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:29457 "EHLO
        mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6843060AbaD2Ob5mEKLe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Apr 2014 16:31:57 +0200
X-IronPort-AV: E=Sophos;i="4.97,951,1389772800"; 
   d="scan'208";a="26850002"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw2-out.broadcom.com with ESMTP; 29 Apr 2014 07:57:06 -0700
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Tue, 29 Apr 2014 07:31:55 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP Server id
 14.3.174.1; Tue, 29 Apr 2014 07:31:56 -0700
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 56E5651E7E;    Tue, 29 Apr 2014 07:31:55 -0700 (PDT)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>, <ralf@linux-mips.org>
Subject: [PATCH 08/17] MIPS: Netlogic: Enable access to more than 64GB
Date:   Tue, 29 Apr 2014 20:07:47 +0530
Message-ID: <cf9ad5487e703b44b7b933c20ce0f12c02699499.1398780013.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1398780013.git.jchandra@broadcom.com>
References: <cover.1398780013.git.jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39975
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

The ELPA bit needs to be set in the PAGEGRAIN register to enable
access to >64GB physical address. Update reset.S to do this from
every hardware thread.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/common/reset.S |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/mips/netlogic/common/reset.S b/arch/mips/netlogic/common/reset.S
index fda772a..13c1bc5 100644
--- a/arch/mips/netlogic/common/reset.S
+++ b/arch/mips/netlogic/common/reset.S
@@ -74,6 +74,18 @@
 .endm
 
 /*
+ * Allow access to physical mem >64G by enabling ELPA in PAGEGRAIN
+ * register. This is needed before going to C code since the SP can
+ * in this region. Called from all HW threads.
+ */
+.macro xlp_early_mmu_init
+	mfc0	t0, CP0_PAGEMASK, 1
+	li	t1, (1 << 29)		/* ELPA bit */
+	or	t0, t1
+	mtc0	t0, CP0_PAGEMASK, 1
+.endm
+
+/*
  * L1D cache has to be flushed before enabling threads in XLP.
  * On XLP8xx/XLP3xx, we do a low level flush using processor control
  * registers. On XLPII CPUs, usual cache instructions work.
@@ -228,6 +240,8 @@ EXPORT(nlm_boot_siblings)
 #endif
 	mtc0	t1, CP0_STATUS
 
+	xlp_early_mmu_init
+
 	/* mark CPU ready */
 	li	t3, CKSEG1ADDR(RESET_DATA_PHYS)
 	ADDIU	t1, t3, BOOT_CPU_READY
@@ -254,6 +268,7 @@ EXPORT(nlm_reset_entry_end)
 LEAF(nlm_init_boot_cpu)
 #ifdef CONFIG_CPU_XLP
 	xlp_config_lsu
+	xlp_early_mmu_init
 #endif
 	jr	ra
 	nop
-- 
1.7.9.5
