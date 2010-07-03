Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Jul 2010 19:03:28 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:43887 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491954Ab0GCRDY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Jul 2010 19:03:24 +0200
Date:   Sat, 3 Jul 2010 18:03:24 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Shinya Kuribayashi <skuribay@pobox.com>
cc:     David VomLehn <dvomlehn@cisco.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: PowerTV: Use fls() carefully where static optimization
 is required
In-Reply-To: <4C2F49D0.60200@pobox.com>
Message-ID: <alpine.LFD.2.00.1007031748350.11778@eddie.linux-mips.org>
References: <4C2755A3.3080600@pobox.com> <20100630220124.GA576@dvomlehn-lnx2.corp.sa.net> <4C2DF427.7080508@pobox.com> <20100702213219.GA390@dvomlehn-lnx2.corp.sa.net> <4C2F49D0.60200@pobox.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 3 Jul 2010, Shinya Kuribayashi wrote:

> Ok, now I've come to the same conclusion.  Revised patch will be like
> this.  Malta is a development platform supporting various types of
> MIPS32/MIPS64 cores, hence use cpu_has_clo_clz directly.  The same goes
> to MIPSSim.  

 Malta also supports a couple of MIPS IV processors too, so please be 
careful about such assumptions.

> +	if (__builtin_constant_p(cpu_has_clo_clz) && cpu_has_clo_clz) {
> +		int x;
> +		__asm__(
> +		"	.set	push					\n"
> +		"	.set	mips32					\n"
> +		"	clz	%0, %1					\n"
> +		"	.set	pop					\n"
> +		: "=r" (x)
> +		: "r" (pending));
> +
> +		return -x + 31 - CAUSEB_IP;
> +	}

 Hmm, ".set mips32" looks dodgy here.  For pre-MIPS32/64 platforms this 
code should never make it to the assembler and if it did, then a 
build-time error is better than a run-time problem.

 It might be simpler just to use __builtin_ffs() for this variant though.  
Inline assembly is better avoided unless absolutely required.  Not even 
mentioning readability.

  Maciej
