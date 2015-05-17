Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 May 2015 12:54:42 +0200 (CEST)
Received: from mail-wi0-f193.google.com ([209.85.212.193]:36406 "EHLO
        mail-wi0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012247AbbEQKy1Ol3tU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 May 2015 12:54:27 +0200
Received: by wivr20 with SMTP id r20so6119058wiv.3;
        Sun, 17 May 2015 03:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5qDfRGDt1cMHalYzVDRFk1sBh4F5KzbDoIJ4RgRBWXI=;
        b=hEZPbhT/cVCGE0f308t5VYiTrU1abLiSQJEmYKCLRClvjZnPeUl/N3lsOkqX2U4Oy0
         H5gE5Fx/1E7TumW4qo1xDCfetr8tmXG6fqQB1pbY0Qs35sYju20YDnrFJTBI+SBH1qGp
         45aEoy/ssw1Sv4VASEGh9uU6VvOCcMCHXzDHEEqBCjmZdDmTC+81FNaeJiWvCnCY49Cy
         XXn2RhQLjT4fDOkDiRDmLeBzasHPv2OZ0KpdWHUg6sDrr8BeyLmk96dF2j3qcv42R3fU
         0+ZerFivXWauQulGjWcwyITnhNOdXEM3sz8LXOA6BYSBRk7tg17Svz16Ms8YAR4f8Tr6
         AIig==
X-Received: by 10.180.78.65 with SMTP id z1mr12870258wiw.14.1431860064428;
        Sun, 17 May 2015 03:54:24 -0700 (PDT)
Received: from Red.local (ANice-651-1-428-5.w83-201.abo.wanadoo.fr. [83.201.252.5])
        by mx.google.com with ESMTPSA id ny7sm7070464wic.11.2015.05.17.03.54.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 May 2015 03:54:23 -0700 (PDT)
From:   LABBE Corentin <clabbe.montjoie@gmail.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ralf@linux-mips.org, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, aaro.koskinen@iki.fi
Cc:     linux-crypto@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org,
        LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: [PATCH 2/6] crypto: md5: use md5 IV MD5_HX instead of their raw value
Date:   Sun, 17 May 2015 12:54:13 +0200
Message-Id: <1431860057-5232-2-git-send-email-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.3.6
In-Reply-To: <1431860057-5232-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1431860057-5232-1-git-send-email-clabbe.montjoie@gmail.com>
Return-Path: <clabbe.montjoie@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47449
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
 crypto/md5.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/crypto/md5.c b/crypto/md5.c
index 36f5e5b..33d17e9 100644
--- a/crypto/md5.c
+++ b/crypto/md5.c
@@ -51,10 +51,10 @@ static int md5_init(struct shash_desc *desc)
 {
 	struct md5_state *mctx = shash_desc_ctx(desc);
 
-	mctx->hash[0] = 0x67452301;
-	mctx->hash[1] = 0xefcdab89;
-	mctx->hash[2] = 0x98badcfe;
-	mctx->hash[3] = 0x10325476;
+	mctx->hash[0] = MD5_H0;
+	mctx->hash[1] = MD5_H1;
+	mctx->hash[2] = MD5_H2;
+	mctx->hash[3] = MD5_H3;
 	mctx->byte_count = 0;
 
 	return 0;
-- 
2.3.6
