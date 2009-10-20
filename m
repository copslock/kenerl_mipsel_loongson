Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Oct 2009 18:22:12 +0200 (CEST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:33122 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492851AbZJTQWG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Oct 2009 18:22:06 +0200
Received: from [192.168.23.10] (really [74.67.89.75])
          by hrndva-omta03.mail.rr.com with ESMTP
          id <20091020162155459.SPFQ15360@hrndva-omta03.mail.rr.com>;
          Tue, 20 Oct 2009 16:21:55 +0000
Subject: Re: ftrace for MIPS
From:	Steven Rostedt <rostedt@goodmis.org>
Reply-To: rostedt@goodmis.org
To:	wuzhangjin@gmail.com
Cc:	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <1256052667.8149.56.camel@falcon>
References: <1255995599.17795.15.camel@falcon>
	 <1255997319.18347.576.camel@gandalf.stny.rr.com>
	 <1256052667.8149.56.camel@falcon>
Content-Type: text/plain
Organization: Kihon Technologies Inc.
Date:	Tue, 20 Oct 2009 12:21:54 -0400
Message-Id: <1256055714.18347.1608.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.3 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Tue, 2009-10-20 at 23:31 +0800, Wu Zhangjin wrote:

> Just added tracing_stop() and tracing_start() around

That seems a bit heavy handed. I still think writing it in "asm" the way
x86 and powerpc do is the best.

> probe_kernel_read(), it works(not hang again), and i can get the stack
> address of the ra register(return address) now, but failed when trying
> to hijack the return address via writing &return_to_handler in the stack
> address:
> 
> I can write hijack some of the addresses, but failed with this error at
> last:
> 
> Unable to handle kernel paging request at 0000000000000000, epc =
> 0000000000000000, ra = 000000000000.

hmm, looks like you jumped to "0"

> 
> Need to check which registers is missing when saving/restoring for
> _mcount:
> 
> 
> NESTED(ftrace_graph_caller, PT_SIZE, ra) 
>         MCOUNT_SAVE_REGS
>         PTR_S   v0, PT_R2(sp)
> 
>         MCOUNT_SET_ARGS
>         jal     prepare_ftrace_return
>         nop
> 
>         /* overwrite the parent as &return_to_handler: v0 -> $1(at) */
>         move    $1,     v0  

I'm confused here? I'm not exactly sure what the above is doing. Is $1 a
register (AT)? And how is this register used before calling mcount?

> 
>         PTR_L   v0, PT_R2(sp)
>         MCOUNT_RESTORE_REGS
>         RETURN_BACK
>         END(ftrace_graph_caller)
> 
>         .align  2
>         .globl  return_to_handler
> return_to_handler:
>         PTR_SUBU        sp, PT_SIZE
>         PTR_S   v0, PT_R2(sp)

BTW, is v0 the only return register? I know x86 can return two different
registers depending on what it returns. What happens if a function
returns a 64 bit value on a 32bit box? Does it use two registers for
that?

-- Steve

> 
>         jal     ftrace_return_to_handler
>         nop
> 
>         /* restore the real parent address: v0 -> ra */
>         move    ra, v0
> 
>         PTR_L   v0, PT_R2(sp)
>         PTR_ADDIU       sp, PT_SIZE
> 
>         jr      ra
> 
> ...
> 
>         .macro MCOUNT_SAVE_REGS
>         PTR_SUBU        sp, PT_SIZE
>         PTR_S   ra, PT_R31(sp)
>         PTR_S   AT, PT_R1(sp)
>         PTR_S   a0, PT_R4(sp)
>         PTR_S   a1, PT_R5(sp)
>         PTR_S   a2, PT_R6(sp)
>         PTR_S   a3, PT_R7(sp)
> #ifdef CONFIG_64BIT
>         PTR_S   a4, PT_R8(sp)
>         PTR_S   a5, PT_R9(sp)
>         PTR_S   a6, PT_R10(sp)
>         PTR_S   a7, PT_R11(sp)
> #endif
>         .endm
> 
>         .macro MCOUNT_RESTORE_REGS
>         PTR_L   ra, PT_R31(sp)
>         PTR_L   AT, PT_R1(sp)
>         PTR_L   a0, PT_R4(sp)
>         PTR_L   a1, PT_R5(sp)
>         PTR_L   a2, PT_R6(sp)
>         PTR_L   a3, PT_R7(sp)
> #ifdef CONFIG_64BIT
>         PTR_L   a4, PT_R8(sp)
>         PTR_L   a5, PT_R9(sp)
>         PTR_L   a6, PT_R10(sp)
>         PTR_L   a7, PT_R11(sp)
> #endif
>         PTR_ADDIU       sp, PT_SIZE
> 
> Regards,
> 	Wu Zhangjin
> 
