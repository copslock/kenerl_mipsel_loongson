Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2008 00:19:15 +0000 (GMT)
Received: from mail.zeugmasystems.com ([192.139.122.66]:2612 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S23755906AbYKSATI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 19 Nov 2008 00:19:08 +0000
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] ptrace syscall cleanups for mips compat archs
Date:	Tue, 18 Nov 2008 16:18:58 -0800
Message-ID: <DDFD17CC94A9BD49A82147DDF7D545C50144C46B@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ptrace syscall cleanups for mips compat archs
Thread-Index: AclFyQZMlMwnGZlJQ4ORamqDWC1rqQEEwAhQ
From:	"Anirban Sinha" <ASinha@zeugmasystems.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <ASinha@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ASinha@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Can someone please respond to this patch please? Even something like
"it's a total crap" would be fine! 


Index: mips-git/arch/mips/kernel/ptrace32.c
===================================================================
--- mips-git.orig/arch/mips/kernel/ptrace32.c
+++ mips-git/arch/mips/kernel/ptrace32.c
@@ -49,19 +49,6 @@ long compat_arch_ptrace(struct task_stru
 	int ret;
 
 	switch (request) {
-	/* when I and D space are separate, these will need to be fixed.
*/
-	case PTRACE_PEEKTEXT: /* read word at location addr. */
-	case PTRACE_PEEKDATA: {
-		unsigned int tmp;
-		int copied;
-
-		copied = access_process_vm(child, addr, &tmp,
sizeof(tmp), 0);
-		ret = -EIO;
-		if (copied != sizeof(tmp))
-			break;
-		ret = put_user(tmp, (unsigned int __user *) (unsigned
long) data);
-		break;
-	}
 
 	/*
 	 * Read 4 bytes of the other process' storage
@@ -208,16 +195,6 @@ long compat_arch_ptrace(struct task_stru
 		break;
 	}
 
-	/* when I and D space are separate, this will have to be fixed.
*/
-	case PTRACE_POKETEXT: /* write the word at location addr. */
-	case PTRACE_POKEDATA:
-		ret = 0;
-		if (access_process_vm(child, addr, &data, sizeof(data),
1)
-		    == sizeof(data))
-			break;
-		ret = -EIO;
-		break;
-
 	/*
 	 * Write 4 bytes into the other process' storage
 	 *  data is the 4 bytes that the user wants written
@@ -332,50 +309,11 @@ long compat_arch_ptrace(struct task_stru
 		ret = ptrace_setfpregs(child, (__u32 __user *) (__u64)
data);
 		break;
 
-	case PTRACE_SYSCALL: /* continue and stop at next (return from)
syscall */
-	case PTRACE_CONT: { /* restart after signal. */
-		ret = -EIO;
-		if (!valid_signal(data))
-			break;
-		if (request == PTRACE_SYSCALL) {
-			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
-		}
-		else {
-			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
-		}
-		child->exit_code = data;
-		wake_up_process(child);
-		ret = 0;
-		break;
-	}
-
-	/*
-	 * make the child exit.  Best I can do is send it a sigkill.
-	 * perhaps it should be put in the status that it wants to
-	 * exit.
-	 */
-	case PTRACE_KILL:
-		ret = 0;
-		if (child->exit_state == EXIT_ZOMBIE)	/* already dead
*/
-			break;
-		child->exit_code = SIGKILL;
-		wake_up_process(child);
-		break;
-
 	case PTRACE_GET_THREAD_AREA:
 		ret = put_user(task_thread_info(child)->tp_value,
 				(unsigned int __user *) (unsigned long)
data);
 		break;
 
-	case PTRACE_DETACH: /* detach a process that was attached. */
-		ret = ptrace_detach(child, data);
-		break;
-
-	case PTRACE_GETEVENTMSG:
-		ret = put_user(child->ptrace_message,
-			       (unsigned int __user *) (unsigned long)
data);
-		break;
-
 	case PTRACE_GET_THREAD_AREA_3264:
 		ret = put_user(task_thread_info(child)->tp_value,
 				(unsigned long __user *) (unsigned long)
data);
@@ -392,7 +330,7 @@ long compat_arch_ptrace(struct task_stru
 		break;
 
 	default:
-		ret = ptrace_request(child, request, addr, data);
+		ret = compat_ptrace_request(child, request, addr, data);
 		break;
 	}
 out:
