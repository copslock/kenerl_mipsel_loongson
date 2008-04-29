Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Apr 2008 10:01:08 +0100 (BST)
Received: from verein.lst.de ([213.95.11.210]:6302 "EHLO verein.lst.de")
	by ftp.linux-mips.org with ESMTP id S28642073AbYD2JBE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 29 Apr 2008 10:01:04 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id m3T90dF3017148
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 29 Apr 2008 11:00:39 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id m3T90dEO017146;
	Tue, 29 Apr 2008 11:00:39 +0200
Date:	Tue, 29 Apr 2008 11:00:39 +0200
From:	Christoph Hellwig <hch@lst.de>
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: undefined reference to `copy_siginfo_from_user32'
Message-ID: <20080429090039.GA16616@lst.de>
References: <20080428212327.47c703b6.giuseppe@eppesuigoccas.homedns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080428212327.47c703b6.giuseppe@eppesuigoccas.homedns.org>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Mon, Apr 28, 2008 at 09:23:27PM +0200, Giuseppe Sacco wrote:
> Hi list,
> since a few days, whenever I try to recompile the latest kernel (from git) it always print this error message:

This should be fixed in mainline.  But the right fix would be to switch
mips to the generic compat_ptrace.  And untested (and in fact even
uncompiled) patch ontop of the copy_siginfo_to_user32 posted to the list
a while ago is below to sketch how this should look like:


Index: linux-2.6/arch/mips/kernel/ptrace32.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/ptrace32.c	2008-04-29 10:54:44.000000000 +0200
+++ linux-2.6/arch/mips/kernel/ptrace32.c	2008-04-29 10:59:17.000000000 +0200
@@ -42,56 +42,17 @@ int ptrace_setregs(struct task_struct *c
 int ptrace_getfpregs(struct task_struct *child, __u32 __user *data);
 int ptrace_setfpregs(struct task_struct *child, __u32 __user *data);
 
+
 /*
  * Tracing a 32-bit process with a 64-bit strace and vice versa will not
  * work.  I don't know how to fix this.
  */
-asmlinkage int sys32_ptrace(int request, int pid, int addr, int data)
+long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
+			compat_ulong_t addr, compat_ulong_t data)
 {
-	struct task_struct *child;
 	int ret;
 
-#if 0
-	printk("ptrace(r=%d,pid=%d,addr=%08lx,data=%08lx)\n",
-	       (int) request, (int) pid, (unsigned long) addr,
-	       (unsigned long) data);
-#endif
-	lock_kernel();
-	if (request == PTRACE_TRACEME) {
-		ret = ptrace_traceme();
-		goto out;
-	}
-
-	child = ptrace_get_task_struct(pid);
-	if (IS_ERR(child)) {
-		ret = PTR_ERR(child);
-		goto out;
-	}
-
-	if (request == PTRACE_ATTACH) {
-		ret = ptrace_attach(child);
-		goto out_tsk;
-	}
-
-	ret = ptrace_check_attach(child, request == PTRACE_KILL);
-	if (ret < 0)
-		goto out_tsk;
-
 	switch (request) {
-	/* when I and D space are separate, these will need to be fixed. */
-	case PTRACE_PEEKTEXT: /* read word at location addr. */
-	case PTRACE_PEEKDATA: {
-		unsigned int tmp;
-		int copied;
-
-		copied = access_process_vm(child, addr, &tmp, sizeof(tmp), 0);
-		ret = -EIO;
-		if (copied != sizeof(tmp))
-			break;
-		ret = put_user(tmp, (unsigned int __user *) (unsigned long) data);
-		break;
-	}
-
 	/*
 	 * Read 4 bytes of the other process' storage
 	 *  data is a pointer specifying where the user wants the
@@ -237,16 +198,6 @@ asmlinkage int sys32_ptrace(int request,
 		break;
 	}
 
-	/* when I and D space are separate, this will have to be fixed. */
-	case PTRACE_POKETEXT: /* write the word at location addr. */
-	case PTRACE_POKEDATA:
-		ret = 0;
-		if (access_process_vm(child, addr, &data, sizeof(data), 1)
-		    == sizeof(data))
-			break;
-		ret = -EIO;
-		break;
-
 	/*
 	 * Write 4 bytes into the other process' storage
 	 *  data is the 4 bytes that the user wants written
@@ -400,24 +351,15 @@ asmlinkage int sys32_ptrace(int request,
 		ret = ptrace_detach(child, data);
 		break;
 
-	case PTRACE_GETEVENTMSG:
-		ret = put_user(child->ptrace_message,
-			       (unsigned int __user *) (unsigned long) data);
-		break;
-
 	case PTRACE_GET_THREAD_AREA_3264:
 		ret = put_user(task_thread_info(child)->tp_value,
 				(unsigned long __user *) (unsigned long) data);
 		break;
 
 	default:
-		ret = ptrace_request(child, request, addr, data);
+		ret = compat_ptrace_request(child, request, addr, data);
 		break;
 	}
 
-out_tsk:
-	put_task_struct(child);
-out:
-	unlock_kernel();
 	return ret;
 }
Index: linux-2.6/include/asm-mips/ptrace.h
===================================================================
--- linux-2.6.orig/include/asm-mips/ptrace.h	2008-04-29 11:00:10.000000000 +0200
+++ linux-2.6/include/asm-mips/ptrace.h	2008-04-29 11:00:19.000000000 +0200
@@ -76,6 +76,8 @@ struct pt_regs {
 #include <linux/linkage.h>
 #include <asm/isadep.h>
 
+#define __ARCH_WANT_COMPAT_SYS_PTRACE
+
 /*
  * Does the process account for user or for system time?
  */
