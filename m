Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2012 15:29:57 +0200 (CEST)
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:36919 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903487Ab2IKN3t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Sep 2012 15:29:49 +0200
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1TBQa3-00079E-00
        for linux-mips@linux-mips.org; Tue, 11 Sep 2012 13:32:43 +0000
Date:   Tue, 11 Sep 2012 09:32:43 -0400
To:     linux-mips@linux-mips.org
Subject: Re: Is r25 saved across syscalls?
Message-ID: <20120911133243.GR27715@brightrain.aerifal.cx>
References: <20120909193008.GA15157@brightrain.aerifal.cx>
 <20120910170830.GB24448@linux-mips.org>
 <20120910172248.GN27715@brightrain.aerifal.cx>
 <504E2BC7.7000108@gmail.com>
 <20120910183720.GO27715@brightrain.aerifal.cx>
 <20120911084804.GE24448@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120911084804.GE24448@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   Rich Felker <dalias@aerifal.cx>
X-archive-position: 34467
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

On Tue, Sep 11, 2012 at 10:48:04AM +0200, Ralf Baechle wrote:
> Note that c0_epc is made to point back to the SYSCALL instruction,
> not the one preceeding the SYSCALL instructions since 8f5a00eb4 [MIPS:
> Sanitize restart logics] which went in for 2.6.36.
> 
> Relying on userland to reload $v0 was something ugly that Linux inherited
> from god knows where and I'm happy to have gotten rid of that.

So basically my whole question/concern is irrelevant to anything but
pre-2.6.36 kernels, and all of those preserve $25, so it would have
been safe to keep using $25.

Thankfully I already found another solution using an "ir" constraint
and "addu $2,$0,%2"; this assembles to "li" whenever the compiler can
do constant propagation, and if CP fails or the syscall number is not
constant, it allocates a register (either an unused argument register
or a call-preserved register since all the others are already in the
clobberlist or used as inputs).

> > The code I'm looking at seems to match what you cited from glibc.
> > 
> > > >These are
> > > >requirements beyond the normal function call convention (which does
> > > >not require the callee preserve the values of r4-r7).
> > > 
> > > I would assume these are clobbered (from glibc sources
> > > ports/sysdeps/unix/sysv/linux/mips/mips64/n64/sysdep.h):
> > > 
> > > "$1", "$3", "$10", "$11", "$12", "$13", "$14", "$15", "$24", "$25",
> > > "hi", "lo"
> 
> Which is correct but also means that the _syscallX() macros that were in
> <asm/unistd.h> up to 2.6.19 were broken; the were lacking clobbers for
> $25, $hi and $lo.  Unfortunately these macros were copied into many
> libraries and applications.

I don't think the compiler will try to cache anything in $25 itself
anyway. Normally it seems to only get used for its role in the
function call ABI. But yes, in theory this is rather problematic,
moreso that my issue of using $25 to restore $2 on restart.

Rich
