Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 20:02:19 +0100 (CET)
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33304 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012336AbcBITBHvbO0R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 20:01:07 +0100
Received: by mail-pa0-f67.google.com with SMTP id gc2so613442pab.0;
        Tue, 09 Feb 2016 11:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kDAYwY9+PlLPcTE52gHDqF/M3Oxywmmnd6Ak6ua9Js4=;
        b=Gl93SYev4v1b33gqYBXrEehc9TZyBgiNEMdEFOwPqsWSU0BpyLCW/UjkI14yswGhid
         pcaIXeFCqI7ArQWiyYw6EVuXXjKojx1a4psUxmvurl+mgI3d86CcE1wd/03wY6Aqdg0h
         D1y7Sgvlr1bnViJ/IXkyJVD0CBzAKa8x7N5aMN/3YNYjbtVEVqPz7FRnO5ZfntdyeUrX
         g5rGZAlcaS6DELBmkdkNZ06a15EoGhZG84AWTvN7trnv+4gKMslSQJNiF9iQbY4YVP54
         b1rRTOOfpKTSx4GfTMEMNl6xOTr0LK6XXeN+spzPOMYnehX1rhT+v2L8Xbph5uNY0Bwm
         d62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kDAYwY9+PlLPcTE52gHDqF/M3Oxywmmnd6Ak6ua9Js4=;
        b=E55YAT3frMpoxZaGntvBL2S9DtZ2blysN1/WaNozDXUx0JhI5AkEjmZQePt6WsRWWd
         nJHRV0y3w9tB5P2bTRa9gBY0h7Nm1Uk20p0A7fVORQtTWbNX5T3t37JqVLfAedGP8oyb
         uWUei5YhFMLFhLvSTAKH83jz00/NMPYMgt/CHJPpgaqVgP4An5TEe9Uh+tghPS4t1YkY
         cI+wpS7Iq8g1pSCgjEGsjPsLeM7exnDVtwgKViGbLaZZzdR9i/Ibp0vDfF2i7gEfMctE
         qpCw7qGQw2BIRmTonvJHEFS5GhhgoEZGwAynzPF/WRioCvs9MlluHmU+sVeD1vFhmIed
         +ejg==
X-Gm-Message-State: AG10YOSFV6O1MjuvAQHRni8GRQDBimes+gA6acC4ghPa6k0sbnjyweogoqs7MTByd9Z8cQ==
X-Received: by 10.66.234.104 with SMTP id ud8mr52810412pac.143.1455044462044;
        Tue, 09 Feb 2016 11:01:02 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.gmail.com with ESMTPSA id 79sm52221391pfq.65.2016.02.09.11.00.54
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 11:00:58 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id u19J0rKr009884;
        Tue, 9 Feb 2016 11:00:53 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id u19J0rrg009883;
        Tue, 9 Feb 2016 11:00:53 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v2 4/8] MIPS: OCTEON: Add model checking support for cn73xx, cnf75xx and cn78xx
Date:   Tue,  9 Feb 2016 11:00:09 -0800
Message-Id: <1455044413-9823-5-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1455044413-9823-1-git-send-email-ddaney.cavm@gmail.com>
References: <1455044413-9823-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

Follow on patchs need to be able to distinguish the new models.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/executive/octeon-model.c | 82 +++++++++++++++++++++++-
 arch/mips/include/asm/octeon/cvmx.h              | 27 +++++++-
 arch/mips/include/asm/octeon/octeon-feature.h    | 19 +++++-
 arch/mips/include/asm/octeon/octeon-model.h      |  5 ++
 4 files changed, 125 insertions(+), 8 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/octeon-model.c b/arch/mips/cavium-octeon/executive/octeon-model.c
index b2104bd..d08a2bc 100644
--- a/arch/mips/cavium-octeon/executive/octeon-model.c
+++ b/arch/mips/cavium-octeon/executive/octeon-model.c
@@ -71,11 +71,11 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 	uint32_t fuse_data = 0;
 
 	fus3.u64 = 0;
-	if (!OCTEON_IS_MODEL(OCTEON_CN6XXX))
+	if (OCTEON_IS_MODEL(OCTEON_CN3XXX) || OCTEON_IS_MODEL(OCTEON_CN5XXX))
 		fus3.u64 = cvmx_read_csr(CVMX_L2D_FUS3);
 	fus_dat2.u64 = cvmx_read_csr(CVMX_MIO_FUS_DAT2);
 	fus_dat3.u64 = cvmx_read_csr(CVMX_MIO_FUS_DAT3);
