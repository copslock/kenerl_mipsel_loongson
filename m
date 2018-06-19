Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2018 10:52:09 +0200 (CEST)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49586 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990393AbeFSIwCvwidZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2018 10:52:02 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 702FC1435;
        Tue, 19 Jun 2018 01:51:54 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3FFF33F25D;
        Tue, 19 Jun 2018 01:51:54 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id D09241AE5153; Tue, 19 Jun 2018 09:52:29 +0100 (BST)
Date:   Tue, 19 Jun 2018 09:52:29 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>, stable@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: implement smp_cond_load_acquire() for Loongson-3
Message-ID: <20180619085229.GA13984@arm.com>
References: <1529042858-9483-1-git-send-email-chenhc@lemote.com>
 <20180618185141.yvkrsbdi2gbxjxj7@pburton-laptop>
 <20180619071710.GB2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619071710.GB2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <will.deacon@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: will.deacon@arm.com
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

Hi all,

On Tue, Jun 19, 2018 at 09:17:10AM +0200, Peter Zijlstra wrote:
> On Mon, Jun 18, 2018 at 11:51:41AM -0700, Paul Burton wrote:
> > On Fri, Jun 15, 2018 at 02:07:38PM +0800, Huacai Chen wrote:
> > > After commit 7f56b58a92aaf2c ("locking/mcs: Use smp_cond_load_acquire()
> > > in MCS spin loop") Loongson-3 fails to boot. This is because Loongson-3
> > > has SFB (Store Fill Buffer) and READ_ONCE() may get an old value in a
> > > tight loop. So in smp_cond_load_acquire() we need a __smp_mb() after
> > > every READ_ONCE().
> > 
> > Thanks - modifying smp_cond_load_acquire() is a step better than
> > modifying arch_mcs_spin_lock_contended() to avoid it, but I'm still not
> > sure we've reached the root of the problem. 
> 
> Agreed, this looks entirely dodgy.
> 
> > If tight loops using
> > READ_ONCE() are at fault then what's special about
> > smp_cond_load_acquire()? Could other such loops not hit the same
> > problem?
> 
> Right again, Linux has a number of places where it relies on loops like
> this.
> 
> 	for (;;) {
> 		if (READ_ONCE(*ptr))
> 			break;
> 
> 		cpu_relax();
> 	}
> 
> That is assumed to terminate -- provided the store to make *ptr != 0
> happens of course.
> 
> And this has nothing to do with store buffers per se, sure store-buffers
> might delay the store from being visible for a (little) while, but we
> very much assume store buffers will not indefinitely hold on to data.

We had an issue 8 years ago with the 11MPCore CPU where reads were
prioritised over writes, so code doing something like:

  WRITE_ONCE(*foo, 1);
  while (!READ_ONCE(*bar));

might never make the store to foo visible to other CPUs. This caused a
livelock in KGDB, where two CPUs were doing this on opposite variables
(i.e. the "SB" litmus test, but with the reads looping until they read
1).

See 534be1d5a2da ("ARM: 6194/1: change definition of cpu_relax() for
ARM11MPCore") for the ugly fix, assuming that the "Store Fill Buffer"
suffers from the same disease.

Will
