Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Sep 2016 13:31:13 +0200 (CEST)
Received: from bombadil.infradead.org ([198.137.202.9]:56546 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992121AbcIGLbHCl0WA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Sep 2016 13:31:07 +0200
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=twins.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.85_2 #1 (Red Hat Linux))
        id 1bhb4I-0004la-O4; Wed, 07 Sep 2016 11:31:02 +0000
Received: by twins.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9177C12573B0D; Wed,  7 Sep 2016 13:31:02 +0200 (CEST)
Date:   Wed, 7 Sep 2016 13:31:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 05/12] MIPS: Barrier: Add definitions of SYNC stype
 values
Message-ID: <20160907113102.GN10168@twins.programming.kicks-ass.net>
References: <1473241520-14917-1-git-send-email-matt.redfearn@imgtec.com>
 <1473241520-14917-6-git-send-email-matt.redfearn@imgtec.com>
 <20160907112423.GQ10138@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160907112423.GQ10138@twins.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55059
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

On Wed, Sep 07, 2016 at 01:24:23PM +0200, Peter Zijlstra wrote:
> > +/*
> > + * Ordering barriers:
> > + * - Every synchronizable specified memory instruction (loads or stores or both)
> > + *   that occurs in the instruction stream before the SYNC instruction must
> > + *   reach a stage in the load/store datapath after which no instruction
> > + *   re-ordering is possible before any synchronizable specified memory
> > + *   instruction which occurs after the SYNC instruction in the instruction
> > + *   stream reaches the same stage in the load/store datapath.
> > + *
> > + * - If any memory instruction before the SYNC instruction in program order,
> > + *   generates a memory request to the external memory and any memory
> > + *   instruction after the SYNC instruction in program order also generates a
> > + *   memory request to external memory, the memory request belonging to the
> > + *   older instruction must be globally performed before the time the memory
> > + *   request belonging to the younger instruction is globally performed.
> > + *
> > + * - The barrier does not guarantee the order in which instruction fetches are
> > + *   performed.
> > + */
> > +
> > +/*
> > + * stype 0x10 - An ordering barrier that affects preceding loads and stores and
> > + * subsequent loads and stores.
> > + * Older instructions which must reach the load/store ordering point before the
> > + * SYNC instruction completes: Loads, Stores
> > + * Younger instructions which must reach the load/store ordering point only
> > + * after the SYNC instruction completes: Loads, Stores
> > + * Older instructions which must be globally performed when the SYNC instruction
> > + * completes: N/A
> > + */
> > +#define STYPE_SYNC_MB 0x10
> 
> This I'm not sure of; it states that things must become globally visible
> in the order specified, but the wording leaves a fairly big hole. It
> doesn't state that things cannot be less than globally visible at
> intermediate times.
> 
> To take the example from Documentation/memory-barriers.txt:
> 
>         CPU 1                   CPU 2                   CPU 3
>         ======================= ======================= =======================
>                 { X = 0, Y = 0 }
>         STORE X=1               LOAD X                  STORE Y=1
>                                 <general barrier>       <general barrier>
>                                 LOAD Y                  LOAD X
> 
> Suppose that CPU 2's load from X returns 1 and its load from Y returns 0.
> This indicates that CPU 2's load from X in some sense follows CPU 1's
> store to X and that CPU 2's load from Y in some sense preceded CPU 3's
> store to Y.  The question is then "Can CPU 3's load from X return 0?"
> 
> 
> Is it ever possible for CPU2 and CPU3 to match "SYNC 10" points but to
> disagree on their loads of X?
> 
> That is, even though CPU2 and CPU3 agree on their respective past and
> future stores, the 'happens before' relation CPU1 and CPU2 have wrt. X
> is not included?
> 

Now, I suspect it _is_ transitive, because CPU2's "LOAD X" must be
globally performed wrt CPU3's "LOAD X", and my interpretation of that
means that the STORE of X must be globally visible for that to be true.

But, like said, wording... so clarification would be grand.

Also, IFF "SYNC 10" is indeed transitive, you should be able to replace
smp_mb() with it unconditionally.
