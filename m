Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Aug 2010 23:10:58 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11320 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491073Ab0HWVKx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Aug 2010 23:10:53 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c72e3f80000>; Mon, 23 Aug 2010 14:11:20 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 23 Aug 2010 14:10:48 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 23 Aug 2010 14:10:48 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o7NLAidx006022;
        Mon, 23 Aug 2010 14:10:44 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o7NLAf1p006020;
        Mon, 23 Aug 2010 14:10:41 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Hookup fanotify_init, fanotify_mark, and prlimit64 syscalls.
Date:   Mon, 23 Aug 2010 14:10:37 -0700
Message-Id: <1282597837-5988-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.1
X-OriginalArrivalTime: 23 Aug 2010 21:10:48.0728 (UTC) FILETIME=[A8E01180:01CB4307]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/unistd.h |   21 +++++++++++++++------
 arch/mips/kernel/linux32.c     |    7 +++++++
 arch/mips/kernel/scall32-o32.S |    5 ++++-
 arch/mips/kernel/scall64-64.S  |    5 ++++-
 arch/mips/kernel/scall64-n32.S |    7 +++++--
 arch/mips/kernel/scall64-o32.S |    5 ++++-
 6 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index baa318a..550725b 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -356,16 +356,19 @@
 #define __NR_perf_event_open		(__NR_Linux + 333)
 #define __NR_accept4			(__NR_Linux + 334)
 #define __NR_recvmmsg			(__NR_Linux + 335)
+#define __NR_fanotify_init		(__NR_Linux + 336)
+#define __NR_fanotify_mark		(__NR_Linux + 337)
+#define __NR_prlimit64			(__NR_Linux + 338)
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		335
+#define __NR_Linux_syscalls		338
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		335
+#define __NR_O32_Linux_syscalls		338
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -668,16 +671,19 @@
 #define __NR_perf_event_open		(__NR_Linux + 292)
 #define __NR_accept4			(__NR_Linux + 293)
 #define __NR_recvmmsg			(__NR_Linux + 294)
+#define __NR_fanotify_init		(__NR_Linux + 295)
+#define __NR_fanotify_mark		(__NR_Linux + 296)
+#define __NR_prlimit64			(__NR_Linux + 297)
 
 /*
  * Offset of the last Linux 64-bit flavoured syscall
  */
-#define __NR_Linux_syscalls		294
+#define __NR_Linux_syscalls		297
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		294
+#define __NR_64_Linux_syscalls		297
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -985,16 +991,19 @@
 #define __NR_accept4			(__NR_Linux + 297)
 #define __NR_recvmmsg			(__NR_Linux + 298)
 #define __NR_getdents64			(__NR_Linux + 299)
+#define __NR_fanotify_init		(__NR_Linux + 300)
+#define __NR_fanotify_mark		(__NR_Linux + 301)
+#define __NR_prlimit64			(__NR_Linux + 302)
 
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		299
+#define __NR_Linux_syscalls		302
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		299
+#define __NR_N32_Linux_syscalls		302
 
 #ifdef __KERNEL__
 
diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index c2dab14..6343b4a 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -341,3 +341,10 @@ asmlinkage long sys32_lookup_dcookie(u32 a0, u32 a1, char __user *buf,
 {
 	return sys_lookup_dcookie(merge_64(a0, a1), buf, len);
 }
+
+SYSCALL_DEFINE6(32_fanotify_mark, int, fanotify_fd, unsigned int, flags,
+		u64, a3, u64, a4, int, dfd, const char  __user *, pathname)
+{
+	return sys_fanotify_mark(fanotify_fd, flags, merge_64(a3, a4),
+				 dfd, pathname);
+}
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 17202bb..584415e 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -583,7 +583,10 @@ einval:	li	v0, -ENOSYS
 	sys	sys_rt_tgsigqueueinfo	4
 	sys	sys_perf_event_open	5
 	sys	sys_accept4		4
-	sys     sys_recvmmsg            5
+	sys	sys_recvmmsg		5	/* 4335 */
+	sys	sys_fanotify_init	2
+	sys	sys_fanotify_mark	6
+	sys	sys_prlimit64		4
 	.endm
 
 	/* We pre-compute the number of _instruction_ bytes needed to
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index a8a6c59..f02aeeb 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -420,5 +420,8 @@ sys_call_table:
 	PTR	sys_rt_tgsigqueueinfo
 	PTR	sys_perf_event_open
 	PTR	sys_accept4
-	PTR     sys_recvmmsg
+	PTR	sys_recvmmsg
+	PTR	sys_fanotify_init		/* 5395 */
+	PTR	sys_fanotify_mark
+	PTR	sys_prlimit64
 	.size	sys_call_table,.-sys_call_table
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index a3d6613..a2514da 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -418,6 +418,9 @@ EXPORT(sysn32_call_table)
 	PTR	compat_sys_rt_tgsigqueueinfo	/* 6295 */
 	PTR	sys_perf_event_open
 	PTR	sys_accept4
-	PTR     compat_sys_recvmmsg
-	PTR     sys_getdents
+	PTR	compat_sys_recvmmsg
+	PTR	sys_getdents
+	PTR	sys_fanotify_init		/* 6300 */
+	PTR	sys_fanotify_mark
+	PTR	sys_prlimit64
 	.size	sysn32_call_table,.-sysn32_call_table
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 813689e..171979f 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -538,5 +538,8 @@ sys_call_table:
 	PTR	compat_sys_rt_tgsigqueueinfo
 	PTR	sys_perf_event_open
 	PTR	sys_accept4
-	PTR     compat_sys_recvmmsg
+	PTR	compat_sys_recvmmsg		/* 4335 */
+	PTR	sys_fanotify_init
+	PTR	sys_32_fanotify_mark
+	PTR	sys_prlimit64
 	.size	sys_call_table,.-sys_call_table
-- 
1.7.2.1
