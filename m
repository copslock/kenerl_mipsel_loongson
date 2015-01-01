Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jan 2015 18:45:34 +0100 (CET)
Received: from mail-we0-f179.google.com ([74.125.82.179]:40168 "EHLO
        mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006810AbbAARpcOdfRt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Jan 2015 18:45:32 +0100
Received: by mail-we0-f179.google.com with SMTP id q59so3589704wes.24
        for <linux-mips@linux-mips.org>; Thu, 01 Jan 2015 09:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=urbPaZxzTEZrQ3yVdR74L4gYycDTAwe2qKMfbwYAQBI=;
        b=ikPmJiuAoaO4MCuTnB2yIpHokTcPAo4U+BwKviEGGh52Hn29i/TGUIv5zHmzLxEZB2
         tZ0ifv44b8KZLT+mNlnLsqHQemDqOWrGyp0Ht+oYRKbVEDxwEx2+uHcx4vws4OB+WwA1
         1J7S4xs/e1tPqLyCQajWLuC/OTTkqfc7dhP30mFLTGusd00affEe/MXTL76JEj8O/RHZ
         EB/oXN9YLvf1w01t2h0btiGD55O4E+uMfuWq+Nn2OU0okWDVYmwEhRHce0V1Jg3ikaP+
         xlRifYaUOxi2fnq26EkwoUQIQtaKZUqkCZUzw2vrvtZozzHz9D8ueuM4fj5cgwNiS9nS
         beDg==
X-Gm-Message-State: ALoCoQlFBRQcHL14fM27BsolkO23S3Ka0/p/o/HkspN/y9u12uSiA+oPpTRfJAkaqy8Vj8FZ4gOV
X-Received: by 10.180.7.198 with SMTP id l6mr126725877wia.26.1420134326945;
        Thu, 01 Jan 2015 09:45:26 -0800 (PST)
Received: from localhost.localdomain (h-246-111.a218.priv.bahnhof.se. [85.24.246.111])
        by mx.google.com with ESMTPSA id fp2sm48843316wib.8.2015.01.01.09.45.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jan 2015 09:45:26 -0800 (PST)
From:   Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>
Cc:     Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        John Crispin <blogic@openwrt.org>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arch: mips: kernel: traps:  Remove some unused functions
Date:   Thu,  1 Jan 2015 18:48:27 +0100
Message-Id: <1420134507-540-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <rickard.strandqvist@spctrm.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rickard_strandqvist@spectrumdigital.se
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Removes some functions that are not used anywhere:
do_bp() do_ftlb() do_dsp() do_mcheck() do_mdmx() do_msa() do_msa_fpe()

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/mips/kernel/traps.c |  185 ----------------------------------------------
 1 file changed, 185 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 22b19c2..59c8e0d 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -854,85 +854,6 @@ static void do_trap_or_bp(struct pt_regs *regs, unsigned int code,
 	}
 }
 
-asmlinkage void do_bp(struct pt_regs *regs)
-{
-	unsigned int opcode, bcode;
-	enum ctx_state prev_state;
-	unsigned long epc;
-	u16 instr[2];
-	mm_segment_t seg;
-
-	seg = get_fs();
-	if (!user_mode(regs))
-		set_fs(KERNEL_DS);
-
-	prev_state = exception_enter();
-	if (get_isa16_mode(regs->cp0_epc)) {
-		/* Calculate EPC. */
-		epc = exception_epc(regs);
-		if (cpu_has_mmips) {
-			if ((__get_user(instr[0], (u16 __user *)msk_isa16_mode(epc)) ||
-			    (__get_user(instr[1], (u16 __user *)msk_isa16_mode(epc + 2)))))
-				goto out_sigsegv;
-			opcode = (instr[0] << 16) | instr[1];
-		} else {
-			/* MIPS16e mode */
-			if (__get_user(instr[0],
-				       (u16 __user *)msk_isa16_mode(epc)))
-				goto out_sigsegv;
-			bcode = (instr[0] >> 6) & 0x3f;
-			do_trap_or_bp(regs, bcode, "Break");
-			goto out;
-		}
-	} else {
-		if (__get_user(opcode,
-			       (unsigned int __user *) exception_epc(regs)))
-			goto out_sigsegv;
-	}
-
-	/*
-	 * There is the ancient bug in the MIPS assemblers that the break
-	 * code starts left to bit 16 instead to bit 6 in the opcode.
-	 * Gas is bug-compatible, but not always, grrr...
-	 * We handle both cases with a simple heuristics.  --macro
-	 */
-	bcode = ((opcode >> 6) & ((1 << 20) - 1));
-	if (bcode >= (1 << 10))
-		bcode >>= 10;
-
-	/*
-	 * notify the kprobe handlers, if instruction is likely to
-	 * pertain to them.
-	 */
-	switch (bcode) {
-	case BRK_KPROBE_BP:
-		if (notify_die(DIE_BREAK, "debug", regs, bcode,
-			       regs_to_trapnr(regs), SIGTRAP) == NOTIFY_STOP)
-			goto out;
-		else
-			break;
-	case BRK_KPROBE_SSTEPBP:
-		if (notify_die(DIE_SSTEPBP, "single_step", regs, bcode,
-			       regs_to_trapnr(regs), SIGTRAP) == NOTIFY_STOP)
-			goto out;
-		else
-			break;
-	default:
-		break;
-	}
-
-	do_trap_or_bp(regs, bcode, "Break");
-
-out:
-	set_fs(seg);
-	exception_exit(prev_state);
-	return;
-
-out_sigsegv:
-	force_sig(SIGSEGV, current);
-	goto out;
-}
-
 asmlinkage void do_tr(struct pt_regs *regs)
 {
 	u32 opcode, tcode = 0;
@@ -1297,46 +1218,6 @@ out:
 	exception_exit(prev_state);
 }
 
