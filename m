Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 04:53:17 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26551 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993894AbdHMCwPTlGC6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 04:52:15 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 562F3D45FAEF8;
        Sun, 13 Aug 2017 03:52:07 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 03:52:08 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 07/19] MIPS: CPS: Use change_*, set_* & clear_* where appropriate
Date:   Sat, 12 Aug 2017 19:49:31 -0700
Message-ID: <20170813024943.14989-8-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170813024943.14989-1-paul.burton@imgtec.com>
References: <20170813024943.14989-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.79.142]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Make use of the new change_*, set_* & clear_* accessor functions for CPS
(CM, CPC & GIC) registers where doing so makes the code easier to read
or shortens it without adversely affecting readability.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/kernel/mips-cm.c |  4 +---
 arch/mips/kernel/smp-cps.c |  6 ++----
 arch/mips/mm/sc-mips.c     | 19 +++++--------------
 3 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index 7bbe0308617f..aa62a9e5254c 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -233,9 +233,7 @@ int mips_cm_probe(void)
 	}
 
 	/* set default target to memory */
-	base_reg &= ~CM_GCR_BASE_CMDEFTGT;
-	base_reg |= CM_GCR_BASE_CMDEFTGT_MEM;
-	write_gcr_base(base_reg);
+	change_gcr_base(CM_GCR_BASE_CMDEFTGT, CM_GCR_BASE_CMDEFTGT_MEM);
 
 	/* disable CM regions */
 	write_gcr_reg0_base(CM_GCR_REGn_BASE_BASEADDR);
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 777e0193e8ed..5729d2c77461 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -212,7 +212,7 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 
 static void boot_core(unsigned int core, unsigned int vpe_id)
 {
-	u32 access, stat, seq_state;
+	u32 stat, seq_state;
 	unsigned timeout;
 
 	/* Select the appropriate core */
@@ -228,9 +228,7 @@ static void boot_core(unsigned int core, unsigned int vpe_id)
 	write_gcr_co_reset_ext_base(CM_GCR_Cx_RESET_EXT_BASE_UEB);
 
 	/* Ensure the core can access the GCRs */
-	access = read_gcr_access();
-	access |= 1 << core;
-	write_gcr_access(access);
+	set_gcr_access(1 << core);
 
 	if (mips_cpc_present()) {
 		/* Reset the core */
diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index 7f30397cb10d..cda878c0010b 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -69,28 +69,19 @@ static void mips_sc_prefetch_enable(void)
 		pftctl |= CM_GCR_L2_PFT_CONTROL_PFTEN;
 		write_gcr_l2_pft_control(pftctl);
 
-		pftctl = read_gcr_l2_pft_control_b();
-		pftctl |= CM_GCR_L2_PFT_CONTROL_B_PORTID;
-		pftctl |= CM_GCR_L2_PFT_CONTROL_B_CEN;
-		write_gcr_l2_pft_control_b(pftctl);
+		set_gcr_l2_pft_control_b(CM_GCR_L2_PFT_CONTROL_B_PORTID |
+					 CM_GCR_L2_PFT_CONTROL_B_CEN);
 	}
 }
 
 static void mips_sc_prefetch_disable(void)
 {
-	unsigned long pftctl;
-
 	if (mips_cm_revision() < CM_REV_CM2_5)
 		return;
 
-	pftctl = read_gcr_l2_pft_control();
-	pftctl &= ~CM_GCR_L2_PFT_CONTROL_PFTEN;
-	write_gcr_l2_pft_control(pftctl);
-
-	pftctl = read_gcr_l2_pft_control_b();
-	pftctl &= ~CM_GCR_L2_PFT_CONTROL_B_PORTID;
-	pftctl &= ~CM_GCR_L2_PFT_CONTROL_B_CEN;
-	write_gcr_l2_pft_control_b(pftctl);
+	clear_gcr_l2_pft_control(CM_GCR_L2_PFT_CONTROL_PFTEN);
+	clear_gcr_l2_pft_control_b(CM_GCR_L2_PFT_CONTROL_B_PORTID |
+				   CM_GCR_L2_PFT_CONTROL_B_CEN);
 }
 
 static bool mips_sc_prefetch_is_enabled(void)
-- 
2.14.0
