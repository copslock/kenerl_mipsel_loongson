Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Jun 2009 18:58:31 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:33306 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492778AbZFZQ6Y (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 26 Jun 2009 18:58:24 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a44fd2e0002>; Fri, 26 Jun 2009 12:54:06 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 26 Jun 2009 09:54:02 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 26 Jun 2009 09:54:02 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n5QGrwuP007176;
	Fri, 26 Jun 2009 09:53:58 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n5QGrvoB007174;
	Fri, 26 Jun 2009 09:53:58 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Hookup sys_rt_tgsigqueueinfo and sys_perf_counter_open.
Date:	Fri, 26 Jun 2009 09:53:57 -0700
Message-Id: <1246035237-7150-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 26 Jun 2009 16:54:02.0456 (UTC) FILETIME=[B5494580:01C9F67E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

There are a couple of new syscalls.  Hook them up.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/unistd.h |   18 ++++++++++++------
 arch/mips/kernel/scall32-o32.S |    2 ++
 arch/mips/kernel/scall64-64.S  |    2 ++
 arch/mips/kernel/scall64-n32.S |    2 ++
 arch/mips/kernel/scall64-o32.S |    2 ++
 5 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index 4000501..b70c49f 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -352,16 +352,18 @@
 #define __NR_inotify_init1		(__NR_Linux + 329)
 #define __NR_preadv			(__NR_Linux + 330)
 #define __NR_pwritev			(__NR_Linux + 331)
+#define __NR_rt_tgsigqueueinfo		(__NR_Linux + 332)
+#define __NR_perf_counter_open		(__NR_Linux + 333)
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		331
+#define __NR_Linux_syscalls		333
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		331
+#define __NR_O32_Linux_syscalls		333
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -660,16 +662,18 @@
 #define __NR_inotify_init1		(__NR_Linux + 288)
 #define __NR_preadv			(__NR_Linux + 289)
 #define __NR_pwritev			(__NR_Linux + 290)
+#define __NR_rt_tgsigqueueinfo		(__NR_Linux + 291)
+#define __NR_perf_counter_open		(__NR_Linux + 292)
 
 /*
  * Offset of the last Linux 64-bit flavoured syscall
  */
-#define __NR_Linux_syscalls		290
+#define __NR_Linux_syscalls		292
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		290
+#define __NR_64_Linux_syscalls		292
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -972,16 +976,18 @@
 #define __NR_inotify_init1		(__NR_Linux + 292)
 #define __NR_preadv			(__NR_Linux + 293)
 #define __NR_pwritev			(__NR_Linux + 294)
+#define __NR_rt_tgsigqueueinfo		(__NR_Linux + 295)
+#define __NR_perf_counter_open		(__NR_Linux + 296)
 
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		294
+#define __NR_Linux_syscalls		296
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		294
+#define __NR_N32_Linux_syscalls		296
 
 #ifdef __KERNEL__
 
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 0b31b9b..20a86e0 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -652,6 +652,8 @@ einval:	li	v0, -ENOSYS
 	sys	sys_inotify_init1	1
 	sys	sys_preadv		6	/* 4330 */
 	sys	sys_pwritev		6
+	sys	sys_rt_tgsigqueueinfo	4
+	sys	sys_perf_counter_open	5
 	.endm
 
 	/* We pre-compute the number of _instruction_ bytes needed to
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index c647fd6..b046130 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -489,4 +489,6 @@ sys_call_table:
 	PTR	sys_inotify_init1
 	PTR	sys_preadv
 	PTR	sys_pwritev			/* 5390 */
+	PTR	sys_rt_tgsigqueueinfo
+	PTR	sys_perf_counter_open
 	.size	sys_call_table,.-sys_call_table
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 93cc672..49cf780 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -415,4 +415,6 @@ EXPORT(sysn32_call_table)
 	PTR	sys_inotify_init1
 	PTR	sys_preadv
 	PTR	sys_pwritev
+	PTR	compat_sys_rt_tgsigqueueinfo
+	PTR	sys_perf_counter_open
 	.size	sysn32_call_table,.-sysn32_call_table
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index a5598b2..781e0f1 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -535,4 +535,6 @@ sys_call_table:
 	PTR	sys_inotify_init1
 	PTR	compat_sys_preadv		/* 4330 */
 	PTR	compat_sys_pwritev
+	PTR	compat_sys_rt_tgsigqueueinfo
+	PTR	sys_perf_counter_open
 	.size	sys_call_table,.-sys_call_table
-- 
1.6.0.6
