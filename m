Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 May 2005 04:11:33 +0100 (BST)
Received: from [IPv6:::ffff:202.230.225.5] ([IPv6:::ffff:202.230.225.5]:13584
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224786AbVEJDLD>; Tue, 10 May 2005 04:11:03 +0100
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 10 May 2005 03:10:52 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 726161D703
	for <linux-mips@linux-mips.org>; Tue, 10 May 2005 12:10:39 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 5DEF2183D4
	for <linux-mips@linux-mips.org>; Tue, 10 May 2005 12:10:39 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j4A3Acoj083787
	for <linux-mips@linux-mips.org>; Tue, 10 May 2005 12:10:39 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 10 May 2005 12:10:38 +0900 (JST)
Message-Id: <20050510.121038.111209401.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Subject: fpu, preempt, ptrace
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7899
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Here is a (revised) patch to fix some preempt issues around fpu and ptrace.

For now, get_fpu_regs() is used in ptrace code only and the condition
'tsk == current' should always be false.  So we can just remove
_save_fp() call instead of disabling preemption.

diff -ur linux-mips/arch/mips/kernel/ptrace.c linux/arch/mips/kernel/ptrace.c
--- linux-mips/arch/mips/kernel/ptrace.c	2005-04-18 11:42:47.000000000 +0900
+++ linux/arch/mips/kernel/ptrace.c	2005-05-10 11:41:35.000000000 +0900
@@ -169,10 +169,12 @@
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
 		default:
diff -ur linux-mips/arch/mips/kernel/ptrace32.c linux/arch/mips/kernel/ptrace32.c
--- linux-mips/arch/mips/kernel/ptrace32.c	2005-04-18 11:42:47.000000000 +0900
+++ linux/arch/mips/kernel/ptrace32.c	2005-05-10 11:38:51.000000000 +0900
@@ -155,10 +155,12 @@
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
 		default:
diff -ur linux-mips/include/asm-mips/fpu.h linux/include/asm-mips/fpu.h
--- linux-mips/include/asm-mips/fpu.h	2005-05-10 10:21:31.000000000 +0900
+++ linux/include/asm-mips/fpu.h	2005-05-10 11:38:38.000000000 +0900
@@ -132,8 +132,10 @@
 static inline fpureg_t *get_fpu_regs(struct task_struct *tsk)
 {
 	if (cpu_has_fpu) {
+		preempt_disable();
 		if ((tsk == current) && __is_fpu_owner()) 
 			_save_fp(current);
+		preempt_enable();
 		return tsk->thread.fpu.hard.fpr;
 	}
 
---
Atsushi Nemoto
