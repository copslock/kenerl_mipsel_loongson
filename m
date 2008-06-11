Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2008 18:30:21 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:38369 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20021887AbYFKRaR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jun 2008 18:30:17 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5BHToVd028593;
	Wed, 11 Jun 2008 18:29:50 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5BHToMi028586;
	Wed, 11 Jun 2008 18:29:50 +0100
Date:	Wed, 11 Jun 2008 18:29:50 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	MIPS Linux List <linux-mips@linux-mips.org>
Subject: Re: Resend: [PATCH] [MIPS] Fix asm constraints for 'ins'
	instructions.
Message-ID: <20080611172950.GA16600@linux-mips.org>
References: <48500599.9080807@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48500599.9080807@avtrex.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 11, 2008 at 10:04:25AM -0700, David Daney wrote:

> The third operand to 'ins' must be a constant int, not a register.
>
> Signed-off-by: David Daney <ddaney@avtrex.com>
> ---
> include/asm-mips/bitops.h |    6 +++---
> 1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/asm-mips/bitops.h b/include/asm-mips/bitops.h
> index 6427247..9a7274b 100644
> --- a/include/asm-mips/bitops.h
> +++ b/include/asm-mips/bitops.h
> @@ -82,7 +82,7 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *addr)
> 		"2:	b	1b					\n"
> 		"	.previous					\n"
> 		: "=&r" (temp), "=m" (*m)
> -		: "ir" (bit), "m" (*m), "r" (~0));
> +		: "i" (bit), "m" (*m), "r" (~0));
> #endif /* CONFIG_CPU_MIPSR2 */
> 	} else if (cpu_has_llsc) {
> 		__asm__ __volatile__(

An old trick to get gcc to do the right thing.  Basically at the stage when
gcc is verifying the constraints it may not yet know that it can optimize
things into an "i" argument, so compilation may fail if "r" isn't in the
constraints.  However we happen to know that due to the way the code is
written gcc will always be able to make use of the "i" constraint so no
code using "r" should ever be created.

The trick is a bit ugly; I think it was used first in asm-i386/io.h ages ago
and I would be happy if we could get rid of it without creating new problems.
Maybe a gcc hacker here can tell more?

  Ralf
