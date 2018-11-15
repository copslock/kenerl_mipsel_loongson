Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2018 07:16:15 +0100 (CET)
Received: from mail-pf1-x442.google.com ([IPv6:2607:f8b0:4864:20::442]:41550
        "EHLO mail-pf1-x442.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991096AbeKOGO4KuGU4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Nov 2018 07:14:56 +0100
Received: by mail-pf1-x442.google.com with SMTP id e22-v6so9159014pfn.8
        for <linux-mips@linux-mips.org>; Wed, 14 Nov 2018 22:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UOD1rZ76ixX1i+wINT/mXb9qg93tcveUQSdF4DVLxOg=;
        b=j5Qgb6datx6I8r5gBbqyz1u7DqEgvrQZAAVbzPbs9C5F46EZlv1PH9WpcF1s5ZWFRE
         ePdLA/+ukMxSAiQA+TlhpUED4GCqHsCiSZGTo3dVIJXAez7Y/V5by/792WXxQZscNAtC
         EDQ6TAtmLTdWJZ3Mm6/IgAQXYoMhFnDp3mOTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UOD1rZ76ixX1i+wINT/mXb9qg93tcveUQSdF4DVLxOg=;
        b=D5Ijt8SRUr76YIiIPYAMO7CwWw9L+uyQmvki0xYABEa8oG++QKFChtPDP5KwTnAqVL
         M5VnVoGxkJ4XHKW4Ls4OFg4sKuoJFk7DtfcmFZ5TBl5gxgP8UmK+ZeFEBLRRg3jCIJjf
         POSvDpUW3Hjt9od9FkrvR8AzhLsrs29GcobIPQQf9BQgiZs942NYWuJVAYhcZLb+PYMU
         kzzPqtOegfobk3jn80YkotEgpDaJ8AnHieEXUi5ToxUf+nuqyFMzVSLCUgAvauXtRdZX
         7OLhR1pD7YCv536uYKpTyC2dmQHvPgkkTWbPtdkgu8K1dq5WnKOe2jagBTFxBS7/JAYC
         AeFw==
X-Gm-Message-State: AGRZ1gKJG0QNM5xpiUaoPYfUwLY5B4BkrsxGnxVUmL48yvzcQlRC63PQ
        bpYKxbpyovo9OxrRBR8erdkXbA==
X-Google-Smtp-Source: AJdET5ct5FkgdjUjXRCS9ivMWxqjb331jore69P+VV2qW30VbkoV1LvNQQJuWE4WR2TprcuYUvx7rQ==
X-Received: by 2002:a63:f658:: with SMTP id u24mr4659976pgj.267.1542262495383;
        Wed, 14 Nov 2018 22:14:55 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 34sm39861931pgp.90.2018.11.14.22.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 22:14:54 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org,
        firoz.khan@linaro.org
Subject: [PATCH v2 1/5] mips: add __NR_syscalls along with __NR_Linux_syscalls
Date:   Thu, 15 Nov 2018 11:44:17 +0530
Message-Id: <1542262461-29024-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org>
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org>
Return-Path: <firoz.khan@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: firoz.khan@linaro.org
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

__NR_Linux_syscalls macro holds the number of system call
exist in mips architecture. We have to change the value of
__NR_Linux_syscalls, if we add or delete a system call.

One of the patch in this patch series has a script which
will generate a uapi header based on syscall.tbl file.
The syscall.tbl file contains the total number of system
calls information. So we have two option to update __NR-
_Linux_syscalls value.

1. Update __NR_Linux_syscalls in asm/unistd.h manually
   by counting the no.of system calls. No need to update
   __NR_Linux_syscalls until we either add a new system
   call or delete existing system call.

2. We can keep this feature it above mentioned script,
   that will count the number of syscalls and keep it in
   a generated file. In this case we don't need to expli-
   citly update __NR_Linux_syscalls in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I
added the __NR_syscalls macro in uapi/asm/unistd.h along
with __NR_Linux_syscalls. The macro __NR_syscalls also
added for making the name convention same across all
architecture. While __NR_syscalls isn't strictly part of
the uapi, having it as part of the generated header to
simplifies the implementation. We also need to enclose
this macro with #ifdef __KERNEL__ to avoid side effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/mips/include/uapi/asm/unistd.h | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index f25dd1d..0ccf954 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -391,16 +391,19 @@
 #define __NR_rseq			(__NR_Linux + 367)
 #define __NR_io_pgetevents		(__NR_Linux + 368)
 
+#ifdef __KERNEL__
+#define __NR_syscalls			368
+#endif
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		368
+#define __NR_Linux_syscalls		__NR_syscalls
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		368
+#define __NR_O32_Linux_syscalls		__NR_syscalls
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -738,15 +741,19 @@
 #define __NR_rseq			(__NR_Linux + 327)
 #define __NR_io_pgetevents		(__NR_Linux + 328)
 
+#ifdef __KERNEL__
+#define __NR_syscalls			328
+#endif
+
 /*
  * Offset of the last Linux 64-bit flavoured syscall
  */
-#define __NR_Linux_syscalls		328
+#define __NR_Linux_syscalls		__NR_syscalls
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		328
+#define __NR_64_Linux_syscalls		__NR_syscalls
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -1088,14 +1095,18 @@
 #define __NR_rseq			(__NR_Linux + 331)
 #define __NR_io_pgetevents		(__NR_Linux + 332)
 
+#ifdef __KERNEL__
+#define __NR_syscalls			332
+#endif
+
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		332
+#define __NR_Linux_syscalls		__NR_syscalls
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		332
+#define __NR_N32_Linux_syscalls		__NR_syscalls
 
 #endif /* _UAPI_ASM_UNISTD_H */
-- 
1.9.1
