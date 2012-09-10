Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Sep 2012 19:20:02 +0200 (CEST)
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:39328 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903469Ab2IJRT6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Sep 2012 19:19:58 +0200
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1TB7hC-0005TT-00
        for linux-mips@linux-mips.org; Mon, 10 Sep 2012 17:22:50 +0000
Date:   Mon, 10 Sep 2012 13:22:50 -0400
To:     linux-mips@linux-mips.org
Subject: Re: Is r25 saved across syscalls?
Message-ID: <20120910172248.GN27715@brightrain.aerifal.cx>
References: <20120909193008.GA15157@brightrain.aerifal.cx>
 <20120910170830.GB24448@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120910170830.GB24448@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   Rich Felker <dalias@aerifal.cx>
X-archive-position: 34454
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

On Mon, Sep 10, 2012 at 07:08:30PM +0200, Ralf Baechle wrote:
> On Sun, Sep 09, 2012 at 03:30:08PM -0400, Rich Felker wrote:
> 
> > The kernel syscall entry/exit code seems to always save and restore
> > r25. Is this stable/documented behavior I can rely on? If there's a
> > reason it _needs_ to be preserved, knowing that would help convince me
> > it's safe to assume it will always be done. The intended usage is to
> > be able to make syscalls (where the syscall # is not a constant that
> > could be loaded with lwi) without a stack frame, as in "move $2,$25 ;
> > syscall".
> 
> The basic design idea is that syscalls use a calling convention similar
> to subroutine calls.  $25 is $t9, so a temp register which is callee saved.
> 
> So if the kernel is saving $t9 and you've been relying on that, consider
> yourself lucky - there's not guarantee for that.

Is there any documentation of what the kernel does guarantee? All
existing syscall-making code I've seen depends at least on r4-r7 not
being clobbered when a signal interrupts a syscall and sets it up for
restart (since the arguments still need to be there when it's
restarted), and seems to also depend on r4-r6 not being clobbered when
the syscall successfully returns (since they're not listed in the
clobber list, e.g. in uClibc's inline syscall asm). These are
requirements beyond the normal function call convention (which does
not require the callee preserve the values of r4-r7).

As for my problem, I can use r7 as the temp ("move $2,$7 ; syscall")
for syscalls with 3 or fewer args, but for the 4-arg syscall, $7 is
occupied by an argument, and I'd need to spill the syscall number to
the stack to be able to restore it if $25 is not available...

Rich
