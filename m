Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jul 2018 11:37:14 +0200 (CEST)
Received: from merlin.infradead.org ([IPv6:2001:8b0:10b:1231::1]:50678 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993961AbeGJJhHO8ef4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Jul 2018 11:37:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MnkMywAPiRkW4Pwzzt3rRZBm6ib+aYpYOXcyNazxtlo=; b=lWf4GC4bNPPcpvzMYNNC87lKh
        mdnBtALBQC4xgM5UfRvQtxsllxaGDfAk8uPqxxH/MvA6d1X7WDgcg42vbIlqGnrjwFVQlEzT05jsK
        OEY4iEATpQcHK6p6HtEfy+qRlhCH7+aVIYymfd87K9+iIR0eRd5KeVGj4F6wd3eK+6qkP45PT+9lD
        eksPTZJp19+kG8p/TKRNQKwRfLSrClVr5lTHaJg7+Q8QABxTaGoj4e5M96LjloLwPSsPYMsOL6NqT
        Fx/baTkxVByxGeQmCNgMv2bZsZlMkvc/XehaF/PnCNoKlNNAbT6NF4fJpUpkEM8iabznrrw6MY0cs
        bZ5MTYfwA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcp4b-0003Z0-1D; Tue, 10 Jul 2018 09:36:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2E92120289CA5; Tue, 10 Jul 2018 11:36:37 +0200 (CEST)
Date:   Tue, 10 Jul 2018 11:36:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] MIPS: implement smp_cond_load_acquire() for Loongson-3
Message-ID: <20180710093637.GF2476@hirez.programming.kicks-ass.net>
References: <1531103198-16764-1-git-send-email-chenhc@lemote.com>
 <20180709164939.uhqsvcv4a7jlbhvp@pburton-laptop>
 <CAAhV-H7bqhz+dzgPk0_tTAN6y_k_8Ds9heF0p5uPHsHNg0v4Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H7bqhz+dzgPk0_tTAN6y_k_8Ds9heF0p5uPHsHNg0v4Rg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peterz@infradead.org
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

On Tue, Jul 10, 2018 at 12:26:34PM +0800, Huacai Chen wrote:
> Hi, Paul and Peter,
> 
> I think we find the real root cause, READ_ONCE() doesn't need any
> barriers, the problematic code is queued_spin_lock_slowpath() in
> kernel/locking/qspinlock.c:
> 
>         if (old & _Q_TAIL_MASK) {
>                 prev = decode_tail(old);
> 
>                 /* Link @node into the waitqueue. */
>                 WRITE_ONCE(prev->next, node);
> 
>                 pv_wait_node(node, prev);
>                 arch_mcs_spin_lock_contended(&node->locked);
> 
>                 /*
>                  * While waiting for the MCS lock, the next pointer may have
>                  * been set by another lock waiter. We optimistically load
>                  * the next pointer & prefetch the cacheline for writing
>                  * to reduce latency in the upcoming MCS unlock operation.
>                  */
>                 next = READ_ONCE(node->next);
>                 if (next)
>                         prefetchw(next);
>         }
> 
> After WRITE_ONCE(prev->next, node); arch_mcs_spin_lock_contended()
> enter a READ_ONCE() loop, so the effect of WRITE_ONCE() is invisible
> by other cores because of the write buffer.

And _that_ is a hardware bug. Also please explain how that is different
from the ARM bug mentioned elsewhere.

> As a result,
> arch_mcs_spin_lock_contended() will wait for ever because the waiters
> of prev->next will wait for ever. I think the right way to fix this is
> flush SFB after this WRITE_ONCE(), but I don't have a good solution:
> 1, MIPS has wbflush() which can be used to flush SFB, but other archs
> don't have;

Sane archs don't need this.

> 2, Every arch has mb(), and add mb() after WRITE_ONCE() can actually
> solve Loongson's problem, but in syntax, mb() is different from
> wbflush();

Still wrong, because any non-broken arch doesn't need that flush to
begin with.

> 3, Maybe we can define a Loongson-specific WRITE_ONCE(), but not every
> WRITE_ONCE() need wbflush(), we only need wbflush() between
> WRITE_ONCE() and a READ_ONCE() loop.

No no no no ...

So now explain why the cpu_relax() hack that arm did doesn't work for
you?
