Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Sep 2016 13:24:40 +0200 (CEST)
Received: from merlin.infradead.org ([205.233.59.134]:52596 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992104AbcIGLY3EtR1R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Sep 2016 13:24:29 +0200
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=twins.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.85_2 #1 (Red Hat Linux))
        id 1bhaxr-00076o-9C; Wed, 07 Sep 2016 11:24:23 +0000
Received: by twins.programming.kicks-ass.net (Postfix, from userid 1000)
        id D965D12573B0D; Wed,  7 Sep 2016 13:24:23 +0200 (CEST)
Date:   Wed, 7 Sep 2016 13:24:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 05/12] MIPS: Barrier: Add definitions of SYNC stype
 values
Message-ID: <20160907112423.GQ10138@twins.programming.kicks-ass.net>
References: <1473241520-14917-1-git-send-email-matt.redfearn@imgtec.com>
 <1473241520-14917-6-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1473241520-14917-6-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55058
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


This seems to be verbatim copies of the text from the manual. A few
questions below.

On Wed, Sep 07, 2016 at 10:45:13AM +0100, Matt Redfearn wrote:

> +/*
> + * Completion barriers:
> + * - Every synchronizable specified memory instruction (loads or stores or both)
> + *   that occurs in the instruction stream before the SYNC instruction must be
> + *   already globally performed before any synchronizable specified memory
> + *   instructions that occur after the SYNC are allowed to be performed, with
> + *   respect to any other processor or coherent I/O module.
> + *
> + * - The barrier does not guarantee the order in which instruction fetches are
> + *   performed.
> + *
> + * - A stype value of zero will always be defined such that it performs the most
> + *   complete set of synchronization operations that are defined.This means
> + *   stype zero always does a completion barrier that affects both loads and
> + *   stores preceding the SYNC instruction and both loads and stores that are
> + *   subsequent to the SYNC instruction. Non-zero values of stype may be defined
> + *   by the architecture or specific implementations to perform synchronization
> + *   behaviors that are less complete than that of stype zero. If an
> + *   implementation does not use one of these non-zero values to define a
> + *   different synchronization behavior, then that non-zero value of stype must
> + *   act the same as stype zero completion barrier. This allows software written
> + *   for an implementation with a lighter-weight barrier to work on another
> + *   implementation which only implements the stype zero completion barrier.
> + *
> + * - A completion barrier is required, potentially in conjunction with SSNOP (in
> + *   Release 1 of the Architecture) or EHB (in Release 2 of the Architecture),
> + *   to guarantee that memory reference results are visible across operating
> + *   mode changes. For example, a completion barrier is required on some
> + *   implementations on entry to and exit from Debug Mode to guarantee that
> + *   memory effects are handled correctly.
> + */
> +
> +/*
> + * stype 0 - A completion barrier that affects preceding loads and stores and
> + * subsequent loads and stores.
> + * Older instructions which must reach the load/store ordering point before the
> + * SYNC instruction completes: Loads, Stores
> + * Younger instructions which must reach the load/store ordering point only
> + * after the SYNC instruction completes: Loads, Stores
> + * Older instructions which must be globally performed when the SYNC instruction
> + * completes: Loads, Stores
> + */
> +#define STYPE_SYNC 0x0

So, and I think there was no confusion on this point, "SYNC 0" is fully
transitive. Everything prior to the SYNC must be globally visible before
we continue.

> +/*
> + * Ordering barriers:
> + * - Every synchronizable specified memory instruction (loads or stores or both)
> + *   that occurs in the instruction stream before the SYNC instruction must
> + *   reach a stage in the load/store datapath after which no instruction
> + *   re-ordering is possible before any synchronizable specified memory
> + *   instruction which occurs after the SYNC instruction in the instruction
> + *   stream reaches the same stage in the load/store datapath.
> + *
> + * - If any memory instruction before the SYNC instruction in program order,
> + *   generates a memory request to the external memory and any memory
> + *   instruction after the SYNC instruction in program order also generates a
> + *   memory request to external memory, the memory request belonging to the
> + *   older instruction must be globally performed before the time the memory
> + *   request belonging to the younger instruction is globally performed.
> + *
> + * - The barrier does not guarantee the order in which instruction fetches are
> + *   performed.
> + */
> +
> +/*
> + * stype 0x10 - An ordering barrier that affects preceding loads and stores and
> + * subsequent loads and stores.
> + * Older instructions which must reach the load/store ordering point before the
> + * SYNC instruction completes: Loads, Stores
> + * Younger instructions which must reach the load/store ordering point only
> + * after the SYNC instruction completes: Loads, Stores
> + * Older instructions which must be globally performed when the SYNC instruction
> + * completes: N/A
> + */
> +#define STYPE_SYNC_MB 0x10

This I'm not sure of; it states that things must become globally visible
in the order specified, but the wording leaves a fairly big hole. It
doesn't state that things cannot be less than globally visible at
intermediate times.

To take the example from Documentation/memory-barriers.txt:

        CPU 1                   CPU 2                   CPU 3
        ======================= ======================= =======================
                { X = 0, Y = 0 }
        STORE X=1               LOAD X                  STORE Y=1
                                <general barrier>       <general barrier>
                                LOAD Y                  LOAD X

Suppose that CPU 2's load from X returns 1 and its load from Y returns 0.
This indicates that CPU 2's load from X in some sense follows CPU 1's
store to X and that CPU 2's load from Y in some sense preceded CPU 3's
store to Y.  The question is then "Can CPU 3's load from X return 0?"


Is it ever possible for CPU2 and CPU3 to match "SYNC 10" points but to
disagree on their loads of X?

That is, even though CPU2 and CPU3 agree on their respective past and
future stores, the 'happens before' relation CPU1 and CPU2 have wrt. X
is not included?
