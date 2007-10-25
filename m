Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 16:52:38 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:49372 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022607AbXJYPwa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 25 Oct 2007 16:52:30 +0100
Received: from localhost (p2115-ipad304funabasi.chiba.ocn.ne.jp [123.217.156.115])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A5751A904; Fri, 26 Oct 2007 00:51:07 +0900 (JST)
Date:	Fri, 26 Oct 2007 00:53:02 +0900 (JST)
Message-Id: <20071026.005302.25909293.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] store sign-extend register values for PTRACE_GETREGS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070304.024152.96687132.anemo@mba.ocn.ne.jp>
References: <20070304.024152.96687132.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 04 Mar 2007 02:41:52 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> A comment on ptrace_getregs() states "Registers are sign extended to
> fill the available space." but it is not true.  Fix code to match the
> comment.  Also fix casts on each caller to get rid of some warnings.

Revised for current git tree.

------------------------------------------------------
Subject: [PATCH] store sign-extend register values for PTRACE_GETREGS
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

A comment on ptrace_getregs() states "Registers are sign extended to
fill the available space." but it is not true.  Fix code to match the
comment.  Also fix casts on each caller to get rid of some warnings.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/kernel/ptrace.c   |   18 +++++++++---------
 arch/mips/kernel/ptrace32.c |    4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 999f785..35234b9 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -65,13 +65,13 @@ int ptrace_getregs(struct task_struct *child, __s64 __user *data)
 	regs = task_pt_regs(child);
 
 	for (i = 0; i < 32; i++)
-		__put_user(regs->regs[i], data + i);
-	__put_user(regs->lo, data + EF_LO - EF_R0);
-	__put_user(regs->hi, data + EF_HI - EF_R0);
-	__put_user(regs->cp0_epc, data + EF_CP0_EPC - EF_R0);
-	__put_user(regs->cp0_badvaddr, data + EF_CP0_BADVADDR - EF_R0);
-	__put_user(regs->cp0_status, data + EF_CP0_STATUS - EF_R0);
-	__put_user(regs->cp0_cause, data + EF_CP0_CAUSE - EF_R0);
+		__put_user((long)regs->regs[i], data + i);
+	__put_user((long)regs->lo, data + EF_LO - EF_R0);
+	__put_user((long)regs->hi, data + EF_HI - EF_R0);
+	__put_user((long)regs->cp0_epc, data + EF_CP0_EPC - EF_R0);
+	__put_user((long)regs->cp0_badvaddr, data + EF_CP0_BADVADDR - EF_R0);
+	__put_user((long)regs->cp0_status, data + EF_CP0_STATUS - EF_R0);
+	__put_user((long)regs->cp0_cause, data + EF_CP0_CAUSE - EF_R0);
 
 	return 0;
 }
@@ -390,11 +390,11 @@ long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 		}
 
 	case PTRACE_GETREGS:
-		ret = ptrace_getregs(child, (__u64 __user *) data);
+		ret = ptrace_getregs(child, (__s64 __user *) data);
 		break;
 
 	case PTRACE_SETREGS:
-		ret = ptrace_setregs(child, (__u64 __user *) data);
+		ret = ptrace_setregs(child, (__s64 __user *) data);
 		break;
 
 	case PTRACE_GETFPREGS:
diff --git a/arch/mips/kernel/ptrace32.c b/arch/mips/kernel/ptrace32.c
index f2bffed..76818be 100644
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -346,11 +346,11 @@ asmlinkage int sys32_ptrace(int request, int pid, int addr, int data)
 		}
 
 	case PTRACE_GETREGS:
-		ret = ptrace_getregs(child, (__u64 __user *) (__u64) data);
+		ret = ptrace_getregs(child, (__s64 __user *) (__u64) data);
 		break;
 
 	case PTRACE_SETREGS:
-		ret = ptrace_setregs(child, (__u64 __user *) (__u64) data);
+		ret = ptrace_setregs(child, (__s64 __user *) (__u64) data);
 		break;
 
 	case PTRACE_GETFPREGS:
