Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Oct 2013 09:42:19 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37799 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6827313Ab3JHHmRdh0MN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Oct 2013 09:42:17 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r987gFpT011866;
        Tue, 8 Oct 2013 09:42:15 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r987gFZo011865;
        Tue, 8 Oct 2013 09:42:15 +0200
Date:   Tue, 8 Oct 2013 09:42:15 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: fix forced successful syscalls
Message-ID: <20131008074215.GG1615@linux-mips.org>
References: <1380550969-9522-1-git-send-email-tanguy.bouzeloc@efixo.com>
 <20131002091909.GA23236@linux-mips.org>
 <524D84EB.8060102@efixo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <524D84EB.8060102@efixo.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Thu, Oct 03, 2013 at 04:53:31PM +0200, Tanguy Bouzeloc wrote:

> On 10/02/2013 11:19 AM, Ralf Baechle wrote:
> >To my personal embarassment I have to admit that I knew about this since the
> >day the syscall wrapper was written - but was considering it an acceptable
> >bug ...
> >
> >Where it really bits is sigreturn and similar which use the following
> >stunt:
> >
> >         /*
> >          * Don't let your children do this ...
> >          */
> >         __asm__ __volatile__(
> >                 "move\t$29, %0\n\t"
> >                 "j\tsyscall_exit"
> >                 :/* no outputs */
> >                 :"r" (&regs));
> >         /* Unreached */
> >
> >to keep the syscall return path from tampering with the return value.
> >
> >The scall*.S part of your patch is clearing TIF_NOERROR using a non-atomic
> >LW/SW sequence.  This needs to be done atomically or the thread's flags
> >variable might get corrupted.  This is complicated by MIPS I, R5900 and
> >afair some older oddball not-quite MIPS II CPUs lacking LL/SC rsp. LLD/SCD.
> >
> >   Ralf
> >
> 
> I discover the issue when changing the HZ of the kernel to 100HZ, in
> this case the jiffies returned to the userland are the same as the
> kernel ticks and it'll wrap after 5 minutes of uptime. With kernel
> HZ at 250 or 1000H it'll make happen the ticks wrap after 230~260j.
> 
> Unfortunately programs relying on ticks (they shouldn't but that
> happens) have unpredictable behavior for 11.3s before the wrap.
> 
> I can update the patch in order to access atomically the thread
> flags, the point is ... it'll make the kernel incompatible with old
> hardware.

The price to pay: an ifdef ...

#include <asm/sgidefs.H>
...
#if (_MIPS_ISA > _MIPS_ISA_MIPS1)
... LL/SC code goes here
#else
... LL/SC-less code goes here
#endif

But I'm wondering if we can move this hopefully relativly rare special
case into do_notify_resume() and handle it in plain C there.

  Ralf
