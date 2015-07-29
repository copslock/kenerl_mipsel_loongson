Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jul 2015 17:43:47 +0200 (CEST)
Received: from prod-mail-xrelay08.akamai.com ([96.6.114.112]:54930 "EHLO
        prod-mail-xrelay08.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011707AbbG2PnNc82Qq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Jul 2015 17:43:13 +0200
Received: from prod-mail-xrelay08.akamai.com (localhost.localdomain [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 8B0ED7400B5;
        Wed, 29 Jul 2015 15:43:07 +0000 (GMT)
Received: from prod-mail-relay08.akamai.com (prod-mail-relay08.akamai.com [172.27.22.71])
        by prod-mail-xrelay08.akamai.com (Postfix) with ESMTP id 6B1127400B4;
        Wed, 29 Jul 2015 15:43:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=akamai.com; s=a1;
        t=1438184587; bh=jS+fFLl8dYu6QFp77SQoDdIMt8y/vbMvRKACcmNUaKA=;
        l=3883; h=From:To:Cc:Date:In-Reply-To:References:From;
        b=Jb7bcec4AAhEmFETCtAEmAvIXhizrjCykAIcoP2/cUSz44k3XHR5XHxsUuvNBgsrh
         5paI0RkShPl1qVs7Rq0O2d3YTju0Zwsyk/xrZOet2gvppkTsvjwtn8tYZlLtGuSXbA
         OEZHOYbBSluQ7XavVKdOBR1XDwgxqnWsAJab8Lus=
Received: from bos-lp6ds.kendall.corp.akamai.com (bos-lp6ds.kendall.corp.akamai.com [172.28.12.193])
        by prod-mail-relay08.akamai.com (Postfix) with ESMTP id E9CE298089;
        Wed, 29 Jul 2015 15:43:06 +0000 (GMT)
From:   Eric B Munson <emunson@akamai.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Eric B Munson <emunson@akamai.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH V6 6/6] mips: Add entry for new mlock2 syscall
Date:   Wed, 29 Jul 2015 11:42:55 -0400
Message-Id: <1438184575-10537-7-git-send-email-emunson@akamai.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1438184575-10537-1-git-send-email-emunson@akamai.com>
References: <1438184575-10537-1-git-send-email-emunson@akamai.com>
Return-Path: <emunson@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: emunson@akamai.com
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

A previous commit introduced the new mlock2 syscall, add entries for the
MIPS architecture.

Signed-off-by: Eric B Munson <emunson@akamai.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/include/uapi/asm/unistd.h | 15 +++++++++------
 arch/mips/kernel/scall32-o32.S      |  1 +
 arch/mips/kernel/scall64-64.S       |  1 +
 arch/mips/kernel/scall64-n32.S      |  1 +
 arch/mips/kernel/scall64-o32.S      |  1 +
 5 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index c03088f..d0bdfaa 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -377,16 +377,17 @@
 #define __NR_memfd_create		(__NR_Linux + 354)
 #define __NR_bpf			(__NR_Linux + 355)
 #define __NR_execveat			(__NR_Linux + 356)
+#define __NR_mlock2			(__NR_Linux + 357)
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		356
+#define __NR_Linux_syscalls		357
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		356
+#define __NR_O32_Linux_syscalls		357
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -711,16 +712,17 @@
 #define __NR_memfd_create		(__NR_Linux + 314)
 #define __NR_bpf			(__NR_Linux + 315)
 #define __NR_execveat			(__NR_Linux + 316)
+#define __NR_mlock2			(__NR_Linux + 317)
 
 /*
  * Offset of the last Linux 64-bit flavoured syscall
  */
-#define __NR_Linux_syscalls		316
+#define __NR_Linux_syscalls		317
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		316
+#define __NR_64_Linux_syscalls		317
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -1049,15 +1051,16 @@
 #define __NR_memfd_create		(__NR_Linux + 318)
 #define __NR_bpf			(__NR_Linux + 319)
 #define __NR_execveat			(__NR_Linux + 320)
+#define __NR_mlock2			(__NR_Linux + 321)
 
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		320
+#define __NR_Linux_syscalls		321
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		320
+#define __NR_N32_Linux_syscalls		321
 
 #endif /* _UAPI_ASM_UNISTD_H */
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 4cc1350..b0b377a 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -599,3 +599,4 @@ EXPORT(sys_call_table)
 	PTR	sys_memfd_create
 	PTR	sys_bpf				/* 4355 */
 	PTR	sys_execveat
+	PTR	sys_mlock2
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index ad4d4463..97aaf51 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -436,4 +436,5 @@ EXPORT(sys_call_table)
 	PTR	sys_memfd_create
 	PTR	sys_bpf				/* 5315 */
 	PTR	sys_execveat
+	PTR	sys_mlock2
 	.size	sys_call_table,.-sys_call_table
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 446cc65..e36f21e 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -429,4 +429,5 @@ EXPORT(sysn32_call_table)
 	PTR	sys_memfd_create
 	PTR	sys_bpf
 	PTR	compat_sys_execveat		/* 6320 */
+	PTR	sys_mlock2
 	.size	sysn32_call_table,.-sysn32_call_table
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index f543ff4..7a8b2df 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -584,4 +584,5 @@ EXPORT(sys32_call_table)
 	PTR	sys_memfd_create
 	PTR	sys_bpf				/* 4355 */
 	PTR	compat_sys_execveat
+	PTR	sys_mlock2
 	.size	sys32_call_table,.-sys32_call_table
-- 
1.9.1
