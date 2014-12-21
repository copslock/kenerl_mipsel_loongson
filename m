Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Dec 2014 21:55:08 +0100 (CET)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:43336 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009464AbaLUUyP6JQhM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Dec 2014 21:54:15 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id 69FF119BD1B;
        Sun, 21 Dec 2014 22:54:14 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id pD3cRILrylFA; Sun, 21 Dec 2014 22:54:07 +0200 (EET)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with ESMTP id C40C45BC00B;
        Sun, 21 Dec 2014 22:54:07 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        linux-crypto@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 3/5] MIPS: OCTEON: reintroduce crypto features check
Date:   Sun, 21 Dec 2014 22:54:00 +0200
Message-Id: <1419195242-546-4-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1419195242-546-1-git-send-email-aaro.koskinen@iki.fi>
References: <1419195242-546-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Reintroduce run-time check for crypto features. The old one was deleted
because it was unreliable, now decide the crypto availability on early
boot when the model string is constructed.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/executive/octeon-model.c |  6 ++++++
 arch/mips/include/asm/octeon/octeon-feature.h    | 17 +++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/octeon-model.c b/arch/mips/cavium-octeon/executive/octeon-model.c
index e15b049..b2104bd 100644
--- a/arch/mips/cavium-octeon/executive/octeon-model.c
+++ b/arch/mips/cavium-octeon/executive/octeon-model.c
@@ -27,6 +27,9 @@
 
 #include <asm/octeon/octeon.h>
 
+enum octeon_feature_bits __octeon_feature_bits __read_mostly;
+EXPORT_SYMBOL_GPL(__octeon_feature_bits);
+
 /**
  * Read a byte of fuse data
  * @byte_addr:	 address to read
@@ -103,6 +106,9 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 	else
 		suffix = "NSP";
 
+	if (!fus_dat2.s.nocrypto)
+		__octeon_feature_bits |= OCTEON_HAS_CRYPTO;
+
 	/*
 	 * Assume pass number is encoded using <5:3><2:0>. Exceptions
 	 * will be fixed later.
diff --git a/arch/mips/include/asm/octeon/octeon-feature.h b/arch/mips/include/asm/octeon/octeon-feature.h
index c4fe81f..8ebd3f57 100644
--- a/arch/mips/include/asm/octeon/octeon-feature.h
+++ b/arch/mips/include/asm/octeon/octeon-feature.h
@@ -46,8 +46,6 @@ enum octeon_feature {
 	OCTEON_FEATURE_SAAD,
 	/* Does this Octeon support the ZIP offload engine? */
 	OCTEON_FEATURE_ZIP,
-	/* Does this Octeon support crypto acceleration using COP2? */
-	OCTEON_FEATURE_CRYPTO,
 	OCTEON_FEATURE_DORM_CRYPTO,
 	/* Does this Octeon support PCI express? */
 	OCTEON_FEATURE_PCIE,
@@ -86,6 +84,21 @@ enum octeon_feature {
 	OCTEON_MAX_FEATURE
 };
 
+enum octeon_feature_bits {
+	OCTEON_HAS_CRYPTO = 0x0001,	/* Crypto acceleration using COP2 */
+};
+extern enum octeon_feature_bits __octeon_feature_bits;
+
+/**
+ * octeon_has_crypto() - Check if this OCTEON has crypto acceleration support.
+ *
+ * Returns: Non-zero if the feature exists. Zero if the feature does not exist.
+ */
+static inline int octeon_has_crypto(void)
+{
+	return __octeon_feature_bits & OCTEON_HAS_CRYPTO;
+}
+
 /**
  * Determine if the current Octeon supports a specific feature. These
  * checks have been optimized to be fairly quick, but they should still
-- 
2.2.0
