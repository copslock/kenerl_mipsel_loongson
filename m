Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Feb 2005 02:36:25 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:41157 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225229AbVBNCgI>;
	Mon, 14 Feb 2005 02:36:08 +0000
Received: from drow by nevyn.them.org with local (Exim 4.44 #1 (Debian))
	id 1D0W5n-0006pQ-5a; Sun, 13 Feb 2005 21:36:07 -0500
Date:	Sun, 13 Feb 2005 21:36:07 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Fix up 32-bit compat for a bunch of syscalls
Message-ID: <20050214023607.GC25335@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

A grab bag of fixes from testing glibc, o32 only, under both 32-bit and
64-bit kernels.  Changes are:

  - There is a generic compat_sys_wait4; use it.
  - waitid needs compat routines for o32 (siginfo and rusage) and n32
    (just rusage).
  - timer_create needs a compat routine for both o32 and n32 (struct
    sigevent).
  - rt_sigtimedwait can use the generic compat routine for o32, but not
    for n32, because n32 uses a 64-bit struct siginfo.  I didn't
    actually test this one yet - I'll be doing n32 testing in a couple
    of weeks...
  - For the same reason n32 should not use sys32_rt_sigqueueinfo.
  - n32 does need compat versions of the other timer_* and clock_*
    functions however.
  - o32 signal delivery was not handling SI_TIMER.
  - waitid takes five arguments now, not four.
  - PTRACE_GETEVENTMSG needs a compat wrapper since it writes a long to
    userspace.

With these, I get the same o32 glibc test results using a 32-bit or
64-bit kernel on my Sentosa.  The only thing left which looks like
a kernel bug is time-related; a bunch of the POSIX timers tests
complain that timers trigger too soon.

Please apply if OK.

Signed-off-by: Daniel Jacobowitz <dan@codesourcery.com>

Index: linux/arch/mips/kernel/linux32.c
===================================================================
--- linux.orig/arch/mips/kernel/linux32.c	2005-02-13 20:55:57.729574958 -0500
+++ linux/arch/mips/kernel/linux32.c	2005-02-13 21:28:08.198089040 -0500
@@ -215,81 +215,36 @@ sys32_readdir(unsigned int fd, void * di
 	return(n);
 }
 
-struct rusage32 {
-        struct compat_timeval ru_utime;
-        struct compat_timeval ru_stime;
-        int    ru_maxrss;
-        int    ru_ixrss;
-        int    ru_idrss;
-        int    ru_isrss;
-        int    ru_minflt;
-        int    ru_majflt;
-        int    ru_nswap;
-        int    ru_inblock;
-        int    ru_oublock;
-        int    ru_msgsnd;
-        int    ru_msgrcv;
-        int    ru_nsignals;
-        int    ru_nvcsw;
-        int    ru_nivcsw;
-};
 
-static int
-put_rusage (struct rusage32 *ru, struct rusage *r)
-{
-	int err;
+asmlinkage int compat_sys_wait4(compat_pid_t pid, unsigned int * stat_addr,
+				int options, struct compat_rusage * ru);
 
-	if (verify_area(VERIFY_WRITE, ru, sizeof *ru))
-		return -EFAULT;
-
-	err = __put_user (r->ru_utime.tv_sec, &ru->ru_utime.tv_sec);
-	err |= __put_user (r->ru_utime.tv_usec, &ru->ru_utime.tv_usec);
-	err |= __put_user (r->ru_stime.tv_sec, &ru->ru_stime.tv_sec);
-	err |= __put_user (r->ru_stime.tv_usec, &ru->ru_stime.tv_usec);
-	err |= __put_user (r->ru_maxrss, &ru->ru_maxrss);
-	err |= __put_user (r->ru_ixrss, &ru->ru_ixrss);
-	err |= __put_user (r->ru_idrss, &ru->ru_idrss);
-	err |= __put_user (r->ru_isrss, &ru->ru_isrss);
-	err |= __put_user (r->ru_minflt, &ru->ru_minflt);
-	err |= __put_user (r->ru_majflt, &ru->ru_majflt);
-	err |= __put_user (r->ru_nswap, &ru->ru_nswap);
-	err |= __put_user (r->ru_inblock, &ru->ru_inblock);
-	err |= __put_user (r->ru_oublock, &ru->ru_oublock);
-	err |= __put_user (r->ru_msgsnd, &ru->ru_msgsnd);
-	err |= __put_user (r->ru_msgrcv, &ru->ru_msgrcv);
-	err |= __put_user (r->ru_nsignals, &ru->ru_nsignals);
-	err |= __put_user (r->ru_nvcsw, &ru->ru_nvcsw);
-	err |= __put_user (r->ru_nivcsw, &ru->ru_nivcsw);
-
-	return err;
+asmlinkage int
+sys32_waitpid(compat_pid_t pid, unsigned int *stat_addr, int options)
+{
+	return compat_sys_wait4(pid, stat_addr, options, NULL);
 }
 
-asmlinkage int
-sys32_wait4(compat_pid_t pid, unsigned int * stat_addr, int options,
-	    struct rusage32 * ru)
+asmlinkage long
+sysn32_waitid(int which, compat_pid_t pid,
+	      siginfo_t __user *uinfo, int options,
+	      struct compat_rusage __user *uru)
 {
-	if (!ru)
-		return sys_wait4(pid, stat_addr, options, NULL);
-	else {
-		struct rusage r;
-		int ret;
-		unsigned int status;
-		mm_segment_t old_fs = get_fs();
+	struct rusage ru;
+	long ret;
+	mm_segment_t old_fs = get_fs();
 
-		set_fs(KERNEL_DS);
-		ret = sys_wait4(pid, stat_addr ? &status : NULL, options, &r);
-		set_fs(old_fs);
-		if (put_rusage (ru, &r)) return -EFAULT;
-		if (stat_addr && put_user (status, stat_addr))
-			return -EFAULT;
+	set_fs (KERNEL_DS);
+	ret = sys_waitid(which, pid, uinfo, options,
+			 uru ? (struct rusage __user *) &ru : NULL);
+	set_fs (old_fs);
+
+	if (ret < 0 || uinfo->si_signo == 0)
 		return ret;
-	}
-}
 
-asmlinkage int
-sys32_waitpid(compat_pid_t pid, unsigned int *stat_addr, int options)
-{
-	return sys32_wait4(pid, stat_addr, options, NULL);
+	if (uru)
+		ret = put_compat_rusage(&ru, uru);
+	return ret;
 }
 
 struct sysinfo32 {
@@ -1496,3 +1451,53 @@ _sys32_clone(unsigned long __dummy0,
 	return do_fork(clone_flags, newsp, &regs, 0,
 	               parent_tidptr, child_tidptr);
 }
+
+struct sigevent32 { 
+	u32 sigev_value;
+	u32 sigev_signo; 
+	u32 sigev_notify; 
+	u32 payload[(64 / 4) - 3]; 
+}; 
+
+extern asmlinkage long
+sys_timer_create(clockid_t which_clock,
+		 struct sigevent __user *timer_event_spec,
+		 timer_t __user * created_timer_id);
+
+long
+sys32_timer_create(u32 clock, struct sigevent32 __user *se32, timer_t __user *timer_id)
+{
+	struct sigevent __user *p = NULL;
+	if (se32) { 
+		struct sigevent se;
+		p = compat_alloc_user_space(sizeof(struct sigevent));
+		memset(&se, 0, sizeof(struct sigevent)); 
+		if (get_user(se.sigev_value.sival_int,  &se32->sigev_value) ||
+		    __get_user(se.sigev_signo, &se32->sigev_signo) ||
+		    __get_user(se.sigev_notify, &se32->sigev_notify) ||
+		    __copy_from_user(&se._sigev_un._pad, &se32->payload, 
+				     sizeof(se32->payload)) ||
+		    copy_to_user(p, &se, sizeof(se)))
+			return -EFAULT;
+	} 
+	return sys_timer_create(clock, p, timer_id);
+} 
+
+asmlinkage long
+sysn32_rt_sigtimedwait(const sigset_t __user *uthese,
+		       siginfo_t __user *uinfo,
+		       const struct compat_timespec __user *uts32,
+		       size_t sigsetsize)
+{
+	struct timespec __user *uts = NULL;
+
+	if (uts32) {
+		struct timespec ts;
+		uts = compat_alloc_user_space(sizeof(struct timespec));
+		if (get_user(ts.tv_sec, &uts32->tv_sec) ||
+		    get_user(ts.tv_nsec, &uts32->tv_nsec) ||
+		    copy_to_user (uts, &ts, sizeof (ts)))
+			return -EFAULT;
+	}
+	return sys_rt_sigtimedwait(uthese, uinfo, uts, sigsetsize);
+}
Index: linux/arch/mips/kernel/scall64-o32.S
===================================================================
--- linux.orig/arch/mips/kernel/scall64-o32.S	2005-02-13 20:55:57.729574958 -0500
+++ linux/arch/mips/kernel/scall64-o32.S	2005-02-13 21:28:08.199088801 -0500
@@ -316,7 +316,7 @@ sys_call_table:
 	PTR	sys_vhangup
 	PTR	sys_ni_syscall			/* was sys_idle	 */
 	PTR	sys_ni_syscall			/* sys_vm86 */
-	PTR	sys32_wait4
+	PTR	compat_sys_wait4
 	PTR	sys_swapoff			/* 4115 */
 	PTR	sys32_sysinfo
 	PTR	sys32_ipc
@@ -459,7 +459,7 @@ sys_call_table:
 	PTR	sys_fadvise64_64
 	PTR	compat_sys_statfs64		/* 4255 */
 	PTR	compat_sys_fstatfs64
-	PTR	sys_timer_create
+	PTR	sys32_timer_create
 	PTR	compat_sys_timer_settime
 	PTR	compat_sys_timer_gettime
 	PTR	sys_timer_getoverrun		/* 4260 */
@@ -480,7 +480,7 @@ sys_call_table:
 	PTR	compat_sys_mq_notify		/* 4275 */
 	PTR	compat_sys_mq_getsetattr
 	PTR	sys_ni_syscall			/* sys_vserver */
-	PTR	sys_waitid
+	PTR	sys32_waitid
 	PTR	sys_ni_syscall			/* available, was setaltroot */
 	PTR	sys_add_key			/* 4280 */
 	PTR	sys_request_key
Index: linux/arch/mips/kernel/scall64-n32.S
===================================================================
--- linux.orig/arch/mips/kernel/scall64-n32.S	2005-02-13 21:26:31.765170354 -0500
+++ linux/arch/mips/kernel/scall64-n32.S	2005-02-13 21:28:08.199088801 -0500
@@ -176,7 +176,7 @@ EXPORT(sysn32_call_table)
 	PTR	sys_fork
 	PTR	sys32_execve
 	PTR	sys_exit
-	PTR	sys32_wait4
+	PTR	compat_sys_wait4
 	PTR	sys_kill			/* 6060 */
 	PTR	sys32_newuname
 	PTR	sys_semget
@@ -243,8 +243,8 @@ EXPORT(sysn32_call_table)
 	PTR	sys_capget
 	PTR	sys_capset
 	PTR	sys32_rt_sigpending		/* 6125 */
-	PTR	compat_sys_rt_sigtimedwait
-	PTR	sys32_rt_sigqueueinfo
+	PTR	sysn32_rt_sigtimedwait
+	PTR	sys_rt_sigqueueinfo
 	PTR	sys32_rt_sigsuspend
 	PTR	sys32_sigaltstack
 	PTR	compat_sys_utime		/* 6130 */
@@ -337,15 +337,15 @@ EXPORT(sysn32_call_table)
 	PTR	compat_sys_statfs64
 	PTR	compat_sys_fstatfs64
 	PTR	sys_sendfile64
-	PTR	sys_timer_create		/* 6220 */
-	PTR	sys_timer_settime
-	PTR	sys_timer_gettime
+	PTR	sys32_timer_create		/* 6220 */
+	PTR	compat_sys_timer_settime
+	PTR	compat_sys_timer_gettime
 	PTR	sys_timer_getoverrun
 	PTR	sys_timer_delete
-	PTR	sys_clock_settime		/* 6225 */
-	PTR	sys_clock_gettime
-	PTR	sys_clock_getres
-	PTR	sys_clock_nanosleep
+	PTR	compat_sys_clock_settime		/* 6225 */
+	PTR	compat_sys_clock_gettime
+	PTR	compat_sys_clock_getres
+	PTR	compat_sys_clock_nanosleep
 	PTR	sys_tgkill
 	PTR	compat_sys_utimes		/* 6230 */
 	PTR	sys_ni_syscall			/* sys_mbind */
@@ -358,7 +358,7 @@ EXPORT(sysn32_call_table)
 	PTR	compat_sys_mq_notify
 	PTR	compat_sys_mq_getsetattr
 	PTR	sys_ni_syscall			/* 6240, sys_vserver */
-	PTR	sys_waitid
+	PTR	sysn32_waitid
 	PTR	sys_ni_syscall			/* available, was setaltroot */
 	PTR	sys_add_key
 	PTR	sys_request_key
Index: linux/arch/mips/kernel/signal32.c
===================================================================
--- linux.orig/arch/mips/kernel/signal32.c	2005-02-11 10:36:55.000000000 -0500
+++ linux/arch/mips/kernel/signal32.c	2005-02-13 21:28:08.199088801 -0500
@@ -81,8 +81,10 @@ typedef struct compat_siginfo {
 
 		/* POSIX.1b timers */
 		struct {
-			unsigned int _timer1;
-			unsigned int _timer2;
+			timer_t _tid;		/* timer id */
+			int _overrun;		/* overrun count */
+			sigval_t32 _sigval;	/* same as below */
+			int _sys_private;       /* not to be passed to user */
 		} _timer;
 
 		/* POSIX.1b signals */
@@ -416,6 +418,11 @@ int copy_siginfo_to_user32(compat_siginf
 		err |= __copy_to_user(&to->_sifields._pad, &from->_sifields._pad, SI_PAD_SIZE);
 	else {
 		switch (from->si_code >> 16) {
+		case __SI_TIMER >> 16:
+			err |= __put_user(from->si_tid, &to->si_tid);
+			err |= __put_user(from->si_overrun, &to->si_overrun);
+			err |= __put_user(from->si_int, &to->si_int);
+			break;
 		case __SI_CHLD >> 16:
 			err |= __put_user(from->si_utime, &to->si_utime);
 			err |= __put_user(from->si_stime, &to->si_stime);
@@ -908,3 +915,30 @@ asmlinkage int sys32_rt_sigqueueinfo(int
 	set_fs (old_fs);
 	return ret;
 }
+
+asmlinkage long
+sys32_waitid(int which, compat_pid_t pid,
+	     compat_siginfo_t __user *uinfo, int options,
+	     struct compat_rusage __user *uru)
+{
+	siginfo_t info;
+	struct rusage ru;
+	long ret;
+	mm_segment_t old_fs = get_fs();
+
+	info.si_signo = 0;
+	set_fs (KERNEL_DS);
+	ret = sys_waitid(which, pid, (siginfo_t __user *) &info, options,
+			 uru ? (struct rusage __user *) &ru : NULL);
+	set_fs (old_fs);
+
+	if (ret < 0 || info.si_signo == 0)
+		return ret;
+
+	if (uru && (ret = put_compat_rusage(&ru, uru)))
+		return ret;
+
+	BUG_ON(info.si_code & __SI_MASK);
+	info.si_code |= __SI_CHLD;
+	return copy_siginfo_to_user32(uinfo, &info);
+}
Index: linux/arch/mips/kernel/scall32-o32.S
===================================================================
--- linux.orig/arch/mips/kernel/scall32-o32.S	2005-02-13 20:55:57.739572561 -0500
+++ linux/arch/mips/kernel/scall32-o32.S	2005-02-13 21:28:08.200088562 -0500
@@ -618,7 +618,7 @@ einval:	li	v0, -EINVAL
 	sys	sys_mq_notify		2	/* 4275 */
 	sys	sys_mq_getsetattr	3
 	sys	sys_ni_syscall		0	/* sys_vserver */
-	sys	sys_waitid		4
+	sys	sys_waitid		5
 	sys	sys_ni_syscall		0	/* available, was setaltroot */
 	sys	sys_add_key		5
 	sys	sys_request_key		4
Index: linux/arch/mips/kernel/ptrace32.c
===================================================================
--- linux.orig/arch/mips/kernel/ptrace32.c	2005-02-13 20:55:57.740572322 -0500
+++ linux/arch/mips/kernel/ptrace32.c	2005-02-13 21:28:04.328015337 -0500
@@ -277,6 +277,11 @@ asmlinkage int sys32_ptrace(int request,
 		ret = ptrace_detach(child, data);
 		break;
 
+	case PTRACE_GETEVENTMSG:
+		ret = put_user(child->ptrace_message,
+			       (unsigned int __user *) (unsigned long) data);
+		break;
+
 	default:
 		ret = ptrace_request(child, request, addr, data);
 		break;

-- 
Daniel Jacobowitz
CodeSourcery, LLC
