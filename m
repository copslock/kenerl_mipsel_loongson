Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 May 2015 12:55:49 +0200 (CEST)
Received: from mail-wg0-f54.google.com ([74.125.82.54]:33773 "EHLO
        mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012285AbbEQKyeOhImz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 May 2015 12:54:34 +0200
Received: by wgin8 with SMTP id n8so158763502wgi.0;
        Sun, 17 May 2015 03:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ADERWW2OgQdlR+b4ecYsSUMbq2ZXZhDHTF5uwKoEOWM=;
        b=wz2H5J+/bz1la1FOQDul1i3RC6w1CJxw1tzX6TRlcKjsl6xPGsWnX0w7ee+N7kpfjx
         2TqtCKbkjCGpCx03zi83oAYvfOW/qmTL2yZCdFtJ3J7P/ib7MCblRypYKaN1SGzUJgqu
         OMtHn1sfjvFTKJSrEsvEKcH/tcXSL82GtSYZumZo95ONmwS8MV15lmY8M7+y9B88hkWq
         5ozyUcoIxl9t7mL6dkJz6uS5O/Lw61WA72l2DRN7r7EJTegnGQVD2ZGeDs6Kz5gqC8zN
         mzf+EUAMy1YnyL1fcAhsS4tKtSeWRWmecG8nUskVsuMrOicaR5S7ZslTrShrMuynzDhe
         D9UA==
X-Received: by 10.180.91.107 with SMTP id cd11mr12316035wib.51.1431860071468;
        Sun, 17 May 2015 03:54:31 -0700 (PDT)
Received: from Red.local (ANice-651-1-428-5.w83-201.abo.wanadoo.fr. [83.201.252.5])
        by mx.google.com with ESMTPSA id ny7sm7070464wic.11.2015.05.17.03.54.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 May 2015 03:54:30 -0700 (PDT)
From:   LABBE Corentin <clabbe.montjoie@gmail.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ralf@linux-mips.org, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, aaro.koskinen@iki.fi
Cc:     linux-crypto@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org,
        LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: [PATCH 6/6] crypto: octeon: use md5 IV MD5_HX instead of their raw value
Date:   Sun, 17 May 2015 12:54:17 +0200
Message-Id: <1431860057-5232-6-git-send-email-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.3.6
In-Reply-To: <1431860057-5232-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1431860057-5232-1-git-send-email-clabbe.montjoie@gmail.com>
Return-Path: <clabbe.montjoie@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clabbe.montjoie@gmail.com
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

Since MD5 IV are now available in crypto/md5.h, use them.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 arch/mips/cavium-octeon/crypto/octeon-md5.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/cavium-octeon/crypto/octeon-md5.c b/arch/mips/cavium-octeon/crypto/octeon-md5.c
index 12dccdb..af4c712 100644
--- a/arch/mips/cavium-octeon/crypto/octeon-md5.c
+++ b/arch/mips/cavium-octeon/crypto/octeon-md5.c
@@ -69,10 +69,10 @@ static int octeon_md5_init(struct shash_desc *desc)
 {
 	struct md5_state *mctx = shash_desc_ctx(desc);
 
-	mctx->hash[0] = cpu_to_le32(0x67452301);
-	mctx->hash[1] = cpu_to_le32(0xefcdab89);
-	mctx->hash[2] = cpu_to_le32(0x98badcfe);
-	mctx->hash[3] = cpu_to_le32(0x10325476);
+	mctx->hash[0] = cpu_to_le32(MD5_H0);
+	mctx->hash[1] = cpu_to_le32(MD5_H1);
+	mctx->hash[2] = cpu_to_le32(MD5_H2);
+	mctx->hash[3] = cpu_to_le32(MD5_H3);
 	mctx->byte_count = 0;
 
 	return 0;
-- 
2.3.6
