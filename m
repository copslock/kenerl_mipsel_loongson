Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id FAA135135 for <linux-archive@neteng.engr.sgi.com>; Mon, 24 Nov 1997 05:58:37 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id FAA13379 for linux-list; Mon, 24 Nov 1997 05:55:03 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id FAA13363 for <linux@engr.sgi.com>; Mon, 24 Nov 1997 05:55:00 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id FAA20557
	for <linux@engr.sgi.com>; Mon, 24 Nov 1997 05:54:58 -0800
	env-from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (ralf@pmport-03.uni-koblenz.de [141.26.249.3])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id OAA00883
	for <linux@engr.sgi.com>; Mon, 24 Nov 1997 14:54:47 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id OAA14473;
	Mon, 24 Nov 1997 14:49:42 +0100
Message-ID: <19971124144942.55920@lappi.waldorf-gmbh.de>
Date: Mon, 24 Nov 1997 14:49:42 +0100
From: ralf@uni-koblenz.de
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: R4600 fun ...
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I've found a problem with the cacheflush routines in the kernel.  The
following routine from arch/mips/mm/r4xx0.c:

static void r4k_flush_cache_sigtramp(unsigned long addr)
{
	addr &= ~(dc_lsize - 1);
	/* These nops handle a processor errata in the R4600 silicon */
	__asm__ __volatile__("nop;nop;nop;nop");
	protected_writeback_dcache_line(addr);
	protected_writeback_dcache_line(addr + dc_lsize);
	protected_flush_icache_line(addr);
	protected_flush_icache_line(addr + dc_lsize);
}

which is being compiled into the following assembler code:

0000d5a0 <r4k_flush_cache_sigtramp> lui $v1,0x0
0000d5a4 <r4k_flush_cache_sigtramp+4> lw $v1,12($v1)
0000d5a8 <r4k_flush_cache_sigtramp+8> negu $v0,$v1
0000d5ac <r4k_flush_cache_sigtramp+c> and $a0,$a0,$v0
...
0000d5c0 <r4k_flush_cache_sigtramp+20> cache Hit_Writeback_Inv_D,0($a0)
0000d5c4 <r4k_flush_cache_sigtramp+24> addu $v1,$a0,$v1
0000d5c8 <r4k_flush_cache_sigtramp+28> cache Hit_Writeback_Inv_D,0($v1)
0000d5cc <r4k_flush_cache_sigtramp+2c> cache Hit_Invalidate_I,0($a0)
0000d5d0 <r4k_flush_cache_sigtramp+30> cache Hit_Invalidate_I,0($v1)
0000d5d4 <r4k_flush_cache_sigtramp+34> jr $ra
...

... is called by setup_frame() in arch/mips/kernel/signal.c when
setting up a signal frame:

[...]
	/*
	 * Set up the return code ...
	 *
	 *         .set    noreorder
	 *         addiu   sp,0x20
	 *         li      v0,__NR_sigreturn
	 *         syscall
	 *         .set    reorder
	 */
	__put_user(0x27bd0000 + scc_offset, &frame->code[0]);
	__put_user(0x24020000 + __NR_sigreturn, &frame->code[1]);
	__put_user(0x0000000c, &frame->code[2]);

	/*
	 * Flush caches so that the instructions will be correctly executed.
	 * (flush_cache_sigtramp is a function pointer)
	 */
	flush_cache_sigtramp((unsigned long) frame->code);
[...]

Unless I've got tomatoes of the size of a space ship on my eyes these
cache flushes do the right thing in order to guarantee the coherence
of Icache with the Dcache.  Nevertheless when executing the code on a
R4600 v2.0 I get illegal instruction exceptions for the instructions
on the stack.  The other MIPS processors seem not to have any problem
with this code.

Silicon problem?  Anybody seen this before?

  Ralf
