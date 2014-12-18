Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 11:23:57 +0100 (CET)
Received: from nivc-ms1.auriga.com ([80.240.102.146]:48932 "EHLO
        nivc-ms1.auriga.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009087AbaLRKWcA34-R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 11:22:32 +0100
Received: from localhost (80.240.102.213) by NIVC-MS1.auriga.ru
 (80.240.102.146) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 18 Dec
 2014 13:22:26 +0300
From:   Aleksey Makarov <aleksey.makarov@auriga.com>
To:     <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2 11/12] MIPS: OCTEON: Update octeon-model.h code for new SoCs.
Date:   Thu, 18 Dec 2014 13:18:03 +0300
Message-ID: <1418897888-17669-12-git-send-email-aleksey.makarov@auriga.com>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418897888-17669-1-git-send-email-aleksey.makarov@auriga.com>
References: <1418897888-17669-1-git-send-email-aleksey.makarov@auriga.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [80.240.102.213]
Return-Path: <aleksey.makarov@auriga.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksey.makarov@auriga.com
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

From: David Daney <david.daney@cavium.com>

Add coverage for OCTEON III models.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
---
 arch/mips/include/asm/octeon/octeon-model.h | 65 ++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/octeon/octeon-model.h b/arch/mips/include/asm/octeon/octeon-model.h
index e2c122c..35d7cbd 100644
--- a/arch/mips/include/asm/octeon/octeon-model.h
+++ b/arch/mips/include/asm/octeon/octeon-model.h
@@ -45,6 +45,7 @@
  */
 
 #define OCTEON_FAMILY_MASK	0x00ffff00
+#define OCTEON_PRID_MASK	0x00ffffff
 
 /* Flag bits in top byte */
 /* Ignores revision in model checks */
@@ -63,6 +64,46 @@
 #define OM_MATCH_6XXX_FAMILY_MODELS	0x40000000
 /* Match all cnf7XXX Octeon models. */
 #define OM_MATCH_F7XXX_FAMILY_MODELS	0x80000000
+/* Match all cn7XXX Octeon models. */
+#define OM_MATCH_7XXX_FAMILY_MODELS     0x10000000
+#define OM_MATCH_FAMILY_MODELS		(OM_MATCH_5XXX_FAMILY_MODELS |	\
+					 OM_MATCH_6XXX_FAMILY_MODELS |	\
+					 OM_MATCH_F7XXX_FAMILY_MODELS | \
+					 OM_MATCH_7XXX_FAMILY_MODELS)
+/*
+ * CN7XXX models with new revision encoding
+ */
+
+#define OCTEON_CN73XX_PASS1_0	0x000d9700
+#define OCTEON_CN73XX		(OCTEON_CN73XX_PASS1_0 | OM_IGNORE_REVISION)
+#define OCTEON_CN73XX_PASS1_X	(OCTEON_CN73XX_PASS1_0 | \
+				 OM_IGNORE_MINOR_REVISION)
+
+#define OCTEON_CN70XX_PASS1_0	0x000d9600
+#define OCTEON_CN70XX_PASS1_1	0x000d9601
+#define OCTEON_CN70XX_PASS1_2	0x000d9602
+
+#define OCTEON_CN70XX_PASS2_0	0x000d9608
+
+#define OCTEON_CN70XX		(OCTEON_CN70XX_PASS1_0 | OM_IGNORE_REVISION)
+#define OCTEON_CN70XX_PASS1_X	(OCTEON_CN70XX_PASS1_0 | \
+				 OM_IGNORE_MINOR_REVISION)
+#define OCTEON_CN70XX_PASS2_X	(OCTEON_CN70XX_PASS2_0 | \
+				 OM_IGNORE_MINOR_REVISION)
+
+#define OCTEON_CN71XX		OCTEON_CN70XX
+
+#define OCTEON_CN78XX_PASS1_0	0x000d9500
+#define OCTEON_CN78XX_PASS1_1	0x000d9501
+#define OCTEON_CN78XX_PASS2_0	0x000d9508
+
+#define OCTEON_CN78XX		(OCTEON_CN78XX_PASS1_0 | OM_IGNORE_REVISION)
+#define OCTEON_CN78XX_PASS1_X	(OCTEON_CN78XX_PASS1_0 | \
+				 OM_IGNORE_MINOR_REVISION)
+#define OCTEON_CN78XX_PASS2_X	(OCTEON_CN78XX_PASS2_0 | \
+				 OM_IGNORE_MINOR_REVISION)
+
+#define OCTEON_CN76XX		(0x000d9540 | OM_CHECK_SUBMODEL)
 
 /*
  * CNF7XXX models with new revision encoding
@@ -217,6 +258,10 @@
 #define OCTEON_CN3XXX		(OCTEON_CN58XX_PASS1_0 | OM_MATCH_PREVIOUS_MODELS | OM_IGNORE_REVISION)
 #define OCTEON_CN5XXX		(OCTEON_CN58XX_PASS1_0 | OM_MATCH_5XXX_FAMILY_MODELS)
 #define OCTEON_CN6XXX		(OCTEON_CN63XX_PASS1_0 | OM_MATCH_6XXX_FAMILY_MODELS)
+#define OCTEON_CNF7XXX		(OCTEON_CNF71XX_PASS1_0 | \
+				 OM_MATCH_F7XXX_FAMILY_MODELS)
+#define OCTEON_CN7XXX		(OCTEON_CN78XX_PASS1_0 | \
+				 OM_MATCH_7XXX_FAMILY_MODELS)
 
 /* These are used to cover entire families of OCTEON processors */
 #define OCTEON_FAM_1		(OCTEON_CN3XXX)
