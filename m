Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2007 16:02:53 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.175.29]:50139 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021413AbXCFQCs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 6 Mar 2007 16:02:48 +0000
Received: from localhost (p5247-ipad28funabasi.chiba.ocn.ne.jp [220.107.204.247])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id BF949BA90; Wed,  7 Mar 2007 00:39:31 +0900 (JST)
Date:	Wed, 07 Mar 2007 00:39:31 +0900 (JST)
Message-Id: <20070307.003931.25235381.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, kraj@mvista.com
Subject: [PATCH] Fix some system calls with long long arguments
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 14377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

fadvise64(), readahead(), sync_file_range() have long long argument(s)
but glibc passes it by hi/lo pair without padding, on both O32 and
N32.

Also wire up fadvise64_64() and fixup confusion of it with
fadvise64().

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/kernel/linux32.c     |   16 ----------------
 arch/mips/kernel/scall32-o32.S |    7 ++++---
 arch/mips/kernel/scall64-n32.S |    5 +++--
 arch/mips/kernel/scall64-o32.S |    3 ++-
 arch/mips/kernel/syscall.c     |   33 +++++++++++++++++++++++++++++++++
 include/asm-mips/unistd.h      |   10 ++++++----
 6 files changed, 48 insertions(+), 26 deletions(-)

diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 30d433f..71e1524 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -528,22 +528,6 @@ asmlinkage int sys32_sendfile(int out_fd
 	return ret;
 }
 
-asmlinkage ssize_t sys32_readahead(int fd, u32 pad0, u64 a2, u64 a3,
-                                   size_t count)
-{
-	return sys_readahead(fd, merge_64(a2, a3), count);
-}
-
-asmlinkage long sys32_sync_file_range(int fd, int __pad,
-	unsigned long a2, unsigned long a3,
-	unsigned long a4, unsigned long a5,
-	int flags)
-{
-	return sys_sync_file_range(fd,
-			merge_64(a2, a3), merge_64(a4, a5),
-			flags);
-}
-
 save_static_function(sys32_clone);
 __attribute_used__ noinline static int
 _sys32_clone(nabi_no_regargs struct pt_regs regs)
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 7c0b393..b898a7c 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -554,7 +554,7 @@ einval:	li	v0, -EINVAL
 	sys	sys_fcntl64		3	/* 4220 */
 	sys	sys_ni_syscall		0
 	sys	sys_gettid		0
-	sys	sys_readahead		5
+	sys	sys32_readahead		4
 	sys	sys_setxattr		5
 	sys	sys_lsetxattr		5	/* 4225 */
 	sys	sys_fsetxattr		5
@@ -596,7 +596,7 @@ einval:	li	v0, -EINVAL
 	sys	sys_remap_file_pages	5
 	sys	sys_set_tid_address	1
 	sys	sys_restart_syscall	0
-	sys	sys_fadvise64_64	7
+	sys	sys32_fadvise64		5
 	sys	sys_statfs64		3	/* 4255 */
 	sys	sys_fstatfs64		2
 	sys	sys_timer_create	3
@@ -647,7 +647,7 @@ einval:	li	v0, -EINVAL
 	sys	sys_ppoll		5
 	sys	sys_unshare		1
 	sys	sys_splice		4
-	sys	sys_sync_file_range	7	/* 4305 */
+	sys	sys32_sync_file_range	6	/* 4305 */
 	sys	sys_tee			4
 	sys	sys_vmsplice		4
 	sys	sys_move_pages		6
@@ -656,6 +656,7 @@ einval:	li	v0, -EINVAL
 	sys	sys_kexec_load		4
 	sys	sys_getcpu		3
 	sys	sys_epoll_pwait		6
+	sys	sys32_fadvise64_64	6
 	.endm
 
 	/* We pre-compute the number of _instruction_ bytes needed to
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index f17e31e..c554f28 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -336,7 +336,7 @@ EXPORT(sysn32_call_table)
 	PTR	sys_set_tid_address
 	PTR	sys_restart_syscall
 	PTR	compat_sys_semtimedop			/* 6215 */
