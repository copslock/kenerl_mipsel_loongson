Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 00:47:22 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:63881 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903744Ab1KOXq1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Nov 2011 00:46:27 +0100
Received: by ywp31 with SMTP id 31so7230863ywp.36
        for <multiple recipients>; Tue, 15 Nov 2011 15:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=oKPvs5anC094y99Kqf4pOHXb0OSWD3WiC80r1HcDsX8=;
        b=GaDM4AKtc0TgmMshzw2E18/AZdZg2+vVk6R08NwtVPbPbuS0yp80Kb7ZDAVKJ1Aok5
         H3EPRLln20S0IT6mDJqJODrZrIxsH1YWpSIpDAFKpPiqoeSC7d03Or+w4KeMHXLpyEE3
         0gXErhrfUWlLd+Go46BYJm9ND/7KHuwTEfvaA=
Received: by 10.146.200.27 with SMTP id x27mr226571yaf.31.1321400781455;
        Tue, 15 Nov 2011 15:46:21 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id b9sm78951737anb.7.2011.11.15.15.46.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Nov 2011 15:46:20 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAFNkIn6032398;
        Tue, 15 Nov 2011 15:46:18 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAFNkIrR032397;
        Tue, 15 Nov 2011 15:46:18 -0800
From:   ddaney.cavm@gmail.com
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 2/5] MIPS: Octeon: Update feature test functions for new chips and features.
Date:   Tue, 15 Nov 2011 15:46:12 -0800
Message-Id: <1321400775-32353-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1321400775-32353-1-git-send-email-ddaney.cavm@gmail.com>
References: <1321400775-32353-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 31618
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12943

From: David Daney <david.daney@cavium.com>

cvmx.h was rearranged to fix include file ordering problems, but there
is no change other than moving some definitions around.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/octeon/cvmx.h           |   42 +++++-----
 arch/mips/include/asm/octeon/octeon-feature.h |  114 +++++++++++++++++++++++--
 2 files changed, 126 insertions(+), 30 deletions(-)

diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index 7e12867..740be97 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -31,6 +31,27 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 
+enum cvmx_mips_space {
+	CVMX_MIPS_SPACE_XKSEG = 3LL,
+	CVMX_MIPS_SPACE_XKPHYS = 2LL,
+	CVMX_MIPS_SPACE_XSSEG = 1LL,
+	CVMX_MIPS_SPACE_XUSEG = 0LL
+};
+
+/* These macros for use when using 32 bit pointers. */
+#define CVMX_MIPS32_SPACE_KSEG0 1l
+#define CVMX_ADD_SEG32(segment, add) \
+	(((int32_t)segment << 31) | (int32_t)(add))
+
+#define CVMX_IO_SEG CVMX_MIPS_SPACE_XKPHYS
+
+/* These macros simplify the process of creating common IO addresses */
+#define CVMX_ADD_SEG(segment, add) \
+	((((uint64_t)segment) << 62) | (add))
+#ifndef CVMX_ADD_IO_SEG
+#define CVMX_ADD_IO_SEG(add) CVMX_ADD_SEG(CVMX_IO_SEG, (add))
+#endif
+
 #include "cvmx-asm.h"
 #include "cvmx-packet.h"
 #include "cvmx-sysinfo.h"
@@ -129,27 +150,6 @@ static inline uint64_t cvmx_build_bits(uint64_t high_bit,
 	return (value & cvmx_build_mask(high_bit - low_bit + 1)) << low_bit;
 }
 
