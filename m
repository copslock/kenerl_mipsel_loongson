Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2016 23:00:49 +0100 (CET)
Received: from e34.co.us.ibm.com ([32.97.110.152]:59295 "EHLO
        e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010860AbcAZV77sw9Mi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2016 22:59:59 +0100
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Jan 2016 14:59:53 -0700
Received: from d03dlp02.boulder.ibm.com (9.17.202.178)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Tue, 26 Jan 2016 14:59:50 -0700
X-IBM-Helo: d03dlp02.boulder.ibm.com
X-IBM-MailFrom: paulmck@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org;ralf@linux-mips.org
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 6AAF03E40030;
        Tue, 26 Jan 2016 14:59:50 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u0QLxoPi23593214;
        Tue, 26 Jan 2016 14:59:50 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u0QLxXKw008507;
        Tue, 26 Jan 2016 14:59:46 -0700
Received: from paulmck-ThinkPad-W541 (paulmck-thinkpad-w541.au.ibm.com [9.192.250.130])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u0QLxWmq008429;
        Tue, 26 Jan 2016 14:59:32 -0700
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 65A9416C1EDE; Tue, 26 Jan 2016 11:51:04 -0800 (PST)
Date:   Tue, 26 Jan 2016 11:51:04 -0800
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Leonid.Yegoshin@imgtec.com, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org, mst@redhat.com, peterz@infradead.org,
        will.deacon@arm.com, virtualization@lists.linux-foundation.org,
        hpa@zytor.com, sparclinux@vger.kernel.org, mingo@kernel.org,
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
Message-ID: <20160126195104.GR4503@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20160114204827.GE3818@linux.vnet.ibm.com>
 <20160118081929.GA30420@gondor.apana.org.au>
 <20160118154629.GB3818@linux.vnet.ibm.com>
 <20160126165207.GB6029@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160126165207.GB6029@fixme-laptop.cn.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16012621-0017-0000-0000-000011879FF6
Return-Path: <paulmck@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51435
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

On Wed, Jan 27, 2016 at 12:52:07AM +0800, Boqun Feng wrote:
> Hi Paul,
> 
> On Mon, Jan 18, 2016 at 07:46:29AM -0800, Paul E. McKenney wrote:
> > On Mon, Jan 18, 2016 at 04:19:29PM +0800, Herbert Xu wrote:
> > > Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> > > >
> > > > You could use SYNC_ACQUIRE() to implement read_barrier_depends() and
> > > > smp_read_barrier_depends(), but SYNC_RMB probably does not suffice.
> > > > The reason for this is that smp_read_barrier_depends() must order the
> > > > pointer load against any subsequent read or write through a dereference
> > > > of that pointer.  For example:
> > > > 
> > > >        p = READ_ONCE(gp);
> > > >        smp_rmb();
> > > >        r1 = p->a; /* ordered by smp_rmb(). */
> > > >        p->b = 42; /* NOT ordered by smp_rmb(), BUG!!! */
> > > >        r2 = x; /* ordered by smp_rmb(), but doesn't need to be. */
> > > > 
> > > > In contrast:
> > > > 
> > > >        p = READ_ONCE(gp);
> > > >        smp_read_barrier_depends();
> > > >        r1 = p->a; /* ordered by smp_read_barrier_depends(). */
> > > >        p->b = 42; /* ordered by smp_read_barrier_depends(). */
> > > >        r2 = x; /* not ordered by smp_read_barrier_depends(), which is OK. */
> > > > 
> > > > Again, if your hardware maintains local ordering for address
> > > > and data dependencies, you can have read_barrier_depends() and
> > > > smp_read_barrier_depends() be no-ops like they are for most
> > > > architectures.
> > > > 
> > > > Does that help?
> > > 
> > > This is crazy! smp_rmb started out being strictly stronger than
> > > smp_read_barrier_depends, when did this stop being the case?
> > 
> > Hello, Herbert!
> > 
> > It is true that most Linux kernel code relies only on the read-read
> > properties of dependencies, but the read-write properties are useful.
> > Admittedly relatively rarely, but useful.
> > 
> > The better comparison for smp_read_barrier_depends(), especially in
> > its rcu_dereference*() form, is smp_load_acquire().
> 
> Confused..
> 
> I recall that last time you and Linus came into a conclusion that even
> on Alpha, a barrier for read->write with data dependency is unnecessary:
> 
> http://article.gmane.org/gmane.linux.kernel/2077661
> 
> And in an earlier mail of that thread, Linus made his point that
> smp_read_barrier_depends() should only be used to order read->read.

Those examples involved read-to-write with conditionals, as in:

	if (READ_ONCE(a))
		WRITE_ONCE(b, 1);

Without the "if", no ordering is guaranteed on weakly ordered CPUs.
(The volatile accesses keep ordering within the compiler for once...

> So right now, are we going to extend the semantics of
> smp_read_barrier_depends()? Can we just make smp_read_barrier_depends()
> still only work for read->read, and assume all the architectures won't
> reorder read->write with data dependency, so that the code above having
> a smp_rmb() also works?

The semantics of smp_read_barrier_depends() has been both read-to-write
and read-to-read for some time now, this patch just catches the
documentation up with reality.

							Thanx, Paul
