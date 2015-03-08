Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Mar 2015 21:09:41 +0100 (CET)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:33439 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008398AbbCHUICeIeZe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 Mar 2015 21:08:02 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id C670C21B7B4;
        Sun,  8 Mar 2015 22:07:58 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id KMWvVJDA5wQz; Sun,  8 Mar 2015 22:07:53 +0200 (EET)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id C1F6A5BC01B;
        Sun,  8 Mar 2015 22:07:53 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 4/7] crypto: octeon - add SHA1 module
Date:   Sun,  8 Mar 2015 22:07:44 +0200
Message-Id: <1425845267-14413-5-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1425845267-14413-1-git-send-email-aaro.koskinen@iki.fi>
References: <1425845267-14413-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46275
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

Add OCTEON SHA1 module.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/crypto/Makefile      |   3 +-
 arch/mips/cavium-octeon/crypto/octeon-sha1.c | 241 +++++++++++++++++++++++++++
 2 files changed, 243 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/cavium-octeon/crypto/octeon-sha1.c

diff --git a/arch/mips/cavium-octeon/crypto/Makefile b/arch/mips/cavium-octeon/crypto/Makefile
index a74f76d..3f671d6 100644
--- a/arch/mips/cavium-octeon/crypto/Makefile
+++ b/arch/mips/cavium-octeon/crypto/Makefile
@@ -4,4 +4,5 @@
 
 obj-y += octeon-crypto.o
 
