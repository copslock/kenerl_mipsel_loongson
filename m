Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Sep 2012 20:34:32 +0200 (CEST)
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:58677 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903468Ab2IJSe2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Sep 2012 20:34:28 +0200
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1TB8rI-0005cS-00
        for linux-mips@linux-mips.org; Mon, 10 Sep 2012 18:37:20 +0000
Date:   Mon, 10 Sep 2012 14:37:20 -0400
To:     linux-mips@linux-mips.org
Subject: Re: Is r25 saved across syscalls?
Message-ID: <20120910183720.GO27715@brightrain.aerifal.cx>
References: <20120909193008.GA15157@brightrain.aerifal.cx>
 <20120910170830.GB24448@linux-mips.org>
 <20120910172248.GN27715@brightrain.aerifal.cx>
 <504E2BC7.7000108@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <504E2BC7.7000108@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   Rich Felker <dalias@aerifal.cx>
X-archive-position: 34457
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
X-Status: A

On Mon, Sep 10, 2012 at 11:04:55AM -0700, David Daney wrote:
> On 09/10/2012 10:22 AM, Rich Felker wrote:
> >On Mon, Sep 10, 2012 at 07:08:30PM +0200, Ralf Baechle wrote:
> >>On Sun, Sep 09, 2012 at 03:30:08PM -0400, Rich Felker wrote:
> >>
> >>>The kernel syscall entry/exit code seems to always save and restore
> >>>r25. Is this stable/documented behavior I can rely on? If there's a
> >>>reason it _needs_ to be preserved, knowing that would help convince me
> >>>it's safe to assume it will always be done. The intended usage is to
> >>>be able to make syscalls (where the syscall # is not a constant that
> >>>could be loaded with lwi) without a stack frame, as in "move $2,$25 ;
> >>>syscall".
> >>
> >>The basic design idea is that syscalls use a calling convention similar
> >>to subroutine calls.  $25 is $t9, so a temp register which is callee saved.
> >>
> >>So if the kernel is saving $t9 and you've been relying on that, consider
> >>yourself lucky - there's not guarantee for that.
> >
> >Is there any documentation of what the kernel does guarantee?
> 
> Not really.  The glibc souces can be used as the canonical
> implementation as we cannot break it.  glibc assumes $25 is
> clobbered.

OK.

> >All
> >existing syscall-making code I've seen depends at least on r4-r7 not
> >being clobbered when a signal interrupts a syscall
> 
> This is an internal kernel implementation detail. Relying on it in
> userspace is probably not a good idea.

When a restartable system call is interrupted by a signal, the kernel
must arrange for it to restart after the signal handler returns.
While some other obscure variants with trampolines are conceivable,
the canonical way to do this is to set PC back to the syscall
instruction with all the relevant registers preserved. MIPS is a bit
peculiar in that the kernel sets PC back to the _previous_ instruction
and requires that instruction to reload $2. This requirement is part
of the syscall ABI in that failure of the application to properly
reload $2 in this slot will cause unpredictable behavior when a
syscall needs to be resumed after a signal.

While I asked about preserving $25 in general, my actual concern is
about the syscall restarting situation. I don't care if the value of
$25 (or $7 in my alternate version) is lost once the syscall returns;
I only care that the value is still there if the kernel decides to
point PC back at the instruction before syscall in order to implement
restarting.

> >and sets it up for
> >restart (since the arguments still need to be there when it's
> >restarted), and seems to also depend on r4-r6 not being clobbered when
> >the syscall successfully returns (since they're not listed in the
> >clobber list, e.g. in uClibc's inline syscall asm).
> 
> Some versions of uClibc's inline syscall asm are buggy.  So they
> cannot be used as an indication of what is supported.

The code I'm looking at seems to match what you cited from glibc.

> >These are
> >requirements beyond the normal function call convention (which does
> >not require the callee preserve the values of r4-r7).
> 
> I would assume these are clobbered (from glibc sources
> ports/sysdeps/unix/sysv/linux/mips/mips64/n64/sysdep.h):
> 
> "$1", "$3", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "$25",
> "hi", "lo"

OK.

Rich
