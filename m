Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Dec 2002 15:14:31 +0100 (CET)
Received: from p508B5AAD.dip.t-dialin.net ([80.139.90.173]:26259 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224847AbSLDOOa>; Wed, 4 Dec 2002 15:14:30 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gB4EEG232413;
	Wed, 4 Dec 2002 15:14:16 +0100
Date: Wed, 4 Dec 2002 15:14:16 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: atul srivastava <atulsrivastava9@rediffmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: hazards during DO_FAULT macro..
Message-ID: <20021204151416.A31089@linux-mips.org>
References: <20021204101741.8326.qmail@webmail24.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021204101741.8326.qmail@webmail24.rediffmail.com>; from atulsrivastava9@rediffmail.com on Wed, Dec 04, 2002 at 10:17:41AM -0000
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 747
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 04, 2002 at 10:17:41AM -0000, atul srivastava wrote:

> macro Do_FAULt(write) expands like..
> 
> #define DO_FAULT(write) \
>          .set    noreorder; \
>          .set    noat; \
>          SAVE_ALL; \
>          STI; \
>          nop; \

Unnecessary nop.

>          .set    at; \
>          move a0, sp; \
>          jal     do_page_fault; \
>          li     a1, write; \
>          nop; \

Unnecessary nop.

>          j       ret_from_sys_call; \

This is ret_from_exception since about 14 months.

>          nop; \
>         .set    noat;
> 
> this macro is called by handle_tlbx() routines.
> when I tracked this problem and i observed my pt_regs address
> looked o.k. and apparently right till after STI; \ and just before 
> instruction     mfc0    a2, CP0_BADVADDR;
> this i found by putting following instructions,
> 
> move  a0,sp; \
> jal show_regs; \
> nop; \
> 
> later it jumps to do_page_fault() ,and pt_regs address there 
> equals unexpectedly to envp_init and from thereon everythings goes 
> wrong..

This would means something like your user process was running with
c0_status.cu0 = 1 which is forbidden.  If that happens the kernel wouldn't
load a new stack pointer on kerne entry.

> I also tried with negating STI; \ , but same result.

This would means something like your user process was running with
c0_status.cu0 = 1 which is forbidden.  If that happens the kernel wouldn't
load a new stack pointer on kerne entry.

> 8001e6ac:	01094025 	or	$t0,$t0,$t1     STI macro code , though i 

The function there has doesn't have STI but KMODE since almost half a
year.  Time to upgrade.

And our code never had the mfc0 from the badvaddr register after the STI /
KMODE, so it seems you kernel tree is a) antique b) seems hacked beyond
recognition.

Moving the mfc0 behind the sti would be valid as long as we know there's
always a hazard of at least one cycle before interrupts get activated.  That
was true for the initially supported processors like R4000 (3 cycles) or
R4600 (1 cycle) but no longer for modern processors.

  Ralf
