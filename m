Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Sep 2014 17:27:31 +0200 (CEST)
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:58267 "EHLO
        demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008468AbaIHP1ZbG9BH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Sep 2014 17:27:25 +0200
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd001.nsn-inter.net (8.14.3/8.14.3) with ESMTP id s88FRI0n002178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 8 Sep 2014 15:27:19 GMT
Received: from ak-desktop.emea.nsn-net.net ([10.144.35.206])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id s88FRGFZ002806;
        Mon, 8 Sep 2014 17:27:18 +0200
From:   Aaro Koskinen <aaro.koskinen@nsn.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@nsn.com>
Subject: [PATCH 2/4] MIPS: OCTEON: delete potentially dangerous feature checks
Date:   Mon,  8 Sep 2014 18:25:41 +0300
Message-Id: <1410189943-4573-3-git-send-email-aaro.koskinen@nsn.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410189943-4573-1-git-send-email-aaro.koskinen@nsn.com>
References: <1410189943-4573-1-git-send-email-aaro.koskinen@nsn.com>
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 4372
X-purgate-ID: 151667::1410190039-00002A30-95C08844/0/0
Return-Path: <aaro.koskinen@nsn.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@nsn.com
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

We should not need to read fuses during normal operation, also the current
code has issues with that (not safe for concurrent access). Since there
are no in-kernel users for these, just delete them. Drivers should
not need such OCTEON_HAS_FEATURE mechanism in any case, instead the
information should be passed via device tree.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nsn.com>
---
 arch/mips/include/asm/octeon/cvmx.h           | 43 ----------------------
 arch/mips/include/asm/octeon/octeon-feature.h | 52 ---------------------------
 2 files changed, 95 deletions(-)

diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index 6852dfa..b0b544f 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -453,47 +453,4 @@ static inline uint32_t cvmx_octeon_num_cores(void)
 
 uint8_t cvmx_fuse_read_byte(int byte_addr);
 
-/**
- * Read a single fuse bit
- *
- * @fuse:   Fuse number (0-1024)
- *
- * Returns fuse value: 0 or 1
- */
-static inline int cvmx_fuse_read(int fuse)
-{
-	return (cvmx_fuse_read_byte(fuse >> 3) >> (fuse & 0x7)) & 1;
-}
-
-static inline int cvmx_octeon_model_CN36XX(void)
-{
-	return OCTEON_IS_MODEL(OCTEON_CN38XX)
-		&& !cvmx_octeon_is_pass1()
-		&& cvmx_fuse_read(264);
-}
-
-static inline int cvmx_octeon_zip_present(void)
-{
-	return octeon_has_feature(OCTEON_FEATURE_ZIP);
-}
-
-static inline int cvmx_octeon_dfa_present(void)
-{
-	if (!OCTEON_IS_MODEL(OCTEON_CN38XX)
-	    && !OCTEON_IS_MODEL(OCTEON_CN31XX)
-	    && !OCTEON_IS_MODEL(OCTEON_CN58XX))
-		return 0;
-	else if (OCTEON_IS_MODEL(OCTEON_CN3020))
-		return 0;
-	else if (cvmx_octeon_is_pass1())
-		return 1;
-	else
-		return !cvmx_fuse_read(120);
-}
-
-static inline int cvmx_octeon_crypto_present(void)
-{
-	return octeon_has_feature(OCTEON_FEATURE_CRYPTO);
-}
-
 #endif /*  __CVMX_H__  */
diff --git a/arch/mips/include/asm/octeon/octeon-feature.h b/arch/mips/include/asm/octeon/octeon-feature.h
index 90e05a8..c4fe81f 100644
--- a/arch/mips/include/asm/octeon/octeon-feature.h
+++ b/arch/mips/include/asm/octeon/octeon-feature.h
@@ -86,8 +86,6 @@ enum octeon_feature {
 	OCTEON_MAX_FEATURE
 };
 
-static inline int cvmx_fuse_read(int fuse);
-
 /**
  * Determine if the current Octeon supports a specific feature. These
  * checks have been optimized to be fairly quick, but they should still
@@ -105,33 +103,6 @@ static inline int octeon_has_feature(enum octeon_feature feature)
 	case OCTEON_FEATURE_SAAD:
 		return !OCTEON_IS_MODEL(OCTEON_CN3XXX);
 
-	case OCTEON_FEATURE_ZIP:
-		if (OCTEON_IS_MODEL(OCTEON_CN30XX)
-		    || OCTEON_IS_MODEL(OCTEON_CN50XX)
-		    || OCTEON_IS_MODEL(OCTEON_CN52XX))
-			return 0;
-		else if (OCTEON_IS_MODEL(OCTEON_CN38XX_PASS1))
-			return 1;
-		else
-			return !cvmx_fuse_read(121);
-
-	case OCTEON_FEATURE_CRYPTO:
-		if (OCTEON_IS_MODEL(OCTEON_CN6XXX)) {
-			union cvmx_mio_fus_dat2 fus_2;
-			fus_2.u64 = cvmx_read_csr(CVMX_MIO_FUS_DAT2);
-			if (fus_2.s.nocrypto || fus_2.s.nomul) {
-				return 0;
-			} else if (!fus_2.s.dorm_crypto) {
-				return 1;
-			} else {
-				union cvmx_rnm_ctl_status st;
-				st.u64 = cvmx_read_csr(CVMX_RNM_CTL_STATUS);
-				return st.s.eer_val;
-			}
-		} else {
-			return !cvmx_fuse_read(90);
-		}
-
 	case OCTEON_FEATURE_DORM_CRYPTO:
 		if (OCTEON_IS_MODEL(OCTEON_CN6XXX)) {
 			union cvmx_mio_fus_dat2 fus_2;
@@ -188,29 +159,6 @@ static inline int octeon_has_feature(enum octeon_feature feature)
 			  && !OCTEON_IS_MODEL(OCTEON_CN56XX_PASS1_X)
 			  && !OCTEON_IS_MODEL(OCTEON_CN52XX_PASS1_X);
 
-	case OCTEON_FEATURE_DFA:
-		if (!OCTEON_IS_MODEL(OCTEON_CN38XX)
-		    && !OCTEON_IS_MODEL(OCTEON_CN31XX)
-		    && !OCTEON_IS_MODEL(OCTEON_CN58XX))
-			return 0;
-		else if (OCTEON_IS_MODEL(OCTEON_CN3020))
-			return 0;
-		else
-			return !cvmx_fuse_read(120);
-
-	case OCTEON_FEATURE_HFA:
-		if (!OCTEON_IS_MODEL(OCTEON_CN6XXX))
-			return 0;
-		else
-			return !cvmx_fuse_read(90);
-
-	case OCTEON_FEATURE_DFM:
-		if (!(OCTEON_IS_MODEL(OCTEON_CN63XX)
-		      || OCTEON_IS_MODEL(OCTEON_CN66XX)))
-			return 0;
-		else
-			return !cvmx_fuse_read(90);
-
 	case OCTEON_FEATURE_MDIO_CLAUSE_45:
 		return !(OCTEON_IS_MODEL(OCTEON_CN3XXX)
 			 || OCTEON_IS_MODEL(OCTEON_CN58XX)
-- 
2.1.0