-	num_cores = cvmx_pop(cvmx_read_csr(CVMX_CIU_FUSE));
+	num_cores = cvmx_octeon_num_cores();
 
 	/* Make sure the non existent devices look disabled */
 	switch ((chip_id >> 8) & 0xff) {
@@ -121,6 +121,15 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 	 * later.
 	 */
 	switch (num_cores) {
+	case 48:
+		core_model = "90";
+		break;
+	case 44:
+		core_model = "88";
+		break;
+	case 40:
+		core_model = "85";
+		break;
 	case 32:
 		core_model = "80";
 		break;
@@ -297,7 +306,7 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 				if (fus_dat3.s.nozip)
 					suffix = "SCP";
 
-				if (fus_dat3.s.bar2_en)
+				if (fus_dat3.cn56xx.bar2_en)
 					suffix = "NSPB2";
 			}
 			if (fus3.cn56xx.crip_1024k)
@@ -369,6 +378,73 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 		else
 			suffix = "AAP";
 		break;
+	case 0x94:		/* CNF71XX */
+		family = "F71";
+		if (fus_dat3.cnf71xx.nozip)
+			suffix = "SCP";
+		else
+			suffix = "AAP";
+		break;
+	case 0x95:		/* CN78XX */
+		if (num_cores == 6)	/* Other core counts match generic */
+			core_model = "35";
+		if (OCTEON_IS_MODEL(OCTEON_CN76XX))
+			family = "76";
+		else
+			family = "78";
+		if (fus_dat3.cn78xx.l2c_crip == 2)
+			family = "77";
+		if (fus_dat3.cn78xx.nozip
+		    && fus_dat3.cn78xx.nodfa_dte
+		    && fus_dat3.cn78xx.nohna_dte) {
+			if (fus_dat3.cn78xx.nozip &&
+				!fus_dat2.cn78xx.raid_en &&
+				fus_dat3.cn78xx.nohna_dte) {
+				suffix = "CP";
+			} else {
+				suffix = "SCP";
+			}
+		} else if (fus_dat2.cn78xx.raid_en == 0)
+			suffix = "HCP";
+		else
+			suffix = "AAP";
+		break;
+	case 0x96:		/* CN70XX */
+		family = "70";
+		if (cvmx_read_csr(CVMX_MIO_FUS_PDF) & (0x1ULL << 32))
+			family = "71";
+		if (fus_dat2.cn70xx.nocrypto)
+			suffix = "CP";
+		else if (fus_dat3.cn70xx.nodfa_dte)
+			suffix = "SCP";
+		else
+			suffix = "AAP";
+		break;
+	case 0x97:		/* CN73XX */
+		if (num_cores == 6)	/* Other core counts match generic */
+			core_model = "35";
+		family = "73";
+		if (fus_dat3.cn73xx.l2c_crip == 2)
+			family = "72";
+		if (fus_dat3.cn73xx.nozip
+				&& fus_dat3.cn73xx.nodfa_dte
+				&& fus_dat3.cn73xx.nohna_dte) {
+			if (!fus_dat2.cn73xx.raid_en)
+				suffix = "CP";
+			else
+				suffix = "SCP";
+		} else
+			suffix = "AAP";
+		break;
+	case 0x98:		/* CN75XX */
+		family = "F75";
+		if (fus_dat3.cn78xx.nozip
+		    && fus_dat3.cn78xx.nodfa_dte
+		    && fus_dat3.cn78xx.nohna_dte)
+			suffix = "SCP";
+		else
+			suffix = "AAP";
+		break;
 	default:
 		family = "XX";
 		core_model = "XX";
diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index 774bb45..9ea9279 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -57,6 +57,7 @@ enum cvmx_mips_space {
 #include <asm/octeon/cvmx-sysinfo.h>
 
 #include <asm/octeon/cvmx-ciu-defs.h>
+#include <asm/octeon/cvmx-ciu3-defs.h>
 #include <asm/octeon/cvmx-gpio-defs.h>
 #include <asm/octeon/cvmx-iob-defs.h>
 #include <asm/octeon/cvmx-ipd-defs.h>
@@ -332,6 +333,21 @@ static inline unsigned int cvmx_get_core_num(void)
 	return core_num;
 }
 
+/* Maximum # of bits to define core in node */
+#define CVMX_NODE_NO_SHIFT	7
+#define CVMX_NODE_MASK		0x3
+static inline unsigned int cvmx_get_node_num(void)
+{
+	unsigned int core_num = cvmx_get_core_num();
+
+	return (core_num >> CVMX_NODE_NO_SHIFT) & CVMX_NODE_MASK;
+}
+
+static inline unsigned int cvmx_get_local_core_num(void)
+{
+	return cvmx_get_core_num() & ((1 << CVMX_NODE_NO_SHIFT) - 1);
+}
+
 /**
  * Returns the number of bits set in the provided value.
  * Simple wrapper for POP instruction.
@@ -439,8 +455,15 @@ static inline uint64_t cvmx_get_cycle_global(void)
 /* Return the number of cores available in the chip */
 static inline uint32_t cvmx_octeon_num_cores(void)
 {
-	uint32_t ciu_fuse = (uint32_t) cvmx_read_csr(CVMX_CIU_FUSE) & 0xffff;
-	return cvmx_pop(ciu_fuse);
+	u64 ciu_fuse_reg;
+	u64 ciu_fuse;
+
+	if (OCTEON_IS_OCTEON3() && !OCTEON_IS_MODEL(OCTEON_CN70XX))
+		ciu_fuse_reg = CVMX_CIU3_FUSE;
+	else
+		ciu_fuse_reg = CVMX_CIU_FUSE;
+	ciu_fuse = cvmx_read_csr(ciu_fuse_reg);
+	return cvmx_dpop(ciu_fuse);
 }
 
 #endif /*  __CVMX_H__  */
diff --git a/arch/mips/include/asm/octeon/octeon-feature.h b/arch/mips/include/asm/octeon/octeon-feature.h
index 8ebd3f57..22d7475 100644
--- a/arch/mips/include/asm/octeon/octeon-feature.h
+++ b/arch/mips/include/asm/octeon/octeon-feature.h
@@ -81,6 +81,10 @@ enum octeon_feature {
 	OCTEON_FEATURE_HFA,
 	OCTEON_FEATURE_DFM,
 	OCTEON_FEATURE_CIU2,
+	OCTEON_FEATURE_CIU3,
+	/* Octeon has FPA first seen on 78XX */
+	OCTEON_FEATURE_FPA3,
+	OCTEON_FEATURE_FAU,
 	OCTEON_MAX_FEATURE
 };
 
@@ -110,7 +114,7 @@ static inline int octeon_has_crypto(void)
  * Returns Non zero if the feature exists. Zero if the feature does not
  *	   exist.
  */
-static inline int octeon_has_feature(enum octeon_feature feature)
+static inline bool octeon_has_feature(enum octeon_feature feature)
 {
 	switch (feature) {
 	case OCTEON_FEATURE_SAAD:
@@ -122,7 +126,7 @@ static inline int octeon_has_feature(enum octeon_feature feature)
 			fus_2.u64 = cvmx_read_csr(CVMX_MIO_FUS_DAT2);
 			return !fus_2.s.nocrypto && !fus_2.s.nomul && fus_2.s.dorm_crypto;
 		} else {
-			return 0;
+			return false;
 		}
 
 	case OCTEON_FEATURE_PCIE:
@@ -189,11 +193,20 @@ static inline int octeon_has_feature(enum octeon_feature feature)
 
 	case OCTEON_FEATURE_CIU2:
 		return OCTEON_IS_MODEL(OCTEON_CN68XX);
+	case OCTEON_FEATURE_CIU3:
+	case OCTEON_FEATURE_FPA3:
+		return OCTEON_IS_MODEL(OCTEON_CN78XX)
+			|| OCTEON_IS_MODEL(OCTEON_CNF75XX)
+			|| OCTEON_IS_MODEL(OCTEON_CN73XX);
+	case OCTEON_FEATURE_FAU:
+		return !(OCTEON_IS_MODEL(OCTEON_CN78XX)
+			 || OCTEON_IS_MODEL(OCTEON_CNF75XX)
+			 || OCTEON_IS_MODEL(OCTEON_CN73XX));
 
 	default:
 		break;
 	}
-	return 0;
+	return false;
 }
 
 #endif /* __OCTEON_FEATURE_H__ */
diff --git a/arch/mips/include/asm/octeon/octeon-model.h b/arch/mips/include/asm/octeon/octeon-model.h
index 92b377e..6c68517 100644
--- a/arch/mips/include/asm/octeon/octeon-model.h
+++ b/arch/mips/include/asm/octeon/octeon-model.h
@@ -74,7 +74,12 @@
  * CN7XXX models with new revision encoding
  */
 
+#define OCTEON_CNF75XX_PASS1_0	0x000d9800
+#define OCTEON_CNF75XX		(OCTEON_CNF75XX_PASS1_0 | OM_IGNORE_REVISION)
+#define OCTEON_CNF75XX_PASS1_X	(OCTEON_CNF75XX_PASS1_0 | OM_IGNORE_MINOR_REVISION)
+
 #define OCTEON_CN73XX_PASS1_0	0x000d9700
+#define OCTEON_CN73XX_PASS1_1	0x000d9701
 #define OCTEON_CN73XX		(OCTEON_CN73XX_PASS1_0 | OM_IGNORE_REVISION)
 #define OCTEON_CN73XX_PASS1_X	(OCTEON_CN73XX_PASS1_0 | \
 				 OM_IGNORE_MINOR_REVISION)
-- 
1.7.11.7
