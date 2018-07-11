Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2018 13:10:15 +0200 (CEST)
Received: from merlin.infradead.org ([IPv6:2001:8b0:10b:1231::1]:57790 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993514AbeGKLKJNq6NG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jul 2018 13:10:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dAuCZZJoWD4NjzZ2cdhm7v1L5BsGI2qcbVsgK7bWiXY=; b=UQCd5mF4Xx1PRok2IwVGTe3dVV
        8bGmTGE0j530pWZfYxTbApW6dwSWrFT3UtSDFgmlfNpShjR8fnBqflg4ruXv8tuHoS2ZURr7/mtcl
        I17mz2r+HOaKyzW+x7eFFU6ZtQpYW0raoOdotsB750Dtsi6tYsj+DScM96SRKLZHYslSyjcLQHXLb
        zy76FP8I+YXRLLbs2cRQfZ1E4Ms8UmMIuYenrcufB20Gw0otYrCtgCX9Crb+3cBaDKDOxaFVKOTon
        meUxYBU36JjupCoOpbz5XsUm3K2T4ZHycox/kU/Px48b5B2g99pK0ak+jYNDTC4tNEqjXB432tavF
        teWbhhww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdD0M-0007DG-Ay; Wed, 11 Jul 2018 11:09:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EB40320289CB2; Wed, 11 Jul 2018 13:09:52 +0200 (CEST)
Date:   Wed, 11 Jul 2018 13:09:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@linux-mips.org,
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
Message-ID: <20180711110952.GC2476@hirez.programming.kicks-ass.net>
References: <1531103198-16764-1-git-send-email-chenhc@lemote.com>
 <tencent_26F8B9E004D4512B2225FCE1@qq.com>
 <20180710121727.GK2476@hirez.programming.kicks-ass.net>
 <5471216.FKXZRxKFUI@flygoat-ry>
 <20180711102106.GG13963@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180711102106.GG13963@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64781
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

On Wed, Jul 11, 2018 at 11:21:06AM +0100, Will Deacon wrote:
> On Wed, Jul 11, 2018 at 06:05:51PM +0800, Jiaxun Yang wrote:
> > On 2018-7-10 Tue at 20:17:27，Peter Zijlstra Wrote：

> > > Still, even with the rules above, the best work-around is still the very
> > > same cpu_relax() hack.
> > 
> > As you say, SFB makes Loongson not fully SMP-coherent.
> > However, modify cpu_relax can solve the current problem,
> > but not so straight forward. On the other hand, providing a Loongson-specific 
> > WRITE_ONCE looks more reasonable, because it the eliminate the "non-cohrency".
> > So we can solve the bug from the root.
> 
> Curious, but why is it not straight-forward to hack cpu_relax()? If you try
> to hack WRITE_ONCE, you also need to hack atomic_set, atomic64_set and all
> the places that should be using WRITE_ONCE but aren't ;~)

Right.

The problem isn't stores pre-se, normal progress should contain enough
stores to flush out 'old' bits in the natural order of things. But the
problem is spin-wait loops that inhibit normal progress (and thereby
store-buffer flushing).

And all spin-wait loops should be having cpu_relax() in them. So
cpu_relax() is the natural place to fix this.

Adding SYNC to WRITE_ONCE()/atomic* will hurt performance lots and will
ultimately not guarantee anything more; and as Will said, keep you
chasing dragons where people forgot to use WRITE_ONCE() where they maybe
should've.