@@ -288,9 +333,16 @@ static inline uint64_t cvmx_read_csr(uint64_t csr_addr);
 		((((arg_model) & (OM_FLAG_MASK)) == OM_CHECK_SUBMODEL)	\
 			&& __OCTEON_MATCH_MASK__((chip_model), (arg_model), OCTEON_58XX_MODEL_REV_MASK)) || \
 		((((arg_model) & (OM_MATCH_5XXX_FAMILY_MODELS)) == OM_MATCH_5XXX_FAMILY_MODELS) \
-			&& ((chip_model) >= OCTEON_CN58XX_PASS1_0) && ((chip_model) < OCTEON_CN63XX_PASS1_0)) || \
+			&& ((chip_model & OCTEON_PRID_MASK) >= OCTEON_CN58XX_PASS1_0) \
+			&& ((chip_model & OCTEON_PRID_MASK) < OCTEON_CN63XX_PASS1_0)) || \
 		((((arg_model) & (OM_MATCH_6XXX_FAMILY_MODELS)) == OM_MATCH_6XXX_FAMILY_MODELS) \
-			&& ((chip_model) >= OCTEON_CN63XX_PASS1_0)) ||	\
+			&& ((chip_model & OCTEON_PRID_MASK) >= OCTEON_CN63XX_PASS1_0) \
+			&& ((chip_model & OCTEON_PRID_MASK) < OCTEON_CNF71XX_PASS1_0)) || \
+		((((arg_model) & (OM_MATCH_F7XXX_FAMILY_MODELS)) == OM_MATCH_F7XXX_FAMILY_MODELS) \
+			&& ((chip_model & OCTEON_PRID_MASK) >= OCTEON_CNF71XX_PASS1_0) \
+			&& ((chip_model & OCTEON_PRID_MASK) < OCTEON_CN78XX_PASS1_0)) || \
+		((((arg_model) & (OM_MATCH_7XXX_FAMILY_MODELS)) == OM_MATCH_7XXX_FAMILY_MODELS) \
+			&& ((chip_model & OCTEON_PRID_MASK) >= OCTEON_CN78XX_PASS1_0)) || \
 		((((arg_model) & (OM_MATCH_PREVIOUS_MODELS)) == OM_MATCH_PREVIOUS_MODELS) \
 			&& (((chip_model) & OCTEON_58XX_MODEL_MASK) < ((arg_model) & OCTEON_58XX_MODEL_MASK))) \
 		)))
@@ -326,6 +378,15 @@ static inline int __octeon_is_model_runtime__(uint32_t model)
 #define OCTEON_IS_COMMON_BINARY() 1
 #undef OCTEON_MODEL
 
+#define OCTEON_IS_OCTEON1()	OCTEON_IS_MODEL(OCTEON_CN3XXX)
+#define OCTEON_IS_OCTEONPLUS()	OCTEON_IS_MODEL(OCTEON_CN5XXX)
+#define OCTEON_IS_OCTEON2()						\
+	(OCTEON_IS_MODEL(OCTEON_CN6XXX) || OCTEON_IS_MODEL(OCTEON_CNF71XX))
+
+#define OCTEON_IS_OCTEON3()	OCTEON_IS_MODEL(OCTEON_CN7XXX)
+
+#define OCTEON_IS_OCTEON1PLUS()	(OCTEON_IS_OCTEON1() || OCTEON_IS_OCTEONPLUS())
+
 const char *octeon_model_get_string(uint32_t chip_id);
 const char *octeon_model_get_string_buffer(uint32_t chip_id, char *buffer);
 
-- 
2.1.3
