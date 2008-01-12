Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jan 2008 23:01:04 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:37864 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20034714AbYALXA4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 12 Jan 2008 23:00:56 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JDpLT-0002tO-00; Sun, 13 Jan 2008 00:00:55 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id AE10EC2F34; Sun, 13 Jan 2008 00:00:51 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] IP28 fixes
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080112230051.AE10EC2F34@solo.franken.de>
Date:	Sun, 13 Jan 2008 00:00:51 +0100 (CET)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

- ISA DMA is broken on IP28
- bus error handler improved to not issue bus errors for
  speculative accesses to CPU and GIO addresses. We now
  treat CSTAT_ADDR and GSTAT_TIME errors as non fatal, when
  they are issues via MC error interrupt. For real (non
  speculative) bus errors a DBE will be issued, which is
  lethal as before. Handling the issue this way gets rid
  of decoding instructions

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/Kconfig              |    1 +
 arch/mips/sgi-ip22/ip28-berr.c |  203 +---------------------------------------
 2 files changed, 4 insertions(+), 200 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3541402..2996b9f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -457,6 +457,7 @@ config SGI_IP28
 	select CSRC_R4K
 	select DEFAULT_SGI_PARTITION
 	select DMA_NONCOHERENT
+	select GENERIC_ISA_DMA_SUPPORT_BROKEN
 	select IRQ_CPU
 	select HW_HAS_EISA
 	select I8253
