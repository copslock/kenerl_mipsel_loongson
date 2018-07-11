Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2018 12:20:38 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:37064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993849AbeGKKUbyBnH4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Jul 2018 12:20:31 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05C43ED1;
        Wed, 11 Jul 2018 03:20:25 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C9AA43F589;
        Wed, 11 Jul 2018 03:20:24 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id D21111AE3828; Wed, 11 Jul 2018 11:21:06 +0100 (BST)
Date:   Wed, 11 Jul 2018 11:21:06 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@linux-mips.org, Peter Zijlstra <peterz@infradead.org>,
        =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        wuzhangjin <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] MIPS: implement smp_cond_load_acquire() for Loongson-3
Message-ID: <20180711102106.GG13963@arm.com>
References: <1531103198-16764-1-git-send-email-chenhc@lemote.com>
 <tencent_26F8B9E004D4512B2225FCE1@qq.com>
 <20180710121727.GK2476@hirez.programming.kicks-ass.net>
 <5471216.FKXZRxKFUI@flygoat-ry>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5471216.FKXZRxKFUI@flygoat-ry>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <will.deacon@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64779
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

On Wed, Jul 11, 2018 at 06:05:51PM +0800, Jiaxun Yang wrote:
> On 2018-7-10 Tue at 20:17:27，Peter Zijlstra Wrote：
> 
> Hi Peter
> Since Huacai unable to send email via client, I'm going to reply for him 
>  
> > Sure.. we all got that far. And no, this isn't the _real_ problem. This
> > is a manifestation of the problem.
> > 
> > The problem is that your SFB is broken (per the Linux requirements). We
> > require that stores will become visible. That is, they must not
> > indefinitely (for whatever reason) stay in the store buffer.
> > 
> > > I don't think this is a hardware bug, in design, SFB will flushed to
> > > L1 cache in three cases:
> > > 
> > > 1, data in SFB is full (be a complete cache line);
> > > 2, there is a subsequent read access in the same cache line;
> > > 3, a 'sync' instruction is executed.
> > 
> > And I think this _is_ a hardware bug. You just designed the bug instead
> > of it being by accident.
> Yes, we understood that this hardware feature is not supported by LKML,
> so it should be a hardware bug for LKML.
> > 
> > It doesn't happen an _any_ other architecture except that dodgy
> > ARM11MPCore part. Linux hard relies on stores to become available
> > _eventually_.
> > 
> > Still, even with the rules above, the best work-around is still the very
> > same cpu_relax() hack.
> 
> As you say, SFB makes Loongson not fully SMP-coherent.
> However, modify cpu_relax can solve the current problem,
> but not so straight forward. On the other hand, providing a Loongson-specific 
> WRITE_ONCE looks more reasonable, because it the eliminate the "non-cohrency".
> So we can solve the bug from the root.

Curious, but why is it not straight-forward to hack cpu_relax()? If you try
to hack WRITE_ONCE, you also need to hack atomic_set, atomic64_set and all
the places that should be using WRITE_ONCE but aren't ;~)

Will
