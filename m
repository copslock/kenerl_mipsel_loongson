Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2007 12:13:01 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:21183 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026066AbXKMMM7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Nov 2007 12:12:59 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lADCAgJP006695;
	Tue, 13 Nov 2007 12:11:02 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lADCAaSj006694;
	Tue, 13 Nov 2007 12:10:36 GMT
Date:	Tue, 13 Nov 2007 12:10:36 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Haley <aph-gcc@littlepinkcloud.COM>
Cc:	David Daney <ddaney@avtrex.com>, linux-mips@linux-mips.org,
	Richard Sandiford <rsandifo@nildram.co.uk>, gcc@gcc.gnu.org
Subject: Re: Cannot unwind through MIPS signal frames with
	ICACHE_REFILLS_WORKAROUND_WAR
Message-ID: <20071113121036.GA6582@linux-mips.org>
References: <473957B6.3030202@avtrex.com> <18233.36645.232058.964652@zebedee.pink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18233.36645.232058.964652@zebedee.pink>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 13, 2007 at 11:48:53AM +0000, Andrew Haley wrote:

> David Daney writes:
>  > With the current kernel (2.6.23.1) in my R5000 based O2 it seems 
>  > impossible for GCC's exception unwinding machinery to unwind through 
>  > signal frames.  The cause of the problems is the 
>  > ICACHE_REFILLS_WORKAROUND_WAR which puts the sigcontext at an almost 
>  > impossible to determine offset from the signal return trampoline.  The 
>  > unwinder depends on being able to find the sigcontext given a known 
>  > location of the trampoline.
>  > 
>  > It seems there are a couple of possible solutions:
>  > 
>  > 1) The comments in war.h indicate the problem only exists in R7000
>  > and E9000 processors.  We could turn off the workaround if the
>  > kernel is configured for R5000.  That would help me, but not those
>  > with the effected systems.
>  > 
>  > 2) In the non-workaround case, the siginfo immediately follows the
>  > trampoline and the first member is the signal number.  For the
>  > workaround case the first word following the trampoline is zero.
>  > We could replace this with the offset to the sigcontext which is
>  > always a small negative value.  The unwinder could then distinguish
>  > the two cases (signal numbers are positive and the offset
>  > negative).  If we did this, the change would have to be coordinated
>  > with GCC's unwinder (in libgcc_s.so.1).
>  > 
>  > Thoughts?
> 
> The best solution is to put the unwinder info in the kernel.  Does
> MIPS use a vDSO ?

No though we should.

Another reason is to get rid of the classic trampoline the kernel installs
on the stack.  On some multiprocessor systems it requires a cacheflush
operation to be performed on all processors which is expensive.  Having
the trampoline in a vDSO would solve that.

I need to look into it, not sure what it would take.

  Ralf
