Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 08:51:51 +0100 (CET)
Received: from bombadil.infradead.org ([198.137.202.9]:44825 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009001AbcA0HvtvbP7p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 08:51:49 +0100
Received: from j217066.upc-j.chello.nl ([24.132.217.66] helo=twins)
        by bombadil.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1aOKt2-0003wJ-Q4; Wed, 27 Jan 2016 07:51:33 +0000
Received: by twins (Postfix, from userid 1000)
        id CEC2D1257A0D8; Wed, 27 Jan 2016 08:51:29 +0100 (CET)
Date:   Wed, 27 Jan 2016 08:51:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips <linux-mips@linux-mips.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Peter Anvin <hpa@zytor.com>, sparclinux@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
        linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        the arch/x86 maintainers <x86@kernel.org>,
        xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>,
        linux-xtensa@linux-xtensa.org,
        James Hogan <james.hogan@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        adi-buildroot-devel@lists.sourceforge.net,
        David Daney <ddaney.cavm@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-metag@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Joe Perches <joe@perches.com>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        David Miller <davem@davemloft.net>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Message-ID: <20160127075129.GH6357@twins.programming.kicks-ass.net>
References: <20160114204827.GE3818@linux.vnet.ibm.com>
 <20160118081929.GA30420@gondor.apana.org.au>
 <20160118154629.GB3818@linux.vnet.ibm.com>
 <20160126165207.GB6029@fixme-laptop.cn.ibm.com>
 <20160126172227.GG6357@twins.programming.kicks-ass.net>
 <CA+55aFzcC6C8imPs5vk4yH1Y2YHjnAdFM9HCkVs04COxuDQH6w@mail.gmail.com>
 <20160126201037.GU4503@linux.vnet.ibm.com>
 <CA+55aFxjb+2rs2wVHtiSCcOzgMrE8H=yDeNcjyujPQudDCtLgw@mail.gmail.com>
 <CA+55aFwxTJd+uibcxtZD3tGnj_n=LMwyAa0s8qyx_OF0OMWQkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwxTJd+uibcxtZD3tGnj_n=LMwyAa0s8qyx_OF0OMWQkA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2012-12-30)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51455
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

On Tue, Jan 26, 2016 at 02:33:40PM -0800, Linus Torvalds wrote:

> If it turns out that some architecture does actually need a barrier
> between a read and a dependent write, then that will mean that
> 
>  (a) we'll have to make up a _new_ barrier, because
> "smp_read_barrier_depends()" is not that barrier. We'll presumably
> then have to make that new barrier part of "rcu_derefence()" and
> friends.
> 
>  (b) we will have found an architecture with even worse memory
> ordering semantics than alpha, and we'll have to stop castigating
> alpha for being the worst memory ordering ever.
> 
> but I sincerely hope that we'll never find that kind of broken architecture.

So for a moment it looked like MIPS wanted to equal or surpass Alpha in
this respect.

And Paul made the point that smp_read_barrier_depends() really should
be smp_aquire_barrier_depends() in that we rely on both dependent reads
and writes to be ordered against the initial pointer load.

Now, as you've made abundantly clear, Alpha does this, although it needs
the little extra help in the dependent read department.

The 'problem' is that someone seemed to have used our
Documentation/memory-barriers.txt as a specification for what hardware
is permitted and we require. And in that light Paul noted that
read_barrier_depends really should be considered an
acquire_barrier_depends and order both dependent reads and writes
against the (prior) read (if nothing else already does).

Now clearly, any sane architecture doesn't need anything like this, but
again our document doesn't seem to judge. That is, from reading the
document one can get the impression is a perfectly fine thing to do.
Nowhere does our disdain for this thing show.