diff --git a/arch/mips/sgi-ip22/ip28-berr.c b/arch/mips/sgi-ip22/ip28-berr.c
index 0ee5be8..b09d7d5 100644
--- a/arch/mips/sgi-ip22/ip28-berr.c
+++ b/arch/mips/sgi-ip22/ip28-berr.c
@@ -299,198 +299,6 @@ static void print_buserr(const struct pt_regs *regs)
 }
 
 /*
- * Try to find out, whether the bus error is caused by the instruction
- * at EPC, otherwise we have an asynchronous error.
- *
- * Doc1: "MIPS IV Instruction Set", Rev 3.2 (SGI 007-2597-001)
- * Doc2: "MIPS R10000 Microporcessor User's Manual", Ver 2.0 (SGI 007-2490-001)
- * Doc3: "MIPS R4000 Microporcessor User's Manual", 2nd Ed. (SGI 007-2489-001)
- */
-
-#define JMP_INDEX26_OP 1
-#define JMP_REGISTER_OP 2
-#define JMP_PCREL16_OP 3
-#define BASE_OFFSET_OP 4
-#define BASE_IDXREG_OP 5
-
-/* Match virtual address in an insn with physical error address */
-
-static int match_addr(unsigned paddr, unsigned long vaddr)
-{
-	unsigned long uaddr;
-
-	if ((vaddr & 0xffffffff80000000L) == 0xffffffff80000000L)
-		uaddr = (unsigned) CPHYSADDR(vaddr);
-	else if ((vaddr >> 62) == 2)
-		uaddr = (unsigned) XPHYSADDR(vaddr);
-	else {
-		unsigned long eh = vaddr & ~0x1fffL;
-
-		eh |= read_c0_entryhi() & 0xff;
-		write_c0_entryhi(eh);
-		tlb_probe();
-		if (read_c0_index() & 0x80000000)
-			return 0;
-		tlb_read();
-		if (vaddr & (1L << PAGE_SHIFT))
-			uaddr = (unsigned) read_c0_entrylo1();
-		else
-			uaddr = (unsigned) read_c0_entrylo0();
-		uaddr <<= 6;
-		uaddr &= ~PAGE_MASK;
-		uaddr |= vaddr & PAGE_MASK;
-	}
-	return ((uaddr & ~0x7f) == (paddr & ~0x7f));
-}
-
-/* Check, which kind of memory reference is triggered by `insn' */
-
-static int check_special(unsigned insn)
-{
-	/* See Doc1, page A-180 */
-	unsigned func = insn & 0x3f;
-
-	if (8 == func || 8+1 == func) /* JR, JALR */
-		return JMP_REGISTER_OP;
-
-	return 0;
-}
-
-static int check_regimm(unsigned insn)
-{
-	/* See Doc1, page A-180 */
-	unsigned rt = (insn >> 19) & 3; /* bits 20..19[..16] */
-
-	/* BLTZ, BGEZ, BLTZL, BBGEZL || BLTZAL, BGEZAL, BLTZALL, BBGEZALL */
-	if (!rt || 2 == rt)
-		return JMP_PCREL16_OP;
-
-	return 0;
-}
-
-static int check_cop0(unsigned insn)
-{
-	/* See Doc2, pages 287 ff., 187 ff. */
-	if ((insn >> 26) == 5*8+7) /* CACHE */
-		switch ((insn >> 16) & 0x1f) {
-		case Index_Writeback_Inv_D:
-		case Hit_Writeback_Inv_D:
-		case Index_Writeback_Inv_S:
-		case Hit_Writeback_Inv_S:
-			return BASE_OFFSET_OP;
-		}
-	return 0;
-}
-
-static int check_cop1(unsigned insn)
-{
-	/* See Doc1, pages B-108 ff. */
-	unsigned fmt = (insn >> 21) & 0x1f; /* bits 25..21 */
-
-	if (8 == fmt) /* BC1* */
-		return JMP_PCREL16_OP;
-
-	return 0;
-}
-
-static int check_cop1x(unsigned insn)
-{
-	/* See Doc1, pages B-108 ff. */
-	switch (insn & 0x3f) {
-	case 0:   /* LWXC1 */
-	case 1:   /* LDXC1 */
-	case 8:   /* SWXC1 */
-	case 8+1: /* SDXC1 */
-		return BASE_IDXREG_OP;
-	}
-	return 0;
-}
-
-static int check_plain(unsigned insn)
-{
-	/* See Doc1, page A-180 */
-	unsigned opcode = insn >> 26;
-
-	if (2 == opcode || 3 == opcode) /* J, JAL */
-		return JMP_INDEX26_OP;
-
-	if ((4     <= opcode && opcode <= 7) ||   /* BEQ, BNE, BLEZ, BGTZ */
-	    (4+2*8 <= opcode && opcode <= 7+2*8)) /* BEQL, BNEL, BLEZL, BGTZL */
-		return JMP_PCREL16_OP;
-
-	if (6*8+3 == opcode) /* PREF */
-		return 0;
-
-	if (3*8+2 == opcode || 3*8+3 == opcode || /* LDL, LDR */
-	    4*8 <= opcode) /* misc. LOAD, STORE */
-		return BASE_OFFSET_OP;
-
-	return 0;
-}
-
-/* Check, whether the insn at EPC causes a memory access at `paddr' */
-
-static int check_addr_in_insn(unsigned paddr, const struct pt_regs *regs)
-{
-	unsigned long epc;
-	unsigned insn;
-	unsigned long a;
-	int typ;
-
-	epc = regs->cp0_cause & CAUSEF_BD ? regs->cp0_epc:regs->cp0_epc+4;
-
-	/* show_code() from kernel/traps.c */
-	if (__get_user(insn, (u32 *)epc))
-		return 1;
-
-	/* See Doc1, pages A-180, B-108 ff. */
-	switch (insn >> 26) {
-	case 0:
-		typ = check_special(insn);
-		break;
-	case 1:
-		typ = check_regimm(insn);
-		break;
-	case 2*8:   /* COP0 */
-	case 5*8+7: /* CACHE */
-		typ = check_cop0(insn);
-		break;
-	case 2*8+1:
-		typ = check_cop1(insn);
-		break;
-	case 2*8+3:
-		typ = check_cop1x(insn);
-		break;
-	default:
-		typ = check_plain(insn);
-		break;
-	}
-	switch (typ) {
-	case JMP_INDEX26_OP:
-		a = (regs->cp0_epc + 4) & ~0xfffffff;
-		a |= (insn & 0x3ffffff) << 2;
-		return match_addr(paddr, a);
-	case JMP_REGISTER_OP:
-		a = regs->regs[(insn >> 21) & 0x1f];
-		return match_addr(paddr, a);
-	case JMP_PCREL16_OP:
-		a = regs->cp0_epc + 4 + ((insn & 0xffff) << 2);
-		return match_addr(paddr, a);
-	case BASE_OFFSET_OP:
-		a = regs->regs[(insn >> 21) & 0x1f] + (insn & 0xffff);
-		return match_addr(paddr, a);
-	case BASE_IDXREG_OP:
-		a = regs->regs[(insn >> 21) & 0x1f];
-		a += regs->regs[(insn >> 16) & 0x1f];
-		return match_addr(paddr, a);
-	case 0:
-		return 0;
-	}
-	/* Assume it would be too dangerous to continue ... */
-	return 1;
-}
-
-/*
  * Check, whether MC's (virtual) DMA address caused the bus error.
  * See "Virtual DMA Specification", Draft 1.5, Feb 13 1992, SGI
  */
@@ -594,16 +402,11 @@ static int ip28_be_interrupt(const struct pt_regs *regs)
 
 	/* Any state other than "Memory bus error" is fatal. */
 	if (cpu_err_stat & CPU_ERRMASK & ~SGIMC_CSTAT_ADDR)
-			goto mips_be_fatal;
-
-	/* GIO errors are fatal */
-	if (gio_err_stat & GIO_ERRMASK)
 		goto mips_be_fatal;
 
-	/* Finding `cpu_err_addr' in the insn at EPC is fatal. */
-	if ((cpu_err_stat & CPU_ERRMASK) &&
-	     check_addr_in_insn(cpu_err_addr, regs))
-			goto mips_be_fatal;
+	/* GIO errors other than timeouts are fatal */
+	if (gio_err_stat & GIO_ERRMASK & ~SGIMC_GSTAT_TIME)
+		goto mips_be_fatal;
 
 	/*
 	 * Now we have an asynchronous bus error, speculatively or DMA caused.
