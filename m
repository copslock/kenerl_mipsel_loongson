Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 04:50:44 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54942 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991445AbdHMCu0WzFk6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 04:50:26 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 5C3A659C48D6F;
        Sun, 13 Aug 2017 03:50:18 +0100 (IST)
Received: from localhost (10.20.79.142) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 13 Aug
 2017 03:50:19 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 01/19] MIPS: CM: Rename mips_cm_base to mips_gcr_base
Date:   Sat, 12 Aug 2017 19:49:25 -0700
Message-ID: <20170813024943.14989-2-paul.burton@imgtec.com>
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
X-archive-position: 59497
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

We currently have a mips_cm_base variable which holds the base address
of the Coherence Manager (CM) Global Configuration Registers (GCRs), and
accessor functions which use the GCR in their names. This works fine,
but gets in the way of sharing the code to generate the accessor
functions with other blocks (ie. CPC & GIC) because that code would then
need to separately handle the name of the base address variable & the
name used in the accessor functions.

In order to prepare for sharing the accessor generation code between CM,
CPC & GIC code this patch renames mips_cm_base to mips_gcr_base such
that the "gcr" portion is common to both the base address variable & the
accessor function names.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/mips-cm.h |  6 +++---
 arch/mips/kernel/mips-cm.c      | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index cfdbab015769..a13d721669e6 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -17,7 +17,7 @@
 #include <linux/types.h>
 
 /* The base address of the CM GCR block */
-extern void __iomem *mips_cm_base;
+extern void __iomem *mips_gcr_base;
 
 /* The base address of the CM L2-only sync region */
 extern void __iomem *mips_cm_l2sync_base;
@@ -80,7 +80,7 @@ static inline int mips_cm_probe(void)
 static inline bool mips_cm_present(void)
 {
 #ifdef CONFIG_MIPS_CM
-	return mips_cm_base != NULL;
+	return mips_gcr_base != NULL;
 #else
 	return false;
 #endif
@@ -116,7 +116,7 @@ static inline bool mips_cm_has_l2sync(void)
 #define BUILD_CM_R_(name, off)					\
 static inline unsigned long __iomem *addr_gcr_##name(void)	\
 {								\
-	return (unsigned long __iomem *)(mips_cm_base + (off));	\
+	return (unsigned long __iomem *)(mips_gcr_base + (off));\
 }								\
 								\
 static inline u32 read32_gcr_##name(void)			\
diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index cb0c57f860d4..caac4a523968 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -15,7 +15,7 @@
 #include <asm/mips-cm.h>
 #include <asm/mipsregs.h>
 
-void __iomem *mips_cm_base;
+void __iomem *mips_gcr_base;
 void __iomem *mips_cm_l2sync_base;
 int mips_cm_is64;
 
@@ -211,7 +211,7 @@ int mips_cm_probe(void)
 	 * No need to probe again if we have already been
 	 * here before.
 	 */
-	if (mips_cm_base)
+	if (mips_gcr_base)
 		return 0;
 
 	addr = mips_cm_phys_base();
@@ -219,8 +219,8 @@ int mips_cm_probe(void)
 	if (!addr)
 		return -ENODEV;
 
-	mips_cm_base = ioremap_nocache(addr, MIPS_CM_GCR_SIZE);
-	if (!mips_cm_base)
+	mips_gcr_base = ioremap_nocache(addr, MIPS_CM_GCR_SIZE);
+	if (!mips_gcr_base)
 		return -ENXIO;
 
 	/* sanity check that we're looking at a CM */
@@ -228,7 +228,7 @@ int mips_cm_probe(void)
 	if ((base_reg & CM_GCR_BASE_GCRBASE_MSK) != addr) {
 		pr_err("GCRs appear to have been moved (expected them at 0x%08lx)!\n",
 		       (unsigned long)addr);
-		mips_cm_base = NULL;
+		mips_gcr_base = NULL;
 		return -ENODEV;
 	}
 
-- 
2.14.0
