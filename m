Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Oct 2003 15:26:36 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:8934 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225402AbTJBO0E>; Thu, 2 Oct 2003 15:26:04 +0100
Received: from localhost (p7045-ip01funabasi.chiba.ocn.ne.jp [219.162.24.45])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C105147BF; Thu,  2 Oct 2003 23:25:01 +0900 (JST)
Date: Thu, 02 Oct 2003 23:41:16 +0900 (JST)
Message-Id: <20031002.234116.74756712.anemo@mba.ocn.ne.jp>
To: macro@ds2.pg.gda.pl
Cc: linux-mips@linux-mips.org
Subject: Re: time(2) for mips64
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.GSO.3.96.1031002150528.15189A-100000@delta.ds2.pg.gda.pl>
References: <20031002.144508.122621824.nemoto@toshiba-tops.co.jp>
	<Pine.GSO.3.96.1031002150528.15189A-100000@delta.ds2.pg.gda.pl>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 2 Oct 2003 15:07:20 +0200 (MET DST), "Maciej W. Rozycki" <macro@ds2.pg.gda.pl> said:

macro>  time(2) is obsolete (by gettimeofday(2)) and should be removed
macro> for new implementations.

Then could you apply these patches?

for 2.4:

diff -ur linux-mips-cvs/arch/mips64/kernel/scall_64.S linux.new/arch/mips64/kernel/scall_64.S
--- linux-mips-cvs/arch/mips64/kernel/scall_64.S	Tue Aug 26 23:41:57 2003
+++ linux.new/arch/mips64/kernel/scall_64.S	Thu Oct  2 23:15:23 2003
@@ -326,7 +326,7 @@
 	PTR	sys_lremovexattr		/* 5190 */
 	PTR	sys_fremovexattr
 	PTR	sys_tkill
-	PTR	sys_time
+	PTR	sys_ni_syscall
 	PTR	sys_ni_syscall			/* res. for futex */
 	PTR	sys_ni_syscall			/* 5195 rs. sched_setaffinity */
 	PTR	sys_ni_syscall			/* res. f. sched_getaffinity */
diff -ur linux-mips-cvs/arch/mips64/kernel/scall_n32.S linux.new/arch/mips64/kernel/scall_n32.S
--- linux-mips-cvs/arch/mips64/kernel/scall_n32.S	Tue Aug 26 23:41:58 2003
+++ linux.new/arch/mips64/kernel/scall_n32.S	Thu Oct  2 23:15:40 2003
@@ -326,7 +326,7 @@
 	PTR	sys_lremovexattr		/* 6190 */
 	PTR	sys_fremovexattr
 	PTR	sys_tkill
-	PTR	sys_time
+	PTR	sys_ni_syscall
 	PTR	sys_ni_syscall			/* res. for futex */
 	PTR	sys_ni_syscall			/* 6195 rs. sched_setaffinity */
 	PTR	sys_ni_syscall			/* res. f. sched_getaffinity */
diff -ur linux-mips-cvs/include/asm-mips64/unistd.h linux.new/include/asm-mips64/unistd.h
--- linux-mips-cvs/include/asm-mips64/unistd.h	Wed Sep 17 23:22:41 2003
+++ linux.new/include/asm-mips64/unistd.h	Thu Oct  2 23:13:19 2003
@@ -461,7 +461,7 @@
 #define __NR_lremovexattr		(__NR_Linux + 190)
 #define __NR_fremovexattr		(__NR_Linux + 191)
 #define __NR_tkill			(__NR_Linux + 192)
-#define __NR_time			(__NR_Linux + 193)
+#define __NR_unused193			(__NR_Linux + 193)
 #define __NR_futex			(__NR_Linux + 194)
 #define __NR_sched_setaffinity		(__NR_Linux + 195)
 #define __NR_sched_getaffinity		(__NR_Linux + 196)


And for 2.6:

diff -ur linux-mips-2.6-cvs/arch/mips/kernel/scall64-64.S linux-2.6.new/arch/mips/kernel/scall64-64.S
--- linux-mips-2.6-cvs/arch/mips/kernel/scall64-64.S	Sun Aug 31 20:14:45 2003
+++ linux-2.6.new/arch/mips/kernel/scall64-64.S	Thu Oct  2 23:21:18 2003
@@ -398,7 +398,7 @@
 	PTR	sys_lremovexattr		/* 5190 */
 	PTR	sys_fremovexattr
 	PTR	sys_tkill
-	PTR	sys_time
+	PTR	sys_ni_syscall
 	PTR	sys_futex
 	PTR	sys_sched_setaffinity		/* 5195 */
 	PTR	sys_sched_getaffinity
diff -ur linux-mips-2.6-cvs/arch/mips/kernel/scall64-n32.S linux-2.6.new/arch/mips/kernel/scall64-n32.S
--- linux-mips-2.6-cvs/arch/mips/kernel/scall64-n32.S	Sun Aug 31 20:14:45 2003
+++ linux-2.6.new/arch/mips/kernel/scall64-n32.S	Thu Oct  2 23:21:55 2003
@@ -303,7 +303,7 @@
 	PTR	sys_lremovexattr		/* 6190 */
 	PTR	sys_fremovexattr
 	PTR	sys_tkill
-	PTR	sys_time
+	PTR	sys_ni_syscall
 	PTR	compat_sys_futex
 	PTR	sys32_sched_setaffinity		/* 6195 */
 	PTR	sys32_sched_getaffinity
diff -ur linux-mips-2.6-cvs/include/asm-mips/unistd.h linux-2.6.new/include/asm-mips/unistd.h
--- linux-mips-2.6-cvs/include/asm-mips/unistd.h	Thu Jul 31 22:55:59 2003
+++ linux-2.6.new/include/asm-mips/unistd.h	Thu Oct  2 23:20:02 2003
@@ -498,7 +498,7 @@
 #define __NR_lremovexattr		(__NR_Linux + 190)
 #define __NR_fremovexattr		(__NR_Linux + 191)
 #define __NR_tkill			(__NR_Linux + 192)
-#define __NR_time			(__NR_Linux + 193)
+#define __NR_reserved193		(__NR_Linux + 193)
 #define __NR_futex			(__NR_Linux + 194)
 #define __NR_sched_setaffinity		(__NR_Linux + 195)
 #define __NR_sched_getaffinity		(__NR_Linux + 196)
@@ -742,7 +742,7 @@
 #define __NR_lremovexattr		(__NR_Linux + 190)
 #define __NR_fremovexattr		(__NR_Linux + 191)
 #define __NR_tkill			(__NR_Linux + 192)
-#define __NR_time			(__NR_Linux + 193)
+#define __NR_reserved193		(__NR_Linux + 193)
 #define __NR_futex			(__NR_Linux + 194)
 #define __NR_sched_setaffinity		(__NR_Linux + 195)
 #define __NR_sched_getaffinity		(__NR_Linux + 196)
---
Atsushi Nemoto
