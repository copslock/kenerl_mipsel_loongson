Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 May 2015 12:54:26 +0200 (CEST)
Received: from mail-wg0-f65.google.com ([74.125.82.65]:33675 "EHLO
        mail-wg0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012039AbbEQKyZWG2L2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 May 2015 12:54:25 +0200
Received: by wggy19 with SMTP id y19so13340491wgg.0;
        Sun, 17 May 2015 03:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=rTl5MwHIFntAo0yK2v942mcwbA/7MQeJi9lsxqT0zPw=;
        b=dys2vYyy38jnMzlpsFr7cVfh7hqTVJrzY0KWQPg5l76wVW+d0pXp2n15ClYUgYVpzf
         hxnfcggeCDnV4WeURGCHemmblVvcLC4k35FF0Go+yxs6peXamR58AGPpWuiMQkxDxS3O
         /Mn0oSijKR5GhPXV80XYSmkPDgNjYJtlBcNp8ObJ6NKTlFuR1PUbQKUSsPvT9zjDcYHF
         TSRxu1gg6lJLe/Iii8YAdUou5KwXq/KYJMVhlP1gUunnHUcux++lXAKaY4yspK0l3zWw
         jaSOcy39+CyLB9H/UNkNmABFWSlyMk5RfNIMELZZLH7U35fBbtM1MsJUaTurQR8dHBCw
         1JnA==
X-Received: by 10.181.11.193 with SMTP id ek1mr12737544wid.15.1431860062561;
        Sun, 17 May 2015 03:54:22 -0700 (PDT)
Received: from Red.local (ANice-651-1-428-5.w83-201.abo.wanadoo.fr. [83.201.252.5])
        by mx.google.com with ESMTPSA id ny7sm7070464wic.11.2015.05.17.03.54.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 May 2015 03:54:21 -0700 (PDT)
From:   LABBE Corentin <clabbe.montjoie@gmail.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ralf@linux-mips.org, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, aaro.koskinen@iki.fi
Cc:     linux-crypto@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org,
        LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: [PATCH 1/6] crypto: md5: add MD5 initial vectors
Date:   Sun, 17 May 2015 12:54:12 +0200
Message-Id: <1431860057-5232-1-git-send-email-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.3.6
Return-Path: <clabbe.montjoie@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47448
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

This patch simply adds the MD5 IV in the md5 header.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 include/crypto/md5.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/crypto/md5.h b/include/crypto/md5.h
index 65f299b..146af82 100644
--- a/include/crypto/md5.h
+++ b/include/crypto/md5.h
@@ -8,6 +8,11 @@
 #define MD5_BLOCK_WORDS		16
 #define MD5_HASH_WORDS		4
 
+#define MD5_H0	0x67452301UL
+#define MD5_H1	0xefcdab89UL
+#define MD5_H2	0x98badcfeUL
+#define MD5_H3	0x10325476UL
+
 struct md5_state {
 	u32 hash[MD5_HASH_WORDS];
 	u32 block[MD5_BLOCK_WORDS];
-- 
2.3.6
