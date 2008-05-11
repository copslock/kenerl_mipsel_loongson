Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 May 2008 17:08:55 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:54250 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027282AbYEKQIw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 11 May 2008 17:08:52 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m4BG7XQm012144;
	Sun, 11 May 2008 17:07:33 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m4BG7WBC012137;
	Sun, 11 May 2008 17:07:32 +0100
Date:	Sun, 11 May 2008 17:07:32 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David VomLehn <dvomlehn@cisco.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [RFC] [PATCH 1/1] [MIPS] Advanced Kernel Stack Backtrace
Message-ID: <20080511160732.GA10492@linux-mips.org>
References: <48224021.7050306@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48224021.7050306@cisco.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 07, 2008 at 04:49:53PM -0700, David VomLehn wrote:

> This patch contains the kernel stack backtrace code we've been running for 
> about a year on our MIPS-based settop box. It is considerably larger than 
> the existing backtrace implementation and so is configurable in the Kernel 
> Hacking section.  It also requires that KALLSYMS be enabled. In return, I 
> think it offers some advantages over the existing backtrace code:
>
> o It will backtrace over nested interrupts and exceptions, allowing 
> detailed analysis of was going on when it was invoked.
> o It handles a number of corner cases involving instructions in branch 
> delay slots.
> o It is very careful to use __get_user when fetching stack data and 
> instructions, meaning that it will fail gracefully even in the presence of 
> stack corruption.
> o It identifies whether the $sp register or another register is being used 
> as the frame pointer. Assuming people are happy with this submission, there 
> is a small subsequent patch I'll submit that dumps the frame pointer value 
> as part of the backtrace.
> o It segregates the backtrace code into a subdirectory of arch/mips/kernel 
> rather than cluttering up traps.c or the kernel directory.
>
> The main reason I am submitting this as a request for comments rather than 
> as a normal patch is that, though I wrote it with 64-bit systems in mind, I 
> don't have access to a 64-bit system on which to test it. I am happy to 
> merge any 64-bit-specific changes. For 32-bit systems, I'll claim it's 
> ready to go.
>
> The other reason is that this is an RFC is that it is such a large, single 
> chunk of code that there are certainly lots of comments that people will 
> have. I'm not naive enough to think it's really ready without more review.
>
> [Note: for anyone who was at the MIPS backtrace session at the CELF 
> Conference, this is the code I was talking about.]

I wasn't even aware of the session.

> Signed-off-by: David VomLehn <dvomlehn@cisco.com>

> +#ifndef	numberof
> +#define	numberof(a)	(sizeof(a) / sizeof((a) [0]))
> +#endif

I really just glanced over the patch.  I think I like the promise of more
accurate backtraces because frequently one (1) backtrace is all information
which there ever will be available for debugging.

 o Use ARRAY_SIZE() from <linux/kernel.h> instead of numberof.
 o Please run the patch through scripts/checkpatch.pl and fix the resulting
   errors.
 o Your patch got linewrapped by your mail client.

  Ralf
