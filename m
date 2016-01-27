Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jan 2016 01:45:52 +0100 (CET)
Received: from e38.co.us.ibm.com ([32.97.110.159]:46737 "EHLO
        e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009266AbcA1ApvCIrU9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jan 2016 01:45:51 +0100
Received: from localhost
        by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 27 Jan 2016 17:45:44 -0700
Received: from d03dlp02.boulder.ibm.com (9.17.202.178)
        by e38.co.us.ibm.com (192.168.1.138) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 27 Jan 2016 17:45:41 -0700
X-IBM-Helo: d03dlp02.boulder.ibm.com
X-IBM-MailFrom: paulmck@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org;ralf@linux-mips.org
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 4F6EA3E40048;
        Wed, 27 Jan 2016 17:45:41 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u0S0jfIg31457484;
        Wed, 27 Jan 2016 17:45:41 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u0S0jXwL007637;
        Wed, 27 Jan 2016 17:45:40 -0700
Received: from paulmck-ThinkPad-W541 (paulmck-thinkpad-w541.au.ibm.com [9.192.250.130])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u0S0jSXt007295;
        Wed, 27 Jan 2016 17:45:30 -0700
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 63DF516C2B5C; Wed, 27 Jan 2016 15:30:18 -0800 (PST)
Date:   Wed, 27 Jan 2016 15:30:18 -0800
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20160127233018.GN4503@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20160118081929.GA30420@gondor.apana.org.au>
 <20160118154629.GB3818@linux.vnet.ibm.com>
 <20160126165207.GB6029@fixme-laptop.cn.ibm.com>
 <20160126172227.GG6357@twins.programming.kicks-ass.net>
 <CA+55aFzcC6C8imPs5vk4yH1Y2YHjnAdFM9HCkVs04COxuDQH6w@mail.gmail.com>
 <20160126201037.GU4503@linux.vnet.ibm.com>
 <CA+55aFxjb+2rs2wVHtiSCcOzgMrE8H=yDeNcjyujPQudDCtLgw@mail.gmail.com>
 <CA+55aFwxTJd+uibcxtZD3tGnj_n=LMwyAa0s8qyx_OF0OMWQkA@mail.gmail.com>
 <20160126232921.GY4503@linux.vnet.ibm.com>
 <20160127020447.GA1293@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160127020447.GA1293@fixme-laptop.cn.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16012800-0029-0000-0000-00000FFF2E60
Return-Path: <paulmck@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paulmck@linux.vnet.ibm.com
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

On Wed, Jan 27, 2016 at 10:04:47AM +0800, Boqun Feng wrote:
> On Tue, Jan 26, 2016 at 03:29:21PM -0800, Paul E. McKenney wrote:
> > On Tue, Jan 26, 2016 at 02:33:40PM -0800, Linus Torvalds wrote:
> > > On Tue, Jan 26, 2016 at 2:15 PM, Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > >
> > > > You might as well just write it as
> > > >
> > > >     struct foo x = READ_ONCE(*ptr);
> > > >     x->bar = 5;
> > > >
> > > > because that "smp_read_barrier_depends()" does NOTHING wrt the second write.
> > > 
> > > Just to clarify: on alpha it adds a memory barrier, but that memory
> > > barrier is useless.
> > 
> > No trailing data-dependent read, so agreed, no smp_read_barrier_depends()
> > needed.  That said, I believe that we should encourage rcu_dereference*()
> > or lockless_dereference() instead of READ_ONCE() for documentation
> > reasons, though.
> > 
> > > On non-alpha, it is a no-op, and obviously does nothing simply because
> > > it generates no code.
> > > 
> > > So if anybody believes that the "smp_read_barrier_depends()" does
> > > something, they are *wrong*.
> > 
> > The other problem with smp_read_barrier_depends() is that it is often
> > a pain figuring out which prior load it is supposed to apply to.
> > Hence my preference for rcu_dereference*() and lockless_dereference().
> > 
> 
> Because semantically speaking, rcu_derefence*() and
> lockless_dereference() are CONSUME(i.e. data/address dependent
> read->read and read->write pairs are ordered), whereas
> smp_read_barrier_depends() only guarantees read->read pairs with data
> dependency are ordered, right?
> 
> If so, maybe we need to call it out in memory-barriers.txt, for example:
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 904ee42..6b262c2 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -1703,8 +1703,8 @@ There are some more advanced barrier functions:
>  
>  
>   (*) lockless_dereference();
> -     This can be thought of as a pointer-fetch wrapper around the
> -     smp_read_barrier_depends() data-dependency barrier.
> +     This is a load, and any load or store that has a data dependency on the
> +     value returned by this load won't be reordered before this load.

This is a good start, but more is needed to warn people off of
smp_read_barrier_depends().  But yes, better explanation would be good.

							Thanx, Paul

>       This is also similar to rcu_dereference(), but in cases where
>       object lifetime is handled by some mechanism other than RCU, for
> 
> 
> Regards,
> Boqun
> 
> > > And if anybody sends out an email with that smp_read_barrier_depends()
> > > in an example, they are actively just confusing other people, which is
> > > even worse than just being wrong. Which is why I jumped in.
> > > 
> > > So stop perpetuating the myth that smp_read_barrier_depends() does
> > > something here. It does not. It's a bug, and it has become this "mind
> > > virus" for some people that seem to believe that it does something.
> > 
> > It looks like I should add words to memory-barriers.txt de-emphasizing
> > smp_read_barrier_depends().  I will take a look at that.
> > 
> > > I had to remove this crap once from the kernel already, see commit
> > > 105ff3cbf225 ("atomic: remove all traces of READ_ONCE_CTRL() and
> > > atomic*_read_ctrl()").
> > > 
> > > I don't want to ever see that broken construct again. And I want to
> > > make sure that everybody is educated about how broken it was. I'm
> > > extremely unhappy that it came up again.
> > 
> > Well, if it makes you feel better, that was control dependencies and this
> > was data dependencies.  So it was not -exactly- the same.  ;-)
> > 
> > (Sorry, couldn't resist...)
> > 
> > > If it turns out that some architecture does actually need a barrier
> > > between a read and a dependent write, then that will mean that
> > > 
> > >  (a) we'll have to make up a _new_ barrier, because
> > > "smp_read_barrier_depends()" is not that barrier. We'll presumably
> > > then have to make that new barrier part of "rcu_derefence()" and
> > > friends.
> > 
> > Agreed.  We can worry about whether or not we replace the current
> > smp_read_barrier_depends() with that new barrier when and if such
> > hardware appears.
> > 
> > >  (b) we will have found an architecture with even worse memory
> > > ordering semantics than alpha, and we'll have to stop castigating
> > > alpha for being the worst memory ordering ever.
> > 
> > ;-) ;-) ;-)
> > 
> > > but I sincerely hope that we'll never find that kind of broken architecture.
> > 
> > Apparently at least some hardware vendors are reading memory-barriers.txt,
> > so perhaps the odds of that kind of breakage have reduced.
> > 
> > 								Thanx, Paul
> > 
