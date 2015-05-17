Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 May 2015 12:55:33 +0200 (CEST)
Received: from mail-wg0-f48.google.com ([74.125.82.48]:34307 "EHLO
        mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012256AbbEQKycdPQkT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 May 2015 12:54:32 +0200
Received: by wguv19 with SMTP id v19so96684357wgu.1;
        Sun, 17 May 2015 03:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nL11O7rpPYjHbw2djJTe6dG37umSOhgfmj2dfrbB3pU=;
        b=QBz9yH+pVFQDq7UMi7KYIHDsh+r+jQnD8cjOYtiSsHNohHuP+aecVF45QeNqzWwdrK
         q2rjmn9fHp+ZMISJb8TEfKf2AmQQF8D/THMKaBJBbu51934kUWczF4MArP6QXUX/8hhv
         8nS6wOmWw+ON8l8fQ0EYPWNulRoq3An1lANMQOzj0msRQF9WNsD/6I0wtYh2rCH2atM2
         fUeNY9nQqCIDA30dL1oAlAVF3epp6KQUecpcIkbFsICKVgVRt6AixvpIgTvrQ2vplEA9
         ZstRrrv9Oc+GlhHL7GO0hNHzcLuhMImpi62wBobdBMOU2Nsoea9TCKc3esQAeTIaQzBR
         8Shw==
X-Received: by 10.194.91.176 with SMTP id cf16mr12780786wjb.141.1431860069824;
        Sun, 17 May 2015 03:54:29 -0700 (PDT)
Received: from Red.local (ANice-651-1-428-5.w83-201.abo.wanadoo.fr. [83.201.252.5])
        by mx.google.com with ESMTPSA id ny7sm7070464wic.11.2015.05.17.03.54.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 May 2015 03:54:29 -0700 (PDT)
From:   LABBE Corentin <clabbe.montjoie@gmail.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ralf@linux-mips.org, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, aaro.koskinen@iki.fi
Cc:     linux-crypto@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org,
        LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: [PATCH 5/6] crypto: n2: use md5 IV MD5_HX instead of their raw value
Date:   Sun, 17 May 2015 12:54:16 +0200
Message-Id: <1431860057-5232-5-git-send-email-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.3.6
In-Reply-To: <1431860057-5232-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1431860057-5232-1-git-send-email-clabbe.montjoie@gmail.com>
Return-Path: <clabbe.montjoie@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47452
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
 drivers/crypto/n2_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/n2_core.c b/drivers/crypto/n2_core.c
index 10a9aef..2e8dab9 100644
--- a/drivers/crypto/n2_core.c
+++ b/drivers/crypto/n2_core.c
@@ -1281,10 +1281,10 @@ static const char md5_zero[MD5_DIGEST_SIZE] = {
 	0xe9, 0x80, 0x09, 0x98, 0xec, 0xf8, 0x42, 0x7e,
 };
 static const u32 md5_init[MD5_HASH_WORDS] = {
-	cpu_to_le32(0x67452301),
-	cpu_to_le32(0xefcdab89),
-	cpu_to_le32(0x98badcfe),
-	cpu_to_le32(0x10325476),
+	cpu_to_le32(MD5_H0),
+	cpu_to_le32(MD5_H1),
+	cpu_to_le32(MD5_H2),
+	cpu_to_le32(MD5_H3),
 };
 static const char sha1_zero[SHA1_DIGEST_SIZE] = {
 	0xda, 0x39, 0xa3, 0xee, 0x5e, 0x6b, 0x4b, 0x0d, 0x32,
-- 
2.3.6