-asmlinkage void do_msa_fpe(struct pt_regs *regs)
-{
-	enum ctx_state prev_state;
-
-	prev_state = exception_enter();
-	die_if_kernel("do_msa_fpe invoked from kernel context!", regs);
-	force_sig(SIGFPE, current);
-	exception_exit(prev_state);
-}
-
-asmlinkage void do_msa(struct pt_regs *regs)
-{
-	enum ctx_state prev_state;
-	int err;
-
-	prev_state = exception_enter();
-
-	if (!cpu_has_msa || test_thread_flag(TIF_32BIT_FPREGS)) {
-		force_sig(SIGILL, current);
-		goto out;
-	}
-
-	die_if_kernel("do_msa invoked from kernel context!", regs);
-
-	err = enable_restore_fp_context(1);
-	if (err)
-		force_sig(SIGILL, current);
-out:
-	exception_exit(prev_state);
-}
-
-asmlinkage void do_mdmx(struct pt_regs *regs)
-{
-	enum ctx_state prev_state;
-
-	prev_state = exception_enter();
-	force_sig(SIGILL, current);
-	exception_exit(prev_state);
-}
-
 /*
  * Called with interrupts disabled.
  */
@@ -1370,36 +1251,6 @@ asmlinkage void do_watch(struct pt_regs *regs)
 	exception_exit(prev_state);
 }
 
-asmlinkage void do_mcheck(struct pt_regs *regs)
-{
-	const int field = 2 * sizeof(unsigned long);
-	int multi_match = regs->cp0_status & ST0_TS;
-	enum ctx_state prev_state;
-
-	prev_state = exception_enter();
-	show_regs(regs);
-
-	if (multi_match) {
-		printk("Index	: %0x\n", read_c0_index());
-		printk("Pagemask: %0x\n", read_c0_pagemask());
-		printk("EntryHi : %0*lx\n", field, read_c0_entryhi());
-		printk("EntryLo0: %0*lx\n", field, read_c0_entrylo0());
-		printk("EntryLo1: %0*lx\n", field, read_c0_entrylo1());
-		printk("\n");
-		dump_tlb_all();
-	}
-
-	show_code((unsigned int __user *) regs->cp0_epc);
-
-	/*
-	 * Some chips may have other causes of machine check (e.g. SB1
-	 * graduation timer)
-	 */
-	panic("Caught Machine Check exception - %scaused by multiple "
-	      "matching entries in the TLB.",
-	      (multi_match) ? "" : "not ");
-}
-
 asmlinkage void do_mt(struct pt_regs *regs)
 {
 	int subcode;
@@ -1436,14 +1287,6 @@ asmlinkage void do_mt(struct pt_regs *regs)
 }
 
 
-asmlinkage void do_dsp(struct pt_regs *regs)
-{
-	if (cpu_has_dsp)
-		panic("Unexpected DSP exception");
-
-	force_sig(SIGILL, current);
-}
-
 asmlinkage void do_reserved(struct pt_regs *regs)
 {
 	/*
@@ -1609,34 +1452,6 @@ asmlinkage void cache_parity_error(void)
 	panic("Can't handle the cache error!");
 }
 
-asmlinkage void do_ftlb(void)
-{
-	const int field = 2 * sizeof(unsigned long);
-	unsigned int reg_val;
-
-	/* For the moment, report the problem and hang. */
-	if (cpu_has_mips_r2 &&
-	    ((current_cpu_data.processor_id & 0xff0000) == PRID_COMP_MIPS)) {
-		pr_err("FTLB error exception, cp0_ecc=0x%08x:\n",
-		       read_c0_ecc());
-		pr_err("cp0_errorepc == %0*lx\n", field, read_c0_errorepc());
-		reg_val = read_c0_cacheerr();
-		pr_err("c0_cacheerr == %08x\n", reg_val);
-
-		if ((reg_val & 0xc0000000) == 0xc0000000) {
-			pr_err("Decoded c0_cacheerr: FTLB parity error\n");
-		} else {
-			pr_err("Decoded c0_cacheerr: %s cache fault in %s reference.\n",
-			       reg_val & (1<<30) ? "secondary" : "primary",
-			       reg_val & (1<<31) ? "data" : "insn");
-		}
-	} else {
-		pr_err("FTLB error exception\n");
-	}
-	/* Just print the cacheerr bits for now */
-	cache_parity_error();
-}
-
 /*
  * SDBBP EJTAG debug exception handler.
  * We skip the instruction and return to the next instruction.
-- 
1.7.10.4
