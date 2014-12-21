Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Dec 2014 21:54:49 +0100 (CET)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:56009 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009458AbaLUUyPYdv7p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Dec 2014 21:54:15 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 4B60556F405;
        Sun, 21 Dec 2014 22:54:14 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id iJYsXxKP+g0a; Sun, 21 Dec 2014 22:54:07 +0200 (EET)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with ESMTP id A60CA5BC00A;
        Sun, 21 Dec 2014 22:54:07 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        linux-crypto@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 2/5] MIPS: OCTEON: crypto: add instruction definitions for MD5
Date:   Sun, 21 Dec 2014 22:53:59 +0200
Message-Id: <1419195242-546-3-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1419195242-546-1-git-send-email-aaro.koskinen@iki.fi>
References: <1419195242-546-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44881
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

Add instruction definitions for MD5. Based on information extracted
from EdgeRouter Pro GPL source tarball.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/crypto/octeon-crypto.h | 56 ++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/mips/cavium-octeon/crypto/octeon-crypto.h b/arch/mips/cavium-octeon/crypto/octeon-crypto.h
index 5ca86d4..3f65bc6 100644
--- a/arch/mips/cavium-octeon/crypto/octeon-crypto.h
+++ b/arch/mips/cavium-octeon/crypto/octeon-crypto.h
@@ -4,14 +4,70 @@
  * for more details.
  *
  * Copyright (C) 2012-2013 Cavium Inc., All Rights Reserved.
+ *
+ * MD5 instruction definitions added by Aaro Koskinen <aaro.koskinen@iki.fi>.
+ *
  */
 #ifndef __LINUX_OCTEON_CRYPTO_H
 #define __LINUX_OCTEON_CRYPTO_H
 
 #include <linux/sched.h>
+#include <asm/mipsregs.h>
 
 extern unsigned long octeon_crypto_enable(struct octeon_cop2_state *state);
 extern void octeon_crypto_disable(struct octeon_cop2_state *state,
 				  unsigned long flags);
 
+/*
+ * Macros needed to implement MD5:
+ */
+
+/*
+ * The index can be 0-1.
+ */
+#define write_octeon_64bit_hash_dword(value, index)	\
+do {							\
+	__asm__ __volatile__ (				\
+	"dmtc2 %[rt],0x0048+" STR(index)		\
+	:						\
+	: [rt] "d" (value));				\
+} while (0)
+
+/*
+ * The index can be 0-1.
+ */
+#define read_octeon_64bit_hash_dword(index)		\
+({							\
+	u64 __value;					\
+							\
+	__asm__ __volatile__ (				\
+	"dmfc2 %[rt],0x0048+" STR(index)		\
+	: [rt] "=d" (__value)				\
+	: );						\
+							\
+	__value;					\
+})
+
+/*
+ * The index can be 0-6.
+ */
+#define write_octeon_64bit_block_dword(value, index)	\
+do {							\
+	__asm__ __volatile__ (				\
+	"dmtc2 %[rt],0x0040+" STR(index)		\
+	:						\
+	: [rt] "d" (value));				\
+} while (0)
+
+/*
+ * The value is the final block dword (64-bit).
+ */
+#define octeon_md5_start(value)				\
+do {							\
+	__asm__ __volatile__ (				\
+	"dmtc2 %[rt],0x4047"				\
+	:						\
+	: [rt] "d" (value));				\
+} while (0)
+
 #endif /* __LINUX_OCTEON_CRYPTO_H */
-- 
2.2.0
