Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2010 01:05:52 +0200 (CEST)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:18311 "EHLO
        smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491191Ab0JGXFC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Oct 2010 01:05:02 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by smtp2.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cae50dc0000>; Thu, 07 Oct 2010 18:59:40 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 7 Oct 2010 16:04:15 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 7 Oct 2010 16:04:15 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o97N42Us026940;
        Thu, 7 Oct 2010 16:04:02 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o97N4228026939;
        Thu, 7 Oct 2010 16:04:02 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 02/14] MIPS: Octeon: Add cn63XX to Octeon chip detection macros.
Date:   Thu,  7 Oct 2010 16:03:41 -0700
Message-Id: <1286492633-26885-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
References: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 07 Oct 2010 23:04:15.0684 (UTC) FILETIME=[F6B9E040:01CB6673]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/octeon/octeon-model.h |   36 +++++++++++++++++++++------
 1 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/octeon/octeon-model.h b/arch/mips/include/asm/octeon/octeon-model.h
index cf50336..700f88e 100644
--- a/arch/mips/include/asm/octeon/octeon-model.h
+++ b/arch/mips/include/asm/octeon/octeon-model.h
@@ -35,14 +35,6 @@
 #ifndef __OCTEON_MODEL_H__
 #define __OCTEON_MODEL_H__
 
-/* NOTE: These must match what is checked in common-config.mk */
-/* Defines to represent the different versions of Octeon.  */
-
-/*
- * IMPORTANT: When the default pass is updated for an Octeon Model,
- * the corresponding change must also be made in the oct-sim script.
- */
-
 /*
  * The defines below should be used with the OCTEON_IS_MODEL() macro
  * to determine what model of chip the software is running on.  Models
@@ -71,6 +63,21 @@
 #define OM_IGNORE_MINOR_REVISION  0x08000000
 #define OM_FLAG_MASK              0xff000000
 
+#define OM_MATCH_5XXX_FAMILY_MODELS     0x20000000 /* Match all cn5XXX Octeon models. */
+#define OM_MATCH_6XXX_FAMILY_MODELS     0x40000000 /* Match all cn6XXX Octeon models. */
+
+/*
+ * CN6XXX models with new revision encoding
+ */
+#define OCTEON_CN63XX_PASS1_0   0x000d9000
+#define OCTEON_CN63XX_PASS1_1   0x000d9001
+#define OCTEON_CN63XX_PASS1_2   0x000d9002
+#define OCTEON_CN63XX_PASS2_0   0x000d9008
+
+#define OCTEON_CN63XX           (OCTEON_CN63XX_PASS2_0 | OM_IGNORE_REVISION)
+#define OCTEON_CN63XX_PASS1_X   (OCTEON_CN63XX_PASS1_0 | OM_IGNORE_MINOR_REVISION)
+#define OCTEON_CN63XX_PASS2_X   (OCTEON_CN63XX_PASS2_0 | OM_IGNORE_MINOR_REVISION)
+
 /*
  * CN5XXX models with new revision encoding
  */
@@ -189,6 +196,9 @@
 				 | OM_MATCH_PREVIOUS_MODELS \
 				 | OM_IGNORE_REVISION)
 
+#define OCTEON_CN5XXX           (OCTEON_CN58XX_PASS1_0 | OM_MATCH_5XXX_FAMILY_MODELS)
+#define OCTEON_CN6XXX           (OCTEON_CN63XX_PASS1_0 | OM_MATCH_6XXX_FAMILY_MODELS)
+
 /* The revision byte (low byte) has two different encodings.
  * CN3XXX:
  *
@@ -222,6 +232,7 @@
 				      | OCTEON_58XX_MODEL_MASK)
 #define OCTEON_58XX_MODEL_MINOR_REV_MASK (OCTEON_58XX_MODEL_REV_MASK \
 					  & 0x00fffff8)
+#define OCTEON_5XXX_MODEL_MASK       0x00ff0fc0
 
 #define __OCTEON_MATCH_MASK__(x, y, z) (((x) & (z)) == ((y) & (z)))
 
@@ -273,6 +284,15 @@ static inline int __OCTEON_IS_MODEL_COMPILE__(uint32_t arg_model,
 		    __OCTEON_MATCH_MASK__((chip_model), (arg_model),
 					  OCTEON_58XX_MODEL_REV_MASK))
 			return 1;
+
+		if (((arg_model & OM_MATCH_5XXX_FAMILY_MODELS) == OM_MATCH_5XXX_FAMILY_MODELS) &&
+		    ((chip_model) >= OCTEON_CN58XX_PASS1_0) && ((chip_model) < OCTEON_CN63XX_PASS1_0))
+			return 1;
+
+		if (((arg_model & OM_MATCH_6XXX_FAMILY_MODELS) == OM_MATCH_6XXX_FAMILY_MODELS) &&
+		    ((chip_model) >= OCTEON_CN63XX_PASS1_0))
+			return 1;
+
 		if ((arg_model & OM_MATCH_PREVIOUS_MODELS) &&
 		    ((chip_model & OCTEON_58XX_MODEL_MASK) <
 			    (arg_model & OCTEON_58XX_MODEL_MASK)))
-- 
1.7.2.3
