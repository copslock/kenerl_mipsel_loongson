Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2015 11:36:12 +0100 (CET)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:55305 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008950AbbAIKgKErWmV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Jan 2015 11:36:10 +0100
X-IronPort-AV: E=Sophos;i="5.07,729,1413270000"; 
   d="scan'208";a="54338080"
Received: from irvexchcas06.broadcom.com (HELO IRVEXCHCAS06.corp.ad.broadcom.com) ([10.9.208.53])
  by mail-gw3-out.broadcom.com with ESMTP; 09 Jan 2015 02:50:53 -0800
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Fri, 9 Jan 2015 02:36:03 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP Server id
 14.3.174.1; Fri, 9 Jan 2015 02:36:38 -0800
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 4156F40FEA;    Fri,  9 Jan 2015 02:35:12 -0800 (PST)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>, <ralf@linux-mips.org>
Subject: [PATCH 13/17] MIPS: Netlogic: Handle XLP hardware errata
Date:   Fri, 9 Jan 2015 16:13:20 +0530
Message-ID: <1420800200-19116-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20150109095119.GB18823@jayachandranc.netlogicmicro.com>
References: <20150109095119.GB18823@jayachandranc.netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45020
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

Core configuration register IFU_BRUB_RESERVE has to be setup to handle
a silicon errata which can result in a CPU hang.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/xlp-hal/cpucontrol.h |  2 ++
 arch/mips/netlogic/common/reset.S                   | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/cpucontrol.h b/arch/mips/include/asm/netlogic/xlp-hal/cpucontrol.h
index 6d2e58a..a06b592 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/cpucontrol.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/cpucontrol.h
@@ -46,6 +46,8 @@
 #define CPU_BLOCKID_FPU		9
 #define CPU_BLOCKID_MAP		10
 
+#define IFU_BRUB_RESERVE	0x007
+
 #define ICU_DEFEATURE		0x100
 
 #define LSU_DEFEATURE		0x304
diff --git a/arch/mips/netlogic/common/reset.S b/arch/mips/netlogic/common/reset.S
index 701c4bc..e3e5189 100644
--- a/arch/mips/netlogic/common/reset.S
+++ b/arch/mips/netlogic/common/reset.S
@@ -235,6 +235,26 @@ EXPORT(nlm_boot_siblings)
 	mfc0	v0, CP0_EBASE, 1
 	andi	v0, 0x3ff		/* v0 <- node/core */
 
+	/*
+	 * Errata: to avoid potential live lock, setup IFU_BRUB_RESERVE
+	 * when running 4 threads per core
+	 */
+	andi	v1, v0, 0x3             /* v1 <- thread id */
+	bnez	v1, 2f
+	nop
+
+	/* thread 0 of each core. */
+	li	t0, CKSEG1ADDR(RESET_DATA_PHYS)
+	lw	t1, BOOT_THREAD_MODE(t0)        /* t1 <- thread mode */
+	subu	t1, 0x3				/* 4-thread per core mode? */
+	bnez	t1, 2f
+	nop
+
+	li	t0, IFU_BRUB_RESERVE
+	li	t1, 0x55
+	mtcr	t1, t0
+	_ehb
+2:
 	beqz	v0, 4f		/* boot cpu (cpuid == 0)? */
 	nop
 
-- 
1.9.1
