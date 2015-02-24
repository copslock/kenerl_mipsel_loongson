Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2015 22:51:05 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27007158AbbBXVvDwVidR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Feb 2015 22:51:03 +0100
Date:   Tue, 24 Feb 2015 21:51:03 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
cc:     Zenon Fortuna <zenon.fortuna@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        IMG - MIPS Linux Kernel developers 
        <IMG-MIPSLinuxKerneldevelopers@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH V2 1/3] MIPS: Fix cache flushing for swap pages with
 non-DMA I/O.
In-Reply-To: <54ECE7CE.4040407@imgtec.com>
Message-ID: <alpine.LFD.2.11.1502242140220.17311@eddie.linux-mips.org>
References: <1424362664-30303-1-git-send-email-Steven.Hill@imgtec.com> <1424362664-30303-2-git-send-email-Steven.Hill@imgtec.com> <CAJiQ=7DMBznB5Ths0sAZORf2hgSQRuBoPF-7HGHhcHn0EajnWg@mail.gmail.com> <54EBCC38.7000702@imgtec.com> <54EBD023.8090706@imgtec.com>
 <alpine.LFD.2.11.1502240224500.17311@eddie.linux-mips.org> <54ECE7CE.4040407@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Tue, 24 Feb 2015, Leonid Yegoshin wrote:

> >   It absolutely has to work, on the MIPS target GCC emits code invoking it
> > to synchronise trampolines built at the run time on the stack (used for
> > calling nested functions, a C language extension borrowed from Pascal,
> > etc.), before passing execution there.  Verification of this syscall is
> > probably implicitly covered by the GCC test suite already.
> >
> >    Maciej
> cacheflush() syscall traps into kernel and it executes I and D caches
> flushing.
> 
> However, it's implementation in 'master' branch from Linus tree is wrong: if
> you call it in multicore environment for size > L1 cache size then it does it
> incorrectly: doesn't call IPI for index cacheops.
> 
> The correct way is ... sorry, can't find it in LMO...

 Hmm, on SMP using hit operations for cacheflush(2) that rely on the 
hardware cache coherency protocol should be cheaper up to at least the 
size of the cache times the number of processors.  To say nothing of the 
the overhead of sending and receiving IPIs.

 For simplicity perhaps on SMP we should just always use hit operations 
regardless of the size requested.  It's not like using cacheflush(2) for 
large blocks is that common.  And GCC trampolines consist of a couple of 
instructions only, they'll never hit the problem.

  Maciej
