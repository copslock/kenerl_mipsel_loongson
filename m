Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 19:12:05 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55644 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008556AbbIVRMDJEI0r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 19:12:03 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 90C4CF76EAEE;
        Tue, 22 Sep 2015 18:11:53 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 18:11:57 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 18:11:54 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>
Subject: [PATCH 2/4] MIPS: Enable L2 prefetching for CM >= 2.5
Date:   Tue, 22 Sep 2015 10:10:54 -0700
Message-ID: <1442941856-31838-3-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <1442941856-31838-1-git-send-email-paul.burton@imgtec.com>
References: <1442941856-31838-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49278
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

On systems with CM 2.5 & beyond there may be L2 prefetch units present
which are not enabled by default. Detect them, configuring & enabling
prefetching when available.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/mips-cm.h | 17 ++++++++++++
 arch/mips/mm/sc-mips.c          | 61 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index d75b75e..36530fd 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -194,6 +194,8 @@ BUILD_CM_RW(reg3_mask,		MIPS_CM_GCB_OFS + 0xc8)
 BUILD_CM_R_(gic_status,		MIPS_CM_GCB_OFS + 0xd0)
 BUILD_CM_R_(cpc_status,		MIPS_CM_GCB_OFS + 0xf0)
 BUILD_CM_RW(l2_config,		MIPS_CM_GCB_OFS + 0x130)
+BUILD_CM_RW(l2_pft_control,	MIPS_CM_GCB_OFS + 0x300)
+BUILD_CM_RW(l2_pft_control_b,	MIPS_CM_GCB_OFS + 0x308)
 
 /* Core Local & Core Other register accessor functions */
 BUILD_CM_Cx_RW(reset_release,	0x00)
@@ -244,6 +246,7 @@ BUILD_CM_Cx_R_(tcid_8_priority,	0x80)
 		 ((minor) << CM_GCR_REV_MINOR_SHF))
 
 #define CM_REV_CM2				CM_ENCODE_REV(6, 0)
+#define CM_REV_CM2_5				CM_ENCODE_REV(7, 0)
 #define CM_REV_CM3				CM_ENCODE_REV(8, 0)
 
 /* GCR_ERROR_CAUSE register fields */
@@ -316,6 +319,20 @@ BUILD_CM_Cx_R_(tcid_8_priority,	0x80)
 #define CM_GCR_L2_CONFIG_ASSOC_SHF		0
 #define CM_GCR_L2_CONFIG_ASSOC_MSK		(_ULCAST_(0xff) << 0)
 
+/* GCR_L2_PFT_CONTROL register fields */
+#define CM_GCR_L2_PFT_CONTROL_PAGEMASK_SHF	12
+#define CM_GCR_L2_PFT_CONTROL_PAGEMASK_MSK	(_ULCAST_(0xfffff) << 12)
+#define CM_GCR_L2_PFT_CONTROL_PFTEN_SHF		8
+#define CM_GCR_L2_PFT_CONTROL_PFTEN_MSK		(_ULCAST_(0x1) << 8)
+#define CM_GCR_L2_PFT_CONTROL_NPFT_SHF		0
+#define CM_GCR_L2_PFT_CONTROL_NPFT_MSK		(_ULCAST_(0xff) << 0)
+
+/* GCR_L2_PFT_CONTROL_B register fields */
+#define CM_GCR_L2_PFT_CONTROL_B_CEN_SHF		8
+#define CM_GCR_L2_PFT_CONTROL_B_CEN_MSK		(_ULCAST_(0x1) << 8)
+#define CM_GCR_L2_PFT_CONTROL_B_PORTID_SHF	0
+#define CM_GCR_L2_PFT_CONTROL_B_PORTID_MSK	(_ULCAST_(0xff) << 0)
+
 /* GCR_Cx_COHERENCE register fields */
 #define CM_GCR_Cx_COHERENCE_COHDOMAINEN_SHF	0
 #define CM_GCR_Cx_COHERENCE_COHDOMAINEN_MSK	(_ULCAST_(0xff) << 0)
diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index 53ea839..95cf07c 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -51,11 +51,69 @@ static void mips_sc_disable(void)
 	/* L2 cache is permanently enabled */
 }
 
+static void mips_sc_prefetch_enable(void)
+{
+	unsigned long pftctl;
+
+	if (mips_cm_revision() < CM_REV_CM2_5)
+		return;
+
+	/*
+	 * If there is one or more L2 prefetch unit present then enable
+	 * prefetching for both code & data, for all ports.
+	 */
+	pftctl = read_gcr_l2_pft_control();
+	if (pftctl & CM_GCR_L2_PFT_CONTROL_NPFT_MSK) {
+		pftctl &= ~CM_GCR_L2_PFT_CONTROL_PAGEMASK_MSK;
+		pftctl |= PAGE_MASK & CM_GCR_L2_PFT_CONTROL_PAGEMASK_MSK;
+		pftctl |= CM_GCR_L2_PFT_CONTROL_PFTEN_MSK;
+		write_gcr_l2_pft_control(pftctl);
+
+		pftctl = read_gcr_l2_pft_control_b();
+		pftctl |= CM_GCR_L2_PFT_CONTROL_B_PORTID_MSK;
+		pftctl |= CM_GCR_L2_PFT_CONTROL_B_CEN_MSK;
+		write_gcr_l2_pft_control_b(pftctl);
+	}
+}
+
+static void mips_sc_prefetch_disable(void)
+{
+	unsigned long pftctl;
+
+	if (mips_cm_revision() < CM_REV_CM2_5)
+		return;
+
+	pftctl = read_gcr_l2_pft_control();
+	pftctl &= ~CM_GCR_L2_PFT_CONTROL_PFTEN_MSK;
+	write_gcr_l2_pft_control(pftctl);
+
+	pftctl = read_gcr_l2_pft_control_b();
+	pftctl &= ~CM_GCR_L2_PFT_CONTROL_B_PORTID_MSK;
+	pftctl &= ~CM_GCR_L2_PFT_CONTROL_B_CEN_MSK;
+	write_gcr_l2_pft_control_b(pftctl);
+}
+
+static bool mips_sc_prefetch_is_enabled(void)
+{
+	unsigned long pftctl;
+
+	if (mips_cm_revision() < CM_REV_CM2_5)
+		return false;
+
+	pftctl = read_gcr_l2_pft_control();
+	if (!(pftctl & CM_GCR_L2_PFT_CONTROL_NPFT_MSK))
+		return false;
+	return !!(pftctl & CM_GCR_L2_PFT_CONTROL_PFTEN_MSK);
+}
+
 static struct bcache_ops mips_sc_ops = {
 	.bc_enable = mips_sc_enable,
 	.bc_disable = mips_sc_disable,
 	.bc_wback_inv = mips_sc_wback_inv,
-	.bc_inv = mips_sc_inv
+	.bc_inv = mips_sc_inv,
+	.bc_prefetch_enable = mips_sc_prefetch_enable,
+	.bc_prefetch_disable = mips_sc_prefetch_disable,
+	.bc_prefetch_is_enabled = mips_sc_prefetch_is_enabled,
 };
 
 /*
@@ -186,6 +244,7 @@ int mips_sc_init(void)
 	int found = mips_sc_probe();
 	if (found) {
 		mips_sc_enable();
+		mips_sc_prefetch_enable();
 		bcops = &mips_sc_ops;
 	}
 	return found;
-- 
2.5.3
