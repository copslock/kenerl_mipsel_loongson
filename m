Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2016 18:23:04 +0100 (CET)
Received: from bombadil.infradead.org ([198.137.202.9]:49944 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011633AbcAZRXDPdCKC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2016 18:23:03 +0100
Received: from j217066.upc-j.chello.nl ([24.132.217.66] helo=twins)
        by bombadil.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1aO7K2-0008Dr-U0; Tue, 26 Jan 2016 17:22:31 +0000
Received: by twins (Postfix, from userid 1000)
        id 9D8311257A0D8; Tue, 26 Jan 2016 18:22:27 +0100 (CET)
Date:   Tue, 26 Jan 2016 18:22:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Leonid.Yegoshin@imgtec.com, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org, mst@redhat.com, will.deacon@arm.com,
        virtualization@lists.linux-foundation.org, hpa@zytor.com,
        sparclinux@vger.kernel.org, mingo@kernel.org,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        linux@arm.linux.org.uk,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, mpe@ellerman.id.au, x86@kernel.org,
        xen-devel@lists.xenproject.org, mingo@elte.hu,
        linux-xtensa@linux-xtensa.org, james.hogan@imgtec.com,
        arnd@arndb.de, stefano.stabellini@eu.citrix.com,
        adi-buildroot-devel@lists.sourceforge.net, ddaney.cavm@gmail.com,
        tglx@linutronix.de, linux-metag@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ralf@linux-mips.org, joe@perches.com,
        linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Message-ID: <20160126172227.GG6357@twins.programming.kicks-ass.net>
References: <20160114204827.GE3818@linux.vnet.ibm.com>
 <20160118081929.GA30420@gondor.apana.org.au>
 <20160118154629.GB3818@linux.vnet.ibm.com>
 <20160126165207.GB6029@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160126165207.GB6029@fixme-laptop.cn.ibm.com>
User-Agent: Mutt/1.5.21 (2012-12-30)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51420
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

On Wed, Jan 27, 2016 at 12:52:07AM +0800, Boqun Feng wrote:
> I recall that last time you and Linus came into a conclusion that even
> on Alpha, a barrier for read->write with data dependency is unnecessary:
> 
> http://article.gmane.org/gmane.linux.kernel/2077661
> 
> And in an earlier mail of that thread, Linus made his point that
> smp_read_barrier_depends() should only be used to order read->read.
> 
> So right now, are we going to extend the semantics of
> smp_read_barrier_depends()? Can we just make smp_read_barrier_depends()
> still only work for read->read, and assume all the architectures won't
> reorder read->write with data dependency, so that the code above having
> a smp_rmb() also works?

That discussions was about control dependencies. So writes that _depend_
on a prior read having an explicit value.

So something like:

	struct foo *x = READ_ONCE(*ptr);
	smp_read_barrier_depends()
	if (x->val == 5)
		x->bar = 5;

In that case, the load of x->val must be complete and its value
determined _before_ the store to x->bar can happen.

This is distinct from:

	struct foo *x = READ_ONCE(*ptr);
	smp_read_barrier_depends();
	x->bar = 5;

And its the second case where smp_read_barrier_depends() read->write
order matters.
