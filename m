Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Oct 2010 03:59:55 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#500 fake: STDIN
        (ralf@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S1492025Ab0JBB7w (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 2 Oct 2010 03:59:52 +0200
Date:   Sat, 2 Oct 2010 10:59:47 +0900
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>,
        linux-mips@linux-mips.org, a.p.zijlstra@chello.nl,
        paulus@samba.org, mingo@elte.hu, acme@redhat.com
Subject: Re: [PATCH resend] Perf-tool/MIPS: support cross compiling of
 tools/perf for MIPS
Message-ID: <20101002015947.GB9360@linux-mips.org>
References: <4CA4920C.30401@gmail.com>
 <4CA6566D.2050003@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4CA6566D.2050003@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 01, 2010 at 02:45:17PM -0700, David Daney wrote:

> In user space the rmb() must expand to a SYNC instruction.  I am not
> sure what your version in the patch is doing with all those NOPs.  That
> is not guaranteed to do anything.

That's a rather old version of the kernel rmb macro I think.  The NOPs
where there to enforce ordering of a mix of cached and uncached accesses
on the R4400 (not R4000) where according to my reading the manual leaves
it a bit unclear if a SYNC is sufficient or if the pipeline needs to be
drained in addition.  See version 2 of the R4000/R4400 User's Manual.

> The instruction set specifications say that SYNC orders all loads and
> stores.  This is a heaver operation than rmb() demands, but is the only
> universally available instruction that imposes ordering.
> 
> For processors that do not support SYNC, the kernel will emulate it, so
> it is safe to use in userspace.  I wouldn't worry about emulation
> overhead though, because processors that lack SYNC probably also lack
> performance counters, so are not as interesting from a perf-tool point
> of view.

Yes, just use SYNC.  SYNC-less processors would only be R2000/R3000
processors and a few other oddball processors which for performance
optimization are totally uninteresting since years.

  Ralf
