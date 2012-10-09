Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2012 01:26:22 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:57788 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6870540Ab2JIX0IzFfZb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Oct 2012 01:26:08 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1TLi9n-0005Wn-Jg; Tue, 09 Oct 2012 17:20:07 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH] MIPS: kspd: Remove kspd support.
Date:   Tue,  9 Oct 2012 17:20:03 -0500
Message-Id: <1349821203-23083-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 34663
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

There are no users of the kspd functionality anymore.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/Kconfig            |   10 -
 arch/mips/include/asm/kspd.h |   36 ----
 arch/mips/kernel/Makefile    |    1 -
 arch/mips/kernel/kspd.c      |  423 ------------------------------------------
 arch/mips/kernel/vpe.c       |   24 ---
 5 files changed, 494 deletions(-)
 delete mode 100644 arch/mips/include/asm/kspd.h
 delete mode 100644 arch/mips/kernel/kspd.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 35453ea..e13c8fa 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2038,16 +2038,6 @@ config MIPS_VPE_APSP_API
 	depends on MIPS_VPE_LOADER
 	help
 
-config MIPS_APSP_KSPD
-	bool "Enable KSPD"
-	depends on MIPS_VPE_APSP_API
-	default y
-	help
-	  KSPD is a kernel daemon that accepts syscall requests from the SP
-	  side, actions them and returns the results. It also handles the
-	  "exit" syscall notifying other kernel modules the SP program is
-	  exiting.  You probably want to say yes here.
-
 config MIPS_CMP
 	bool "MIPS CMP framework support"
 	depends on SYS_SUPPORTS_MIPS_CMP
diff --git a/arch/mips/include/asm/kspd.h b/arch/mips/include/asm/kspd.h
deleted file mode 100644
index 4e9e724..0000000
--- a/arch/mips/include/asm/kspd.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * Copyright (C) 2005 MIPS Technologies, Inc.  All rights reserved.
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- */
-
-#ifndef _ASM_KSPD_H
-#define _ASM_KSPD_H
-
-struct kspd_notifications {
-	void (*kspd_sp_exit)(int sp_id);
-
-	struct list_head list;
-};
-
-#ifdef CONFIG_MIPS_APSP_KSPD
-extern void kspd_notify(struct kspd_notifications *notify);
-#else
-static inline void kspd_notify(struct kspd_notifications *notify)
-{
-}
-#endif
-
-#endif
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index d6c2a74..e49c446 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -53,7 +53,6 @@ obj-$(CONFIG_CPU_MIPSR2)	+= spram.o
 
 obj-$(CONFIG_MIPS_VPE_LOADER)	+= vpe.o
 obj-$(CONFIG_MIPS_VPE_APSP_API)	+= rtlx.o
-obj-$(CONFIG_MIPS_APSP_KSPD)	+= kspd.o
 
 obj-$(CONFIG_I8259)		+= i8259.o
 obj-$(CONFIG_IRQ_CPU)		+= irq_cpu.o
