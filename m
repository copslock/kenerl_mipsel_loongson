Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 02:01:39 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:60399 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225199AbTCMCBi>;
	Thu, 13 Mar 2003 02:01:38 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h2D21ac02704;
	Wed, 12 Mar 2003 18:01:36 -0800
Date: Wed, 12 Mar 2003 18:01:36 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [PATCH] memory leak in ptrace 
Message-ID: <20030312180136.F24687@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Several places in sys_ptrace() don't decrease the page
count where they should.  This will cause memory leak
later when the traced task is freed.

This patch is initially brought up by Sony people and modified
by Drow and me.

Jun


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="030312.2.4-ptrace-memory-leak.patch"

diff -Nru linux/arch/mips/kernel/ptrace.c.orig linux/arch/mips/kernel/ptrace.c
--- linux/arch/mips/kernel/ptrace.c.orig	Thu Nov  7 14:05:33 2002
+++ linux/arch/mips/kernel/ptrace.c	Wed Mar 12 17:28:34 2003
@@ -72,7 +72,7 @@
 
 	ret = -EPERM;
 	if (pid == 1)		/* you may not mess with init */
-		goto out;
+		goto out_tsk;
 
 	if (request == PTRACE_ATTACH) {
 		ret = ptrace_attach(child);
@@ -94,8 +94,7 @@
 		if (copied != sizeof(tmp))
 			break;
 		ret = put_user(tmp,(unsigned long *) data);
-
-		goto out;
+		break;
 		}
 
 	/* Read the word at location addr in the USER area.  */
@@ -164,10 +163,10 @@
 		default:
 			tmp = 0;
 			ret = -EIO;
-			goto out;
+			goto out_tsk;
 		}
 		ret = put_user(tmp, (unsigned long *) data);
-		goto out;
+		break;
 		}
 
 	case PTRACE_POKETEXT: /* write the word at location addr. */
@@ -177,7 +176,7 @@
 		    == sizeof(data))
 			break;
 		ret = -EIO;
-		goto out;
+		break;
 
 	case PTRACE_POKEUSR: {
 		struct pt_regs *regs;
@@ -277,7 +276,7 @@
 
 	default:
 		ret = -EIO;
-		goto out;
+		break;
 	}
 out_tsk:
 	free_task_struct(child);
diff -Nru linux/arch/mips64/kernel/ptrace.c.orig linux/arch/mips64/kernel/ptrace.c
--- linux/arch/mips64/kernel/ptrace.c.orig	Wed Jan 29 15:33:04 2003
+++ linux/arch/mips64/kernel/ptrace.c	Wed Mar 12 17:34:33 2003
@@ -206,7 +206,7 @@
 			ret = -EIO;
 			break;
 		}
-		goto out;
+		break;
 		}
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
 	case PTRACE_CONT: { /* restart after signal. */
@@ -293,7 +293,7 @@
 
 	ret = -EPERM;
 	if (pid == 1)		/* you may not mess with init */
-		goto out;
+		goto out_tsk;
 
 	if (request == PTRACE_ATTACH) {
 		ret = ptrace_attach(child);
@@ -427,7 +427,7 @@
 			ret = -EIO;
 			break;
 		}
-		goto out;
+		break;
 		}
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
 	case PTRACE_CONT: { /* restart after signal. */

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="030312.2.5-ptrace-memory-leak.patch"

diff -Nru linux/arch/mips/kernel/ptrace.c.orig linux/arch/mips/kernel/ptrace.c
--- linux/arch/mips/kernel/ptrace.c.orig	Thu Dec 12 13:58:26 2002
+++ linux/arch/mips/kernel/ptrace.c	Wed Mar 12 17:41:56 2003
@@ -73,7 +73,7 @@
 
 	ret = -EPERM;
 	if (pid == 1)		/* you may not mess with init */
-		goto out;
+		goto out_tsk;
 
 	if (request == PTRACE_ATTACH) {
 		ret = ptrace_attach(child);
@@ -95,8 +95,7 @@
 		if (copied != sizeof(tmp))
 			break;
 		ret = put_user(tmp,(unsigned long *) data);
-
-		goto out;
+		break;
 		}
 
 	/* Read the word at location addr in the USER area.  */
@@ -165,10 +164,10 @@
 		default:
 			tmp = 0;
 			ret = -EIO;
-			goto out;
+			goto out_tsk;
 		}
 		ret = put_user(tmp, (unsigned long *) data);
-		goto out;
+		break;
 		}
 
 	case PTRACE_POKETEXT: /* write the word at location addr. */
@@ -178,7 +177,7 @@
 		    == sizeof(data))
 			break;
 		ret = -EIO;
-		goto out;
+		break;
 
 	case PTRACE_POKEUSR: {
 		struct pt_regs *regs;
diff -Nru linux/arch/mips64/kernel/ptrace.c.orig linux/arch/mips64/kernel/ptrace.c
--- linux/arch/mips64/kernel/ptrace.c.orig	Thu Feb 13 11:37:35 2003
+++ linux/arch/mips64/kernel/ptrace.c	Wed Mar 12 17:41:56 2003
@@ -206,7 +206,7 @@
 			ret = -EIO;
 			break;
 		}
-		goto out;
+		break;
 		}
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
 	case PTRACE_CONT: { /* restart after signal. */
@@ -286,7 +286,7 @@
 
 	ret = -EPERM;
 	if (pid == 1)		/* you may not mess with init */
-		goto out;
+		goto out_tsk;
 
 	if (request == PTRACE_ATTACH) {
 		ret = ptrace_attach(child);
@@ -420,7 +420,7 @@
 			ret = -EIO;
 			break;
 		}
-		goto out;
+		break;
 		}
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
 	case PTRACE_CONT: { /* restart after signal. */

--rwEMma7ioTxnRzrJ--
