Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Aug 2003 12:55:49 +0100 (BST)
Received: from p508B618D.dip.t-dialin.net ([IPv6:::ffff:80.139.97.141]:36534
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225280AbTHFLzq>; Wed, 6 Aug 2003 12:55:46 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h76BtapR031840;
	Wed, 6 Aug 2003 13:55:36 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h76BtWqj031839;
	Wed, 6 Aug 2003 13:55:32 +0200
Date: Wed, 6 Aug 2003 13:55:31 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Fuxin Zhang <fxzhang@ict.ac.cn>
Cc: Adam Kiepul <Adam_Kiepul@pmc-sierra.com>,
	MAKE FUN PRANK CALLS <linux-mips@linux-mips.org>
Subject: Re: RM7k cache_flush_sigtramp
Message-ID: <20030806115531.GA12161@linux-mips.org>
References: <9DFF23E1E33391449FDC324526D1F259017DF091@SJC1EXM02> <3F30DFB7.8030304@ict.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F30DFB7.8030304@ict.ac.cn>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 06, 2003 at 07:00:07PM +0800, Fuxin Zhang wrote:

>  And here I have a question for Mr. Adam: original linux code use 
> 'Writeback_Inv_D"
> and "Hit_Invalidate_I",not "Writeback_D" and "Hit_Invalidate_I",could it 
> lead to the
> problem?

No.  To synchronize the D-cache and I-cache it's irrelevant if you
invalidate the D-cache or not.

> BTW:
>   a silly question: how can i make my email show up pretier? I find 
> that the mailing list
> often break my lines very badly. I feel guilty for that:) I am using 
> mozilla composer,the
> original linebreaks are manually inserted(hit enter when i feel it is 
> long enough).

Format your email with hard breaks to about 75 columns.  75 columns
because god made vt100 with 80 columns so that leaves a bit of space for
quoting your mail nicely.

Now for your register dumps and information:

> (gdb) info reg
[...]
>            t8       t9       k0       k1       gp       sp       s8       ra
> R24  00000000 00000000 00000000 00000000 1000d880 7fff7590 00000003 7fff75a0
>            sr       lo       hi      bad    cause       pc
>      a004f413 000001b0 00000000 8009c6a0 80000028 7fff75b8
[...]

> 0x7fff75a0:     li      v0,4119
> 0x7fff75a4:     syscall

So the pc is pointing just after the trampoline which suspiciously looks
like the return of an old bug.  Could your application be doing something
unusual such as forking from a signal handler or similar?  The scenario
is about

 - kernel installs signal trampoline on stack
 - kernel forks.  Now the signal trampoline installed in the first step
   resides on a copy-on-write page.
 - newly created process touches the cow page, thereby resulting in
   breaking of the cow page.  Now parent and child have their own copy
   of the page.  BUT: flush_cache_page() doesn't properly flush this page.
 - Parent executes again on the copy of the page for which caches have
   not been flushed proplerly in the previous step, thereby failing to
   execute the trampoline - crash.

  Ralf
