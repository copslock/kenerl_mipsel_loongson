Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jan 2003 09:30:27 +0000 (GMT)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:36256 "EHLO
	mail.sonytel.be") by linux-mips.org with ESMTP id <S8225194AbTA1Ja0>;
	Tue, 28 Jan 2003 09:30:26 +0000
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA00884;
	Tue, 28 Jan 2003 10:30:19 +0100 (MET)
Date: Tue, 28 Jan 2003 10:30:20 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Mike Uhler <uhler@mips.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: unaligned load in branch delay slot
In-Reply-To: <20030128033901.A23492@linux-mips.org>
Message-ID: <Pine.GSO.4.21.0301281024060.9269-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 28 Jan 2003, Ralf Baechle wrote:
> On Mon, Jan 13, 2003 at 07:04:36PM +0100, Geert Uytterhoeven wrote:
> > The following patch (against linux-mips-2.4.x CVS) cures my crash.
> > 
> > I don't know on which CPUs this may happen (need #ifdef CONFIG_CPU_VR41XX?),
> > nor whether all branch and jump instructions are affected (I included
> > everything that starts with a `b' or `j').
> 
> I'm suggesting this alternative patch below.  Comments?

I tried to write a simple user space test to identify which CPUs suffer from
this, but I wasn't able to trigger it from user space. Perhaps it happens in
kernel space only?

Or perhaps I made a silly mistake, here's the code I used:
--snip--------------------------------------------------------------------------
        .text
        .align  2
        .globl  probe
probe:
        .set    noreorder
        .set    nomacro
        beq     $4,$0,$L2
        lw      $2,0($5)
        j       $31
        nop
$L2:
        li      $2,-559087616                   # 0xffffffffdead0000
        ori     $2,$2,0xbeef
        j       $31
        nop
        .set    macro
        .set    reorder
--snip--------------------------------------------------------------------------
#include <stdio.h>

extern int probe(int a, char *p);

static int data[2] = { 0x01234567, 0x89abcdef };

int main(int argc, char *argv[])
{
    char *p = (char *)data;

    printf("Should print 0x01234567:               0x%08x\n", probe(1, p));
    printf("Should print 0xdeadbeef:               0x%08x\n", probe(0, p));
    printf("Should print 0x23456789 or 0xef012345: 0x%08x\n", probe(1, p+1));
    printf("Should print 0xdeadbeef:               0x%08x\n", probe(0, p+1));
    return 0;
}
--snip--------------------------------------------------------------------------

If it happens, I should get a SIGILL, right?

> diff -u -r1.4.2.1 branch.h
> --- include/asm-mips/branch.h 7 May 2002 03:48:08 -0000
> +++ include/asm-mips/branch.h 28 Jan 2003 02:34:12 -0000
> @@ -8,11 +8,52 @@
>  #ifndef _ASM_BRANCH_H
>  #define _ASM_BRANCH_H
>  
> +#include <asm/inst.h>
>  #include <asm/ptrace.h>
> +#include <asm/uaccess.h>
> +#include <asm/war.h>
>  
>  static inline int delay_slot(struct pt_regs *regs)
>  {
> -	return regs->cp0_cause & CAUSEF_BD;
> +#ifdef BDSLOT_WAR
> +	union mips_instruction insn;
> +	mm_segment_t seg;
> +#endif
> +	int ds;
> +
> +	ds = regs->cp0_cause & CAUSEF_BD;
> +	if (ds)
> +		return ds;
> +
> +#ifdef BDSLOT_WAR
> +	if (!user_mode(regs))
> +		set_fs(KERNEL_DS);
> +	__get_user(insn.word, (unsigned int *)regs->cp0_epc);
> +	set_fs(seg);

`seg' is never initialized?

> +	switch (insn.i_format.opcode) {
> +	/*
> +	 * On some CPUs, if an unaligned access happens in a branch delay slot
> +	 * and the branch is not taken, EPC points at the branch instruction,
> +	 * but the BD bit in the cause register is not set.
> +	 */
> +	case bcond_op:
> +	case j_op:
> +	case jal_op:
> +	case beq_op:
> +	case bne_op:
> +	case blez_op:
> +	case bgtz_op:
> +	case beql_op:
> +	case bnel_op:
> +	case blezl_op:
> +	case bgtzl_op:
> +	case jalx_op:
> +		return 1;	

I think you can remove the unconditional jumps, cfr. Mike's comments.

> +#if !defined(CONFIG_CPU_MIPS32) && !defined(CONFIG_CPU_MIPS64)
> +
> +/*
> + * A bunch of CPUs predating the MIPS32 and MIPS64 specs do not always set
> + * the BD bit in c0_cause on an exception.  For those we need to look at
> + * the faulting instruction to deciede if we were faulting in a delay slot.
> + * There might be further CPUs where BD works as expected but for now we're
> + * paranoid.
> + */
> +#define BDSLOT_WAR
> +
> +#endif

Isn't the Vr4120A core MIPS32?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