diff --git a/arch/mips/kernel/kspd.c b/arch/mips/kernel/kspd.c
deleted file mode 100644
index b77f56b..0000000
--- a/arch/mips/kernel/kspd.c
+++ /dev/null
@@ -1,423 +0,0 @@
-/*
- * Copyright (C) 2005 MIPS Technologies, Inc.  All rights reserved.
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- */
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/sched.h>
-#include <linux/unistd.h>
-#include <linux/file.h>
-#include <linux/fdtable.h>
-#include <linux/fs.h>
-#include <linux/syscalls.h>
-#include <linux/workqueue.h>
-#include <linux/errno.h>
-#include <linux/list.h>
-
-#include <asm/vpe.h>
-#include <asm/rtlx.h>
-#include <asm/kspd.h>
-
-static struct workqueue_struct *workqueue;
-static struct work_struct work;
-
-extern unsigned long cpu_khz;
-
-struct mtsp_syscall {
-	int cmd;
-	unsigned char abi;
-	unsigned char size;
-};
-
-struct mtsp_syscall_ret {
-	int retval;
-	int errno;
-};
-
-struct mtsp_syscall_generic {
-	int arg0;
-	int arg1;
-	int arg2;
-	int arg3;
-	int arg4;
-	int arg5;
-	int arg6;
-};
-
-static struct list_head kspd_notifylist;
-static int sp_stopping;
-
-/* these should match with those in the SDE kit */
-#define MTSP_SYSCALL_BASE	0
-#define MTSP_SYSCALL_EXIT	(MTSP_SYSCALL_BASE + 0)
-#define MTSP_SYSCALL_OPEN	(MTSP_SYSCALL_BASE + 1)
-#define MTSP_SYSCALL_READ	(MTSP_SYSCALL_BASE + 2)
-#define MTSP_SYSCALL_WRITE	(MTSP_SYSCALL_BASE + 3)
-#define MTSP_SYSCALL_CLOSE	(MTSP_SYSCALL_BASE + 4)
-#define MTSP_SYSCALL_LSEEK32	(MTSP_SYSCALL_BASE + 5)
-#define MTSP_SYSCALL_ISATTY	(MTSP_SYSCALL_BASE + 6)
-#define MTSP_SYSCALL_GETTIME	(MTSP_SYSCALL_BASE + 7)
-#define MTSP_SYSCALL_PIPEFREQ	(MTSP_SYSCALL_BASE + 8)
-#define MTSP_SYSCALL_GETTOD	(MTSP_SYSCALL_BASE + 9)
-#define MTSP_SYSCALL_IOCTL     (MTSP_SYSCALL_BASE + 10)
-
-#define MTSP_O_RDONLY		0x0000
-#define MTSP_O_WRONLY		0x0001
-#define MTSP_O_RDWR		0x0002
-#define MTSP_O_NONBLOCK		0x0004
-#define MTSP_O_APPEND		0x0008
-#define MTSP_O_SHLOCK		0x0010
-#define MTSP_O_EXLOCK		0x0020
-#define MTSP_O_ASYNC		0x0040
-/* XXX: check which of these is actually O_SYNC vs O_DSYNC */
-#define MTSP_O_FSYNC		O_SYNC
-#define MTSP_O_NOFOLLOW		0x0100
-#define MTSP_O_SYNC		0x0080
-#define MTSP_O_CREAT		0x0200
-#define MTSP_O_TRUNC		0x0400
-#define MTSP_O_EXCL		0x0800
-#define MTSP_O_BINARY		0x8000
-
-extern int tclimit;
-
-struct apsp_table  {
-	int sp;
-	int ap;
-};
-
-/* we might want to do the mode flags too */
-struct apsp_table open_flags_table[] = {
-	{ MTSP_O_RDWR, O_RDWR },
-	{ MTSP_O_WRONLY, O_WRONLY },
-	{ MTSP_O_CREAT, O_CREAT },
-	{ MTSP_O_TRUNC, O_TRUNC },
-	{ MTSP_O_NONBLOCK, O_NONBLOCK },
-	{ MTSP_O_APPEND, O_APPEND },
-	{ MTSP_O_NOFOLLOW, O_NOFOLLOW }
-};
-
-struct apsp_table syscall_command_table[] = {
-	{ MTSP_SYSCALL_OPEN, __NR_open },
-	{ MTSP_SYSCALL_CLOSE, __NR_close },
-	{ MTSP_SYSCALL_READ, __NR_read },
-	{ MTSP_SYSCALL_WRITE, __NR_write },
-	{ MTSP_SYSCALL_LSEEK32, __NR_lseek },
-	{ MTSP_SYSCALL_IOCTL, __NR_ioctl }
-};
-
-static int sp_syscall(int num, int arg0, int arg1, int arg2, int arg3)
-{
-	register long int _num  __asm__("$2") = num;
-	register long int _arg0  __asm__("$4") = arg0;
-	register long int _arg1  __asm__("$5") = arg1;
-	register long int _arg2  __asm__("$6") = arg2;
-	register long int _arg3  __asm__("$7") = arg3;
-
-	mm_segment_t old_fs;
-
-	old_fs = get_fs();
- 	set_fs(KERNEL_DS);
-
-  	__asm__ __volatile__ (
- 	"	syscall					\n"
- 	: "=r" (_num), "=r" (_arg3)
- 	: "r" (_num), "r" (_arg0), "r" (_arg1), "r" (_arg2), "r" (_arg3));
-
-	set_fs(old_fs);
-
-	/* $a3 is error flag */
-	if (_arg3)
-		return -_num;
-
-	return _num;
-}
-
-static int translate_syscall_command(int cmd)
-{
-	int i;
-	int ret = -1;
-
-	for (i = 0; i < ARRAY_SIZE(syscall_command_table); i++) {
-		if ((cmd == syscall_command_table[i].sp))
-			return syscall_command_table[i].ap;
-	}
-
-	return ret;
-}
-
-static unsigned int translate_open_flags(int flags)
-{
-	int i;
-	unsigned int ret = 0;
-
-	for (i = 0; i < ARRAY_SIZE(open_flags_table); i++) {
-		if( (flags & open_flags_table[i].sp) ) {
-			ret |= open_flags_table[i].ap;
-		}
-	}
-
-	return ret;
-}
-
-
-static int sp_setfsuidgid(uid_t uid, gid_t gid)
-{
-	struct cred *new;
-
-	new = prepare_creds();
-	if (!new)
-		return -ENOMEM;
-
-	new->fsuid = uid;
-	new->fsgid = gid;
-
-	commit_creds(new);
-
-	return 0;
-}
-
-/*
- * Expects a request to be on the sysio channel. Reads it.  Decides whether
- * its a linux syscall and runs it, or whatever.  Puts the return code back
- * into the request and sends the whole thing back.
- */
-void sp_work_handle_request(void)
-{
-	struct mtsp_syscall sc;
-	struct mtsp_syscall_generic generic;
-	struct mtsp_syscall_ret ret;
-	struct kspd_notifications *n;
-	unsigned long written;
-	mm_segment_t old_fs;
-	struct timeval tv;
-	struct timezone tz;
-	int err, cmd;
-
-	char *vcwd;
-	int size;
-
-	ret.retval = -1;
-
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-
-	if (!rtlx_read(RTLX_CHANNEL_SYSIO, &sc, sizeof(struct mtsp_syscall))) {
-		set_fs(old_fs);
-		printk(KERN_ERR "Expected request but nothing to read\n");
-		return;
-	}
-
-	size = sc.size;
-
-	if (size) {
-		if (!rtlx_read(RTLX_CHANNEL_SYSIO, &generic, size)) {
-			set_fs(old_fs);
-			printk(KERN_ERR "Expected request but nothing to read\n");
-			return;
-		}
-	}
-
-	/* Run the syscall at the privilege of the user who loaded the
-	   SP program */
-
-	if (vpe_getuid(tclimit)) {
-		err = sp_setfsuidgid(vpe_getuid(tclimit), vpe_getgid(tclimit));
-		if (!err)
-			pr_err("Change of creds failed\n");
-	}
-
-	switch (sc.cmd) {
-	/* needs the flags argument translating from SDE kit to
-	   linux */
- 	case MTSP_SYSCALL_PIPEFREQ:
- 		ret.retval = cpu_khz * 1000;
- 		ret.errno = 0;
- 		break;
-
- 	case MTSP_SYSCALL_GETTOD:
- 		memset(&tz, 0, sizeof(tz));
- 		if ((ret.retval = sp_syscall(__NR_gettimeofday, (int)&tv,
-					     (int)&tz, 0, 0)) == 0)
-			ret.retval = tv.tv_sec;
-		break;
-
- 	case MTSP_SYSCALL_EXIT:
-		list_for_each_entry(n, &kspd_notifylist, list)
-			n->kspd_sp_exit(tclimit);
-		sp_stopping = 1;
-
-		printk(KERN_DEBUG "KSPD got exit syscall from SP exitcode %d\n",
-		       generic.arg0);
- 		break;
-
- 	case MTSP_SYSCALL_OPEN:
- 		generic.arg1 = translate_open_flags(generic.arg1);
-
-		vcwd = vpe_getcwd(tclimit);
-
-		/* change to cwd of the process that loaded the SP program */
-		old_fs = get_fs();
-		set_fs(KERNEL_DS);
-		sys_chdir(vcwd);
-		set_fs(old_fs);
-
- 		sc.cmd = __NR_open;
-
-		/* fall through */
-
-  	default:
- 		if ((sc.cmd >= __NR_Linux) &&
-		    (sc.cmd <= (__NR_Linux +  __NR_Linux_syscalls)) )
-			cmd = sc.cmd;
-		else
-			cmd = translate_syscall_command(sc.cmd);
-
-		if (cmd >= 0) {
-			ret.retval = sp_syscall(cmd, generic.arg0, generic.arg1,
-			                        generic.arg2, generic.arg3);
-		} else
- 			printk(KERN_WARNING
-			       "KSPD: Unknown SP syscall number %d\n", sc.cmd);
-		break;
- 	} /* switch */
-
-	if (vpe_getuid(tclimit)) {
-		err = sp_setfsuidgid(0, 0);
-		if (!err)
-			pr_err("restoring old creds failed\n");
-	}
-
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	written = rtlx_write(RTLX_CHANNEL_SYSIO, &ret, sizeof(ret));
-	set_fs(old_fs);
-	if (written < sizeof(ret))
-		printk("KSPD: sp_work_handle_request failed to send to SP\n");
-}
-
-static void sp_cleanup(void)
-{
-	struct files_struct *files = current->files;
-	int i, j;
-	struct fdtable *fdt;
-
-	j = 0;
-
-	/*
-	 * It is safe to dereference the fd table without RCU or
-	 * ->file_lock
-	 */
-	fdt = files_fdtable(files);
-	for (;;) {
-		unsigned long set;
-		i = j * BITS_PER_LONG;
-		if (i >= fdt->max_fds)
-			break;
-		set = fdt->open_fds[j++];
-		while (set) {
-			if (set & 1) {
-				struct file * file = xchg(&fdt->fd[i], NULL);
-				if (file)
-					filp_close(file, files);
-			}
-			i++;
-			set >>= 1;
-		}
-	}
-
-	/* Put daemon cwd back to root to avoid umount problems */
-	sys_chdir("/");
-}
-
-static int channel_open;
-
-/* the work handler */
-static void sp_work(struct work_struct *unused)
-{
-	if (!channel_open) {
-		if( rtlx_open(RTLX_CHANNEL_SYSIO, 1) != 0) {
-			printk("KSPD: unable to open sp channel\n");
-			sp_stopping = 1;
-		} else {
-			channel_open++;
-			printk(KERN_DEBUG "KSPD: SP channel opened\n");
-		}
-	} else {
-		/* wait for some data, allow it to sleep */
-		rtlx_read_poll(RTLX_CHANNEL_SYSIO, 1);
-
-		/* Check we haven't been woken because we are stopping */
-		if (!sp_stopping)
-			sp_work_handle_request();
-	}
-
-	if (!sp_stopping)
-		queue_work(workqueue, &work);
-	else
-		sp_cleanup();
-}
-
-static void startwork(int vpe)
-{
-	sp_stopping = channel_open = 0;
-
-	if (workqueue == NULL) {
-		if ((workqueue = create_singlethread_workqueue("kspd")) == NULL) {
-			printk(KERN_ERR "unable to start kspd\n");
-			return;
-		}
-
-		INIT_WORK(&work, sp_work);
-	}
-
-	queue_work(workqueue, &work);
-}
-
-static void stopwork(int vpe)
-{
-	sp_stopping = 1;
-
-	printk(KERN_DEBUG "KSPD: SP stopping\n");
-}
-
-void kspd_notify(struct kspd_notifications *notify)
-{
-	list_add(&notify->list, &kspd_notifylist);
-}
-
-static struct vpe_notifications notify;
-static int kspd_module_init(void)
-{
-	INIT_LIST_HEAD(&kspd_notifylist);
-
-	notify.start = startwork;
-	notify.stop = stopwork;
-	vpe_notify(tclimit, &notify);
-
-	return 0;
-}
-
-static void kspd_module_exit(void)
-{
-
-}
-
-module_init(kspd_module_init);
-module_exit(kspd_module_exit);
-
-MODULE_DESCRIPTION("MIPS KSPD");
-MODULE_AUTHOR("Elizabeth Oldham, MIPS Technologies, Inc.");
-MODULE_LICENSE("GPL");
diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index f6f9152..eec690a 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -50,7 +50,6 @@
 #include <asm/mips_mt.h>
 #include <asm/processor.h>
 #include <asm/vpe.h>
