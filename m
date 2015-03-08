Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Mar 2015 21:09:25 +0100 (CET)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:33439 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008396AbbCHUIAjvEqo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 Mar 2015 21:08:00 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 87D1121B77C;
        Sun,  8 Mar 2015 22:07:58 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id 6uujFmvJNfR1; Sun,  8 Mar 2015 22:07:53 +0200 (EET)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 8DDD45BC011;
        Sun,  8 Mar 2015 22:07:53 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 2/7] crypto: octeon - always disable preemption when using crypto engine
Date:   Sun,  8 Mar 2015 22:07:42 +0200
Message-Id: <1425845267-14413-3-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1425845267-14413-1-git-send-email-aaro.koskinen@iki.fi>
References: <1425845267-14413-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46274
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

Always disable preemption on behalf of the drivers when crypto engine
is taken into use. This will simplify the usage.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/crypto/octeon-crypto.c | 4 +++-
 arch/mips/cavium-octeon/crypto/octeon-md5.c    | 4 ----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/mips/cavium-octeon/crypto/octeon-crypto.c b/arch/mips/cavium-octeon/crypto/octeon-crypto.c
index 7c82ff4..f66bd1a 100644
--- a/arch/mips/cavium-octeon/crypto/octeon-crypto.c
+++ b/arch/mips/cavium-octeon/crypto/octeon-crypto.c
@@ -17,7 +17,7 @@
  * crypto operations in calls to octeon_crypto_enable/disable in order to make
  * sure the state of COP2 isn't corrupted if userspace is also performing
  * hardware crypto operations. Allocate the state parameter on the stack.
- * Preemption must be disabled to prevent context switches.
+ * Returns with preemption disabled.
  *
  * @state: Pointer to state structure to store current COP2 state in.
  *
@@ -28,6 +28,7 @@ unsigned long octeon_crypto_enable(struct octeon_cop2_state *state)
 	int status;
 	unsigned long flags;
 
+	preempt_disable();
 	local_irq_save(flags);
 	status = read_c0_status();
 	write_c0_status(status | ST0_CU2);
@@ -62,5 +63,6 @@ void octeon_crypto_disable(struct octeon_cop2_state *state,
 	else
 		write_c0_status(read_c0_status() & ~ST0_CU2);
 	local_irq_restore(flags);
+	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(octeon_crypto_disable);
diff --git a/arch/mips/cavium-octeon/crypto/octeon-md5.c b/arch/mips/cavium-octeon/crypto/octeon-md5.c
index 3dd8845..12dccdb 100644
--- a/arch/mips/cavium-octeon/crypto/octeon-md5.c
+++ b/arch/mips/cavium-octeon/crypto/octeon-md5.c
@@ -97,7 +97,6 @@ static int octeon_md5_update(struct shash_desc *desc, const u8 *data,
 	memcpy((char *)mctx->block + (sizeof(mctx->block) - avail), data,
 	       avail);
 
-	preempt_disable();
 	flags = octeon_crypto_enable(&state);
 	octeon_md5_store_hash(mctx);
 
@@ -113,7 +112,6 @@ static int octeon_md5_update(struct shash_desc *desc, const u8 *data,
 
 	octeon_md5_read_hash(mctx);
 	octeon_crypto_disable(&state, flags);
-	preempt_enable();
 
 	memcpy(mctx->block, data, len);
 
@@ -131,7 +129,6 @@ static int octeon_md5_final(struct shash_desc *desc, u8 *out)
 
 	*p++ = 0x80;
 
-	preempt_disable();
 	flags = octeon_crypto_enable(&state);
 	octeon_md5_store_hash(mctx);
 
@@ -149,7 +146,6 @@ static int octeon_md5_final(struct shash_desc *desc, u8 *out)
 
 	octeon_md5_read_hash(mctx);
 	octeon_crypto_disable(&state, flags);
-	preempt_enable();
 
 	memcpy(out, mctx->hash, sizeof(mctx->hash));
 	memset(mctx, 0, sizeof(*mctx));
-- 
2.2.0
