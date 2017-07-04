Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jul 2017 13:45:01 +0200 (CEST)
Received: from mail-pf0-x236.google.com ([IPv6:2607:f8b0:400e:c00::236]:36794
        "EHLO mail-pf0-x236.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993543AbdGDLoycGiwv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jul 2017 13:44:54 +0200
Received: by mail-pf0-x236.google.com with SMTP id q86so114363502pfl.3
        for <linux-mips@linux-mips.org>; Tue, 04 Jul 2017 04:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zLeAV6js01dIatCeo30cAABzLRqFOHAVuaeh8GxhRB0=;
        b=Wl5w/BSiDXEKW1lPPTQT5CIAiBFNp+brC/1nKc0JdglCmOfSL2iIdkQc/6RUUblsxp
         lOTOETYtYrHgbh0aCqhyBeYB1RogtW5pUrF0sB+vLXfu79gDf2m6jnevR5uAiyKuy37k
         e9ki3jELEtN2m/yctVrXd597zZ1yH6Hk6LkNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zLeAV6js01dIatCeo30cAABzLRqFOHAVuaeh8GxhRB0=;
        b=cPABcvHH2tW2iyqIJkmqppIIoowgpapmDo8ai9UUOBgkq80gD1HRulVd7MEL0JE9fg
         9o5jD3amsEZ3oslsZab/9c2Gl/5b0LPGIpRUlo3B63dQOk7GIpnLZd+5hbm8sa/RWdS4
         +dnffdfBpUIqez5Gp/GESbJsmYxySpyla88umCjDx94tIN086iLOF2ucybh17/amvfjo
         PLPG54kuNuIlFjVGL4LjsYTbTKoS0SZ0NWIgPFtmkRSe7Lqr6kT5ITo0WTZDMFmAxO2I
         ggHDh4Y0oc03P7+kmj2kwo2UIn6KcCSI8N9/mFghHIr0Pu+btBJa2q6XaJr7RmxdIEJN
         bZxA==
X-Gm-Message-State: AIVw112Wf1ErSQGvX8hD1GLb8YX4pjK4j7vdSAVgCIELy83CAQlw0KtL
        D2O0zA1qXNplHv30
X-Received: by 10.98.113.65 with SMTP id m62mr14830617pfc.150.1499168688577;
        Tue, 04 Jul 2017 04:44:48 -0700 (PDT)
Received: from localhost.localdomain ([106.51.234.165])
        by smtp.gmail.com with ESMTPSA id t83sm39782750pfg.91.2017.07.04.04.44.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Jul 2017 04:44:47 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Stable <stable@vger.kernel.org>,
        Yousong Zhou <yszhou4tech@gmail.com>,
        "Maciej W . Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH for-3.18 4/5] MIPS: UAPI: Ignore __arch_swab{16,32,64} when using MIPS16
Date:   Tue,  4 Jul 2017 17:14:23 +0530
Message-Id: <1499168664-25980-5-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1499168664-25980-1-git-send-email-amit.pundir@linaro.org>
References: <1499168664-25980-1-git-send-email-amit.pundir@linaro.org>
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amit.pundir@linaro.org
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

From: Yousong Zhou <yszhou4tech@gmail.com>

commit 71a0a72456b48de972d7ed613b06a22a3aa9057f upstream.

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
Cc: Maciej W. Rozycki <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/11241/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 arch/mips/include/uapi/asm/swab.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/uapi/asm/swab.h b/arch/mips/include/uapi/asm/swab.h
index 8f2d184dbe9f..23cd9b118c9e 100644
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
2.7.4
