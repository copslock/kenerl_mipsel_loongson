Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Sep 2015 07:47:41 +0200 (CEST)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33401 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006855AbbIZFrMQGqb9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 26 Sep 2015 07:47:12 +0200
Received: by pacex6 with SMTP id ex6so124466421pac.0;
        Fri, 25 Sep 2015 22:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QIkA3FuoG3yCgSUUxiYYC85AKYml041PErVG1cmhdB4=;
        b=WjWf+c6Mpo0/zZvaI23wul0NSDffOen0dtUJih+y+sGzjPPYS/SifFmBvPgk8J4r+F
         YphuXS+RDapQcC80iynPuCCKLxDm6dfeDAxUB4DN6tFlXPYdOjk9B7ZwnlxAuzSNmJzQ
         XVQBeKqR0e2LSj1onlthsb4AFTbt+HVdUrF3cqAwfJJge6D24APms0U8VcfLE8GeoCOy
         Xe9Oyp/G86j3/RBoZkkAhd7Lt+UFQlPo+BLCCvQscWFukrWkwp1sozcRZlwLo4DtjPYa
         z55SB+mfUan+Jr+0LSwpe1ZO2GSLHuinUO6wGpo3P4O671jpVaaqJ+MGPQoZ0xyay9g0
         Z5PA==
X-Received: by 10.68.100.226 with SMTP id fb2mr12302862pbb.92.1443246425206;
        Fri, 25 Sep 2015 22:47:05 -0700 (PDT)
Received: from debian.corp.sankuai.com ([103.29.140.56])
        by smtp.gmail.com with ESMTPSA id gt1sm7074339pbc.10.2015.09.25.22.47.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2015 22:47:04 -0700 (PDT)
From:   Yousong Zhou <yszhou4tech@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org, Yousong Zhou <yszhou4tech@gmail.com>
Subject: [PATCH v3 2/2] MIPS: UAPI: Ignore __arch_swab{16,32,64} when using MIPS16
Date:   Sat, 26 Sep 2015 13:41:43 +0800
Message-Id: <1443246103-31122-3-git-send-email-yszhou4tech@gmail.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1443246103-31122-1-git-send-email-yszhou4tech@gmail.com>
References: <1443246103-31122-1-git-send-email-yszhou4tech@gmail.com>
Return-Path: <yszhou4tech@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yszhou4tech@gmail.com
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

Some GCC versions (e.g. 4.8.3) can incorrectly inline a function with
MIPS32 instructions into another function with MIPS16 code [1], causing
the assembler to genereate incorrect binary code or fail right away
complaining about unrecognized opcode.

In the case of __arch_swab{16,32}, when inlined by the compiler with
flags `-mips32r2 -mips16 -Os', the assembler can fail with the following
error.

    {standard input}:79: Error: unrecognized opcode `wsbh $2,$2'

For performance concerns and to workaround the issue already existing in
older compilers, just ignore these 2 functions when compiling with
mips16 enabled.

 [1] Inlining nomips16 function into mips16 function can result in
     undefined builtins, https://gcc.gnu.org/bugzilla/show_bug.cgi?id=55777

Signed-off-by: Yousong Zhou <yszhou4tech@gmail.com>
---
 arch/mips/include/uapi/asm/swab.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/uapi/asm/swab.h b/arch/mips/include/uapi/asm/swab.h
index 8f2d184..23cd9b1 100644
--- a/arch/mips/include/uapi/asm/swab.h
+++ b/arch/mips/include/uapi/asm/swab.h
@@ -13,8 +13,9 @@
 
 #define __SWAB_64_THRU_32__
 
-#if (defined(__mips_isa_rev) && (__mips_isa_rev >= 2)) ||		\
-    defined(_MIPS_ARCH_LOONGSON3A)
+#if !defined(__mips16) &&					\
+	((defined(__mips_isa_rev) && (__mips_isa_rev >= 2)) ||	\
+	 defined(_MIPS_ARCH_LOONGSON3A))
 
 static inline __attribute_const__ __u16 __arch_swab16(__u16 x)
 {
@@ -65,5 +66,5 @@ static inline __attribute_const__ __u64 __arch_swab64(__u64 x)
 }
 #define __arch_swab64 __arch_swab64
 #endif /* __mips64 */
-#endif /* MIPS R2 or newer or Loongson 3A */
+#endif /* (not __mips16) and (MIPS R2 or newer or Loongson 3A) */
 #endif /* _ASM_SWAB_H */
-- 
1.7.10.4