-enum cvmx_mips_space {
-	CVMX_MIPS_SPACE_XKSEG = 3LL,
-	CVMX_MIPS_SPACE_XKPHYS = 2LL,
-	CVMX_MIPS_SPACE_XSSEG = 1LL,
-	CVMX_MIPS_SPACE_XUSEG = 0LL
-};
-
-/* These macros for use when using 32 bit pointers. */
-#define CVMX_MIPS32_SPACE_KSEG0 1l
-#define CVMX_ADD_SEG32(segment, add) \
-	(((int32_t)segment << 31) | (int32_t)(add))
-
-#define CVMX_IO_SEG CVMX_MIPS_SPACE_XKPHYS
-
-/* These macros simplify the process of creating common IO addresses */
-#define CVMX_ADD_SEG(segment, add) \
-	((((uint64_t)segment) << 62) | (add))
-#ifndef CVMX_ADD_IO_SEG
-#define CVMX_ADD_IO_SEG(add) CVMX_ADD_SEG(CVMX_IO_SEG, (add))
-#endif
-
 /**
  * Convert a memory pointer (void*) into a hardware compatible
  * memory address (uint64_t). Octeon hardware widgets don't
diff --git a/arch/mips/include/asm/octeon/octeon-feature.h b/arch/mips/include/asm/octeon/octeon-feature.h
index cba6fbe..3caa826 100644
--- a/arch/mips/include/asm/octeon/octeon-feature.h
+++ b/arch/mips/include/asm/octeon/octeon-feature.h
@@ -31,8 +31,14 @@
 
 #ifndef __OCTEON_FEATURE_H__
 #define __OCTEON_FEATURE_H__
+#include <asm/octeon/cvmx-mio-defs.h>
+#include <asm/octeon/cvmx-rnm-defs.h>
 
 enum octeon_feature {
+        /* CN68XX uses port kinds for packet interface */
+	OCTEON_FEATURE_PKND,
+	/* CN68XX has different fields in word0 - word2 */ 
+	OCTEON_FEATURE_CN68XX_WQE,
 	/*
 	 * Octeon models in the CN5XXX family and higher support
 	 * atomic add instructions to memory (saa/saad).
@@ -42,8 +48,13 @@ enum octeon_feature {
 	OCTEON_FEATURE_ZIP,
 	/* Does this Octeon support crypto acceleration using COP2? */
 	OCTEON_FEATURE_CRYPTO,
+	OCTEON_FEATURE_DORM_CRYPTO,
 	/* Does this Octeon support PCI express? */
 	OCTEON_FEATURE_PCIE,
+        /* Does this Octeon support SRIOs */
+	OCTEON_FEATURE_SRIO,
+	/*  Does this Octeon support Interlaken */
+	OCTEON_FEATURE_ILK,
 	/* Some Octeon models support internal memory for storing
 	 * cryptographic keys */
 	OCTEON_FEATURE_KEY_MEMORY,
@@ -64,6 +75,15 @@ enum octeon_feature {
 	/* Octeon MDIO block supports clause 45 transactions for 10
 	 * Gig support */
 	OCTEON_FEATURE_MDIO_CLAUSE_45,
+        /*
+	 *  CN52XX and CN56XX used a block named NPEI for PCIe
+	 *  access. Newer chips replaced this with SLI+DPI.
+	 */
+	OCTEON_FEATURE_NPEI,
+	OCTEON_FEATURE_HFA,
+	OCTEON_FEATURE_DFM,
+	OCTEON_FEATURE_CIU2,
+	OCTEON_MAX_FEATURE
 };
 
 static inline int cvmx_fuse_read(int fuse);
@@ -96,30 +116,78 @@ static inline int octeon_has_feature(enum octeon_feature feature)
 			return !cvmx_fuse_read(121);
 
 	case OCTEON_FEATURE_CRYPTO:
-		return !cvmx_fuse_read(90);
+		if (OCTEON_IS_MODEL(OCTEON_CN6XXX)) {
+			union cvmx_mio_fus_dat2 fus_2;
+			fus_2.u64 = cvmx_read_csr(CVMX_MIO_FUS_DAT2);
+			if (fus_2.s.nocrypto || fus_2.s.nomul) {
+				return 0;
+			} else if (!fus_2.s.dorm_crypto) {
+				return 1;
+			} else {
+				union cvmx_rnm_ctl_status st;
+				st.u64 = cvmx_read_csr(CVMX_RNM_CTL_STATUS);
+				return st.s.eer_val;
+			}
+		} else {
+			return !cvmx_fuse_read(90);
+		}
+
+	case OCTEON_FEATURE_DORM_CRYPTO:
+		if (OCTEON_IS_MODEL(OCTEON_CN6XXX)) {
+			union cvmx_mio_fus_dat2 fus_2;
+			fus_2.u64 = cvmx_read_csr(CVMX_MIO_FUS_DAT2);
+			return !fus_2.s.nocrypto && !fus_2.s.nomul && fus_2.s.dorm_crypto;
+		} else {
+			return 0;
+		}
 
 	case OCTEON_FEATURE_PCIE:
-	case OCTEON_FEATURE_MGMT_PORT:
-	case OCTEON_FEATURE_RAID:
 		return OCTEON_IS_MODEL(OCTEON_CN56XX)
-			|| OCTEON_IS_MODEL(OCTEON_CN52XX);
+			|| OCTEON_IS_MODEL(OCTEON_CN52XX)
+			|| OCTEON_IS_MODEL(OCTEON_CN6XXX);
+
+	case OCTEON_FEATURE_SRIO:
+		return OCTEON_IS_MODEL(OCTEON_CN63XX)
+			|| OCTEON_IS_MODEL(OCTEON_CN66XX);
+
+	case OCTEON_FEATURE_ILK:
+		return (OCTEON_IS_MODEL(OCTEON_CN68XX));
 
 	case OCTEON_FEATURE_KEY_MEMORY:
