Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Mar 2007 17:43:17 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:14023 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037679AbXCCRnM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 3 Mar 2007 17:43:12 +0000
Received: from localhost (p6054-ipad201funabasi.chiba.ocn.ne.jp [222.146.69.54])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 8416CB665; Sun,  4 Mar 2007 02:41:52 +0900 (JST)
Date:	Sun, 04 Mar 2007 02:41:52 +0900 (JST)
Message-Id: <20070304.024152.96687132.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] store sign-extend register values for PTRACE_GETREGS
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
X-archive-position: 14333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

A comment on ptrace_getregs() states "Registers are sign extended to
fill the available space." but it is not true.  Fix code to match the
comment.  Also fix casts on each caller to get rid of some warnings.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 478355a..5560b6d 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -66,13 +66,13 @@ int ptrace_getregs (struct task_struct *
 	regs = task_pt_regs(child);
 
 	for (i = 0; i < 32; i++)
-		__put_user (regs->regs[i], data + i);
-	__put_user (regs->lo, data + EF_LO - EF_R0);
-	__put_user (regs->hi, data + EF_HI - EF_R0);
-	__put_user (regs->cp0_epc, data + EF_CP0_EPC - EF_R0);
-	__put_user (regs->cp0_badvaddr, data + EF_CP0_BADVADDR - EF_R0);
-	__put_user (regs->cp0_status, data + EF_CP0_STATUS - EF_R0);
-	__put_user (regs->cp0_cause, data + EF_CP0_CAUSE - EF_R0);
+		__put_user ((long)regs->regs[i], data + i);
+	__put_user ((long)regs->lo, data + EF_LO - EF_R0);
+	__put_user ((long)regs->hi, data + EF_HI - EF_R0);
+	__put_user ((long)regs->cp0_epc, data + EF_CP0_EPC - EF_R0);
+	__put_user ((long)regs->cp0_badvaddr, data + EF_CP0_BADVADDR - EF_R0);
+	__put_user ((long)regs->cp0_status, data + EF_CP0_STATUS - EF_R0);
+	__put_user ((long)regs->cp0_cause, data + EF_CP0_CAUSE - EF_R0);
 
 	return 0;
 }
@@ -403,11 +403,11 @@ long arch_ptrace(struct task_struct *chi
 		}
 
 	case PTRACE_GETREGS:
-		ret = ptrace_getregs (child, (__u64 __user *) data);
+		ret = ptrace_getregs (child, (__s64 __user *) data);
 		break;
 
 	case PTRACE_SETREGS:
-		ret = ptrace_setregs (child, (__u64 __user *) data);
+		ret = ptrace_setregs (child, (__s64 __user *) data);
 		break;
 
 	case PTRACE_GETFPREGS:
diff --git a/arch/mips/kernel/ptrace32.c b/arch/mips/kernel/ptrace32.c
index d9a39c1..2c60320 100644
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -346,11 +346,11 @@ asmlinkage int sys32_ptrace(int request,
 		}
 
 	case PTRACE_GETREGS:
-		ret = ptrace_getregs (child, (__u64 __user *) (__u64) data);
+		ret = ptrace_getregs (child, (__s64 __user *) (__u64) data);
 		break;
 
 	case PTRACE_SETREGS:
-		ret = ptrace_setregs (child, (__u64 __user *) (__u64) data);
+		ret = ptrace_setregs (child, (__s64 __user *) (__u64) data);
 		break;
 
 	case PTRACE_GETFPREGS:
