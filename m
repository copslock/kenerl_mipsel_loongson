Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 04:53:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32332 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992993AbdHMCweaEml6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 04:52:34 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 95D7E9EFD7CF4;
        Sun, 13 Aug 2017 03:52:25 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 03:52:26 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 08/19] MIPS: CPS: Add CM/CPC 3.5 register definitions
Date:   Sat, 12 Aug 2017 19:49:32 -0700
Message-ID: <20170813024943.14989-9-paul.burton@imgtec.com>
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
X-archive-position: 59504
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

Introduce definitions & accessors for a selection of Coherence Manager
(CM) & Cluster Power Controller (CPC) registers that are new with CM
v3.5 & the MIPS I6500. These are primarily registers that will be used
in supporting multiple CPU clusters.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/mips-cm.h  | 54 ++++++++++++++++++++++++++++++++++++----
 arch/mips/include/asm/mips-cpc.h | 22 ++++++++++++++--
 2 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 4857d4ae97b7..225586bdd81c 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -114,10 +114,12 @@ static inline bool mips_cm_has_l2sync(void)
 #define MIPS_CM_L2SYNC_SIZE	0x1000
 
 #define GCR_ACCESSOR_RO(sz, off, name)					\
-	CPS_ACCESSOR_RO(gcr, sz, MIPS_CM_GCB_OFS + off, name)
+	CPS_ACCESSOR_RO(gcr, sz, MIPS_CM_GCB_OFS + off, name)		\
+	CPS_ACCESSOR_RO(gcr, sz, MIPS_CM_COCB_OFS + off, redir_##name)
 
 #define GCR_ACCESSOR_RW(sz, off, name)					\
-	CPS_ACCESSOR_RW(gcr, sz, MIPS_CM_GCB_OFS + off, name)
+	CPS_ACCESSOR_RW(gcr, sz, MIPS_CM_GCB_OFS + off, name)		\
+	CPS_ACCESSOR_RW(gcr, sz, MIPS_CM_COCB_OFS + off, redir_##name)
 
 #define GCR_CX_ACCESSOR_RO(sz, off, name)				\
 	CPS_ACCESSOR_RO(gcr, sz, MIPS_CM_CLCB_OFS + off, cl_##name)	\
@@ -129,6 +131,9 @@ static inline bool mips_cm_has_l2sync(void)
 
 /* GCR_CONFIG - Information about the system */
 GCR_ACCESSOR_RO(64, 0x000, config)
+#define CM_GCR_CONFIG_CLUSTER_COH_CAPABLE	BIT_ULL(43)
+#define CM_GCR_CONFIG_CLUSTER_ID		GENMASK_ULL(39, 32)
+#define CM_GCR_CONFIG_NUM_CLUSTERS		GENMASK(29, 23)
 #define CM_GCR_CONFIG_NUMIOCU			GENMASK(15, 8)
 #define CM_GCR_CONFIG_PCORES			GENMASK(7, 0)
 
@@ -157,6 +162,7 @@ GCR_ACCESSOR_RO(32, 0x030, rev)
 #define CM_REV_CM2				CM_ENCODE_REV(6, 0)
 #define CM_REV_CM2_5				CM_ENCODE_REV(7, 0)
 #define CM_REV_CM3				CM_ENCODE_REV(8, 0)
+#define CM_REV_CM3_5				CM_ENCODE_REV(9, 0)
 
 /* GCR_ERR_CONTROL - Control error checking logic */
 GCR_ACCESSOR_RW(32, 0x038, err_control)
@@ -246,6 +252,33 @@ GCR_ACCESSOR_RW(32, 0x308, l2_pft_control_b)
 #define CM_GCR_L2_PFT_CONTROL_B_CEN		BIT(8)
 #define CM_GCR_L2_PFT_CONTROL_B_PORTID		GENMASK(7, 0)
 
+/* GCR_L2SM_COP - L2 cache op state machine control */
+GCR_ACCESSOR_RW(32, 0x620, l2sm_cop)
+#define CM_GCR_L2SM_COP_PRESENT			BIT(31)
+#define CM_GCR_L2SM_COP_RESULT			GENMASK(8, 6)
+#define  CM_GCR_L2SM_COP_RESULT_DONTCARE	0
+#define  CM_GCR_L2SM_COP_RESULT_DONE_OK		1
+#define  CM_GCR_L2SM_COP_RESULT_DONE_ERROR	2
+#define  CM_GCR_L2SM_COP_RESULT_ABORT_OK	3
+#define  CM_GCR_L2SM_COP_RESULT_ABORT_ERROR	4
+#define CM_GCR_L2SM_COP_RUNNING			BIT(5)
+#define CM_GCR_L2SM_COP_TYPE			GENMASK(4, 2)
+#define  CM_GCR_L2SM_COP_TYPE_IDX_WBINV		0
+#define  CM_GCR_L2SM_COP_TYPE_IDX_STORETAG	1
+#define  CM_GCR_L2SM_COP_TYPE_IDX_STORETAGDATA	2
+#define  CM_GCR_L2SM_COP_TYPE_HIT_INV		4
+#define  CM_GCR_L2SM_COP_TYPE_HIT_WBINV		5
+#define  CM_GCR_L2SM_COP_TYPE_HIT_WB		6
+#define  CM_GCR_L2SM_COP_TYPE_FETCHLOCK		7
+#define CM_GCR_L2SM_COP_CMD			GENMASK(1, 0)
+#define  CM_GCR_L2SM_COP_CMD_START		1	/* only when idle */
+#define  CM_GCR_L2SM_COP_CMD_ABORT		3	/* only when running */
+
+/* GCR_L2SM_TAG_ADDR_COP - L2 cache op state machine address control */
+GCR_ACCESSOR_RW(64, 0x628, l2sm_tag_addr_cop)
+#define CM_GCR_L2SM_TAG_ADDR_COP_NUM_LINES	GENMASK_ULL(63, 48)
+#define CM_GCR_L2SM_TAG_ADDR_COP_START_TAG	GENMASK_ULL(47, 6)
+
 /* GCR_BEV_BASE - Controls the location of the BEV for powered up cores */
 GCR_ACCESSOR_RW(64, 0x680, bev_base)
 
@@ -264,9 +297,18 @@ GCR_CX_ACCESSOR_RO(32, 0x010, config)
 
 /* GCR_Cx_OTHER - Configure the core-other/redirect GCR block */
 GCR_CX_ACCESSOR_RW(32, 0x018, other)
-#define CM_GCR_Cx_OTHER_CORENUM			GENMASK(31, 16)
-#define CM3_GCR_Cx_OTHER_CORE			GENMASK(13, 8)
-#define CM3_GCR_Cx_OTHER_VP			GENMASK(2, 0)
+#define CM_GCR_Cx_OTHER_CORENUM			GENMASK(31, 16)	/* CM < 3 */
+#define CM_GCR_Cx_OTHER_CLUSTER_EN		BIT(31)		/* CM >= 3.5 */
+#define CM_GCR_Cx_OTHER_GIC_EN			BIT(30)		/* CM >= 3.5 */
+#define CM_GCR_Cx_OTHER_BLOCK			GENMASK(25, 24)	/* CM >= 3.5 */
+#define  CM_GCR_Cx_OTHER_BLOCK_LOCAL		0
+#define  CM_GCR_Cx_OTHER_BLOCK_GLOBAL		1
+#define  CM_GCR_Cx_OTHER_BLOCK_USER		2
+#define  CM_GCR_Cx_OTHER_BLOCK_GLOBAL_HIGH	3
+#define CM_GCR_Cx_OTHER_CLUSTER			GENMASK(21, 16)	/* CM >= 3.5 */
+#define CM3_GCR_Cx_OTHER_CORE			GENMASK(13, 8)	/* CM >= 3 */
+#define  CM_GCR_Cx_OTHER_CORE_CM		32
+#define CM3_GCR_Cx_OTHER_VP			GENMASK(2, 0)	/* CM >= 3 */
 
 /* GCR_Cx_RESET_BASE - Configure where powered up cores will fetch from */
 GCR_CX_ACCESSOR_RW(32, 0x020, reset_base)
@@ -274,6 +316,8 @@ GCR_CX_ACCESSOR_RW(32, 0x020, reset_base)
 
 /* GCR_Cx_ID - Identify the current core */
 GCR_CX_ACCESSOR_RO(32, 0x028, id)
+#define CM_GCR_Cx_ID_CLUSTER			GENMASK(15, 8)
+#define CM_GCR_Cx_ID_CORE			GENMASK(7, 0)
 
 /* GCR_Cx_RESET_EXT_BASE - Configure behaviour when cores reset or power up */
 GCR_CX_ACCESSOR_RW(32, 0x030, reset_ext_base)
diff --git a/arch/mips/include/asm/mips-cpc.h b/arch/mips/include/asm/mips-cpc.h
index 6cd2847fc95b..1d024cc6ccd8 100644
--- a/arch/mips/include/asm/mips-cpc.h
+++ b/arch/mips/include/asm/mips-cpc.h
@@ -63,10 +63,12 @@ static inline bool mips_cpc_present(void)
 #define MIPS_CPC_COCB_OFS	0x4000
 
 #define CPC_ACCESSOR_RO(sz, off, name)					\
-	CPS_ACCESSOR_RO(cpc, sz, MIPS_CPC_GCB_OFS + off, name)
+	CPS_ACCESSOR_RO(cpc, sz, MIPS_CPC_GCB_OFS + off, name)		\
+	CPS_ACCESSOR_RO(cpc, sz, MIPS_CPC_COCB_OFS + off, redir_##name)
 
 #define CPC_ACCESSOR_RW(sz, off, name)					\
-	CPS_ACCESSOR_RW(cpc, sz, MIPS_CPC_GCB_OFS + off, name)
+	CPS_ACCESSOR_RW(cpc, sz, MIPS_CPC_GCB_OFS + off, name)		\
+	CPS_ACCESSOR_RW(cpc, sz, MIPS_CPC_COCB_OFS + off, redir_##name)
 
 #define CPC_CX_ACCESSOR_RO(sz, off, name)				\
 	CPS_ACCESSOR_RO(cpc, sz, MIPS_CPC_CLCB_OFS + off, cl_##name)	\
@@ -91,6 +93,19 @@ CPC_ACCESSOR_RW(32, 0x018, resetlen)
 /* CPC_REVISION - Indicates the revisison of the CPC */
 CPC_ACCESSOR_RO(32, 0x020, revision)
 
+/* CPC_PWRUP_CTL - Control power to the Coherence Manager (CM) */
+CPC_ACCESSOR_RW(32, 0x030, pwrup_ctl)
+#define CPC_PWRUP_CTL_CM_PWRUP			BIT(0)
+
+/* CPC_CONFIG - Mirrors GCR_CONFIG */
+CPC_ACCESSOR_RW(64, 0x138, config)
+
+/* CPC_SYS_CONFIG - Control cluster endianness */
+CPC_ACCESSOR_RW(32, 0x140, sys_config)
+#define CPC_SYS_CONFIG_BE_IMMEDIATE		BIT(2)
+#define CPC_SYS_CONFIG_BE_STATUS		BIT(1)
+#define CPC_SYS_CONFIG_BE			BIT(0)
+
 /* CPC_Cx_CMD - Instruct the CPC to take action on a core */
 CPC_CX_ACCESSOR_RW(32, 0x000, cmd)
 #define CPC_Cx_CMD				GENMASK(3, 0)
@@ -131,6 +146,9 @@ CPC_CX_ACCESSOR_RW(32, 0x028, vp_run)
 /* CPC_Cx_VP_RUNNING - Indicate which Virtual Processors (VPs) are running */
 CPC_CX_ACCESSOR_RW(32, 0x030, vp_running)
 
+/* CPC_Cx_CONFIG - Mirrors GCR_Cx_CONFIG */
+CPC_CX_ACCESSOR_RW(32, 0x090, config)
+
 #ifdef CONFIG_MIPS_CPC
 
 /**
-- 
2.14.0
