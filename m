Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Mar 2015 21:08:00 +0100 (CET)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:38337 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007561AbbCHUH6m5hNy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 Mar 2015 21:07:58 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 33B6F5A6E9B;
        Sun,  8 Mar 2015 22:07:48 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id McwLBNIoId7E; Sun,  8 Mar 2015 22:07:43 +0200 (EET)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 7334D5BC019;
        Sun,  8 Mar 2015 22:07:53 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 1/7] crypto: octeon - don't disable bottom half in octeon-md5
Date:   Sun,  8 Mar 2015 22:07:41 +0200
Message-Id: <1425845267-14413-2-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1425845267-14413-1-git-send-email-aaro.koskinen@iki.fi>
References: <1425845267-14413-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46269
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

Don't disable bottom half while the crypto engine is in use, as it
should be unnecessary: All kernel crypto engine usage is wrapped with
crypto engine state save/restore, so if we get interrupted by softirq
that uses crypto they should save and restore our context.

This actually fixes an issue when running OCTEON MD5 with interrupts
disabled (tcrypt mode=302). There's a WARNING because the module is
trying to enable the bottom half with irqs disabled:

[   52.656610] ------------[ cut here ]------------
[   52.661439] WARNING: CPU: 1 PID: 428 at /home/aaro/git/linux/kernel/softirq.c:150 __local_bh_enable_ip+0x9c/0xd8()
[   52.671780] Modules linked in: tcrypt(+)
[...]
[   52.763539] [<ffffffff8114082c>] warn_slowpath_common+0x94/0xd8
[   52.769465] [<ffffffff81144614>] __local_bh_enable_ip+0x9c/0xd8
[   52.775390] [<ffffffff81119574>] octeon_md5_final+0x12c/0x1e8
[   52.781144] [<ffffffff81337050>] shash_compat_digest+0xd0/0x1b0

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/crypto/octeon-md5.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/mips/cavium-octeon/crypto/octeon-md5.c b/arch/mips/cavium-octeon/crypto/octeon-md5.c
index b909881..3dd8845 100644
--- a/arch/mips/cavium-octeon/crypto/octeon-md5.c
+++ b/arch/mips/cavium-octeon/crypto/octeon-md5.c
@@ -97,7 +97,6 @@ static int octeon_md5_update(struct shash_desc *desc, const u8 *data,
 	memcpy((char *)mctx->block + (sizeof(mctx->block) - avail), data,
 	       avail);
 
-	local_bh_disable();
 	preempt_disable();
 	flags = octeon_crypto_enable(&state);
 	octeon_md5_store_hash(mctx);
@@ -115,7 +114,6 @@ static int octeon_md5_update(struct shash_desc *desc, const u8 *data,
 	octeon_md5_read_hash(mctx);
 	octeon_crypto_disable(&state, flags);
 	preempt_enable();
-	local_bh_enable();
 
 	memcpy(mctx->block, data, len);
 
@@ -133,7 +131,6 @@ static int octeon_md5_final(struct shash_desc *desc, u8 *out)
 
 	*p++ = 0x80;
 
-	local_bh_disable();
 	preempt_disable();
 	flags = octeon_crypto_enable(&state);
 	octeon_md5_store_hash(mctx);
@@ -153,7 +150,6 @@ static int octeon_md5_final(struct shash_desc *desc, u8 *out)
 	octeon_md5_read_hash(mctx);
 	octeon_crypto_disable(&state, flags);
 	preempt_enable();
-	local_bh_enable();
 
 	memcpy(out, mctx->hash, sizeof(mctx->hash));
 	memset(mctx, 0, sizeof(*mctx));
-- 
2.2.0
