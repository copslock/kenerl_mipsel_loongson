Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Mar 2015 21:08:49 +0100 (CET)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:38343 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008393AbbCHUIATh6lz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 Mar 2015 21:08:00 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 017225A6EA1;
        Sun,  8 Mar 2015 22:07:49 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id j8IPr7SVJiJw; Sun,  8 Mar 2015 22:07:44 +0200 (EET)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 3C32B5BC015;
        Sun,  8 Mar 2015 22:07:54 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 7/7] crypto: octeon - enable OCTEON SHA1/256/512 module selection
Date:   Sun,  8 Mar 2015 22:07:47 +0200
Message-Id: <1425845267-14413-8-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1425845267-14413-1-git-send-email-aaro.koskinen@iki.fi>
References: <1425845267-14413-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46272
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

Enable user to select OCTEON SHA1/256/512 modules.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 crypto/Kconfig | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 50f4da4..38b2315 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -546,6 +546,15 @@ config CRYPTO_SHA512_SSSE3
 	  Extensions version 1 (AVX1), or Advanced Vector Extensions
 	  version 2 (AVX2) instructions, when available.
 
+config CRYPTO_SHA1_OCTEON
+	tristate "SHA1 digest algorithm (OCTEON)"
+	depends on CPU_CAVIUM_OCTEON
+	select CRYPTO_SHA1
+	select CRYPTO_HASH
+	help
+	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2) implemented
+	  using OCTEON crypto instructions, when available.
+
 config CRYPTO_SHA1_SPARC64
 	tristate "SHA1 digest algorithm (SPARC64)"
 	depends on SPARC64
@@ -610,6 +619,15 @@ config CRYPTO_SHA256
 	  This code also includes SHA-224, a 224 bit hash with 112 bits
 	  of security against collision attacks.
 
+config CRYPTO_SHA256_OCTEON
+	tristate "SHA224 and SHA256 digest algorithm (OCTEON)"
+	depends on CPU_CAVIUM_OCTEON
+	select CRYPTO_SHA256
+	select CRYPTO_HASH
+	help
+	  SHA-256 secure hash standard (DFIPS 180-2) implemented
+	  using OCTEON crypto instructions, when available.
+
 config CRYPTO_SHA256_SPARC64
 	tristate "SHA224 and SHA256 digest algorithm (SPARC64)"
 	depends on SPARC64
@@ -631,6 +649,15 @@ config CRYPTO_SHA512
 	  This code also includes SHA-384, a 384 bit hash with 192 bits
 	  of security against collision attacks.
 
+config CRYPTO_SHA512_OCTEON
+	tristate "SHA384 and SHA512 digest algorithms (OCTEON)"
+	depends on CPU_CAVIUM_OCTEON
+	select CRYPTO_SHA512
+	select CRYPTO_HASH
+	help
+	  SHA-512 secure hash standard (DFIPS 180-2) implemented
+	  using OCTEON crypto instructions, when available.
+
 config CRYPTO_SHA512_SPARC64
 	tristate "SHA384 and SHA512 digest algorithm (SPARC64)"
 	depends on SPARC64
-- 
2.2.0
