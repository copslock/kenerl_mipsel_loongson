Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Dec 2013 12:13:18 +0100 (CET)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:1142 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6832668Ab3LULK5ukEMq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Dec 2013 12:10:57 +0100
X-IronPort-AV: E=Sophos;i="4.95,527,1384329600"; 
   d="scan'208";a="4363730"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw3-out.broadcom.com with ESMTP; 21 Dec 2013 03:12:44 -0800
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.1.438.0; Sat, 21 Dec 2013 03:10:50 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.1.438.0; Sat, 21 Dec 2013 03:10:50 -0800
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 6784E246A4;    Sat, 21 Dec 2013 03:10:49 -0800 (PST)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Yonghong Song <ysong@broadcom.com>, <ralf@linux-mips.org>,
        Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH 04/18] MIPS: Netlogic: L1D cacheflush before thread enable on XLPII
Date:   Sat, 21 Dec 2013 16:52:16 +0530
Message-ID: <1387624950-31297-5-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1387624950-31297-1-git-send-email-jchandra@broadcom.com>
References: <1387624950-31297-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38780
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

From: Yonghong Song <ysong@broadcom.com>

On XLPII CPUs, the L1D cache has to be flushed with regular cache
operations before enabling threads in a core.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/common/reset.S |   25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/mips/netlogic/common/reset.S b/arch/mips/netlogic/common/reset.S
index 06381e1..57eb7a1 100644
--- a/arch/mips/netlogic/common/reset.S
+++ b/arch/mips/netlogic/common/reset.S
@@ -36,6 +36,7 @@
 
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/cacheops.h>
 #include <asm/regdef.h>
 #include <asm/mipsregs.h>
 #include <asm/stackframe.h>
@@ -74,10 +75,18 @@
 .endm
 
 /*
- * Low level flush for L1D cache on XLP, the normal cache ops does
- * not do the complete and correct cache flush.
+ * L1D cache has to be flushed before enabling threads in XLP.
+ * On XLP8xx/XLP3xx, we do a low level flush using processor control
+ * registers. On XLPII CPUs, usual cache instructions work.
  */
 .macro	xlp_flush_l1_dcache
+	mfc0	t0, CP0_EBASE, 0
+	andi	t0, t0, 0xff00
+	slt	t1, t0, 0x1200
+	beqz	t1, 15f
+	nop
+
+	/* XLP8xx low level cache flush */
 	li	t0, LSU_DEBUG_DATA0
 	li	t1, LSU_DEBUG_ADDR
 	li	t2, 0		/* index */
@@ -103,6 +112,18 @@
 	addi	t2, 1
 	bne	t3, t2, 11b
 	nop
+	b	17f
+	nop
+
+	/* XLPII CPUs, Invalidate all 64k of L1 D-cache */
+15:
+	li	t0, 0x80000000
+	li	t1, 0x80010000
+16:	cache	Index_Writeback_Inv_D, 0(t0)
+	addiu	t0, t0, 32
+	bne	t0, t1, 16b
+	nop
+17:
 .endm
 
 /*
-- 
1.7.9.5
