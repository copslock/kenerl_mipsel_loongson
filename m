Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Mar 2017 01:42:27 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39602 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993420AbdCDAmSYGtek (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Mar 2017 01:42:18 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 99130768FAA31;
        Sat,  4 Mar 2017 00:42:06 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Sat, 4 Mar 2017 00:42:11 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: Wire up statx system call
Date:   Sat, 4 Mar 2017 00:41:25 +0000
Message-ID: <20170304004125.6447-1-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Wire up the statx system call for MIPS, which was introduced in commit
a528d35e8bfc ("statx: Add a system call to make enhanced file info
available").

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/uapi/asm/unistd.h | 15 +++++++++------
 arch/mips/kernel/scall32-o32.S      |  1 +
 arch/mips/kernel/scall64-64.S       |  1 +
 arch/mips/kernel/scall64-n32.S      |  1 +
 arch/mips/kernel/scall64-o32.S      |  1 +
 5 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index 3e940dbe0262..78faf4292e90 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -386,17 +386,18 @@
 #define __NR_pkey_mprotect		(__NR_Linux + 363)
 #define __NR_pkey_alloc			(__NR_Linux + 364)
 #define __NR_pkey_free			(__NR_Linux + 365)
+#define __NR_statx			(__NR_Linux + 366)
 
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		365
+#define __NR_Linux_syscalls		366
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		365
+#define __NR_O32_Linux_syscalls		366
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -730,16 +731,17 @@
 #define __NR_pkey_mprotect		(__NR_Linux + 323)
 #define __NR_pkey_alloc			(__NR_Linux + 324)
 #define __NR_pkey_free			(__NR_Linux + 325)
+#define __NR_statx			(__NR_Linux + 326)
 
 /*
  * Offset of the last Linux 64-bit flavoured syscall
  */
-#define __NR_Linux_syscalls		325
+#define __NR_Linux_syscalls		326
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		325
+#define __NR_64_Linux_syscalls		326
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -1077,15 +1079,16 @@
 #define __NR_pkey_mprotect		(__NR_Linux + 327)
 #define __NR_pkey_alloc			(__NR_Linux + 328)
 #define __NR_pkey_free			(__NR_Linux + 329)
+#define __NR_statx			(__NR_Linux + 330)
 
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		329
+#define __NR_Linux_syscalls		330
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		329
+#define __NR_N32_Linux_syscalls		330
 
 #endif /* _UAPI_ASM_UNISTD_H */
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index c29d397eee86..80ed68b2c95e 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -600,3 +600,4 @@ EXPORT(sys_call_table)
 	PTR	sys_pkey_mprotect
 	PTR	sys_pkey_alloc
 	PTR	sys_pkey_free			/* 4365 */
+	PTR	sys_statx
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index 0687f96ee912..49765b44aa9b 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -438,4 +438,5 @@ EXPORT(sys_call_table)
 	PTR	sys_pkey_mprotect
 	PTR	sys_pkey_alloc
 	PTR	sys_pkey_free			/* 5325 */
+	PTR	sys_statx
 	.size	sys_call_table,.-sys_call_table
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 0331ba39a065..90bad2d1b2d3 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -433,4 +433,5 @@ EXPORT(sysn32_call_table)
 	PTR	sys_pkey_mprotect
 	PTR	sys_pkey_alloc
 	PTR	sys_pkey_free
+	PTR	sys_statx			/* 6330 */
 	.size	sysn32_call_table,.-sysn32_call_table
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 5a47042dd25f..2dd70bd104e1 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -588,4 +588,5 @@ EXPORT(sys32_call_table)
 	PTR	sys_pkey_mprotect
 	PTR	sys_pkey_alloc
 	PTR	sys_pkey_free			/* 4365 */
+	PTR	sys_statx
 	.size	sys32_call_table,.-sys32_call_table
-- 
2.11.1
