Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 May 2013 16:37:45 +0200 (CEST)
Received: from mail-pb0-f45.google.com ([209.85.160.45]:49842 "EHLO
        mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823073Ab3EUOhjky--j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 May 2013 16:37:39 +0200
Received: by mail-pb0-f45.google.com with SMTP id mc17so687826pbc.4
        for <multiple recipients>; Tue, 21 May 2013 07:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=weD/RO24HWWf7T4F7uYNOlQu9Wr03yy3DoaFa/LQ5yw=;
        b=Kc89XRm4/DkBIMyGcvV2QdKI1lfG/j3lb8ODA1OlQKyEiD/qQvT3v+82Ug5+vkFXur
         fXpeUAChRzPuTeeLfVkgl+2Is+rG5+SzFW8oWXsZzUODw4VagSA7lc0OTQi3BI4VIyKk
         g+YEVCGu8tlgwofXWun6YKATjJU5aLmxAiqHn8AFINqVbOlpCC5v2O6k68X8xiM6PPmg
         EdcFrX4WruhO/isyBJSJE38WTOq/cW2JvZ4wFG5M81G9udBTky/QkIfgpkLI2WDs0FNM
         WBd5EI49meeZ+0xoWDHU22gOC4NLff4t2mpp4kK3jvG/T8vqHbQ837Z0/bWaxsomNWsk
         W8mQ==
X-Received: by 10.66.228.233 with SMTP id sl9mr3592194pac.38.1369147052874;
        Tue, 21 May 2013 07:37:32 -0700 (PDT)
Received: from localhost ([2001:da8:20f:2789:9e4e:36ff:fe98:8aac])
        by mx.google.com with ESMTPSA id 3sm2929493pbj.46.2013.05.21.07.37.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 May 2013 07:37:32 -0700 (PDT)
From:   Aron Xu <aron@debian.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Aron Xu <aron@debian.org>
Subject: [PATCH] MIPS: N64: Define getdents64
Date:   Tue, 21 May 2013 22:37:06 +0800
Message-Id: <1369147026-23033-1-git-send-email-aron@debian.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <happyaron.xu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aron@debian.org
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

As a relatively new ABI, N64 only had getdents syscall while other modern
architectures have getdents64.

This was noticed when Python 3.3 shifted to the latter one for aarch64.

Signed-off-by: Aron Xu <aron@debian.org>
---
 arch/mips/include/uapi/asm/unistd.h |    5 +++--
 arch/mips/kernel/scall64-64.S       |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index 16338b8..1dee279 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -694,16 +694,17 @@
 #define __NR_process_vm_writev		(__NR_Linux + 305)
 #define __NR_kcmp			(__NR_Linux + 306)
 #define __NR_finit_module		(__NR_Linux + 307)
+#define __NR_getdents64			(__NR_Linux + 308)
 
 /*
  * Offset of the last Linux 64-bit flavoured syscall
  */
-#define __NR_Linux_syscalls		307
+#define __NR_Linux_syscalls		308
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		307
+#define __NR_64_Linux_syscalls		308
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index 36cfd40..97a5909 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -423,4 +423,5 @@ sys_call_table:
 	PTR	sys_process_vm_writev		/* 5305 */
 	PTR	sys_kcmp
 	PTR	sys_finit_module
+	PTR	sys_getdents64
 	.size	sys_call_table,.-sys_call_table
-- 
1.7.10.4
