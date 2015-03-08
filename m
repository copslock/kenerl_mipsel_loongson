Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Mar 2015 21:08:33 +0100 (CET)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:44114 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008384AbbCHUH6t7pQR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 Mar 2015 21:07:58 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id A30C156F909;
        Sun,  8 Mar 2015 22:07:58 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id 9YYoOar-Je+H; Sun,  8 Mar 2015 22:07:53 +0200 (EET)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id A6BE45BC01A;
        Sun,  8 Mar 2015 22:07:53 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 3/7] crypto: octeon - add instruction definitions for SHA1/256/512
Date:   Sun,  8 Mar 2015 22:07:43 +0200
Message-Id: <1425845267-14413-4-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1425845267-14413-1-git-send-email-aaro.koskinen@iki.fi>
References: <1425845267-14413-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46271
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

Add instruction definitions for SHA1/256/512.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/crypto/octeon-crypto.h | 83 ++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 4 deletions(-)

diff --git a/arch/mips/cavium-octeon/crypto/octeon-crypto.h b/arch/mips/cavium-octeon/crypto/octeon-crypto.h
index e2a4aec..3550725 100644
--- a/arch/mips/cavium-octeon/crypto/octeon-crypto.h
+++ b/arch/mips/cavium-octeon/crypto/octeon-crypto.h
@@ -5,7 +5,8 @@
  *
  * Copyright (C) 2012-2013 Cavium Inc., All Rights Reserved.
  *
- * MD5 instruction definitions added by Aaro Koskinen <aaro.koskinen@iki.fi>.
+ * MD5/SHA1/SHA256/SHA512 instruction definitions added by
+ * Aaro Koskinen <aaro.koskinen@iki.fi>.
  *
  */
 #ifndef __LINUX_OCTEON_CRYPTO_H
@@ -21,11 +22,11 @@ extern void octeon_crypto_disable(struct octeon_cop2_state *state,
 				  unsigned long flags);
 
 /*
- * Macros needed to implement MD5:
+ * Macros needed to implement MD5/SHA1/SHA256:
  */
 
 /*
- * The index can be 0-1.
+ * The index can be 0-1 (MD5) or 0-2 (SHA1), 0-3 (SHA256).
  */
 #define write_octeon_64bit_hash_dword(value, index)	\
 do {							\
@@ -36,7 +37,7 @@ do {							\
 } while (0)
 
 /*
- * The index can be 0-1.
+ * The index can be 0-1 (MD5) or 0-2 (SHA1), 0-3 (SHA256).
  */
 #define read_octeon_64bit_hash_dword(index)		\
 ({							\
@@ -72,4 +73,78 @@ do {							\
 	: [rt] "d" (value));				\
 } while (0)
 
+/*
+ * The value is the final block dword (64-bit).
+ */
+#define octeon_sha1_start(value)			\
+do {							\
+	__asm__ __volatile__ (				\
+	"dmtc2 %[rt],0x4057"				\
+	:						\
+	: [rt] "d" (value));				\
+} while (0)
+
+/*
+ * The value is the final block dword (64-bit).
+ */
+#define octeon_sha256_start(value)			\
+do {							\
+	__asm__ __volatile__ (				\
+	"dmtc2 %[rt],0x404f"				\
+	:						\
+	: [rt] "d" (value));				\
+} while (0)
+
+/*
+ * Macros needed to implement SHA512:
+ */
+
+/*
+ * The index can be 0-7.
+ */
+#define write_octeon_64bit_hash_sha512(value, index)	\
+do {							\
+	__asm__ __volatile__ (				\
+	"dmtc2 %[rt],0x0250+" STR(index)		\
+	:						\
+	: [rt] "d" (value));				\
+} while (0)
+
+/*
+ * The index can be 0-7.
+ */
+#define read_octeon_64bit_hash_sha512(index)		\
+({							\
+	u64 __value;					\
+							\
+	__asm__ __volatile__ (				\
+	"dmfc2 %[rt],0x0250+" STR(index)		\
+	: [rt] "=d" (__value)				\
+	: );						\
+							\
+	__value;					\
+})
+
+/*
+ * The index can be 0-14.
+ */
+#define write_octeon_64bit_block_sha512(value, index)	\
+do {							\
+	__asm__ __volatile__ (				\
+	"dmtc2 %[rt],0x0240+" STR(index)		\
+	:						\
+	: [rt] "d" (value));				\
+} while (0)
+
+/*
+ * The value is the final block word (64-bit).
+ */
+#define octeon_sha512_start(value)			\
+do {							\
+	__asm__ __volatile__ (				\
+	"dmtc2 %[rt],0x424f"				\
+	:						\
+	: [rt] "d" (value));				\
+} while (0)
+
 #endif /* __LINUX_OCTEON_CRYPTO_H */
-- 
2.2.0
