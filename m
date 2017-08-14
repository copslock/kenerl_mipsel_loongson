Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Aug 2017 12:22:04 +0200 (CEST)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:36047
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993923AbdHNKV6Y0hnJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Aug 2017 12:21:58 +0200
Received: by mail-wm0-x244.google.com with SMTP id d40so13892081wma.3;
        Mon, 14 Aug 2017 03:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=85KZ5iSYa4kbNJVZjgsz5D0FlD02lP+x4Gq+okBucg8=;
        b=tJ7/5DwCd3jn0lI+n4CuEnpVEy2rIHtEK0/zlERMdNEFOYGG7x8ss3rBLnbJOHgaI2
         ZmAq4edGduIlwnZdr6qkFdKIjr8J97VKpI0SI9tRoUE/ko1MEOLYsrpbW1RG9ciq+8xN
         IEPTkdNoXF92qO2lR+zL6ChBiXINiZWiymIHwIp8B3VBmuM/b5eSRs8QsegfaggU+wmi
         ja05QTbJyZsMXjTzUQ162WRbhRR56QxrzPQxaC+txPfb3T8GI2wxdekcy+2x7GtQEZ4C
         l8zBJUJdEi5JkyUE5CN81owtZzR1Hl6goetBEDPNsFRXVBo80M+RcmR0NDkKtdOi4yau
         oOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=85KZ5iSYa4kbNJVZjgsz5D0FlD02lP+x4Gq+okBucg8=;
        b=oXpg14v698BiImgCj0aNa/Q3CxhuorZG1zal9mlgEkBvPT+X0E4B7H2drd2LJE8tOe
         pQ8Y/4Gjd2MaA7t4TkGRobgrbf2+G6uYk5KdGocdjLceejG9KUmm1I8xbP26Q/iVG0L3
         RVsUbZI3KQZLdbSGlwqyecqSXQXae3oCzN+44Uc71y36nSz0DPzlb7eWG7mxB6hedkAV
         q6pOiXN9/majGMWJSv3myuaAAS34MUQbmuIX8tqObIUc1jYthipQR1FJyxKUkbWGDxI8
         YQEXHIN9dZQsYiYUPMDfi13RDiK2tBjhnLxjtjkShQOdo2jQmvI12AizMVYnRm6yMWAm
         7fGA==
X-Gm-Message-State: AHYfb5h8x0u2NEdb4a/IUPdeqIYI5CMl3PrLcYM5kciPUDuzSrmNSFlY
        FqjKGMnIGKru2ETm
X-Received: by 10.28.52.12 with SMTP id b12mr3920301wma.54.1502706112873;
        Mon, 14 Aug 2017 03:21:52 -0700 (PDT)
Received: from flagship2.speedport.ip (p200300C20BDC300542C67896337F1D76.dip0.t-ipconnect.de. [2003:c2:bdc:3005:42c6:7896:337f:1d76])
        by smtp.gmail.com with ESMTPSA id c68sm5357757wmh.21.2017.08.14.03.21.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Aug 2017 03:21:52 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W . Rozycki" <macro@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH v2] MIPS: math-emu: do not use bools for arithmetic
Date:   Mon, 14 Aug 2017 12:21:48 +0200
Message-Id: <20170814102148.397474-1-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.14.1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

GCC-7 complains about a boolean value being used with an arithmetic
AND:

arch/mips/math-emu/cp1emu.c: In function 'cop1Emulate':
arch/mips/math-emu/cp1emu.c:838:14: warning: '~' on a boolean expression [-Wbool-operation]
  fpr = (x) & ~(cop1_64bit(xcp) == 0);    \
              ^
arch/mips/math-emu/cp1emu.c:1068:3: note: in expansion of macro 'DITOREG'
   DITOREG(dval, MIPSInst_RT(ir));
   ^~~~~~~
arch/mips/math-emu/cp1emu.c:838:14: note: did you mean to use logical not?
  fpr = (x) & ~(cop1_64bit(xcp) == 0);    \

Since cop1_64bit() returns and int, just flip the LSB.

Suggested-by: Maciej W. Rozycki <macro@imgtec.com> 
Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
v2: just use xor, as suggested by Maciej.  No size changes this time, but still
untested due to lack of hardfloat userland.

 arch/mips/math-emu/cp1emu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index f08a7b4facb9..53a3b73a28d5 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -830,12 +830,12 @@ do {									\
 } while (0)
 
 #define DIFROMREG(di, x)						\
-	((di) = get_fpr64(&ctx->fpr[(x) & ~(cop1_64bit(xcp) == 0)], 0))
+	((di) = get_fpr64(&ctx->fpr[(x) & ~(cop1_64bit(xcp) ^ 1)], 0))
 
 #define DITOREG(di, x)							\
 do {									\
 	unsigned fpr, i;						\
-	fpr = (x) & ~(cop1_64bit(xcp) == 0);				\
+	fpr = (x) & ~(cop1_64bit(xcp) ^ 1);				\
 	set_fpr64(&ctx->fpr[fpr], 0, di);				\
 	for (i = 1; i < ARRAY_SIZE(ctx->fpr[x].val64); i++)		\
 		set_fpr64(&ctx->fpr[fpr], i, 0);			\
-- 
2.14.1