+		return OCTEON_IS_MODEL(OCTEON_CN38XX)
+			|| OCTEON_IS_MODEL(OCTEON_CN58XX)
+			|| OCTEON_IS_MODEL(OCTEON_CN56XX)
+			|| OCTEON_IS_MODEL(OCTEON_CN6XXX);
+
 	case OCTEON_FEATURE_LED_CONTROLLER:
 		return OCTEON_IS_MODEL(OCTEON_CN38XX)
 			|| OCTEON_IS_MODEL(OCTEON_CN58XX)
 			|| OCTEON_IS_MODEL(OCTEON_CN56XX);
+
 	case OCTEON_FEATURE_TRA:
 		return !(OCTEON_IS_MODEL(OCTEON_CN30XX)
 			 || OCTEON_IS_MODEL(OCTEON_CN50XX));
+	case OCTEON_FEATURE_MGMT_PORT:
+		return OCTEON_IS_MODEL(OCTEON_CN56XX)
+			|| OCTEON_IS_MODEL(OCTEON_CN52XX)
+			|| OCTEON_IS_MODEL(OCTEON_CN6XXX);
+
+	case OCTEON_FEATURE_RAID:
+		return OCTEON_IS_MODEL(OCTEON_CN56XX)
+			|| OCTEON_IS_MODEL(OCTEON_CN52XX)
+			|| OCTEON_IS_MODEL(OCTEON_CN6XXX);
+
 	case OCTEON_FEATURE_USB:
 		return !(OCTEON_IS_MODEL(OCTEON_CN38XX)
 			 || OCTEON_IS_MODEL(OCTEON_CN58XX));
+
 	case OCTEON_FEATURE_NO_WPTR:
 		return (OCTEON_IS_MODEL(OCTEON_CN56XX)
-			 || OCTEON_IS_MODEL(OCTEON_CN52XX))
-			&& !OCTEON_IS_MODEL(OCTEON_CN56XX_PASS1_X)
-			&& !OCTEON_IS_MODEL(OCTEON_CN52XX_PASS1_X);
+			|| OCTEON_IS_MODEL(OCTEON_CN52XX)
+			|| OCTEON_IS_MODEL(OCTEON_CN6XXX))
+			  && !OCTEON_IS_MODEL(OCTEON_CN56XX_PASS1_X)
+			  && !OCTEON_IS_MODEL(OCTEON_CN52XX_PASS1_X);
+
 	case OCTEON_FEATURE_DFA:
 		if (!OCTEON_IS_MODEL(OCTEON_CN38XX)
 		    && !OCTEON_IS_MODEL(OCTEON_CN31XX)
@@ -127,14 +195,42 @@ static inline int octeon_has_feature(enum octeon_feature feature)
 			return 0;
 		else if (OCTEON_IS_MODEL(OCTEON_CN3020))
 			return 0;
-		else if (OCTEON_IS_MODEL(OCTEON_CN38XX_PASS1))
-			return 1;
 		else
 			return !cvmx_fuse_read(120);
+
+	case OCTEON_FEATURE_HFA:
+		if (!OCTEON_IS_MODEL(OCTEON_CN6XXX))
+			return 0;
+		else
+			return !cvmx_fuse_read(90);
+
+	case OCTEON_FEATURE_DFM:
+		if (!(OCTEON_IS_MODEL(OCTEON_CN63XX)
+		      || OCTEON_IS_MODEL(OCTEON_CN66XX)))
+			return 0;
+		else
+			return !cvmx_fuse_read(90);
+
 	case OCTEON_FEATURE_MDIO_CLAUSE_45:
 		return !(OCTEON_IS_MODEL(OCTEON_CN3XXX)
 			 || OCTEON_IS_MODEL(OCTEON_CN58XX)
 			 || OCTEON_IS_MODEL(OCTEON_CN50XX));
+
+	case OCTEON_FEATURE_NPEI:
+		return OCTEON_IS_MODEL(OCTEON_CN56XX)
+			|| OCTEON_IS_MODEL(OCTEON_CN52XX);
+
+	case OCTEON_FEATURE_PKND:
+		return OCTEON_IS_MODEL(OCTEON_CN68XX);
+
+	case OCTEON_FEATURE_CN68XX_WQE:
+		return OCTEON_IS_MODEL(OCTEON_CN68XX);
+
+	case OCTEON_FEATURE_CIU2:
+		return OCTEON_IS_MODEL(OCTEON_CN68XX);
+
+	default:
+		break;
 	}
 	return 0;
 }
-- 
1.7.2.3
