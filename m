Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Mar 2005 06:59:03 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:47620
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225388AbVCNG6r>; Mon, 14 Mar 2005 06:58:47 +0000
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 14 Mar 2005 06:58:45 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 8069B1F1DF;
	Mon, 14 Mar 2005 15:58:41 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 6BF121F1DE;
	Mon, 14 Mar 2005 15:58:41 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j2E6we9c036604;
	Mon, 14 Mar 2005 15:58:41 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 14 Mar 2005 15:58:40 +0900 (JST)
Message-Id: <20050314.155840.44100135.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: multi-threaded core dump
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
X-archive-position: 7427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

It seems linux-mips does not produce correct register dumps in core
file for multi-threaded programs.  This patch tries to fix it.  Could
you review it?  Thank you.


diff -ur linux-mips/arch/mips/kernel/process.c linux/arch/mips/kernel/process.c
--- linux-mips/arch/mips/kernel/process.c	2005-03-04 10:19:33.000000000 +0900
+++ linux/arch/mips/kernel/process.c	2005-03-14 15:51:43.592837356 +0900
@@ -167,6 +167,14 @@
 #endif
 }
 
+int dump_task_regs (struct task_struct *tsk, elf_gregset_t *regs)
+{
+	struct thread_info *ti = tsk->thread_info;
+	long ksp = (unsigned long)ti + THREAD_SIZE - 32;
+	dump_regs(&(*regs)[0], (struct pt_regs *) ksp - 1);
+	return 1;
+}
+
 int dump_task_fpu (struct task_struct *t, elf_fpregset_t *fpr)
 {
 	memcpy(fpr, &t->thread.fpu, sizeof(current->thread.fpu));
diff -ur linux-mips/include/asm-mips/elf.h linux/include/asm-mips/elf.h
--- linux-mips/include/asm-mips/elf.h	2005-03-04 10:19:35.000000000 +0900
+++ linux/include/asm-mips/elf.h	2005-03-14 15:52:22.000046107 +0900
@@ -225,10 +225,12 @@
 #endif /* CONFIG_MIPS64 */
 
 extern void dump_regs(elf_greg_t *, struct pt_regs *regs);
+extern int dump_task_regs (struct task_struct *, elf_gregset_t *);
 extern int dump_task_fpu(struct task_struct *, elf_fpregset_t *);
 
 #define ELF_CORE_COPY_REGS(elf_regs, regs)			\
 	dump_regs((elf_greg_t *)&(elf_regs), regs);
+#define ELF_CORE_COPY_TASK_REGS(tsk, elf_regs) dump_task_regs(tsk, elf_regs)
 #define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs)			\
 	dump_task_fpu(tsk, elf_fpregs)
 
---
Atsushi Nemoto
