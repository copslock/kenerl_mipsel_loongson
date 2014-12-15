Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2014 19:09:24 +0100 (CET)
Received: from mail-lb0-f171.google.com ([209.85.217.171]:37824 "EHLO
        mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008848AbaLOSG7HLoao (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Dec 2014 19:06:59 +0100
Received: by mail-lb0-f171.google.com with SMTP id w7so5353589lbi.16
        for <multiple recipients>; Mon, 15 Dec 2014 10:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zEk0fZkHMp3uEJ0bzGHzQZtZmeTmdlibwSSdgce5z04=;
        b=MO71j6PfeZaB44bilalrMzDKNgIB/seCckjI9/EJhfPNxVDCoGUPvpwpms7nzm7wcZ
         IH+hFdBqAxky8qHMQP1VlmT1xlFCfeqyIlCLdf/v5xGUv/ZYQSkgdzIh6967fAXF4VbF
         pTFeZvdDNtW7ry9sXzqEbdJFWDlsqCB6KxeZBD1nIqkITa8C5gOM0MF+sUA4Sky/75wY
         X4hlp5riZOo+cGrZO9/Pao+7d1QZV41el43inxS2gtk+F0QLGCKge2W4cfjetH0Jrpk/
         GaJ3/YQ47kFp78aiYrQI1lPTLI4sg5hNaWsL9z1UgG/Wd8hXaY7lwlnaIIcDuSODF0F6
         0xoQ==
X-Received: by 10.152.23.98 with SMTP id l2mr12852617laf.46.1418666813890;
        Mon, 15 Dec 2014 10:06:53 -0800 (PST)
Received: from turnip.localdomain (nivc-213.auriga.ru. [80.240.102.213])
        by mx.google.com with ESMTPSA id l9sm1238952lae.0.2014.12.15.10.06.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Dec 2014 10:06:53 -0800 (PST)
From:   Aleksey Makarov <feumilieu@gmail.com>
X-Google-Original-From: Aleksey Makarov <aleksey.makarov@auriga.com>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 12/14] MIPS: OCTEON: Update octeon-model.h code for new SoCs.
Date:   Mon, 15 Dec 2014 21:03:18 +0300
Message-Id: <1418666603-15159-13-git-send-email-aleksey.makarov@auriga.com>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418666603-15159-1-git-send-email-aleksey.makarov@auriga.com>
References: <1418666603-15159-1-git-send-email-aleksey.makarov@auriga.com>
Return-Path: <feumilieu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: feumilieu@gmail.com
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