-	PTR	sys_fadvise64_64
+	PTR	sys32_fadvise64
 	PTR	compat_sys_statfs64
 	PTR	compat_sys_fstatfs64
 	PTR	sys_sendfile64
@@ -388,7 +388,7 @@ EXPORT(sysn32_call_table)
 	PTR	sys_ppoll			/* 6265 */
 	PTR	sys_unshare
 	PTR	sys_splice
-	PTR	sys_sync_file_range
+	PTR	sys32_sync_file_range
 	PTR	sys_tee
 	PTR	sys_vmsplice			/* 6270 */
 	PTR	sys_move_pages
@@ -397,3 +397,4 @@ EXPORT(sysn32_call_table)
 	PTR	compat_sys_kexec_load
 	PTR	sys_getcpu
 	PTR	compat_sys_epoll_pwait
+	PTR	sys32_fadvise64_64
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 142c9b7..5b7ca00 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -459,7 +459,7 @@ sys_call_table:
 	PTR	sys_remap_file_pages
 	PTR	sys_set_tid_address
 	PTR	sys_restart_syscall
-	PTR	sys_fadvise64_64
+	PTR	sys32_fadvise64
 	PTR	compat_sys_statfs64		/* 4255 */
 	PTR	compat_sys_fstatfs64
 	PTR	compat_sys_timer_create
@@ -519,4 +519,5 @@ sys_call_table:
 	PTR	compat_sys_kexec_load
 	PTR	sys_getcpu
 	PTR	compat_sys_epoll_pwait
+	PTR	sys32_fadvise64_64
 	.size	sys_call_table,.-sys_call_table
diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 26e1a7e..6e107fc 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -435,3 +435,36 @@ int kernel_execve(const char *filename,
 
 	return -__v0;
 }
+
+#if defined(CONFIG_32BIT) || defined(CONFIG_MIPS32_COMPAT)
+#ifdef __BIG_ENDIAN
+#define merge_64(r1,r2)	(((u64)(r1) << 32) + ((u32)(r2)))
+#else
+#define merge_64(r1,r2)	(((u64)(r2) << 32) + ((u32)(r1)))
+#endif
+asmlinkage long sys32_fadvise64_64(int fd, long a1, long a2, long a3, long a4,
+	int advice)
+{
+	return sys_fadvise64_64(fd, merge_64(a1, a2), merge_64(a3, a4),
+				advice);
+}
+
+asmlinkage long sys32_fadvise64(int fd, long a1, long a2, size_t len,
+	int advice)
+{
+	return sys_fadvise64_64(fd, merge_64(a1, a2), len, advice);
+}
+
+asmlinkage ssize_t sys32_readahead(int fd, long a1, long a2, size_t count)
+{
+	return sys_readahead(fd, merge_64(a1, a2), count);
+}
+
+asmlinkage long sys32_sync_file_range(int fd, long a1, long a2,
+	long a3, long a4, unsigned int flags)
+{
+	return sys_sync_file_range(fd, merge_64(a1, a2), merge_64(a3, a4),
+				   flags);
+}
+
+#endif
diff --git a/include/asm-mips/unistd.h b/include/asm-mips/unistd.h
index 696cff3..949e956 100644
--- a/include/asm-mips/unistd.h
+++ b/include/asm-mips/unistd.h
@@ -334,16 +334,17 @@
 #define __NR_kexec_load			(__NR_Linux + 311)
 #define __NR_getcpu			(__NR_Linux + 312)
 #define __NR_epoll_pwait		(__NR_Linux + 313)
+#define __NR_fadvise64_64		(__NR_Linux + 314)
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		313
+#define __NR_Linux_syscalls		314
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		313
+#define __NR_O32_Linux_syscalls		314
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -918,16 +919,17 @@
 #define __NR_kexec_load			(__NR_Linux + 274)
 #define __NR_getcpu			(__NR_Linux + 275)
 #define __NR_epoll_pwait		(__NR_Linux + 276)
+#define __NR_fadvise64_64		(__NR_Linux + 277)
 
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		276
+#define __NR_Linux_syscalls		277
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		276
+#define __NR_N32_Linux_syscalls		277
 
 #ifdef __KERNEL__
 
