Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 May 2007 15:29:21 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:40687 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022722AbXE2O3U (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 29 May 2007 15:29:20 +0100
Received: from localhost (p1139-ipad32funabasi.chiba.ocn.ne.jp [221.189.133.139])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id CF70DA7C9; Tue, 29 May 2007 23:29:14 +0900 (JST)
Date:	Tue, 29 May 2007 23:29:40 +0900 (JST)
Message-Id: <20070529.232940.27955433.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Wire up utimensat, signalfd, timerfd, eventfd
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 0c9a9ff..ae985d1 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -657,7 +657,11 @@ einval:	li	v0, -EINVAL
 	sys	sys_getcpu		3
 	sys	sys_epoll_pwait		6
 	sys	sys_ioprio_set		3
-	sys	sys_ioprio_get		2
+	sys	sys_ioprio_get		2	/* 4315 */
+	sys	sys_utimensat		4
+	sys	sys_signalfd		3
+	sys	sys_timerfd		4
+	sys	sys_eventfd		1
 	.endm
 
 	/* We pre-compute the number of _instruction_ bytes needed to
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index 23f3b11..7bcd5a1 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -473,4 +473,8 @@ sys_call_table:
 	PTR	sys_epoll_pwait
 	PTR	sys_ioprio_set
 	PTR	sys_ioprio_get
+	PTR	sys_utimensat			/* 5275 */
+	PTR	sys_signalfd
+	PTR	sys_timerfd
+	PTR	sys_eventfd
 	.size	sys_call_table,.-sys_call_table
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 1631035..532a2f3 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -399,4 +399,8 @@ EXPORT(sysn32_call_table)
 	PTR	compat_sys_epoll_pwait
 	PTR	sys_ioprio_set
 	PTR	sys_ioprio_get
+	PTR	compat_sys_utimensat
+	PTR	compat_sys_signalfd		/* 5280 */
+	PTR	compat_sys_timerfd
+	PTR	sys_eventfd
 	.size	sysn32_call_table,.-sysn32_call_table
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 2aa9942..6bbe0f4 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -521,4 +521,8 @@ sys_call_table:
 	PTR	compat_sys_epoll_pwait
 	PTR	sys_ioprio_set
 	PTR	sys_ioprio_get			/* 4315 */
+	PTR	compat_sys_utimensat
+	PTR	compat_sys_signalfd
+	PTR	compat_sys_timerfd
+	PTR	sys_eventfd
 	.size	sys_call_table,.-sys_call_table
diff --git a/include/asm-mips/unistd.h b/include/asm-mips/unistd.h
index 91c306f..4aab8f9 100644
--- a/include/asm-mips/unistd.h
+++ b/include/asm-mips/unistd.h
@@ -336,16 +336,20 @@
 #define __NR_epoll_pwait		(__NR_Linux + 313)
 #define __NR_ioprio_set			(__NR_Linux + 314)
 #define __NR_ioprio_get			(__NR_Linux + 315)
+#define __NR_utimensat			(__NR_Linux + 316)
+#define __NR_signalfd			(__NR_Linux + 317)
+#define __NR_timerfd			(__NR_Linux + 318)
+#define __NR_eventfd			(__NR_Linux + 319)
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		315
+#define __NR_Linux_syscalls		319
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		315
+#define __NR_O32_Linux_syscalls		319
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -628,16 +632,20 @@
 #define __NR_epoll_pwait		(__NR_Linux + 272)
 #define __NR_ioprio_set			(__NR_Linux + 273)
 #define __NR_ioprio_get			(__NR_Linux + 274)
+#define __NR_utimensat			(__NR_Linux + 275)
+#define __NR_signalfd			(__NR_Linux + 276)
+#define __NR_timerfd			(__NR_Linux + 277)
+#define __NR_eventfd			(__NR_Linux + 278)
 
 /*
  * Offset of the last Linux 64-bit flavoured syscall
  */
-#define __NR_Linux_syscalls		274
+#define __NR_Linux_syscalls		278
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		274
+#define __NR_64_Linux_syscalls		278
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -924,16 +932,20 @@
 #define __NR_epoll_pwait		(__NR_Linux + 276)
 #define __NR_ioprio_set			(__NR_Linux + 277)
 #define __NR_ioprio_get			(__NR_Linux + 278)
+#define __NR_utimensat			(__NR_Linux + 279)
+#define __NR_signalfd			(__NR_Linux + 280)
+#define __NR_timerfd			(__NR_Linux + 281)
+#define __NR_eventfd			(__NR_Linux + 282)
 
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		278
+#define __NR_Linux_syscalls		282
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		278
+#define __NR_N32_Linux_syscalls		282
 
 #ifdef __KERNEL__
 
