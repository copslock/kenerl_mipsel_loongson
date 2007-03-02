Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Mar 2007 16:30:39 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:23793 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28573827AbXCBQae (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 2 Mar 2007 16:30:34 +0000
Received: from localhost (p2238-ipad211funabasi.chiba.ocn.ne.jp [58.91.158.238])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id 769ECB7F8
	for <linux-mips@linux-mips.org>; Sat,  3 Mar 2007 01:29:13 +0900 (JST)
Date:	Sat, 03 Mar 2007 01:29:14 +0900 (JST)
Message-Id: <20070303.012914.15243240.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Subject: Re: fadvise on MIPS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070217.004812.03978264.anemo@mba.ocn.ne.jp>
	<20070217.004329.108739438.anemo@mba.ocn.ne.jp>
References: <20070217.004329.108739438.anemo@mba.ocn.ne.jp>
	<20070217.004812.03978264.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 17 Feb 2007 00:43:29 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> 1) unistd.h defines __NR_fadvise64 for all ABI but no
> __NR_fadvise64_64.  But sys_fadvise64_64 is used for all syscall
> entries.  For N64, sys_fadvise64 and sys_fadvise64_64 are same so no
> problem, but for other ABIs size of 'len' argument cause mismatch
> between kernel and libc.
> 
> 2) On O32, glibc pass a 'long long' argument by hi and lo words, but
> kernel needs padding word between 'fd' and 'offset' argument.
> 
> 3) On N32, glibc pass a 'long long' argument by hi and lo words, but
> kernel expects a single register value for 'long long' argument.
> 
> 4) __ARCH_WANT_SYS_FADVISE64 is defined in unistd.h but sys_fadvise64
> is not used.
> 
> What is preferred way to fix those issues?
> 
> It seems N64 do not need any fix.
> 
> For N32 and O32, kernel should be fixed anyway, but which syscall
> should be supported?  And whether kernel or libc should take care of
> 'long long' issue?

Then how about this absolutely untested patch?

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 7c0b393..4d46b1d 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -596,7 +596,7 @@ einval:	li	v0, -EINVAL
 	sys	sys_remap_file_pages	5
 	sys	sys_set_tid_address	1
 	sys	sys_restart_syscall	0
-	sys	sys_fadvise64_64	7
+	sys	_sys_fadvise64		5
 	sys	sys_statfs64		3	/* 4255 */
 	sys	sys_fstatfs64		2
 	sys	sys_timer_create	3
@@ -647,7 +647,7 @@ einval:	li	v0, -EINVAL
 	sys	sys_ppoll		5
 	sys	sys_unshare		1
 	sys	sys_splice		4
-	sys	sys_sync_file_range	7	/* 4305 */
+	sys	_sys_sync_file_range	6	/* 4305 */
 	sys	sys_tee			4
 	sys	sys_vmsplice		4
 	sys	sys_move_pages		6
@@ -656,6 +656,7 @@ einval:	li	v0, -EINVAL
 	sys	sys_kexec_load		4
 	sys	sys_getcpu		3
 	sys	sys_epoll_pwait		6
+	sys	_sys_fadvise64_64	6
 	.endm
 
 	/* We pre-compute the number of _instruction_ bytes needed to
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index f17e31e..2013773 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -336,7 +336,7 @@ EXPORT(sysn32_call_table)
 	PTR	sys_set_tid_address
 	PTR	sys_restart_syscall
 	PTR	compat_sys_semtimedop			/* 6215 */
-	PTR	sys_fadvise64_64
+	PTR	_sys_fadvise64
 	PTR	compat_sys_statfs64
 	PTR	compat_sys_fstatfs64
 	PTR	sys_sendfile64
@@ -397,3 +397,4 @@ EXPORT(sysn32_call_table)
 	PTR	compat_sys_kexec_load
 	PTR	sys_getcpu
 	PTR	compat_sys_epoll_pwait
+	PTR	_sys_fadvise64_64
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 142c9b7..3cc443b 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -459,7 +459,7 @@ sys_call_table:
 	PTR	sys_remap_file_pages
 	PTR	sys_set_tid_address
 	PTR	sys_restart_syscall
-	PTR	sys_fadvise64_64
+	PTR	_sys_fadvise64
 	PTR	compat_sys_statfs64		/* 4255 */
 	PTR	compat_sys_fstatfs64
 	PTR	compat_sys_timer_create
@@ -519,4 +519,5 @@ sys_call_table:
 	PTR	compat_sys_kexec_load
 	PTR	sys_getcpu
 	PTR	compat_sys_epoll_pwait
+	PTR	_sys_fadvise64_64
 	.size	sys_call_table,.-sys_call_table
diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 26e1a7e..ab8af1c 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -435,3 +435,29 @@ int kernel_execve(const char *filename,
 
 	return -__v0;
 }
+
+#if defined(CONFIG_32BIT) || defined(CONFIG_MIPS32_COMPAT)
+#ifdef __BIG_ENDIAN
+#define merge_64(r1,r2)	(((u64)(r1) << 32) + ((u32)(r2)))
+#else
+#define merge_64(r1,r2)	(((u64)(r2) << 32) + ((u32)(r1)))
+#endif
+asmlinkage long _sys_fadvise64_64(int fd, long a1, long a2, long a3, long a4,
+				  int advice)
+{
+	return sys_fadvise64_64(fd, merge_64(a1, a2), merge_64(a3, a4),
+				advice);
+}
+
+asmlinkage long _sys_fadvise64(int fd, long a1, long a2, size_t len, int advice)
+{
+	return sys_fadvise64_64(fd, merge_64(a1, a2), len, advice);
+}
+
+asmlinkage long _sys_sync_file_range(int fd, long a1, long a2, long a3, long a4,
+				     unsigned int flags)
+{
+	return sys_sync_file_range(fd, merge_64(a1, a2), merge_64(a3, a4),
+				   flags);
+}
+#endif
diff --git a/include/asm-mips/unistd.h b/include/asm-mips/unistd.h
index 696cff3..bf3ff4a 100644
--- a/include/asm-mips/unistd.h
+++ b/include/asm-mips/unistd.h
@@ -334,6 +334,7 @@
 #define __NR_kexec_load			(__NR_Linux + 311)
 #define __NR_getcpu			(__NR_Linux + 312)
 #define __NR_epoll_pwait		(__NR_Linux + 313)
+#define __NR_fadvise64_64		(__NR_Linux + 314)
 
 /*
  * Offset of the last Linux o32 flavoured syscall
@@ -918,6 +919,7 @@
 #define __NR_kexec_load			(__NR_Linux + 274)
 #define __NR_getcpu			(__NR_Linux + 275)
 #define __NR_epoll_pwait		(__NR_Linux + 276)
+#define __NR_fadvise64_64		(__NR_Linux + 277)
 
 /*
  * Offset of the last N32 flavoured syscall
