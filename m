Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2018 09:17:46 +0200 (CEST)
Received: from merlin.infradead.org ([IPv6:2001:8b0:10b:1231::1]:48828 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990391AbeFSHRj1GNMJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2018 09:17:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fSm0IjljCEq0+TTQR+bJD7gVMYsv1w69dMPn3iubxvY=; b=1BYWA/Vt6kvbkQo4KbWwHfe6f
        3U9RfKZduhygkixGpUrJDqVoqLmGmFK8qu81CHZhEYQ7KBsvPqHnENX+oPrG02/UcKPPza0u9uE0d
        Xg9Npcy1jNHB6KGHp80bPT3rk9Fgocyc+0ijvimTKpuEuDS6GB8LUYngB0ox8sZ3EqfOHcWtAkq/4
        khrN0NO8eL/zqg2iqO+hxVH2kul5wJQ6EIh47aVqEMLXsXtiBNQyOfbygdTDs1VHZUTc5BQ0gJF8r
        4B/6wmfIULDKn3LDy1Be6Od9Px1paLvR1/EXffDwwZkvOY/LZ/fadfaQw7jwNvnrzSPJO1G6Y2S2a
        g6rvxaXvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVAt7-0003tp-2t; Tue, 19 Jun 2018 07:17:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EB39D20268507; Tue, 19 Jun 2018 09:17:10 +0200 (CEST)
Date:   Tue, 19 Jun 2018 09:17:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>, stable@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: implement smp_cond_load_acquire() for Loongson-3
Message-ID: <20180619071710.GB2494@hirez.programming.kicks-ass.net>
References: <1529042858-9483-1-git-send-email-chenhc@lemote.com>
 <20180618185141.yvkrsbdi2gbxjxj7@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618185141.yvkrsbdi2gbxjxj7@pburton-laptop>
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64363
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

On Mon, Jun 18, 2018 at 11:51:41AM -0700, Paul Burton wrote:
> Hi Huacai,
> 
> On Fri, Jun 15, 2018 at 02:07:38PM +0800, Huacai Chen wrote:
> > After commit 7f56b58a92aaf2c ("locking/mcs: Use smp_cond_load_acquire()
> > in MCS spin loop") Loongson-3 fails to boot. This is because Loongson-3
> > has SFB (Store Fill Buffer) and READ_ONCE() may get an old value in a
> > tight loop. So in smp_cond_load_acquire() we need a __smp_mb() after
> > every READ_ONCE().
> 
> Thanks - modifying smp_cond_load_acquire() is a step better than
> modifying arch_mcs_spin_lock_contended() to avoid it, but I'm still not
> sure we've reached the root of the problem. 

Agreed, this looks entirely dodgy.

> If tight loops using
> READ_ONCE() are at fault then what's special about
> smp_cond_load_acquire()? Could other such loops not hit the same
> problem?

Right again, Linux has a number of places where it relies on loops like
this.

	for (;;) {
		if (READ_ONCE(*ptr))
			break;

		cpu_relax();
	}

That is assumed to terminate -- provided the store to make *ptr != 0
happens of course.

And this has nothing to do with store buffers per se, sure store-buffers
might delay the store from being visible for a (little) while, but we
very much assume store buffers will not indefinitely hold on to data.

The proposed __smp_mb() doesn't make any kind of sense here. I presume
it's effect is to flush remote store buffers, but that is not something
LKMM allows for.

> Is the scenario you encounter the same as that outlined in the "DATA
> DEPENDENCY BARRIERS (HISTORICAL)" section of
> Documentation/memory-barriers.txt by any chance? If so then perhaps it
> would be better to implement smp_read_barrier_depends(), or just raw
> read_barrier_depends() depending upon how your SFB functions.

That doesn't make any sense, there is no actual data dependency here. We
load a single variable. Data dependencies are where you have (at least)
2 loads, where the second depends on the first, like:

	struct obj *obj = rcu_dereference(objp);
	int val = obj->val;

Here the load of val depends on the load of obj.

> Is there any public documentation describing the behaviour of the store
> fill buffer in Loongson-3?

I know of Store Buffers, but what exactly is a Store Fill Buffer? Better
would be to get a coherent memory model document on Loongson, because
this all smells horribly.

> Part of the problem is that I'm still not sure what's actually happening
> in your system - it would be helpful to have further information in the
> commit message about what actually happens. For example if you could
> walk us through an example of the problem step by step in the style of
> the diagrams you'll see in Documentation/memory-barriers.txt then I
> think that would help us to see what the best solution here is.
> 
> I've copied the LKMM maintainers in case they have further input.

Thanks, patches like proposed certainly require closer scrutiny and I
agree with you that this needs far better explanation.
