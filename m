Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Jan 2010 18:14:52 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:55359 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492955Ab0AJROs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 10 Jan 2010 18:14:48 +0100
Date:   Sun, 10 Jan 2010 17:14:48 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     loody <miloody@gmail.com>
cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: some question about Extended Asm
In-Reply-To: <3a665c761001100809g1400db9er5cc3a6228467934a@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1001101708360.13474@eddie.linux-mips.org>
References: <3a665c761001052313v36bfeb89v37ada6b76e91c271@mail.gmail.com>         <alpine.LFD.2.00.1001061244330.13474@eddie.linux-mips.org> <3a665c761001100809g1400db9er5cc3a6228467934a@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 25556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6584

On Mon, 11 Jan 2010, loody wrote:

> I have some question about extended assembly in mips
> 1. is mips assembly in AT&T syntax?
>     from the document I google from the web, they emphasize that the
> GNU C compiler use AT&T syntax, and they list some example about intel
> instructions.

 I'm not sure if the "AT&T syntax" term has any meaning except for Intel 
architecture processors.

> But when I write the extended assembly in mips, I find it seem not AT&T syntax.
> The order of input and output is still the same as original mips instructions.
> Does that mean GNU compiler for mips doesn't use AT&T syntax?

 GNU as for MIPS processors uses the same syntax original tools provided 
by MIPS Computer Systems and Silicon Graphics companies used.  This syntax 
is used throughout all the documentation available and has nothing to do 
with the syntax used for Intel architecture processors (in particular, the 
specific instruction and not the data flow direction determines the order 
of operands).

> 2. how do we know which parameter is for %0,%1,etc?
> 
> suppose my src is as below
>  asm(
>                 "add %0, %1, %2\n"
>                 "sub %0,%2, %1\n"
>                 :"=r" (count)
>                 :"r" (temp), "r" (count)
>         );
> how do I know which parameter is %0, %1 and %2?
> there 2 variable, count and temp above, but in assembly it use 3 parameters.
> how to match them?

 See the Extended Asm chapter of the GCC manual.

  Maciej
