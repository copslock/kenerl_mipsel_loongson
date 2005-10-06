Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Oct 2005 16:45:38 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:47066 "EHLO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with ESMTP id S8133547AbVJFPpR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Oct 2005 16:45:17 +0100
Received: from localhost (p6235-ipad201funabasi.chiba.ocn.ne.jp [222.146.69.235])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id 532848A98;
	Fri,  7 Oct 2005 00:45:15 +0900 (JST)
Date:	Fri, 07 Oct 2005 00:43:59 +0900 (JST)
Message-Id: <20051007.004359.25909892.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] protect CU1 bit manipulation from preempt
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
X-archive-position: 9161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The ptrace temporarily enable CP1 without fpu-ownership.  These
regions should be protected from preempt.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -126,10 +126,12 @@ int ptrace_getfpregs (struct task_struct
 
 		__put_user (child->thread.fpu.hard.fcr31, data + 64);
 
+		preempt_disable();
 		flags = read_c0_status();
 		__enable_fpu();
 		__asm__ __volatile__("cfc1\t%0,$0" : "=r" (tmp));
 		write_c0_status(flags);
+		preempt_enable();
 		__put_user (tmp, data + 65);
 	} else {
 		__put_user (child->thread.fpu.soft.fcr31, data + 64);
@@ -284,10 +286,12 @@ asmlinkage int sys_ptrace(long request, 
 			if (!cpu_has_fpu)
 				break;
 
+			preempt_disable();
 			flags = read_c0_status();
 			__enable_fpu();
 			__asm__ __volatile__("cfc1\t%0,$0": "=r" (tmp));
 			write_c0_status(flags);
+			preempt_enable();
 			break;
 		}
 		case DSP_BASE ... DSP_BASE + 5: {
diff --git a/arch/mips/kernel/ptrace32.c b/arch/mips/kernel/ptrace32.c
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -191,10 +191,12 @@ asmlinkage int sys32_ptrace(int request,
 			if (!cpu_has_fpu)
 				break;
 
+			preempt_disable();
 			flags = read_c0_status();
 			__enable_fpu();
 			__asm__ __volatile__("cfc1\t%0,$0": "=r" (tmp));
 			write_c0_status(flags);
+			preempt_enable();
 			break;
 		}
 		case DSP_BASE ... DSP_BASE + 5:
