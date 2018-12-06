Return-Path: <SRS0=dj/1=OP=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42ED5C04EBF
	for <linux-mips@archiver.kernel.org>; Thu,  6 Dec 2018 05:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0770C20838
	for <linux-mips@archiver.kernel.org>; Thu,  6 Dec 2018 05:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hsyudtka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0770C20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbeLFFTa (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 6 Dec 2018 00:19:30 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44455 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbeLFFTa (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 6 Dec 2018 00:19:30 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so11174571pfh.11
        for <linux-mips@vger.kernel.org>; Wed, 05 Dec 2018 21:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kGl5LFLSs0dA190vDRXrA6LLA8QGbgKzTjmcNEweksU=;
        b=Hsyudtka9ZQUfqh0efmurP1Owbr5AEKLNzby5q59+sHWsBeUggmq7KyhIEUndJKWJI
         zBbS7oV5jPTCr7x/nGFF5p8SOhRI79iC1bbDKDZ75zdZFT9rTR04LlEm0JgO4Wyqgaru
         6n81TGaqqWfk2rJnVsm3kaUsjbaptiwYWpn+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kGl5LFLSs0dA190vDRXrA6LLA8QGbgKzTjmcNEweksU=;
        b=ruKDMzWn+360dHBfv8A+2tEDQ38ssC4pbxheqrKdMsMndhJrw+5l7QqXLCnSlhAp23
         P0b+x8XL8N6y91NIhH6srJp43IQh5B4KVlMJPBNcjYHG07KA4eJkuR0Ul4gwnql6RzaB
         nzB8gMKKukhAWziltyEl/jRrqk0Zm2oGfdi2A+u9bh/bBBCojLtaPSHYjOwAukpwYF89
         ZW+/xhGnfCM00ZjdKXWSSNAzT5SB4qK4mW6csb83f4D9weQSLkKXqLtFuTKUuvpTpkjW
         wZvsvHBtjVN7HJh+zSUGKwoI2lqFGGCy04E0ysZTRVxg65v55zXdZCinijSSL3jW79tI
         FpJw==
X-Gm-Message-State: AA+aEWaRm5LA/Ddz0Q4dCQFzTz0+2d6O2NPlPrb4ljTZ/pkOlaaA8OZL
        Lup0YdUSlJFLqtfOigu/gSXmKAphfs8=
X-Google-Smtp-Source: AFSGD/W17BXHHTHuwcWWLArx5fURxmMklDnOCyuO5jtUpLvhqsxeluGHhULObHcjlwjkuyy+ZmQd+Q==
X-Received: by 2002:a63:3f44:: with SMTP id m65mr23531925pga.115.1544073569336;
        Wed, 05 Dec 2018 21:19:29 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id r66sm32877803pfk.157.2018.12.05.21.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Dec 2018 21:19:28 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v4 2/7] mips: remove unused macros
Date:   Thu,  6 Dec 2018 10:48:23 +0530
Message-Id: <1544073508-13720-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Remove NR_syscalls from asm/unistd.h as there is no
users to use NR_syscalls macro in mips kernel.

Remove __NR_Linux_syscalls from uapi/asm/unistd.h as
there is no users to use NR_syscalls macro in mips
kernel.

MAX_SYSCALL_NO can also remove as there is commit
2957c9e61ee9 ("[MIPS] IRIX: Goodbye and thanks for
all the fish"), eight years ago.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/mips/include/asm/unistd.h      |  8 --------
 arch/mips/include/uapi/asm/unistd.h | 15 ---------------
 arch/mips/kernel/scall32-o32.S      |  3 ---
 3 files changed, 26 deletions(-)

diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index c68b8ae..d7ee846 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -14,14 +14,6 @@
 
 #include <uapi/asm/unistd.h>
 
-#ifdef CONFIG_MIPS32_N32
-#define NR_syscalls  (__NR_N32_Linux + __NR_N32_Linux_syscalls)
-#elif defined(CONFIG_64BIT)
-#define NR_syscalls  (__NR_64_Linux + __NR_64_Linux_syscalls)
-#else
-#define NR_syscalls  (__NR_O32_Linux + __NR_O32_Linux_syscalls)
-#endif
-
 #ifndef __ASSEMBLY__
 
 #define __ARCH_WANT_NEW_STAT
diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index 6914be5..c897195 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -395,11 +395,6 @@
 #define __NR_syscalls			368
 #endif
 
-/*
- * Offset of the last Linux o32 flavoured syscall
- */
-#define __NR_Linux_syscalls		__NR_syscalls
-
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
@@ -745,11 +740,6 @@
 #define __NR_syscalls			328
 #endif
 
-/*
- * Offset of the last Linux 64-bit flavoured syscall
- */
-#define __NR_Linux_syscalls		__NR_syscalls
-
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
@@ -1099,11 +1089,6 @@
 #define __NR_syscalls			332
 #endif
 
-/*
- * Offset of the last N32 flavoured syscall
- */
-#define __NR_Linux_syscalls		__NR_syscalls
-
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 91d3c8c..fea6edb 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -22,9 +22,6 @@
 #include <asm/war.h>
 #include <asm/asm-offsets.h>
 
-/* Highest syscall used of any syscall flavour */
-#define MAX_SYSCALL_NO	__NR_O32_Linux + __NR_O32_Linux_syscalls
-
 	.align	5
 NESTED(handle_sys, PT_SIZE, sp)
 	.set	noat
-- 
1.9.1

