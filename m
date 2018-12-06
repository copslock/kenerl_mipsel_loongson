Return-Path: <SRS0=dj/1=OP=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF54C65BB0
	for <linux-mips@archiver.kernel.org>; Thu,  6 Dec 2018 05:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C8C20838
	for <linux-mips@archiver.kernel.org>; Thu,  6 Dec 2018 05:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LsWzddNn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C8C20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbeLFFTZ (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 6 Dec 2018 00:19:25 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33074 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbeLFFTY (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 6 Dec 2018 00:19:24 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so11206578pfb.0
        for <linux-mips@vger.kernel.org>; Wed, 05 Dec 2018 21:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YFkH6BiVFMb84PF3sgPw/qdfk9RQVU5JUMVa27R0rjA=;
        b=LsWzddNnSpnI8bf2rDcBqamsS82gKi9t+RgrgQ7mFavobL3Z+6zEzj+g5feQM2Vgim
         o49WN3HgSa2vwsV9Z5yUl0r98x05JhVykKBuAQSU4rJnKY50G54LRa7SswM/KE4WA18E
         TsOMm68vyLyljVmkCtFvEf6deRm9mBrYfozpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YFkH6BiVFMb84PF3sgPw/qdfk9RQVU5JUMVa27R0rjA=;
        b=jRlMRUcoN+pYZ7q6BhgWo4v3KCcMP7YJWQdf5BKF+X+WRfcvzYFMAufRQpv876ITSb
         gPUtE2Nctg5QRt3ghaFjP1r4y0JM4nr+KwJ2ikSVq7BMJUrFONG5mWEQDudqYOxkqxxv
         QIARK2MLDxlEv6xE28WaF8Ivl9VqbJrdT4XLAp1bCRL1eFBrZNbRCq64NR+C5TRwv8n6
         /RC4Jg6Db3gcrEcNbRqeH02WFy/2ZOJF4ZhQwJcQ5HkKKh3Y4y8sor5XIh2t6KhB1pw4
         xYhlkNleg7rxob4A/a/f+o8tDUVAMcY+YDW11vh4mj6RnNw+vL+K+7TfgrHb72DrwxW3
         HQYQ==
X-Gm-Message-State: AA+aEWavAMhwBcAG2yeLowjpPnvELQW7mpVU1JmTv90zewU1pBK/ARDJ
        h/Mb/vd+1alHuUGOWUBtM4l8QGVeuCc=
X-Google-Smtp-Source: AFSGD/VXxZwAHEaCZrGSTkAsw4hIZqTom61rBBZB1HdbwTJxZ3TVLxK0Fq3adh5usbi0ChM7cp2DCA==
X-Received: by 2002:a62:4156:: with SMTP id o83mr27054347pfa.72.1544073563972;
        Wed, 05 Dec 2018 21:19:23 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id r66sm32877803pfk.157.2018.12.05.21.19.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Dec 2018 21:19:23 -0800 (PST)
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
Subject: [PATCH v4 1/7] mips: add __NR_syscalls along with __NR_Linux_syscalls
Date:   Thu,  6 Dec 2018 10:48:22 +0530
Message-Id: <1544073508-13720-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

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
 arch/mips/include/uapi/asm/unistd.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index f25dd1d..6914be5 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -391,11 +391,14 @@
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
 
@@ -738,10 +741,14 @@
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
 
@@ -1088,10 +1095,14 @@
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
 
-- 
1.9.1