-#include <asm/kspd.h>
 
 typedef void *vpe_handle;
 
@@ -69,11 +68,6 @@ static char module_name[] = "vpe";
 static int major;
 static const int minor = 1;	/* fixed for now  */
 
-#ifdef CONFIG_MIPS_APSP_KSPD
-static struct kspd_notifications kspd_events;
-static int kspd_events_reqd;
-#endif
-
 /* grab the likely amount of memory we will need. */
 #ifdef CONFIG_MIPS_VPE_LOADER_TOM
 #define P_SIZE (2 * 1024 * 1024)
@@ -1101,14 +1095,6 @@ static int vpe_open(struct inode *inode, struct file *filp)
 	v->uid = filp->f_cred->fsuid;
 	v->gid = filp->f_cred->fsgid;
 
-#ifdef CONFIG_MIPS_APSP_KSPD
-	/* get kspd to tell us when a syscall_exit happens */
-	if (!kspd_events_reqd) {
-		kspd_notify(&kspd_events);
-		kspd_events_reqd++;
-	}
-#endif
-
 	v->cwd[0] = 0;
 	ret = getcwd(v->cwd, VPE_PATH_MAX);
 	if (ret < 0)
@@ -1341,13 +1327,6 @@ char *vpe_getcwd(int index)
 
 EXPORT_SYMBOL(vpe_getcwd);
 
-#ifdef CONFIG_MIPS_APSP_KSPD
-static void kspd_sp_exit( int sp_id)
-{
-	cleanup_tc(get_tc(sp_id));
-}
-#endif
-
 static ssize_t store_kill(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t len)
 {
@@ -1585,9 +1564,6 @@ out_reenable:
 	emt(mtflags);
 	local_irq_restore(flags);
 
-#ifdef CONFIG_MIPS_APSP_KSPD
-	kspd_events.kspd_sp_exit = kspd_sp_exit;
-#endif
 	return 0;
 
 out_class:
-- 
1.7.9.5
