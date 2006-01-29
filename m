Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jan 2006 13:30:30 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:22738 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133370AbWA2NaM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 29 Jan 2006 13:30:12 +0000
Received: from localhost (p4016-ipad26funabasi.chiba.ocn.ne.jp [220.104.90.16])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 529E1A266; Sun, 29 Jan 2006 22:34:55 +0900 (JST)
Date:	Sun, 29 Jan 2006 22:34:32 +0900 (JST)
Message-Id: <20060129.223432.07642700.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] fix some compiler/sparse warnings in ptrace32.c
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
X-archive-position: 10223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/ptrace32.c b/arch/mips/kernel/ptrace32.c
index 0c82b25..0d5cf97 100644
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -88,7 +88,7 @@ asmlinkage int sys32_ptrace(int request,
 		ret = -EIO;
 		if (copied != sizeof(tmp))
 			break;
-		ret = put_user(tmp, (unsigned int *) (unsigned long) data);
+		ret = put_user(tmp, (unsigned int __user *) (unsigned long) data);
 		break;
 	}
 
@@ -174,8 +174,10 @@ asmlinkage int sys32_ptrace(int request,
 		case FPC_EIR: {	/* implementation / version register */
 			unsigned int flags;
 
-			if (!cpu_has_fpu)
+			if (!cpu_has_fpu) {
+				tmp = 0;
 				break;
+			}
 
 			preempt_disable();
 			if (cpu_has_mipsmt) {
@@ -194,15 +196,18 @@ asmlinkage int sys32_ptrace(int request,
 			preempt_enable();
 			break;
 		}
-		case DSP_BASE ... DSP_BASE + 5:
+		case DSP_BASE ... DSP_BASE + 5: {
+			dspreg_t *dregs;
+
 			if (!cpu_has_dsp) {
 				tmp = 0;
 				ret = -EIO;
 				goto out_tsk;
 			}
-			dspreg_t *dregs = __get_dsp_regs(child);
+			dregs = __get_dsp_regs(child);
 			tmp = (unsigned long) (dregs[addr - DSP_BASE]);
 			break;
+		}
 		case DSP_CONTROL:
 			if (!cpu_has_dsp) {
 				tmp = 0;
@@ -216,7 +221,7 @@ asmlinkage int sys32_ptrace(int request,
 			ret = -EIO;
 			goto out_tsk;
 		}
-		ret = put_user(tmp, (unsigned *) (unsigned long) data);
+		ret = put_user(tmp, (unsigned __user *) (unsigned long) data);
 		break;
 	}
 
@@ -304,15 +309,18 @@ asmlinkage int sys32_ptrace(int request,
 			else
 				child->thread.fpu.soft.fcr31 = data;
 			break;
-		case DSP_BASE ... DSP_BASE + 5:
+		case DSP_BASE ... DSP_BASE + 5: {
+			dspreg_t *dregs;
+
 			if (!cpu_has_dsp) {
 				ret = -EIO;
 				break;
 			}
 
-			dspreg_t *dregs = __get_dsp_regs(child);
+			dregs = __get_dsp_regs(child);
 			dregs[addr - DSP_BASE] = data;
 			break;
+		}
 		case DSP_CONTROL:
 			if (!cpu_has_dsp) {
 				ret = -EIO;
