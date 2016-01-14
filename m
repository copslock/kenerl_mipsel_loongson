Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jan 2016 21:34:51 +0100 (CET)
Received: from e38.co.us.ibm.com ([32.97.110.159]:51726 "EHLO
        e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008357AbcANUetQyW4p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jan 2016 21:34:49 +0100
Received: from localhost
        by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 14 Jan 2016 13:34:42 -0700
Received: from d03dlp03.boulder.ibm.com (9.17.202.179)
        by e38.co.us.ibm.com (192.168.1.138) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 14 Jan 2016 13:34:41 -0700
X-IBM-Helo: d03dlp03.boulder.ibm.com
X-IBM-MailFrom: paulmck@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org;ralf@linux-mips.org
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 5C21A19D8051;
        Thu, 14 Jan 2016 13:22:42 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u0EKYeS330998772;
        Thu, 14 Jan 2016 13:34:40 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u0EKYVhT004078;
        Thu, 14 Jan 2016 13:34:40 -0700
Received: from paulmck-ThinkPad-W541 ([9.70.82.27])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u0EKYS9s003917;
        Thu, 14 Jan 2016 13:34:29 -0700
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 65DC716C192E; Thu, 14 Jan 2016 12:34:30 -0800 (PST)
Date:   Thu, 14 Jan 2016 12:34:30 -0800
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     Will Deacon <will.deacon@arm.com>,
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
Message-ID: <20160114203430.GC3818@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <56945366.2090504@imgtec.com>
 <20160112092711.GP6344@twins.programming.kicks-ass.net>
 <20160112102555.GV6373@twins.programming.kicks-ass.net>
 <20160112104012.GW6373@twins.programming.kicks-ass.net>
 <20160112114111.GB15737@arm.com>
 <569565DA.2010903@imgtec.com>
 <20160113104516.GE25458@arm.com>
 <5696CF08.8080700@imgtec.com>
 <20160114121449.GC15828@arm.com>
 <5697F6D2.60409@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5697F6D2.60409@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16011420-0029-0000-0000-00000FA25885
Return-Path: <paulmck@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51127
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

On Thu, Jan 14, 2016 at 11:28:18AM -0800, Leonid Yegoshin wrote:
> On 01/14/2016 04:14 AM, Will Deacon wrote:
> >On Wed, Jan 13, 2016 at 02:26:16PM -0800, Leonid Yegoshin wrote:
> >
> >>     Moreover, there are voices against guarantee that it will be in future
> >>and that voices point me to Documentation/memory-barriers.txt section "DATA
> >>DEPENDENCY BARRIERS" examples which require SYNC_RMB between loading
> >>address/index and using that for loading data based on that address or index
> >>for shared data (look on CPU2 pseudo-code):
> >>>To deal with this, a data dependency barrier or better must be inserted
> >>>between the address load and the data load:
> >>>
> >>>        CPU 1                 CPU 2
> >>>        ===============       ===============
> >>>        { A == 1, B == 2, C = 3, P == &A, Q == &C }
> >>>        B = 4;
> >>>        <write barrier>
> >>>        WRITE_ONCE(P, &B);
> >>>                              Q = READ_ONCE(P);
> >>>                              <data dependency barrier> <-----------
> >>>SYNC_RMB is here
> >>>                              D = *Q;
> >>...
> >>>Another example of where data dependency barriers might be required is
> >>>where a
> >>>number is read from memory and then used to calculate the index for an
> >>>array
> >>>access:
> >>>
> >>>        CPU 1                 CPU 2
> >>>        ===============       ===============
> >>>        { M[0] == 1, M[1] == 2, M[3] = 3, P == 0, Q == 3 }
> >>>        M[1] = 4;
> >>>        <write barrier>
> >>>        WRITE_ONCE(P, 1);
> >>>                              Q = READ_ONCE(P);
> >>>                              <data dependency barrier> <------------
> >>>SYNC_RMB is here
> >>>                              D = M[Q];
> >>That voices say that there is a legitimate reason to relax HW here for
> >>performance if SYNC_RMB is needed anyway to work with this sequence of
> >>shared data.
> >Are you saying that MIPS needs to implement [smp_]read_barrier_depends?
> 
> It is not me, it is Documentation/memory-barriers.txt from kernel sources.
> 
> HW team can't work on voice statements, it should do a work on
> written documents. If that is written (see above the lines which I
> marked by "SYNC_RMB") then anybody should use it and never mind how
> many CPUs/Threads are in play. This examples explicitly requires to
> insert "data dependency barrier" between reading a shared
> pointer/index and using it to fetch a shared data. So, your
> WRC+addr+addr test is a violation of that recommendation.

Perhaps Documentation/memory-barriers.txt needs additional clarification.
It would not be the first time.

If your CPU implicitly maintains ordering based on address and
data dependencies, then you don't need any instructions for
<data dependency barrier>.

The WRC+addr+addr is OK because data dependencies are not required to be
transitive, in other words, they are not required to flow from one CPU to
another without the help of an explicit memory barrier.  Transitivity is
instead supplied by smp_mb() and by smp_store_release()-smp_load_acquire()
chains.  Here is the Linux kernel code for WRC+addr+addr, give or take
(and no, I have no idea why anyone would want to write code like this):

	struct foo {
		struct foo **a;
	};
	struct foo b;
	struct foo c;
	struct foo d;
	struct foo e;
	struct foo f = { &d };
	struct foo g = { &e };
	struct foo *x = &b;

	void cpu0(void)
	{
		WRITE_ONCE(x, &f);
	}

	void cpu1(void)
	{
		struct foo *p;

		p = lockless_dereference(x);
		WRITE_ONCE(p->a, &x);
	}

	void cpu2(void)
	{
		r1 = lockless_dereference(f.a);
		WRITE_ONCE(*r1, &c);
	}

It is legal to end the run with x==&f and r1==&x.  To prevent this outcome,
we do the following:

	struct foo {
		struct foo **a;
	};
	struct foo b;
	struct foo c;
	struct foo d;
	struct foo e;
	struct foo f = { &d };
	struct foo g = { &e };
	struct foo *x = &b;

	void cpu0(void)
	{
		WRITE_ONCE(x, &f);
	}

	void cpu1(void)
	{
		struct foo *p;

		p = lockless_dereference(x);
		smp_store_release(&p->a, &x); /* Additional ordering. */
	}

	void cpu2(void)
	{
		r1 = lockless_dereference(f.a);
		WRITE_ONCE(*r1, &c);
	}

And I still don't know why anyone would need this sort of code.  ;-)

Alternatively, we pull cpu2() into cpu1():

	struct foo {
		struct foo **a;
	};
	struct foo b;
	struct foo c;
	struct foo d;
	struct foo e;
	struct foo f = { &d };
	struct foo g = { &e };
	struct foo *x = &b;

	void cpu0(void)
	{
		WRITE_ONCE(x, &f);
	}

	void cpu1(void)
	{
		struct foo *p;

		p = lockless_dereference(x);
		WRITE_ONCE(p->a, &x);
		r1 = lockless_dereference(f.a);
		WRITE_ONCE(*r1, &c);
	}

The ordering is now enforced by being within a single thread.  In fact,
the second lockless_dereference() can be READ_ONCE().

So, does MIPS maintain ordering within a given CPU based on address and
data dependencies?  If so, you don't need to emit memory-barrier instructions
for read_barrier_depends().

							Thanx, Paul
