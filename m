Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2007 14:16:33 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.185]:53557 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20044413AbXAWOQB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Jan 2007 14:16:01 +0000
Received: by nf-out-0910.google.com with SMTP id l24so237969nfc
        for <linux-mips@linux-mips.org>; Tue, 23 Jan 2007 06:16:00 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=tmgXuNuhnqH+K3Hs2iF+EHeu97VXYCiRc0rm4Ep/VYs9xhdchuBt//vSQKNI2xvF812Nky/uRKldhQgx7YyO077qp03TlRTr1qjRn0QOlB8x/hW3oRnNNsnmop9QE3d43p1BuX64YEEb380vLYQ1D6PWPXN0oWBh21i8KnnYqqg=
Received: by 10.49.21.8 with SMTP id y8mr1144317nfi.1169561760035;
        Tue, 23 Jan 2007 06:16:00 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id c10sm2724025nfb.2007.01.23.06.15.58;
        Tue, 23 Jan 2007 06:15:59 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 5E2BE23F76F; Tue, 23 Jan 2007 15:18:23 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 1/7] signals: reduce {setup,restore}_sigcontext sizes
Date:	Tue, 23 Jan 2007 15:18:17 +0100
Message-Id: <11695619031540-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
In-Reply-To: <1169561903878-git-send-email-fbuihuu@gmail.com>
References: <1169561903878-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

This trivial change reduces considerably code size of these
2 functions callers. For instance, here is the figures for
arch/kernel/signal.o objects:

   text    data     bss     dec     hex filename
  11972       0       0   11972    2ec4 arch/mips/kernel/signal.o~old
   5380       0       0    5380    1504 arch/mips/kernel/signal.o~new

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/signal-common.h |   35 +++++++----------------------------
 1 files changed, 7 insertions(+), 28 deletions(-)

diff --git a/arch/mips/kernel/signal-common.h b/arch/mips/kernel/signal-common.h
index b1f09d5..d56897e 100644
--- a/arch/mips/kernel/signal-common.h
+++ b/arch/mips/kernel/signal-common.h
@@ -13,22 +13,13 @@ static inline int
 setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 {
 	int err = 0;
+	int i;
 
 	err |= __put_user(regs->cp0_epc, &sc->sc_pc);
 
-#define save_gp_reg(i) do {						\
-	err |= __put_user(regs->regs[i], &sc->sc_regs[i]);		\
-} while(0)
-	__put_user(0, &sc->sc_regs[0]); save_gp_reg(1); save_gp_reg(2);
-	save_gp_reg(3); save_gp_reg(4); save_gp_reg(5); save_gp_reg(6);
-	save_gp_reg(7); save_gp_reg(8); save_gp_reg(9); save_gp_reg(10);
-	save_gp_reg(11); save_gp_reg(12); save_gp_reg(13); save_gp_reg(14);
-	save_gp_reg(15); save_gp_reg(16); save_gp_reg(17); save_gp_reg(18);
-	save_gp_reg(19); save_gp_reg(20); save_gp_reg(21); save_gp_reg(22);
-	save_gp_reg(23); save_gp_reg(24); save_gp_reg(25); save_gp_reg(26);
-	save_gp_reg(27); save_gp_reg(28); save_gp_reg(29); save_gp_reg(30);
-	save_gp_reg(31);
-#undef save_gp_reg
+	err |= __put_user(0, &sc->sc_regs[0]);
+	for (i = 1; i < 32; i++)
+		err |= __put_user(regs->regs[i], &sc->sc_regs[i]);
 
 	err |= __put_user(regs->hi, &sc->sc_mdhi);
 	err |= __put_user(regs->lo, &sc->sc_mdlo);
@@ -71,6 +62,7 @@ restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 	unsigned int used_math;
 	unsigned long treg;
 	int err = 0;
+	int i;
 
 	/* Always make any pending restarted system calls return -EINTR */
 	current_thread_info()->restart_block.fn = do_no_restart_syscall;
@@ -88,21 +80,8 @@ restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 		err |= __get_user(treg, &sc->sc_dsp); wrdsp(treg, DSP_MASK);
 	}
 
-#define restore_gp_reg(i) do {						\
-	err |= __get_user(regs->regs[i], &sc->sc_regs[i]);		\
-} while(0)
-	restore_gp_reg( 1); restore_gp_reg( 2); restore_gp_reg( 3);
-	restore_gp_reg( 4); restore_gp_reg( 5); restore_gp_reg( 6);
-	restore_gp_reg( 7); restore_gp_reg( 8); restore_gp_reg( 9);
-	restore_gp_reg(10); restore_gp_reg(11); restore_gp_reg(12);
-	restore_gp_reg(13); restore_gp_reg(14); restore_gp_reg(15);
-	restore_gp_reg(16); restore_gp_reg(17); restore_gp_reg(18);
-	restore_gp_reg(19); restore_gp_reg(20); restore_gp_reg(21);
-	restore_gp_reg(22); restore_gp_reg(23); restore_gp_reg(24);
-	restore_gp_reg(25); restore_gp_reg(26); restore_gp_reg(27);
-	restore_gp_reg(28); restore_gp_reg(29); restore_gp_reg(30);
-	restore_gp_reg(31);
-#undef restore_gp_reg
+	for (i = 1; i < 32; i++)
+		err |= __get_user(regs->regs[i], &sc->sc_regs[i]);
 
 	err |= __get_user(used_math, &sc->sc_used_math);
 	conditional_used_math(used_math);
-- 
1.4.4.3.ge6d4