-obj-$(CONFIG_CRYPTO_MD5_OCTEON) += octeon-md5.o
+obj-$(CONFIG_CRYPTO_MD5_OCTEON)		+= octeon-md5.o
+obj-$(CONFIG_CRYPTO_SHA1_OCTEON)	+= octeon-sha1.o
diff --git a/arch/mips/cavium-octeon/crypto/octeon-sha1.c b/arch/mips/cavium-octeon/crypto/octeon-sha1.c
new file mode 100644
index 0000000..2b74b5b
--- /dev/null
+++ b/arch/mips/cavium-octeon/crypto/octeon-sha1.c
@@ -0,0 +1,241 @@
+/*
+ * Cryptographic API.
+ *
+ * SHA1 Secure Hash Algorithm.
+ *
+ * Adapted for OCTEON by Aaro Koskinen <aaro.koskinen@iki.fi>.
+ *
+ * Based on crypto/sha1_generic.c, which is:
+ *
+ * Copyright (c) Alan Smithee.
+ * Copyright (c) Andrew McDonald <andrew@mcdonald.org.uk>
+ * Copyright (c) Jean-Francois Dive <jef@linuxbe.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include <linux/mm.h>
+#include <crypto/sha.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <asm/byteorder.h>
+#include <asm/octeon/octeon.h>
+#include <crypto/internal/hash.h>
+
+#include "octeon-crypto.h"
+
+/*
+ * We pass everything as 64-bit. OCTEON can handle misaligned data.
+ */
+
+static void octeon_sha1_store_hash(struct sha1_state *sctx)
+{
+	u64 *hash = (u64 *)sctx->state;
+	union {
+		u32 word[2];
+		u64 dword;
+	} hash_tail = { { sctx->state[4], } };
+
+	write_octeon_64bit_hash_dword(hash[0], 0);
+	write_octeon_64bit_hash_dword(hash[1], 1);
+	write_octeon_64bit_hash_dword(hash_tail.dword, 2);
+	memzero_explicit(&hash_tail.word[0], sizeof(hash_tail.word[0]));
+}
+
+static void octeon_sha1_read_hash(struct sha1_state *sctx)
+{
+	u64 *hash = (u64 *)sctx->state;
+	union {
+		u32 word[2];
+		u64 dword;
+	} hash_tail;
+
+	hash[0]		= read_octeon_64bit_hash_dword(0);
+	hash[1]		= read_octeon_64bit_hash_dword(1);
+	hash_tail.dword	= read_octeon_64bit_hash_dword(2);
+	sctx->state[4]	= hash_tail.word[0];
+	memzero_explicit(&hash_tail.dword, sizeof(hash_tail.dword));
+}
+
+static void octeon_sha1_transform(const void *_block)
+{
+	const u64 *block = _block;
+
+	write_octeon_64bit_block_dword(block[0], 0);
+	write_octeon_64bit_block_dword(block[1], 1);
+	write_octeon_64bit_block_dword(block[2], 2);
+	write_octeon_64bit_block_dword(block[3], 3);
+	write_octeon_64bit_block_dword(block[4], 4);
+	write_octeon_64bit_block_dword(block[5], 5);
+	write_octeon_64bit_block_dword(block[6], 6);
+	octeon_sha1_start(block[7]);
+}
+
+static int octeon_sha1_init(struct shash_desc *desc)
+{
+	struct sha1_state *sctx = shash_desc_ctx(desc);
+
+	sctx->state[0] = SHA1_H0;
+	sctx->state[1] = SHA1_H1;
+	sctx->state[2] = SHA1_H2;
+	sctx->state[3] = SHA1_H3;
+	sctx->state[4] = SHA1_H4;
+	sctx->count = 0;
+
+	return 0;
+}
+
+static void __octeon_sha1_update(struct sha1_state *sctx, const u8 *data,
+				 unsigned int len)
+{
+	unsigned int partial;
+	unsigned int done;
+	const u8 *src;
+
+	partial = sctx->count % SHA1_BLOCK_SIZE;
+	sctx->count += len;
+	done = 0;
+	src = data;
+
+	if ((partial + len) >= SHA1_BLOCK_SIZE) {
+		if (partial) {
+			done = -partial;
+			memcpy(sctx->buffer + partial, data,
+			       done + SHA1_BLOCK_SIZE);
+			src = sctx->buffer;
+		}
+
+		do {
+			octeon_sha1_transform(src);
+			done += SHA1_BLOCK_SIZE;
+			src = data + done;
+		} while (done + SHA1_BLOCK_SIZE <= len);
+
+		partial = 0;
+	}
+	memcpy(sctx->buffer + partial, src, len - done);
+}
+
+static int octeon_sha1_update(struct shash_desc *desc, const u8 *data,
+			unsigned int len)
+{
+	struct sha1_state *sctx = shash_desc_ctx(desc);
+	struct octeon_cop2_state state;
+	unsigned long flags;
+
+	/*
+	 * Small updates never reach the crypto engine, so the generic sha1 is
+	 * faster because of the heavyweight octeon_crypto_enable() /
+	 * octeon_crypto_disable().
+	 */
+	if ((sctx->count % SHA1_BLOCK_SIZE) + len < SHA1_BLOCK_SIZE)
+		return crypto_sha1_update(desc, data, len);
+
+	flags = octeon_crypto_enable(&state);
+	octeon_sha1_store_hash(sctx);
+
+	__octeon_sha1_update(sctx, data, len);
+
+	octeon_sha1_read_hash(sctx);
+	octeon_crypto_disable(&state, flags);
+
+	return 0;
+}
+
+static int octeon_sha1_final(struct shash_desc *desc, u8 *out)
+{
+	struct sha1_state *sctx = shash_desc_ctx(desc);
+	static const u8 padding[64] = { 0x80, };
+	struct octeon_cop2_state state;
+	__be32 *dst = (__be32 *)out;
+	unsigned int pad_len;
+	unsigned long flags;
+	unsigned int index;
+	__be64 bits;
+	int i;
+
+	/* Save number of bits. */
+	bits = cpu_to_be64(sctx->count << 3);
+
+	/* Pad out to 56 mod 64. */
+	index = sctx->count & 0x3f;
+	pad_len = (index < 56) ? (56 - index) : ((64+56) - index);
+
+	flags = octeon_crypto_enable(&state);
+	octeon_sha1_store_hash(sctx);
+
+	__octeon_sha1_update(sctx, padding, pad_len);
+
+	/* Append length (before padding). */
+	__octeon_sha1_update(sctx, (const u8 *)&bits, sizeof(bits));
+
+	octeon_sha1_read_hash(sctx);
+	octeon_crypto_disable(&state, flags);
+
+	/* Store state in digest */
+	for (i = 0; i < 5; i++)
+		dst[i] = cpu_to_be32(sctx->state[i]);
+
+	/* Zeroize sensitive information. */
+	memset(sctx, 0, sizeof(*sctx));
+
+	return 0;
+}
+
+static int octeon_sha1_export(struct shash_desc *desc, void *out)
+{
+	struct sha1_state *sctx = shash_desc_ctx(desc);
+
+	memcpy(out, sctx, sizeof(*sctx));
+	return 0;
+}
+
+static int octeon_sha1_import(struct shash_desc *desc, const void *in)
+{
+	struct sha1_state *sctx = shash_desc_ctx(desc);
+
+	memcpy(sctx, in, sizeof(*sctx));
+	return 0;
+}
+
+static struct shash_alg octeon_sha1_alg = {
+	.digestsize	=	SHA1_DIGEST_SIZE,
+	.init		=	octeon_sha1_init,
+	.update		=	octeon_sha1_update,
+	.final		=	octeon_sha1_final,
+	.export		=	octeon_sha1_export,
+	.import		=	octeon_sha1_import,
+	.descsize	=	sizeof(struct sha1_state),
+	.statesize	=	sizeof(struct sha1_state),
+	.base		=	{
+		.cra_name	=	"sha1",
+		.cra_driver_name=	"octeon-sha1",
+		.cra_priority	=	OCTEON_CR_OPCODE_PRIORITY,
+		.cra_flags	=	CRYPTO_ALG_TYPE_SHASH,
+		.cra_blocksize	=	SHA1_BLOCK_SIZE,
+		.cra_module	=	THIS_MODULE,
+	}
+};
+
+static int __init octeon_sha1_mod_init(void)
+{
+	if (!octeon_has_crypto())
+		return -ENOTSUPP;
+	return crypto_register_shash(&octeon_sha1_alg);
+}
+
+static void __exit octeon_sha1_mod_fini(void)
+{
+	crypto_unregister_shash(&octeon_sha1_alg);
+}
+
+module_init(octeon_sha1_mod_init);
+module_exit(octeon_sha1_mod_fini);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SHA1 Secure Hash Algorithm (OCTEON)");
+MODULE_AUTHOR("Aaro Koskinen <aaro.koskinen@iki.fi>");
-- 
2.2.0
