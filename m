Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2005 15:53:33 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:34263 "EHLO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with ESMTP id S8133576AbVJGOxK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Oct 2005 15:53:10 +0100
Received: from localhost (p8236-ipad203funabasi.chiba.ocn.ne.jp [222.146.87.236])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id A37B37BA5;
	Fri,  7 Oct 2005 23:53:07 +0900 (JST)
Date:	Fri, 07 Oct 2005 23:51:52 +0900 (JST)
Message-Id: <20051007.235152.75184664.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] fix possible sleeping in atomic on setup/restore sigcontext
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
X-archive-position: 9182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The setup_sigcontect/restore_sigcontext might sleep on
put_user/get_user with preemption disabled (i.e. atomic context).
Sleeping in atomic context is not allowed.  This patch fixes this
problem using temporary variable (struct sigcontext tmpsc).

Another possible fix might be rewriting
restore_fp_context/save_fp_context to copy to/from current
thread_struct and use them with restore_fp/save_fp.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/signal-common.h b/arch/mips/kernel/signal-common.h
--- a/arch/mips/kernel/signal-common.h
+++ b/arch/mips/kernel/signal-common.h
@@ -14,6 +14,7 @@ static inline int
 setup_sigcontext(struct pt_regs *regs, struct sigcontext *sc)
 {
 	int err = 0;
+	struct sigcontext tmpsc;
 
 	err |= __put_user(regs->cp0_epc, &sc->sc_pc);
 
@@ -73,10 +74,15 @@ setup_sigcontext(struct pt_regs *regs, s
 		own_fpu();
 		restore_fp(current);
 	}
-	err |= save_fp_context(sc);
+	/* make sure save_fp_context not sleep */
+	err |= save_fp_context(&tmpsc);
 
 	preempt_enable();
 
+	err |= __copy_to_user(&sc->sc_fpregs, &tmpsc.sc_fpregs,
+			      sizeof(tmpsc.sc_fpregs));
+	err |= __put_user(tmpsc.sc_fpc_csr, &sc->sc_fpc_csr);
+
 out:
 	return err;
 }
@@ -138,14 +144,18 @@ restore_sigcontext(struct pt_regs *regs,
 	err |= __get_user(used_math, &sc->sc_used_math);
 	conditional_used_math(used_math);
 
-	preempt_disable();
-
 	if (used_math()) {
+		/* make sure restore_fp_context not sleep */
+		struct sigcontext tmpsc;
+		err |= __copy_from_user(&tmpsc.sc_fpregs, &sc->sc_fpregs, sizeof(tmpsc.sc_fpregs));
+		err |= __get_user(tmpsc.sc_fpc_csr, &sc->sc_fpc_csr);
+		preempt_disable();
 		/* restore fpu context if we have used it before */
 		own_fpu();
-		err |= restore_fp_context(sc);
+		err |= restore_fp_context(&tmpsc);
 	} else {
 		/* signal handler may have used FPU.  Give it up. */
+		preempt_disable();
 		lose_fpu();
 	}
 
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -376,14 +376,18 @@ static int restore_sigcontext32(struct p
 	err |= __get_user(used_math, &sc->sc_used_math);
 	conditional_used_math(used_math);
 
-	preempt_disable();
-
 	if (used_math()) {
+		struct sigcontext32 tmpsc;
+		/* make sure restore_fp_context32 not sleep */
+		err |= __copy_from_user(&tmpsc.sc_fpregs, &sc->sc_fpregs, sizeof(tmpsc.sc_fpregs));
+		err |= __get_user(tmpsc.sc_fpc_csr, &sc->sc_fpc_csr);
+		preempt_disable();
 		/* restore fpu context if we have used it before */
 		own_fpu();
-		err |= restore_fp_context32(sc);
+		err |= restore_fp_context32(&tmpsc);
 	} else {
 		/* signal handler may have used FPU.  Give it up. */
+		preempt_disable();
 		lose_fpu();
 	}
 
@@ -569,6 +573,7 @@ static inline int setup_sigcontext32(str
 				     struct sigcontext32 *sc)
 {
 	int err = 0;
+	struct sigcontext32 tmpsc;
 
 	err |= __put_user(regs->cp0_epc, &sc->sc_pc);
 	err |= __put_user(regs->cp0_status, &sc->sc_status);
@@ -614,10 +619,15 @@ static inline int setup_sigcontext32(str
 		own_fpu();
 		restore_fp(current);
 	}
-	err |= save_fp_context32(sc);
+	/* make sure save_fp_context32 not sleep */
+	err |= save_fp_context32(&tmpsc);
 
 	preempt_enable();
 
+	err |= __copy_to_user(&sc->sc_fpregs, &tmpsc.sc_fpregs,
+			      sizeof(tmpsc.sc_fpregs));
+	err |= __put_user(tmpsc.sc_fpc_csr, &sc->sc_fpc_csr);
+
 out:
 	return err;
 }
