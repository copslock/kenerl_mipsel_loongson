Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Dec 2007 05:26:34 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:11398 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022153AbXLIF0c (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 9 Dec 2007 05:26:32 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lB95QN88027144;
	Sun, 9 Dec 2007 05:26:24 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lB95QNOU027143;
	Sun, 9 Dec 2007 05:26:23 GMT
Date:	Sun, 9 Dec 2007 05:26:23 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kaz Kylheku <kaz@zeugmasystems.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: SiByte 1480 & Branch Likely instructions?
Message-ID: <20071209052623.GC18181@linux-mips.org>
References: <DDFD17CC94A9BD49A82147DDF7D545C5590CF0@exchange.ZeugmaSystems.local> <DDFD17CC94A9BD49A82147DDF7D545C5590D6B@exchange.ZeugmaSystems.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDFD17CC94A9BD49A82147DDF7D545C5590D6B@exchange.ZeugmaSystems.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Dec 07, 2007 at 03:39:57PM -0800, Kaz Kylheku wrote:

> > Not really a kernel-related question. I've discovered that GCC 4.1.1
> > (which I'm not using for kernel compiling, but user space) generates
> > branch likely instructions by default, even though the documentation
> > says that their use is off by default for MIPS32 and MIPS64, because
> 
> That's because the compiler is not configured correctly. The default CPU
> string "from-abi" ends up being used, and so the target ISA is MIPS III.
> 
> > In parallel with writing some tests, I thought I would ask whether
> > anyone happens know whether or not these instructions are known to
> > actually work correctly on the SB1480 silicon (and perhaps any
> > additional details, like what revisions, etc)?
> 
> A basic sanity test does find bnezl working.
> 
> #include <stdio.h>
> #include <stdlib.h>
> 
> static int branch_likely_works(void)
> {
>     int one = 1;
>     int result;
> 
>     __asm__ __volatile__
>     ("        .set push\n"
>      "        .set noreorder\n"
>      "1:      move %0, $0\n"
>      "        bnezl %0, 1b\n"
>      "        lw %0, %1\n"
>      "        .set pop\n"
>      : "=r" (result)
>      : "m" (one));
> 
>      return result == 0;
> }
> 
> int main(void)
> {
>     if (branch_likely_works()) {
>         puts("branch-likely instruction bnezl correctly annuls delay
> slot");
>         return 0;
>     } 
>     puts("branch-likely instruction bnezl fails to annul delay slot");
>     return EXIT_FAILURE;
> }

That's a very basic test and it'd be very unlikely for the CPU to fail
such a simple test.

But think of scenarios like a load in the delay slot of a branch likely
where the load instruction is on a different page than the branch and a
tlb exception is getting caused.  There are many other special cases
which might be improperly implemented.

But honestly - branch likely instructions were introduced into the MIPS
architecture by the MIPS II R6000 in '89.  And the SB1 core is 2000
vintage so I'd assume by now have figured out how to get it right.  And
branch likely is used in existing binaries.  So I'd be surprised if it
was broken.

  Ralf
