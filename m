Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 10:39:34 +0200 (CEST)
Received: from mail-pf1-x443.google.com ([IPv6:2607:f8b0:4864:20::443]:35895
        "EHLO mail-pf1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994243AbeINIjSJndYi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Sep 2018 10:39:18 +0200
Received: by mail-pf1-x443.google.com with SMTP id b11-v6so3984194pfo.3
        for <linux-mips@linux-mips.org>; Fri, 14 Sep 2018 01:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qmk9tdmyCNAX0uYS98kxHvRp3zsest+IBqTfinGmuMM=;
        b=Zje1zK3Bnbi+aIOYb0gSn4xU3rKqZP088NnH6u+iImR/bexjjon0SHWVGeZxDU3dQH
         icV4e+hlASBIOkWVmYGpY97Iyjn0rMWqiz85PWCQP8LCz48B4jp2KswkxpRHZYz5weJL
         pZ62Z9RnnzLFp/7yXjrJXkps+yzpOvZxgMPUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qmk9tdmyCNAX0uYS98kxHvRp3zsest+IBqTfinGmuMM=;
        b=WB5ZeLLdpOYe0OZ3euljrkCngpxeXHZxkpT0Qnu366kU2WSczQu6PSm149TSjzETrI
         TWtqFHcIMTtQHtat9y/SOFpzTJSVSmoFJuVY72mxUrbKAeR1F6NNUUNAaTzZtbl3587A
         Up4SI5BNKTx/pJc4yu5qJq5bXUowm4ix2/LOn0XZKyUn0Uaxcp7hpcRK54MUv1ngPJ7W
         A1mj0Jm1WtZA39v8IOYT/C40UtvnWOAks/0a0Tkk/kzZZJ2okeMmmnRfWJiYH0xc6Co8
         uZn+yDLihYBAxdWtKKn0NTmJci+7jrZxs+oM78xXh9TMSZtpvnGnR2NSfVtxcRM+IAME
         7C0g==
X-Gm-Message-State: APzg51COI/yI59fq5t1ROmXB5U+xYdnhmV6C5P/qpTO/jmt8rB3xJntF
        CiLrz4/6KGUuqqFE/IngwwHxxw==
X-Google-Smtp-Source: ANB0VdaiUCuoDIkBDZAu8gLthUdTIyL/KRvGnlLXWG3da+9eT2zKr6CpjBhaanFvmwP9dd6jAL13Aw==
X-Received: by 2002:a63:3587:: with SMTP id c129-v6mr10749967pga.290.1536914352128;
        Fri, 14 Sep 2018 01:39:12 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.60.83])
        by smtp.gmail.com with ESMTPSA id c1-v6sm11664289pfg.25.2018.09.14.01.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Sep 2018 01:39:11 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 1/3] mips: Add __NR_syscalls macro in uapi/asm/unistd.h
Date:   Fri, 14 Sep 2018 14:08:32 +0530
Message-Id: <1536914314-5026-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org>
References: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org>
Return-Path: <firoz.khan@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66238
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

NR_syscalls macro holds the number of system call exist in MIPS
architecture. This macro is currently not a part of uapi/asm/unistd.h
file. The purpose of this macro is We have to change the value of
NR_syscalls, if we add or delete a system call.

One of the patch in this patch series has a script which will generate
a uapi header based on syscall.tbl file. The syscall.tbl file contains
the number of system call information. So we have two option to update
NR_syscalls value.

1. Update NR_syscalls in uapi/asm/unistd.h manually by counting the
   no.of system calls. No need to update NR_syscalls until we either
   add a new system call or delete an existing system call.

2. We can keep this feature it above mentioned script, that'll
   count the number of syscalls and keep it in a generated file.
   In this case we don't need to explicitly update NR_syscalls
   in asm/unistd.h file.

The 2nd option will be the recommended one. While __NR_syscalls
isn't strictly part of the uapi, having it as part of the generated
header to simplifies the implementation.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/mips/include/uapi/asm/unistd.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index f25dd1d..f8bab34 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -390,17 +390,17 @@
 #define __NR_statx			(__NR_Linux + 366)
 #define __NR_rseq			(__NR_Linux + 367)
 #define __NR_io_pgetevents		(__NR_Linux + 368)
-
+#define __NR_syscalls                   368
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		368
+#define __NR_Linux_syscalls             __NR_syscalls
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		368
+#define __NR_O32_Linux_syscalls         __NR_syscalls
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -737,16 +737,17 @@
 #define __NR_statx			(__NR_Linux + 326)
 #define __NR_rseq			(__NR_Linux + 327)
 #define __NR_io_pgetevents		(__NR_Linux + 328)
+#define __NR_syscalls                   328
 
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
 
@@ -1087,15 +1088,16 @@
 #define __NR_statx			(__NR_Linux + 330)
 #define __NR_rseq			(__NR_Linux + 331)
 #define __NR_io_pgetevents		(__NR_Linux + 332)
+#define __NR_syscalls                   332
 
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
