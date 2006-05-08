Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 May 2006 20:28:35 +0100 (BST)
Received: from nevyn.them.org ([66.93.172.17]:22719 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8133519AbWEHT2Z (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 8 May 2006 20:28:25 +0100
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1FdBP4-0003fP-Lu; Mon, 08 May 2006 15:28:22 -0400
Date:	Mon, 8 May 2006 15:28:22 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Update struct sigcontext member names
Message-ID: <20060508192822.GA14037@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

Rename the MIPS64 sc_hi and sc_lo arrays to use the same names
as the MIPS32 struct sigcontext (sc_mdhi, sc_hi1, et cetera).

Signed-off-by: Daniel Jacobowitz <dan@codesourcery.com>

---

As we discussed earlier - this lets glibc use the same definitions, without
breaking source compatibility for the 64-bit sigcontext.

diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 92b28b6..0facfaf 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -272,8 +272,8 @@ void output_sc_defines(void)
 	text("/* Linux sigcontext offsets. */");
 	offset("#define SC_REGS       ", struct sigcontext, sc_regs);
 	offset("#define SC_FPREGS     ", struct sigcontext, sc_fpregs);
-	offset("#define SC_MDHI       ", struct sigcontext, sc_hi);
-	offset("#define SC_MDLO       ", struct sigcontext, sc_lo);
+	offset("#define SC_MDHI       ", struct sigcontext, sc_mdhi);
+	offset("#define SC_MDLO       ", struct sigcontext, sc_mdlo);
 	offset("#define SC_PC         ", struct sigcontext, sc_pc);
 	offset("#define SC_FPC_CSR    ", struct sigcontext, sc_fpc_csr);
 	linefeed;
diff --git a/arch/mips/kernel/signal-common.h b/arch/mips/kernel/signal-common.h
index 3ca7862..ce6cb91 100644
--- a/arch/mips/kernel/signal-common.h
+++ b/arch/mips/kernel/signal-common.h
@@ -31,7 +31,6 @@ #define save_gp_reg(i) do {						\
 	save_gp_reg(31);
 #undef save_gp_reg
 
-#ifdef CONFIG_32BIT
 	err |= __put_user(regs->hi, &sc->sc_mdhi);
 	err |= __put_user(regs->lo, &sc->sc_mdlo);
 	if (cpu_has_dsp) {
@@ -43,20 +42,6 @@ #ifdef CONFIG_32BIT
 		err |= __put_user(mflo3(), &sc->sc_lo3);
 		err |= __put_user(rddsp(DSP_MASK), &sc->sc_dsp);
 	}
-#endif
-#ifdef CONFIG_64BIT
-	err |= __put_user(regs->hi, &sc->sc_hi[0]);
-	err |= __put_user(regs->lo, &sc->sc_lo[0]);
-	if (cpu_has_dsp) {
-		err |= __put_user(mfhi1(), &sc->sc_hi[1]);
-		err |= __put_user(mflo1(), &sc->sc_lo[1]);
-		err |= __put_user(mfhi2(), &sc->sc_hi[2]);
-		err |= __put_user(mflo2(), &sc->sc_lo[2]);
-		err |= __put_user(mfhi3(), &sc->sc_hi[3]);
-		err |= __put_user(mflo3(), &sc->sc_lo[3]);
-		err |= __put_user(rddsp(DSP_MASK), &sc->sc_dsp);
-	}
-#endif
 
 	err |= __put_user(!!used_math(), &sc->sc_used_math);
 
@@ -92,7 +77,6 @@ restore_sigcontext(struct pt_regs *regs,
 	current_thread_info()->restart_block.fn = do_no_restart_syscall;
 
 	err |= __get_user(regs->cp0_epc, &sc->sc_pc);
-#ifdef CONFIG_32BIT
 	err |= __get_user(regs->hi, &sc->sc_mdhi);
 	err |= __get_user(regs->lo, &sc->sc_mdlo);
 	if (cpu_has_dsp) {
@@ -104,20 +88,6 @@ #ifdef CONFIG_32BIT
 		err |= __get_user(treg, &sc->sc_lo3); mtlo3(treg);
 		err |= __get_user(treg, &sc->sc_dsp); wrdsp(treg, DSP_MASK);
 	}
-#endif
-#ifdef CONFIG_64BIT
-	err |= __get_user(regs->hi, &sc->sc_hi[0]);
-	err |= __get_user(regs->lo, &sc->sc_lo[0]);
-	if (cpu_has_dsp) {
-		err |= __get_user(treg, &sc->sc_hi[1]); mthi1(treg);
-		err |= __get_user(treg, &sc->sc_lo[1]); mthi1(treg);
-		err |= __get_user(treg, &sc->sc_hi[2]); mthi2(treg);
-		err |= __get_user(treg, &sc->sc_lo[2]); mthi2(treg);
-		err |= __get_user(treg, &sc->sc_hi[3]); mthi3(treg);
-		err |= __get_user(treg, &sc->sc_lo[3]); mthi3(treg);
-		err |= __get_user(treg, &sc->sc_dsp); wrdsp(treg, DSP_MASK);
-	}
-#endif
 
 #define restore_gp_reg(i) do {						\
 	err |= __get_user(regs->regs[i], &sc->sc_regs[i]);		\
diff --git a/include/asm-mips/sigcontext.h b/include/asm-mips/sigcontext.h
index 8edabb0..cefa657 100644
--- a/include/asm-mips/sigcontext.h
+++ b/include/asm-mips/sigcontext.h
@@ -55,8 +55,14 @@ #if _MIPS_SIM == _MIPS_SIM_ABI64 || _MIP
 struct sigcontext {
 	unsigned long	sc_regs[32];
 	unsigned long	sc_fpregs[32];
-	unsigned long	sc_hi[4];
-	unsigned long	sc_lo[4];
+	unsigned long	sc_mdhi;
+	unsigned long	sc_hi1;
+	unsigned long	sc_hi2;
+	unsigned long	sc_hi3;
+	unsigned long	sc_mdlo;
+	unsigned long	sc_lo1;
+	unsigned long	sc_lo2;
+	unsigned long	sc_lo3;
 	unsigned long	sc_pc;
 	unsigned int	sc_fpc_csr;
 	unsigned int	sc_used_math;

-- 
Daniel Jacobowitz
CodeSourcery
