Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Sep 2003 16:20:45 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:27328 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225492AbTITPUm>;
	Sat, 20 Sep 2003 16:20:42 +0100
Received: from drow by nevyn.them.org with local (Exim 4.22 #1 (Debian))
	id 1A0jXI-0003Mo-U3
	for <linux-mips@linux-mips.org>; Sat, 20 Sep 2003 11:20:36 -0400
Date: Sat, 20 Sep 2003 11:20:36 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: linux-mips@linux-mips.org
Subject: Impossible fixup in do_ade
Message-ID: <20030920152036.GA12905@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

Here's a snippet from emulate_load_store_insn.  See the way the sdl and sdr
are wrapped in fixups?  Well, the fixups can't trigger: we get to
emulate_load_store_insn a second time, and we hit the fact that sdl_op has a
"goto sigbus" before we hit the fixup_exception call.

It doesn't much matter, the bug I'm working on is whatever caused the first
call.  But we get a SIGBUS when arguably we ought to get a SIGSEGV.

        case sd_op:
#ifdef CONFIG_MIPS64
                /*
                 * A 32-bit kernel might be running on a 64-bit processor.  But
                 * if we're on a 32-bit processor and an i-cache incoherency
                 * or race makes us see a 64-bit instruction here the sdl/sdr
                 * would blow up, so for now we don't handle unaligned 64-bit
                 * instructions on 32-bit kernels.
                 */
                if (verify_area(VERIFY_WRITE, addr, 8))
                        goto sigbus;

                value = regs->regs[insn.i_format.rt];
                __asm__ __volatile__ (
#ifdef __BIG_ENDIAN
                        "1:\tsdl\t%1,(%2)\n"
                        "2:\tsdr\t%1, 7(%2)\n\t"
#endif
#ifdef __LITTLE_ENDIAN
                        "1:\tsdl\t%1, 7(%2)\n"
                        "2:\tsdr\t%1, (%2)\n\t"
#endif
                        "li\t%0, 0\n"
                        "3:\n\t"
                        ".section\t.fixup,\"ax\"\n\t"
                        "4:\tli\t%0, %3\n\t"
                        "j\t3b\n\t"
                        ".previous\n\t"
                        ".section\t__ex_table,\"a\"\n\t"
                        STR(PTR)"\t1b, 4b\n\t"
                        STR(PTR)"\t2b, 4b\n\t"
                        ".previous"
                : "=r" (res)
                : "r" (value), "r" (addr), "i" (-EFAULT));
                if (res)
                        goto fault;
                break;

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
