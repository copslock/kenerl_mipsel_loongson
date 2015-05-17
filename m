Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 May 2015 12:55:14 +0200 (CEST)
Received: from mail-wi0-f193.google.com ([209.85.212.193]:33230 "EHLO
        mail-wi0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012251AbbEQKya5nZtf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 May 2015 12:54:30 +0200
Received: by wivz2 with SMTP id z2so6122578wiv.0;
        Sun, 17 May 2015 03:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DbyAQ+Gd4OAzwd0xXL96MuoxuEmYmbmk7wSvl2mOO2M=;
        b=fGT0hJtAU+UPftnLUtKMTu81Tq+QUa9FvL7KzoNTE1NfFrhsvgByQ/PIWPSXe905T0
         QP/A4LITvqqOPGFXZvkH2UliFXZoGzTEhbORDKksqixv21QRcQ9zKEe1SFQqB1a40CV9
         ducd11T3sfVJZtYT0pWyE6bjDfGMMKvi35naj41bX3qOarvdfNSNkCLdW23v9h/9GHiS
         nlefG4Hgpqdzmgj2rLTISkkqe8JR27qbQm+TLoY6i4aDY7PNMTQv4HomaFmquYV2XyxR
         D/Aye8I1o/70N7iYMtVUpvqxthNt4xeIpKzYAuGxw2OeaseNjIrRtrpEeG4Wt7V2yzR+
         4Hyw==
X-Received: by 10.194.178.201 with SMTP id da9mr9815318wjc.139.1431860068164;
        Sun, 17 May 2015 03:54:28 -0700 (PDT)
Received: from Red.local (ANice-651-1-428-5.w83-201.abo.wanadoo.fr. [83.201.252.5])
        by mx.google.com with ESMTPSA id ny7sm7070464wic.11.2015.05.17.03.54.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 May 2015 03:54:27 -0700 (PDT)
From:   LABBE Corentin <clabbe.montjoie@gmail.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ralf@linux-mips.org, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, aaro.koskinen@iki.fi
Cc:     linux-crypto@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org,
        LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: [PATCH 4/6] crypto: sparc/md5: use md5 IV MD5_HX instead of their raw value
Date:   Sun, 17 May 2015 12:54:15 +0200
Message-Id: <1431860057-5232-4-git-send-email-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.3.6
In-Reply-To: <1431860057-5232-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1431860057-5232-1-git-send-email-clabbe.montjoie@gmail.com>
Return-Path: <clabbe.montjoie@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47451
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
 arch/sparc/crypto/md5_glue.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/crypto/md5_glue.c b/arch/sparc/crypto/md5_glue.c
index b688731..c9d2b92 100644
--- a/arch/sparc/crypto/md5_glue.c
+++ b/arch/sparc/crypto/md5_glue.c
@@ -33,10 +33,10 @@ static int md5_sparc64_init(struct shash_desc *desc)
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
