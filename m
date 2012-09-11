Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2012 15:42:14 +0200 (CEST)
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:52723 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903494Ab2IKNmE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Sep 2012 15:42:04 +0200
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1TBQlv-0007AB-00
        for linux-mips@linux-mips.org; Tue, 11 Sep 2012 13:44:59 +0000
Date:   Tue, 11 Sep 2012 09:44:59 -0400
To:     linux-mips@linux-mips.org
Subject: Re: Is r25 saved across syscalls?
Message-ID: <20120911134459.GS27715@brightrain.aerifal.cx>
References: <20120909193008.GA15157@brightrain.aerifal.cx>
 <20120911081256.GD24448@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120911081256.GD24448@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   Rich Felker <dalias@aerifal.cx>
X-archive-position: 34468
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

On Tue, Sep 11, 2012 at 10:12:56AM +0200, Ralf Baechle wrote:
> On Sun, Sep 09, 2012 at 03:30:08PM -0400, Rich Felker wrote:
> 
> > Hi all,
> > The kernel syscall entry/exit code seems to always save and restore
> > r25. Is this stable/documented behavior I can rely on? If there's a
> > reason it _needs_ to be preserved, knowing that would help convince me
> > it's safe to assume it will always be done. The intended usage is to
> > be able to make syscalls (where the syscall # is not a constant that
> > could be loaded with lwi) without a stack frame, as in "move $2,$25 ;
> > syscall".
> 
> Since there is no place where the syscall interface is documented other
> than in the code itself, I've written a new wiki article
> 
>   http://www.linux-mips.org/wiki/Syscall
> 
> as start.  It's still lacking on the more obscure points but it at least
> should have have answered your question, had it already existed when you
> asked.

Thanks!

Some comments... In the table,

    $a0 ... $a2/$a7 except $a3

is unclear. Do you mean to say $a0 ... $a2 on o32 and also $a4 ... $a7
on all other ABIs? If so I think it would make sense to put those
ranges as separate lines in the table, so it's clear that the second
group are not preserved on o32 (if they were, they would also have
solved my problem).

As for

    $a3  4th syscall argument   $a3 set to 0/1 for success/error

Does the kernel guarantee 0/1, or is it 0/nonzero? This could matter
to asm programmers using the syscall ABI who want to do bit twiddling.

    Syscall restarting is a special case where $v0, $v1 and $a3 will
    stay unmodified. Even the program counter will stay unmodified so
    the same syscall will be executed again. This is something that
    does not matter to application programmers but may become visible
    in debuggers. Syscall restarting is something that is used
    internally by the kernel, for example when during a large read(2)
    syscall the kernel receives a signal.

The way syscall restarting works does matter to userspace, although
only to very low-level code. In musl (http://www.etalabs.net/musl),
the syscall routine for cancellation-point syscalls uses labels in the
asm before checking the cancellation flag and immediately after the
syscall instruction so that the signal handler that processes thread
cancellation can examine the saved program counter in the ucontext_t
it receives and determine whether the interrupted code is at a
cancellable syscall or not, with no race conditions. The glibc/NPTL
approach of wrapping a plain syscall with code to change to async
cancellation mode and back has extremely dangerous race conditions,
and my approach in musl of examining the program counter and comparing
it against asm labels is the only solution I've seen that's race-free.

Rich
