Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2012 04:25:52 +0200 (CEST)
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:51211 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901165Ab2IKCZr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Sep 2012 04:25:47 +0200
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1TBGDQ-0006UC-00
        for linux-mips@linux-mips.org; Tue, 11 Sep 2012 02:28:40 +0000
Date:   Mon, 10 Sep 2012 22:28:40 -0400
To:     linux-mips@linux-mips.org
Subject: Re: Is r25 saved across syscalls?
Message-ID: <20120911022840.GP27715@brightrain.aerifal.cx>
References: <20120909193008.GA15157@brightrain.aerifal.cx>
 <20120910170830.GB24448@linux-mips.org>
 <20120910172248.GN27715@brightrain.aerifal.cx>
 <alpine.LFD.2.00.1209110059580.8926@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1209110059580.8926@eddie.linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   Rich Felker <dalias@aerifal.cx>
X-archive-position: 34462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dalias@aerifal.cx
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Sep 11, 2012 at 01:29:52AM +0100, Maciej W. Rozycki wrote:
> On Mon, 10 Sep 2012, Rich Felker wrote:
> 
> > As for my problem, I can use r7 as the temp ("move $2,$7 ; syscall")
> > for syscalls with 3 or fewer args, but for the 4-arg syscall, $7 is
> > occupied by an argument, and I'd need to spill the syscall number to
> > the stack to be able to restore it if $25 is not available...
> 
>  If performance or some other factors require you to avoid spilling the 
> syscall number to the stack or other readily-accessible (e.g. GP-relative) 
> memory and the number is not a constant you could load with LI, then you 
> can always store it in a call-saved register, one of $s0-$s8, that are 
> guaranteed by the syscall ABI to be preserved across.

That's not possible; you'd need to save the old contents of that
register somewhere else, and that requires spilling it to the stack.

>  Relying on any call-clobbered registers, including $7 to be preserved 
> across a syscall is risky, to say the least, as this is not guaranteed by 
> the syscall ABI.

Relying on them being preserved upon return from the syscall is
"unsafe", I agree. In reality, r4-r6 are preserved, and r7 is
clobbered with the syscall error flag. But there's no fundamental
reason r4-r6 have to be preserved in this case.

On the other hand, relying on them being preserved when the kernel
resets PC to the instruction before the syscall instruction in order
to restart as syscall after a signal interrupts it is completely safe.
If it didn't restore them, the restarted syscall would be executed
with the wrong arguments.

Of course the kernel design could change to point PC at the syscall
instruction rather than the previous instruction, and arrange for the
registers (including $2) to all have their correct values for the
syscall, and then the issue would become irrelevant because the
instruction "move $2,$7" would not be executed again on restart.

> I do wonder however why we have these instructions to 
> save/restore $25 in SAVE_SOME/RESTORE_SOME.  This dates back to 2.4 at the 
> very least.
> 
>  Ralf, any insights?

I would be interested in knowing too. It goes back further than 2.4.
It seems 2.0 saved and restored ALL registers, and 2.2 dropped it down
to the current set. This past change is why I'm hesitant to rely on
behavior that's not either documented or fundamentally required.

Rich
