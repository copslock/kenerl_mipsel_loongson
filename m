Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jul 2017 11:22:07 +0200 (CEST)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:34776
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991073AbdGaJWAy90tP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 Jul 2017 11:22:00 +0200
Received: by mail-wm0-x243.google.com with SMTP id x64so10486456wmg.1;
        Mon, 31 Jul 2017 02:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tUgkLdM+pwQJARhd8KfM3AK2nPJ8z5AFxnSLAyWubaA=;
        b=l8WcwqTs+nxvP5Txi08tYjfq+gCWQds7TqqnIJp0M/fT8poe9gIbHol3TtrVbErVAL
         YkDTu3TUPm5Cb5Lmr1kbTtqZ8QafWjpJFzDbwVhfL1/FzEvpJ8qMLfmBRPum8wiq+tM9
         H45bqdtqRbwQU08sUnKG8utW8/4F/2+vAQSchhqKyPaKtOICiBD4FW3gJAQX4Qqp3aKi
         T6ygTBhGSABf//K5B6N8CgCVvzxS0R3ugqIeK5SgEPjI85IvzKkTOt6BdobeCORC4xo6
         Bt9Msh+lg3u6v2ValfBhDGl+X1E69ri2zEuYhYYkEGPEk2TgCbqfklmyYwrlWp8m+BXx
         t+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tUgkLdM+pwQJARhd8KfM3AK2nPJ8z5AFxnSLAyWubaA=;
        b=nE3c3sZEPfKfhx0BHNsvrci5hh5+f2tJvWjjNVQeBddQKGyThE11HIbb6BE0dCFSJE
         fruOkgKCxbokoC1lAQnRTNeCssgQYZdAjx7vgPTtj/QcF0tQLfs7Dt/P2ps+MPe7vvTz
         1rOCksDoJ0giSaYf3R8N9t/grmWXNqqAmB0B71yEYKJ35sl2luo/IdLhVC3JxC9fG2IB
         sGBMvFyhsTOZmDKp+zuIeTdb//ss1CxxndzwGz4FQWs6wVMjqtc1t7OlkQfpMpgq8sbL
         o56pjSLA9RTAsUYjvA29/H0SzQ7k4kSQllBgPKnOn+Dt725ANBO1aPMi8ZND9thOA9X0
         SyAQ==
X-Gm-Message-State: AIVw112oZRI6RYzFMhe249Gbps9Vq5ducqDDGwCVcbyxS5eSTZWBV8Fp
        02BP3L8rqz1Xn9HjHXQ=
X-Received: by 10.80.190.139 with SMTP id b11mr13934734edk.254.1501492915235;
        Mon, 31 Jul 2017 02:21:55 -0700 (PDT)
Received: from dargo.speedport.ip (x59cc8a31.dyn.telefonica.de. [89.204.138.49])
        by smtp.gmail.com with ESMTPSA id y55sm5460614edb.7.2017.07.31.02.21.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Jul 2017 02:21:54 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH] MIPS: math-emu: do not use bools for arithmetic
Date:   Mon, 31 Jul 2017 11:21:51 +0200
Message-Id: <20170731092151.116438-1-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.13.1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59308
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

Fix this by testing the bool and returning an int.
This also shrinks the size of the file object file by 312 bytes:

   text    data     bss     dec     hex filename
  11432       0       0   11432    2ca8 cp1emu.o-alt
  11120       0       0   11120    2b70 cp1emu.o

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
I'm unsure whether the patch is really correct, due to the unexpected
binary size reduction.  I do not have a hardfloat mips32 userland at hand
therefore I'd appreciate it if someone could test it!
Thanks!

 arch/mips/math-emu/cp1emu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index f08a7b4facb9..f3a9bf5285e0 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -830,12 +830,12 @@ do {									\
 } while (0)
 
 #define DIFROMREG(di, x)						\
-	((di) = get_fpr64(&ctx->fpr[(x) & ~(cop1_64bit(xcp) == 0)], 0))
+	((di) = get_fpr64(&ctx->fpr[(x) & ~(cop1_64bit(xcp) == 0 ? 1 : 0)], 0))
 
 #define DITOREG(di, x)							\
 do {									\
 	unsigned fpr, i;						\
-	fpr = (x) & ~(cop1_64bit(xcp) == 0);				\
+	fpr = (x) & ~(cop1_64bit(xcp) == 0 ? 1 : 0);			\
 	set_fpr64(&ctx->fpr[fpr], 0, di);				\
 	for (i = 1; i < ARRAY_SIZE(ctx->fpr[x].val64); i++)		\
 		set_fpr64(&ctx->fpr[fpr], i, 0);			\
-- 
2.13.1
