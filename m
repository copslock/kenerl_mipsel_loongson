Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2012 10:48:11 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45126 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903304Ab2IKIsG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Sep 2012 10:48:06 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q8B8m4hp021507;
        Tue, 11 Sep 2012 10:48:04 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q8B8m4po021506;
        Tue, 11 Sep 2012 10:48:04 +0200
Date:   Tue, 11 Sep 2012 10:48:04 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Rich Felker <dalias@aerifal.cx>
Cc:     linux-mips@linux-mips.org
Subject: Re: Is r25 saved across syscalls?
Message-ID: <20120911084804.GE24448@linux-mips.org>
References: <20120909193008.GA15157@brightrain.aerifal.cx>
 <20120910170830.GB24448@linux-mips.org>
 <20120910172248.GN27715@brightrain.aerifal.cx>
 <504E2BC7.7000108@gmail.com>
 <20120910183720.GO27715@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120910183720.GO27715@brightrain.aerifal.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34465
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, Sep 10, 2012 at 02:37:20PM -0400, Rich Felker wrote:

> When a restartable system call is interrupted by a signal, the kernel
> must arrange for it to restart after the signal handler returns.
> While some other obscure variants with trampolines are conceivable,
> the canonical way to do this is to set PC back to the syscall
> instruction with all the relevant registers preserved. MIPS is a bit
> peculiar in that the kernel sets PC back to the _previous_ instruction
> and requires that instruction to reload $2. This requirement is part
> of the syscall ABI in that failure of the application to properly
> reload $2 in this slot will cause unpredictable behavior when a
> syscall needs to be resumed after a signal.
> 
> While I asked about preserving $25 in general, my actual concern is
> about the syscall restarting situation. I don't care if the value of
> $25 (or $7 in my alternate version) is lost once the syscall returns;
> I only care that the value is still there if the kernel decides to
> point PC back at the instruction before syscall in order to implement
> restarting.

Yes.  The kernel keeps a backup copy of $a3 around and uses it to restore
the old content of $a3 before returning to userland, even in old kernels.

A recent signal.c contains:

        if (regs->regs[2] == ERESTART_RESTARTBLOCK) {
                regs->regs[2] = current->thread.abi->restart;
                regs->regs[7] = regs->regs[26];
                regs->cp0_epc -= 4;
        }

Note that c0_epc is made to point back to the SYSCALL instruction,
not the one preceeding the SYSCALL instructions since 8f5a00eb4 [MIPS:
Sanitize restart logics] which went in for 2.6.36.

Relying on userland to reload $v0 was something ugly that Linux inherited
from god knows where and I'm happy to have gotten rid of that.

> The code I'm looking at seems to match what you cited from glibc.
> 
> > >These are
> > >requirements beyond the normal function call convention (which does
> > >not require the callee preserve the values of r4-r7).
> > 
> > I would assume these are clobbered (from glibc sources
> > ports/sysdeps/unix/sysv/linux/mips/mips64/n64/sysdep.h):
> > 
> > "$1", "$3", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "$25",
> > "hi", "lo"

Which is correct but also means that the _syscallX() macros that were in
<asm/unistd.h> up to 2.6.19 were broken; the were lacking clobbers for
$25, $hi and $lo.  Unfortunately these macros were copied into many
libraries and applications.

  Ralf
