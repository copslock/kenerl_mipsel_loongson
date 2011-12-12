Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Dec 2011 22:48:52 +0100 (CET)
Received: from 206.83.70.73.ptr.us.xo.net ([206.83.70.73]:11550 "EHLO
        king.tilera.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903738Ab1LLVsl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Dec 2011 22:48:41 +0100
Received: from farm-0002.internal.tilera.com ([10.2.0.32]) by king.tilera.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 12 Dec 2011 16:48:31 -0500
Received: (from cmetcalf@localhost)
        by farm-0002.internal.tilera.com (8.13.8/8.12.11/Submit) id pBCLmPH0023959;
        Mon, 12 Dec 2011 16:48:25 -0500
Message-Id: <201112122148.pBCLmPH0023959@farm-0002.internal.tilera.com>
From:   Chris Metcalf <cmetcalf@tilera.com>
Date:   Fri, 9 Dec 2011 10:29:07 -0500
Subject: [PATCH v3] ipc: provide generic compat versions of IPC syscalls
References: <201112091536.pB9Fa5f7002738@farm-0002.internal.tilera.com> <201112091903.pB9J39pd031553@farm-0002.internal.tilera.com> <20111209134852.f5b5bcbc.akpm@linux-foundation.org> <1690400.7yOAjHVqTH@wuerfel>
In-Reply-To: <1690400.7yOAjHVqTH@wuerfel>
To:     Arnd Bergmann <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christoph Hellwig <hch@lst.de>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "J. Bruce Fields" <bfields@redhat.com>, NeilBrown <neilb@suse.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org
X-OriginalArrivalTime: 12 Dec 2011 21:48:31.0319 (UTC) FILETIME=[CA1D0E70:01CCB917]
X-archive-position: 32088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cmetcalf@tilera.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9691

When using the "compat" APIs, architectures will generally want to
be able to make direct syscalls to msgsnd(), shmctl(), etc., and
in the kernel we would want them to be handled directly by
compat_sys_xxx() functions, as is true for other compat syscalls.

However, for historical reasons, several of the existing compat IPC
syscalls do not do this.  semctl() expects a pointer to the fourth
argument, instead of the fourth argument itself.  msgsnd(), msgrcv()
and shmat() expect arguments in different order.

This change adds an ARCH_WANT_OLD_COMPAT_IPC config option that can be
set to preserve this behavior for ports that use it (x86, sparc, powerpc,
s390, and mips).  No actual semantics are changed for those architectures,
and there is only a minimal amount of code refactoring in ipc/compat.c.

Newer architectures like tile (and perhaps future architectures such
as arm64 and unicore64) should not select this option, and thus can
avoid having any IPC-specific code at all in their architecture-specific
compat layer.  In the same vein, if this option is not selected, IPC_64
mode is assumed, since that's what the <asm-generic> headers expect.

The workaround code in "tile" for msgsnd() and msgrcv() is removed
with this change; it also fixes the bug that shmat() and semctl() were
not being properly handled.

Signed-off-by: Chris Metcalf <cmetcalf@tilera.com>
---
 arch/Kconfig                   |    3 ++
 arch/mips/Kconfig              |    1 +
 arch/powerpc/Kconfig           |    1 +
 arch/s390/Kconfig              |    1 +
 arch/sparc/Kconfig             |    1 +
 arch/tile/include/asm/compat.h |   11 ------
 arch/tile/kernel/compat.c      |   43 ------------------------
 arch/x86/Kconfig               |    1 +
 include/linux/compat.h         |   12 ++++++-
 ipc/compat.c                   |   70 ++++++++++++++++++++++++++++++++++++---
 10 files changed, 83 insertions(+), 61 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 4b0669c..dfb1e07 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -181,4 +181,7 @@ config HAVE_RCU_TABLE_FREE
 config ARCH_HAVE_NMI_SAFE_CMPXCHG
 	bool
 
+config ARCH_WANT_OLD_COMPAT_IPC
+	bool
+
 source "kernel/gcov/Kconfig"
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d46f1da..ad2af82 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2420,6 +2420,7 @@ config MIPS32_COMPAT
 config COMPAT
 	bool
 	depends on MIPS32_COMPAT
+	select ARCH_WANT_OLD_COMPAT_IPC
 	default y
 
 config SYSVIPC_COMPAT
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 951e18f..e2be710 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -146,6 +146,7 @@ config COMPAT
 	bool
 	default y if PPC64
 	select COMPAT_BINFMT_ELF
+	select ARCH_WANT_OLD_COMPAT_IPC
 
 config SYSVIPC_COMPAT
 	bool
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 373679b..2fc3bca 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -221,6 +221,7 @@ config COMPAT
 	prompt "Kernel support for 31 bit emulation"
 	depends on 64BIT
 	select COMPAT_BINFMT_ELF
+	select ARCH_WANT_OLD_COMPAT_IPC
 	help
 	  Select this option if you want to enable your system kernel to
 	  handle system-calls from ELF binaries for 31 bit ESA.  This option
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index f92602e..846cb5c 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -577,6 +577,7 @@ config COMPAT
 	depends on SPARC64
 	default y
 	select COMPAT_BINFMT_ELF
+	select ARCH_WANT_OLD_COMPAT_IPC
 
 config SYSVIPC_COMPAT
 	bool
diff --git a/arch/tile/include/asm/compat.h b/arch/tile/include/asm/compat.h
index bf95f55..4b4b289 100644
--- a/arch/tile/include/asm/compat.h
+++ b/arch/tile/include/asm/compat.h
@@ -242,17 +242,6 @@ long compat_sys_fallocate(int fd, int mode,
 long compat_sys_sched_rr_get_interval(compat_pid_t pid,
 				      struct compat_timespec __user *interval);
 
-/* Versions of compat functions that differ from generic Linux. */
-struct compat_msgbuf;
-long tile_compat_sys_msgsnd(int msqid,
-			    struct compat_msgbuf __user *msgp,
-			    size_t msgsz, int msgflg);
-long tile_compat_sys_msgrcv(int msqid,
-			    struct compat_msgbuf __user *msgp,
-			    size_t msgsz, long msgtyp, int msgflg);
-long tile_compat_sys_ptrace(compat_long_t request, compat_long_t pid,
-			    compat_long_t addr, compat_long_t data);
-
 /* Tilera Linux syscalls that don't have "compat" versions. */
 #define compat_sys_flush_cache sys_flush_cache
 
diff --git a/arch/tile/kernel/compat.c b/arch/tile/kernel/compat.c
index bf5e9d7..d67459b 100644
--- a/arch/tile/kernel/compat.c
+++ b/arch/tile/kernel/compat.c
@@ -16,7 +16,6 @@
 #define __SYSCALL_COMPAT
 
 #include <linux/compat.h>
-#include <linux/msg.h>
 #include <linux/syscalls.h>
 #include <linux/kdev_t.h>
 #include <linux/fs.h>
@@ -95,52 +94,10 @@ long compat_sys_sched_rr_get_interval(compat_pid_t pid,
 	return ret;
 }
 
-/*
- * The usual compat_sys_msgsnd() and _msgrcv() seem to be assuming
- * some different calling convention than our normal 32-bit tile code.
- */
-
-/* Already defined in ipc/compat.c, but we need it here. */
-struct compat_msgbuf {
-	compat_long_t mtype;
-	char mtext[1];
-};
-
-long tile_compat_sys_msgsnd(int msqid,
-			    struct compat_msgbuf __user *msgp,
-			    size_t msgsz, int msgflg)
-{
-	compat_long_t mtype;
-
-	if (get_user(mtype, &msgp->mtype))
-		return -EFAULT;
-	return do_msgsnd(msqid, mtype, msgp->mtext, msgsz, msgflg);
-}
-
-long tile_compat_sys_msgrcv(int msqid,
-			    struct compat_msgbuf __user *msgp,
-			    size_t msgsz, long msgtyp, int msgflg)
-{
-	long err, mtype;
-
-	err =  do_msgrcv(msqid, &mtype, msgp->mtext, msgsz, msgtyp, msgflg);
-	if (err < 0)
-		goto out;
-
-	if (put_user(mtype, &msgp->mtype))
-		err = -EFAULT;
- out:
-	return err;
-}
-
 /* Provide the compat syscall number to call mapping. */
 #undef __SYSCALL
 #define __SYSCALL(nr, call) [nr] = (call),
 
-/* The generic versions of these don't work for Tile. */
-#define compat_sys_msgrcv tile_compat_sys_msgrcv
-#define compat_sys_msgsnd tile_compat_sys_msgsnd
-
 /* See comments in sys.c */
 #define compat_sys_fadvise64_64 sys32_fadvise64_64
 #define compat_sys_readahead sys32_readahead
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index cb9a104..0e1f474 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2131,6 +2131,7 @@ config IA32_AOUT
 config COMPAT
 	def_bool y
 	depends on IA32_EMULATION
+	select ARCH_WANT_OLD_COMPAT_IPC
 
 config COMPAT_FOR_U64_ALIGNMENT
 	def_bool COMPAT
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 66ed067..f295dae 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -224,6 +224,7 @@ struct compat_sysinfo;
 struct compat_sysctl_args;
 struct compat_kexec_segment;
 struct compat_mq_attr;
+struct compat_msgbuf;
 
 extern void compat_exit_robust_list(struct task_struct *curr);
 
@@ -234,13 +235,22 @@ asmlinkage long
 compat_sys_get_robust_list(int pid, compat_uptr_t __user *head_ptr,
 			   compat_size_t __user *len_ptr);
 
+#ifdef CONFIG_ARCH_WANT_OLD_COMPAT_IPC
 long compat_sys_semctl(int first, int second, int third, void __user *uptr);
 long compat_sys_msgsnd(int first, int second, int third, void __user *uptr);
 long compat_sys_msgrcv(int first, int second, int msgtyp, int third,
 		int version, void __user *uptr);
-long compat_sys_msgctl(int first, int second, void __user *uptr);
 long compat_sys_shmat(int first, int second, compat_uptr_t third, int version,
 		void __user *uptr);
+#else
+long compat_sys_semctl(int semid, int semnum, int cmd, int arg);
+long compat_sys_msgsnd(int msqid, struct compat_msgbuf __user *msgp,
+		size_t msgsz, int msgflg);
+long compat_sys_msgrcv(int msqid, struct compat_msgbuf __user *msgp,
+		size_t msgsz, long msgtyp, int msgflg);
+long compat_sys_shmat(int shmid, compat_uptr_t shmaddr, int shmflg);
+#endif
+long compat_sys_msgctl(int first, int second, void __user *uptr);
 long compat_sys_shmctl(int first, int second, void __user *uptr);
 long compat_sys_semtimedop(int semid, struct sembuf __user *tsems,
 		unsigned nsems, const struct compat_timespec __user *timeout);
diff --git a/ipc/compat.c b/ipc/compat.c
index 845a287..a6df704 100644
--- a/ipc/compat.c
+++ b/ipc/compat.c
@@ -27,6 +27,7 @@
 #include <linux/msg.h>
 #include <linux/shm.h>
 #include <linux/syscalls.h>
+#include <linux/ptrace.h>
 
 #include <linux/mutex.h>
 #include <asm/uaccess.h>
@@ -117,6 +118,7 @@ extern int sem_ctls[];
 
 static inline int compat_ipc_parse_version(int *cmd)
 {
+#ifdef CONFIG_ARCH_WANT_OLD_COMPAT_IPC
 	int version = *cmd & IPC_64;
 
 	/* this is tricky: architectures that have support for the old
@@ -128,6 +130,10 @@ static inline int compat_ipc_parse_version(int *cmd)
 	*cmd &= ~IPC_64;
 #endif
 	return version;
+#else
+	/* With the asm-generic APIs, we always use the 64-bit versions. */
+	return IPC_64;
+#endif
 }
 
 static inline int __get_compat_ipc64_perm(struct ipc64_perm *p64,
@@ -232,10 +238,9 @@ static inline int put_compat_semid_ds(struct semid64_ds *s,
 	return err;
 }
 
-long compat_sys_semctl(int first, int second, int third, void __user *uptr)
+static long do_compat_semctl(int first, int second, int third, u32 pad)
 {
 	union semun fourth;
-	u32 pad;
 	int err, err2;
 	struct semid64_ds s64;
 	struct semid64_ds __user *up64;
@@ -243,10 +248,6 @@ long compat_sys_semctl(int first, int second, int third, void __user *uptr)
 
 	memset(&s64, 0, sizeof(s64));
 
-	if (!uptr)
-		return -EINVAL;
-	if (get_user(pad, (u32 __user *) uptr))
-		return -EFAULT;
 	if ((third & (~IPC_64)) == SETVAL)
 		fourth.val = (int) pad;
 	else
@@ -305,6 +306,18 @@ long compat_sys_semctl(int first, int second, int third, void __user *uptr)
 	return err;
 }
 
+#ifdef CONFIG_ARCH_WANT_OLD_COMPAT_IPC
+long compat_sys_semctl(int first, int second, int third, void __user *uptr)
+{
+	u32 pad;
+
+	if (!uptr)
+		return -EINVAL;
+	if (get_user(pad, (u32 __user *) uptr))
+		return -EFAULT;
+	return do_compat_semctl(first, second, third, pad);
+}
+
 long compat_sys_msgsnd(int first, int second, int third, void __user *uptr)
 {
 	struct compat_msgbuf __user *up = uptr;
@@ -353,6 +366,37 @@ long compat_sys_msgrcv(int first, int second, int msgtyp, int third,
 out:
 	return err;
 }
+#else
+long compat_sys_semctl(int semid, int semnum, int cmd, int arg)
+{
+	return do_compat_semctl(semid, semnum, cmd, arg);
+}
+
+long compat_sys_msgsnd(int msqid, struct compat_msgbuf __user *msgp,
+		       size_t msgsz, int msgflg)
+{
+	compat_long_t mtype;
+
+	if (get_user(mtype, &msgp->mtype))
+		return -EFAULT;
+	return do_msgsnd(msqid, mtype, msgp->mtext, msgsz, msgflg);
+}
+
+long compat_sys_msgrcv(int msqid, struct compat_msgbuf __user *msgp,
+		       size_t msgsz, long msgtyp, int msgflg)
+{
+	long err, mtype;
+
+	err =  do_msgrcv(msqid, &mtype, msgp->mtext, msgsz, msgtyp, msgflg);
+	if (err < 0)
+		goto out;
+
+	if (put_user(mtype, &msgp->mtype))
+		err = -EFAULT;
+ out:
+	return err;
+}
+#endif
 
 static inline int get_compat_msqid64(struct msqid64_ds *m64,
 				     struct compat_msqid64_ds __user *up64)
@@ -470,6 +514,7 @@ long compat_sys_msgctl(int first, int second, void __user *uptr)
 	return err;
 }
 
+#ifdef CONFIG_ARCH_WANT_OLD_COMPAT_IPC
 long compat_sys_shmat(int first, int second, compat_uptr_t third, int version,
 			void __user *uptr)
 {
@@ -485,6 +530,19 @@ long compat_sys_shmat(int first, int second, compat_uptr_t third, int version,
 	uaddr = compat_ptr(third);
 	return put_user(raddr, uaddr);
 }
+#else
+long compat_sys_shmat(int shmid, compat_uptr_t shmaddr, int shmflg)
+{
+	unsigned long ret;
+	long err;
+
+	err = do_shmat(shmid, compat_ptr(shmaddr), shmflg, &ret);
+	if (err)
+		return err;
+	force_successful_syscall_return();
+	return (long)ret;
+}
+#endif
 
 static inline int get_compat_shmid64_ds(struct shmid64_ds *s64,
 					struct compat_shmid64_ds __user *up64)
-- 
1.6.5.2
