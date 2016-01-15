Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jan 2016 18:54:27 +0100 (CET)
Received: from e38.co.us.ibm.com ([32.97.110.159]:43792 "EHLO
        e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009986AbcAORyVwWrEJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jan 2016 18:54:21 +0100
Received: from localhost
        by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 15 Jan 2016 10:54:15 -0700
Received: from d03dlp01.boulder.ibm.com (9.17.202.177)
        by e38.co.us.ibm.com (192.168.1.138) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Fri, 15 Jan 2016 10:54:13 -0700
X-IBM-Helo: d03dlp01.boulder.ibm.com
X-IBM-MailFrom: paulmck@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org;ralf@linux-mips.org
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 342821FF0051;
        Fri, 15 Jan 2016 10:42:23 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u0FHsC3j28246142;
        Fri, 15 Jan 2016 10:54:12 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u0FHs3iP011764;
        Fri, 15 Jan 2016 10:54:12 -0700
Received: from paulmck-ThinkPad-W541 ([9.70.82.27])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u0FHrwDi011453;
        Fri, 15 Jan 2016 10:53:59 -0700
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 52FD316C0BB3; Fri, 15 Jan 2016 09:54:01 -0800 (PST)
Date:   Fri, 15 Jan 2016 09:54:01 -0800
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        virtualization@lists.linux-foundation.org,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Joe Perches <joe@perches.com>,
        David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        xen-devel@lists.xenproject.org, Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>, ddaney.cavm@gmail.com,
        james.hogan@imgtec.com, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Message-ID: <20160115175401.GW3818@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20160113104516.GE25458@arm.com>
 <5696CF08.8080700@imgtec.com>
 <20160114121449.GC15828@arm.com>
 <5697F6D2.60409@imgtec.com>
 <20160114203430.GC3818@linux.vnet.ibm.com>
 <56980C91.1010403@imgtec.com>
 <20160114212913.GF3818@linux.vnet.ibm.com>
 <569814F2.50801@imgtec.com>
 <20160114225510.GJ3818@linux.vnet.ibm.com>
 <20160115102431.GB2131@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160115102431.GB2131@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16011517-0029-0000-0000-00000FA8AA70
Return-Path: <paulmck@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51155
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

On Fri, Jan 15, 2016 at 10:24:32AM +0000, Will Deacon wrote:
> On Thu, Jan 14, 2016 at 02:55:10PM -0800, Paul E. McKenney wrote:
> > On Thu, Jan 14, 2016 at 01:36:50PM -0800, Leonid Yegoshin wrote:
> > > On 01/14/2016 01:29 PM, Paul E. McKenney wrote:
> > > >
> > > >>On 01/14/2016 12:34 PM, Paul E. McKenney wrote:
> > > >>>
> > > >>>The WRC+addr+addr is OK because data dependencies are not required to be
> > > >>>transitive, in other words, they are not required to flow from one CPU to
> > > >>>another without the help of an explicit memory barrier.
> > > >>I don't see any reliable way to fit WRC+addr+addr into "DATA
> > > >>DEPENDENCY BARRIERS" section recommendation to have data dependency
> > > >>barrier between read of a shared pointer/index and read the shared
> > > >>data based on that pointer. If you have this two reads, it doesn't
> > > >>matter the rest of scenario, you should put the dependency barrier
> > > >>in code anyway. If you don't do it in WRC+addr+addr scenario then
> > > >>after years it can be easily changed to different scenario which
> > > >>fits some of scenario in "DATA DEPENDENCY BARRIERS" section and
> > > >>fails.
> > > >The trick is that lockless_dereference() contains an
> > > >smp_read_barrier_depends():
> > > >
> > > >#define lockless_dereference(p) \
> > > >({ \
> > > >	typeof(p) _________p1 = READ_ONCE(p); \
> > > >	smp_read_barrier_depends(); /* Dependency order vs. p above. */ \
> > > >	(_________p1); \
> > > >})
> > > >
> > > >Or am I missing your point?
> > > 
> > > WRC+addr+addr has no any barrier. lockless_dereference() has a
> > > barrier. I don't see a common points between this and that in your
> > > answer, sorry.
> > 
> > Me, I am wondering what WRC+addr+addr has to do with anything at all.
> 
> See my earlier reply [1] (but also, your WRC Linux example looks more
> like a variant on WWC and I couldn't really follow it).

I will revisit my WRC Linux example.  And yes, creating litmus tests
that use non-fake dependencies is still a bit of an undertaking.  :-/
I am sure that it will seem more natural with time and experience...

> > <Going back through earlier email>
> > 
> > OK, so it looks like Will was asking not about WRC+addr+addr, but instead
> > about WRC+sync+addr.  This would drop an smp_mb() into cpu2() in my
> > earlier example, which needs to provide ordering.
> > 
> > I am guessing that the manual's "Older instructions which must be globally
> > performed when the SYNC instruction completes" provides the equivalent
> > of ARM/Power A-cumulativity, which can be thought of as transitivity
> > backwards in time. 
> 
> I couldn't make that leap. In particular, the manual's "Detailed
> Description" sections explicitly refer to program-order:
> 
>   Every synchronizable specified memory instruction (loads or stores or
>   both) that occurs in the instruction stream before the SYNC
>   instruction must reach a stage in the load/store datapath after which
>   no instruction re-ordering is possible before any synchronizable
>   specified memory instruction which occurs after the SYNC instruction
>   in the instruction stream reaches the same stage in the load/store
>   datapath.
> 
> Will
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/399765.html

All good points.  I think we all agree that the MIPS documentation could
use significant help.  And given that I work for the company that produced
the analogous documentation for PowerPC, that is saying something.  ;-)

We simply can't know if MIPS's memory ordering is sufficient for the
Linux kernel given its current implementation of the ordering primitives
and its current documentation.

I feel a bit better than I did earlier due to Leonid's response to my
earlier litmus-test examples.  But I do recommend some serious stress
testing of MIPS on a good set of litmus tests.  Much nicer finding issues
that way than as random irreproducible strange behavior!

							Thanx, Paul
