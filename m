Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Nov 2002 13:34:56 +0100 (CET)
Received: from p508B75AF.dip.t-dialin.net ([80.139.117.175]:32912 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1124127AbSKRMe4>; Mon, 18 Nov 2002 13:34:56 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gAICYd111074;
	Mon, 18 Nov 2002 13:34:39 +0100
Date: Mon, 18 Nov 2002 13:34:39 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: atul srivastava <atulsrivastava9@rediffmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: -mips2 amd -mcpu=r4600 for Rc32334..?
Message-ID: <20021118133438.A4988@linux-mips.org>
References: <20021118114317.22526.qmail@mailweb34.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021118114317.22526.qmail@mailweb34.rediffmail.com>; from atulsrivastava9@rediffmail.com on Mon, Nov 18, 2002 at 11:43:17AM -0000
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 663
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 18, 2002 at 11:43:17AM -0000, atul srivastava wrote:

> what should be appropiate compilation flag for MIPS 
> RC32134/Rc32334..?
> currently i am trying in arch/mips/Makefile
>   GCCFLAGS        += -mcpu=r4600 -mips2 -Wa,--trap
> 
> But I doubt it for two reasons.
> 
> 1.I think mips1 should be used instead of mips2 because
> if you follow mips literature mips 2* and 3* series fall under 
> MIPS1 category.

Exceptions such at the R3900 which is an almost-mips2 processor ...

> 4* and bigger series comes under MIP2 and MIPS3 series.
> 
> for example CONFIG_CPU_LLSC is not enabled for all MIPS1
> category processors.

CONFIG_CPU_LLSC is mandatory for for multiprocessor systems.  For uni-
processor systems such as your's CONFIG_CPU_LLSC should be enabled for
best performance - but only if your CPU actually has ll / sc instructions.

The kernel emulates ll/sc instructions if they're not available in
hardware.  The emulation is not performance optimal so should be avoided
by using the appropriate setting of CONFIG_CPU_LLSC.

> 2.Is -mcpu=r4600 switch is alright for Rc32334?

Not knowing the Rc32334 in detail I can only tell you the switch is
technically correct.  It may or may not be optimal.

> I was just wondering why i should use -mcpu=r4600 for RC323334

-mcpu=<cpu> is just a performance optimization option.  Gcc doesn't use
this value very well to optimize the code but it's making some minor
difference.  For most <cpu> values the code generator doesn't use
instructions that are specific to CPU, so there's little risk playing
with the value.  Gcc doesn't know the Rc32334 as value so you'll have to
pick a CPU that is as similar possible.

  Ralf
