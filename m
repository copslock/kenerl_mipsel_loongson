Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Mar 2011 18:38:32 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15181 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491954Ab1CRRi2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Mar 2011 18:38:28 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d8398c80000>; Fri, 18 Mar 2011 10:39:20 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 18 Mar 2011 10:37:34 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 18 Mar 2011 10:37:34 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p2IHbSXY019814;
        Fri, 18 Mar 2011 10:37:28 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p2IHbOBq019803;
        Fri, 18 Mar 2011 10:37:24 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Hook up sys_name_to_handle_at, sys_open_by_handle_at and sys_clock_adjtime.
Date:   Fri, 18 Mar 2011 10:37:23 -0700
Message-Id: <1300469843-19771-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 18 Mar 2011 17:37:34.0579 (UTC) FILETIME=[2A7A1C30:01CBE593]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

These system calls we recently added.

32-bit ABIs need compat handling for sys_clock_adjtime().

o32 also needs compat handling for sys_open_by_handle_at();

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/unistd.h |   21 +++++++++++++++------
 arch/mips/kernel/scall32-o32.S |    3 +++
 arch/mips/kernel/scall64-64.S  |    3 +++
 arch/mips/kernel/scall64-n32.S |    3 +++
 arch/mips/kernel/scall64-o32.S |    3 +++
 5 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index 550725b..d1ea5ea 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -359,16 +359,19 @@
 #define __NR_fanotify_init		(__NR_Linux + 336)
 #define __NR_fanotify_mark		(__NR_Linux + 337)
 #define __NR_prlimit64			(__NR_Linux + 338)
+#define __NR_name_to_handle_at		(__NR_Linux + 339)
+#define __NR_open_by_handle_at		(__NR_Linux + 340)
+#define __NR_clock_adjtime		(__NR_Linux + 341)
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		338
+#define __NR_Linux_syscalls		341
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		338
+#define __NR_O32_Linux_syscalls		341
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -674,16 +677,19 @@
 #define __NR_fanotify_init		(__NR_Linux + 295)
 #define __NR_fanotify_mark		(__NR_Linux + 296)
 #define __NR_prlimit64			(__NR_Linux + 297)
+#define __NR_name_to_handle_at		(__NR_Linux + 298)
+#define __NR_open_by_handle_at		(__NR_Linux + 299)
+#define __NR_clock_adjtime		(__NR_Linux + 300)
 
 /*
  * Offset of the last Linux 64-bit flavoured syscall
  */
-#define __NR_Linux_syscalls		297
+#define __NR_Linux_syscalls		300
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		297
+#define __NR_64_Linux_syscalls		300
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -994,16 +1000,19 @@
 #define __NR_fanotify_init		(__NR_Linux + 300)
 #define __NR_fanotify_mark		(__NR_Linux + 301)
 #define __NR_prlimit64			(__NR_Linux + 302)
+#define __NR_name_to_handle_at		(__NR_Linux + 303)
+#define __NR_open_by_handle_at		(__NR_Linux + 304)
+#define __NR_clock_adjtime		(__NR_Linux + 305)
 
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		302
+#define __NR_Linux_syscalls		305
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		302
+#define __NR_N32_Linux_syscalls		305
 
 #ifdef __KERNEL__
 
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index fbaabad..66b439d 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -586,6 +586,9 @@ einval:	li	v0, -ENOSYS
 	sys	sys_fanotify_init	2
 	sys	sys_fanotify_mark	6
 	sys	sys_prlimit64		4
+	sys	sys_name_to_handle_at	5
+	sys	sys_open_by_handle_at	3	/* 4340 */
+	sys	sys_clock_adjtime	2
 	.endm
 
 	/* We pre-compute the number of _instruction_ bytes needed to
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index 3f41792..0ccd6e3 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -425,4 +425,7 @@ sys_call_table:
 	PTR	sys_fanotify_init		/* 5295 */
 	PTR	sys_fanotify_mark
 	PTR	sys_prlimit64
+	PTR	sys_name_to_handle_at
+	PTR	sys_open_by_handle_at
+	PTR	sys_clock_adjtime		/* 5300 */
 	.size	sys_call_table,.-sys_call_table
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index f08ece6..179d1c8 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -425,4 +425,7 @@ EXPORT(sysn32_call_table)
 	PTR	sys_fanotify_init		/* 6300 */
 	PTR	sys_fanotify_mark
 	PTR	sys_prlimit64
+	PTR	sys_name_to_handle_at
+	PTR	sys_open_by_handle_at
+	PTR	compat_sys_clock_adjtime	/* 6305 */
 	.size	sysn32_call_table,.-sysn32_call_table
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 78d768a..5c4e0dc 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -543,4 +543,7 @@ sys_call_table:
 	PTR	sys_fanotify_init
 	PTR	sys_32_fanotify_mark
 	PTR	sys_prlimit64
+	PTR	sys_name_to_handle_at
+	PTR	compat_sys_open_by_handle_at	/* 4340 */
+	PTR	compat_sys_clock_adjtime
 	.size	sys_call_table,.-sys_call_table
-- 
1.7.2.3
