Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Apr 2005 06:46:53 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:53000
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225266AbVD0Fqh>; Wed, 27 Apr 2005 06:46:37 +0100
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for [62.254.210.162]) with SMTP; 27 Apr 2005 05:46:35 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id D7D541F2BF;
	Wed, 27 Apr 2005 14:46:33 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id C23AC1D6CC;
	Wed, 27 Apr 2005 14:46:33 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j3R5kXoj034228;
	Wed, 27 Apr 2005 14:46:33 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 27 Apr 2005 14:46:33 +0900 (JST)
Message-Id: <20050427.144633.01210513.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: preempt safe fpu-emulator
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050427.143622.77402407.nemoto@toshiba-tops.co.jp>
References: <20050427.143622.77402407.nemoto@toshiba-tops.co.jp>
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
X-archive-position: 7800
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 27 Apr 2005 14:36:22 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:
anemo> With this patch, whole fpu-emulator can be run without
anemo> disabling preempt.  I will post a patch to fix preemption issue
anemo> soon.

Here it is.

It also fixes these issues:

* The process might lose fpu BEFORE calling preempt_disable() in
  do_fpe().
* The saved fp context might be overwritten if another process took
  fpu.


--- linux-mips/arch/mips/kernel/traps.c	2005-04-18 11:42:47.000000000 +0900
+++ linux/arch/mips/kernel/traps.c	2005-04-27 14:04:53.407006244 +0900
@@ -551,6 +551,14 @@
 
 		preempt_disable();
 
+#ifdef CONFIG_PREEMPT
+		if (!is_fpu_owner()) {
+			/* We might lose fpu before disabling preempt... */
+			own_fpu();
+			BUG_ON(!used_math());
+			restore_fp(current);
+		}
+#endif
 		/*
 	 	 * Unimplemented operation exception.  If we've got the full
 		 * software emulator on-board, let's use it...
@@ -562,11 +570,18 @@
 		 * a bit extreme for what should be an infrequent event.
 		 */
 		save_fp(current);
+		/* Ensure 'resume' not overwrite saved fp context again. */
+		lose_fpu();
+
+		preempt_enable();
 
 		/* Run the emulator */
 		sig = fpu_emulator_cop1Handler (0, regs,
 			&current->thread.fpu.soft);
 
+		preempt_disable();
+
+		own_fpu();	/* Using the FPU again.  */
 		/*
 		 * We can't allow the emulated instruction to leave any of
 		 * the cause bit set in $fcr31.
@@ -712,6 +727,8 @@
 			set_used_math();
 		}
 
+		preempt_enable();
+
 		if (!cpu_has_fpu) {
 			int sig = fpu_emulator_cop1Handler(0, regs,
 						&current->thread.fpu.soft);
@@ -719,8 +736,6 @@
 				force_sig(sig, current);
 		}
 
-		preempt_enable();
-
 		return;
 
 	case 2:
