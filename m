Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 May 2015 12:54:58 +0200 (CEST)
Received: from mail-wi0-f195.google.com ([209.85.212.195]:36432 "EHLO
        mail-wi0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012249AbbEQKy3Le9SN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 May 2015 12:54:29 +0200
Received: by wivr20 with SMTP id r20so6119236wiv.3;
        Sun, 17 May 2015 03:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=olktZ4TGFQ8M7C3uTu2Fr0ZGeHumtZr1flCOmmbaqOQ=;
        b=NLqHlGjio8evoFgX3v+Vcl8Hk8dY7/SOc9GNzN8T5n9SWlgODOzycIaY+FcVncmKaT
         srv0K/dVYGf9YwXTknrMeKqgqxEf6dPh7+lnrnVG6TFamvU/MfHwcX+7BYQdPRFP4VaA
         VK2fs+WdvgaLuE7qk+ptGgBw/xDuaxToYBjlesPjcwtxbApW1iIwPPQYi9UsjPCdvWRE
         zhT7bZbVpyaV7IFWZySUj9htQgx556y5kH9CY/JEklxxiiXT/EOFfXecKJ8X2xvlZIPN
         wnT04Pw0aSfFHszXGktKO7jaf9gvS+f//uTklmU4z+X5lalsBzFYe53q/zN/mE6FstLF
         yqUA==
X-Received: by 10.180.96.200 with SMTP id du8mr13113653wib.54.1431860066442;
        Sun, 17 May 2015 03:54:26 -0700 (PDT)
Received: from Red.local (ANice-651-1-428-5.w83-201.abo.wanadoo.fr. [83.201.252.5])
        by mx.google.com with ESMTPSA id ny7sm7070464wic.11.2015.05.17.03.54.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 May 2015 03:54:25 -0700 (PDT)
From:   LABBE Corentin <clabbe.montjoie@gmail.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ralf@linux-mips.org, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, aaro.koskinen@iki.fi
Cc:     linux-crypto@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org,
        LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: [PATCH 3/6] crypto: powerpc/md5: use md5 IV MD5_HX instead of their raw value
Date:   Sun, 17 May 2015 12:54:14 +0200
Message-Id: <1431860057-5232-3-git-send-email-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.3.6
In-Reply-To: <1431860057-5232-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1431860057-5232-1-git-send-email-clabbe.montjoie@gmail.com>
Return-Path: <clabbe.montjoie@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47450
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
 arch/powerpc/crypto/md5-glue.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/crypto/md5-glue.c b/arch/powerpc/crypto/md5-glue.c
index 452fb4d..9228967 100644
--- a/arch/powerpc/crypto/md5-glue.c
+++ b/arch/powerpc/crypto/md5-glue.c
@@ -37,10 +37,10 @@ static int ppc_md5_init(struct shash_desc *desc)
 {
 	struct md5_state *sctx = shash_desc_ctx(desc);
 
-	sctx->hash[0] = 0x67452301;
-	sctx->hash[1] = 0xefcdab89;
-	sctx->hash[2] = 0x98badcfe;
-	sctx->hash[3] =	0x10325476;
+	sctx->hash[0] = MD5_H0;
+	sctx->hash[1] = MD5_H1;
+	sctx->hash[2] = MD5_H2;
+	sctx->hash[3] =	MD5_H3;
 	sctx->byte_count = 0;
 
 	return 0;
-- 
2.3.6
