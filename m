Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Oct 2004 07:21:36 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:47904
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224791AbUJGGVa>; Thu, 7 Oct 2004 07:21:30 +0100
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 7 Oct 2004 06:21:29 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 8AE66239E23; Thu,  7 Oct 2004 15:24:07 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i976LL8G030232;
	Thu, 7 Oct 2004 15:21:21 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Thu, 07 Oct 2004 15:20:17 +0900 (JST)
Message-Id: <20041007.152017.30190458.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: Re: fpu_emulator can lose fpu on get_user/put_user
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20041006.101920.126571873.nemoto@toshiba-tops.co.jp>
References: <20041006.101920.126571873.nemoto@toshiba-tops.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 06 Oct 2004 10:19:20 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:
anemo> I found a potential problem in math emulation.  The math-emu
anemo> uses put_user/get_user to fetch the instruction or to emulate
anemo> load/store fp-regs.  The put_user/get_user can sleep then we
anemo> can lose fpu ownership on it.  It it happened, subsequent
anemo> restore_fp will cause CpU exception which not allowed in
anemo> kernel.

And there are similar potential problem in setup/restore sigcontext.
save_fp_context/restore_fp_context might sleep on put_user/get_user.

This is a quick fix for 2.6 kernel.  Another possible fix is rewriting
restore_fp_context/save_fp_context to copy to/from current
thread_struct and use them with restore_fp/save_fp.  Is this better?
Any comment are welcome.


diff -up linux-mips/arch/mips/kernel/signal.c linux/arch/mips/kernel/signal.c
--- linux-mips/arch/mips/kernel/signal.c	Wed Sep 22 13:27:59 2004
+++ linux/arch/mips/kernel/signal.c	Thu Oct  7 14:47:23 2004
@@ -182,9 +182,14 @@ asmlinkage int restore_sigcontext(struct
 	err |= __get_user(current->used_math, &sc->sc_used_math);
 
 	if (current->used_math) {
+		/* make sure restore_fp_context not sleep */
+		struct sigcontext tmpsc;
+		err |= __copy_from_user(&tmpsc.sc_fpregs, &sc->sc_fpregs, sizeof(tmpsc.sc_fpregs));
+		err |= __get_user(tmpsc.sc_fpc_csr, &sc->sc_fpc_csr);
+		err |= __get_user(tmpsc.sc_fpc_eir, &sc->sc_fpc_eir);
 		/* restore fpu context if we have used it before */
 		own_fpu();
-		err |= restore_fp_context(sc);
+		err |= restore_fp_context(&tmpsc);
 	} else {
 		/* signal handler may have used FPU.  Give it up. */
 		lose_fpu();
@@ -291,6 +296,7 @@ badframe:
 inline int setup_sigcontext(struct pt_regs *regs, struct sigcontext *sc)
 {
 	int err = 0;
+	struct sigcontext tmpsc;
 
 	err |= __put_user(regs->cp0_epc, &sc->sc_pc);
 	err |= __put_user(regs->cp0_status, &sc->sc_status);
@@ -327,7 +333,12 @@ inline int setup_sigcontext(struct pt_re
 		own_fpu();
 		restore_fp(current);
 	}
-	err |= save_fp_context(sc);
+	/* make sure save_fp_context not sleep */
+	err |= save_fp_context(&tmpsc);
+	err |= __copy_to_user(&sc->sc_fpregs, &tmpsc.sc_fpregs,
+			      sizeof(tmpsc.sc_fpregs));
+	err |= __put_user(tmpsc.sc_fpc_csr, &sc->sc_fpc_csr);
+	err |= __put_user(tmpsc.sc_fpc_eir, &sc->sc_fpc_eir);
 
 out:
 	return err;
diff -up linux-mips/arch/mips/kernel/signal32.c linux/arch/mips/kernel/signal32.c
--- linux-mips/arch/mips/kernel/signal32.c	Wed Sep 22 13:27:59 2004
+++ linux/arch/mips/kernel/signal32.c	Thu Oct  7 14:47:39 2004
@@ -365,9 +365,14 @@ static asmlinkage int restore_sigcontext
 	err |= __get_user(current->used_math, &sc->sc_used_math);
 
 	if (current->used_math) {
+		struct sigcontext32 tmpsc;
+		/* make sure restore_fp_context32 not sleep */
+		err |= __copy_from_user(&tmpsc.sc_fpregs, &sc->sc_fpregs, sizeof(tmpsc.sc_fpregs));
+		err |= __get_user(tmpsc.sc_fpc_csr, &sc->sc_fpc_csr);
+		err |= __get_user(tmpsc.sc_fpc_eir, &sc->sc_fpc_eir);
 		/* restore fpu context if we have used it before */
 		own_fpu();
-		err |= restore_fp_context32(sc);
+		err |= restore_fp_context32(&tmpsc);
 	} else {
 		/* signal handler may have used FPU.  Give it up. */
 		lose_fpu();
@@ -526,6 +531,7 @@ static inline int setup_sigcontext32(str
 				     struct sigcontext32 *sc)
 {
 	int err = 0;
+	struct sigcontext32 tmpsc;
 
 	err |= __put_user(regs->cp0_epc, &sc->sc_pc);
 	err |= __put_user(regs->cp0_status, &sc->sc_status);
@@ -562,7 +568,12 @@ static inline int setup_sigcontext32(str
 		own_fpu();
 		restore_fp(current);
 	}
-	err |= save_fp_context32(sc);
+	/* make sure save_fp_context32 not sleep */
+	err |= save_fp_context32(&tmpsc);
+	err |= __copy_to_user(&sc->sc_fpregs, &tmpsc.sc_fpregs,
+			      sizeof(tmpsc.sc_fpregs));
+	err |= __put_user(tmpsc.sc_fpc_csr, &sc->sc_fpc_csr);
+	err |= __put_user(tmpsc.sc_fpc_eir, &sc->sc_fpc_eir);
 
 out:
 	return err;

---
Atsushi Nemoto
