Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jan 2016 22:29:34 +0100 (CET)
Received: from e33.co.us.ibm.com ([32.97.110.151]:51590 "EHLO
        e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010191AbcANV3c5cpS7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jan 2016 22:29:32 +0100
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 14 Jan 2016 14:29:26 -0700
Received: from d03dlp03.boulder.ibm.com (9.17.202.179)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 14 Jan 2016 14:29:23 -0700
X-IBM-Helo: d03dlp03.boulder.ibm.com
X-IBM-MailFrom: paulmck@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org;ralf@linux-mips.org
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id A51A619D8026;
        Thu, 14 Jan 2016 14:17:24 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u0ELTNqL27394074;
        Thu, 14 Jan 2016 14:29:23 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u0ELTCdJ000307;
        Thu, 14 Jan 2016 14:29:22 -0700
Received: from paulmck-ThinkPad-W541 ([9.70.82.27])
        by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u0ELTBR8032741;
        Thu, 14 Jan 2016 14:29:12 -0700
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7664716C05D5; Thu, 14 Jan 2016 13:29:13 -0800 (PST)
Date:   Thu, 14 Jan 2016 13:29:13 -0800
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
Message-ID: <20160114212913.GF3818@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20160112102555.GV6373@twins.programming.kicks-ass.net>
 <20160112104012.GW6373@twins.programming.kicks-ass.net>
 <20160112114111.GB15737@arm.com>
 <569565DA.2010903@imgtec.com>
 <20160113104516.GE25458@arm.com>
 <5696CF08.8080700@imgtec.com>
 <20160114121449.GC15828@arm.com>
 <5697F6D2.60409@imgtec.com>
 <20160114203430.GC3818@linux.vnet.ibm.com>
 <56980C91.1010403@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56980C91.1010403@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16011421-0009-0000-0000-0000116CB6FB
Return-Path: <paulmck@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51134
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

On Thu, Jan 14, 2016 at 01:01:05PM -0800, Leonid Yegoshin wrote:
> I need some time to understand your test examples. However,

Understood.

> On 01/14/2016 12:34 PM, Paul E. McKenney wrote:
> >
> >
> >The WRC+addr+addr is OK because data dependencies are not required to be
> >transitive, in other words, they are not required to flow from one CPU to
> >another without the help of an explicit memory barrier.
> 
> I don't see any reliable way to fit WRC+addr+addr into "DATA
> DEPENDENCY BARRIERS" section recommendation to have data dependency
> barrier between read of a shared pointer/index and read the shared
> data based on that pointer. If you have this two reads, it doesn't
> matter the rest of scenario, you should put the dependency barrier
> in code anyway. If you don't do it in WRC+addr+addr scenario then
> after years it can be easily changed to different scenario which
> fits some of scenario in "DATA DEPENDENCY BARRIERS" section and
> fails.

The trick is that lockless_dereference() contains an
smp_read_barrier_depends():

#define lockless_dereference(p) \
({ \
	typeof(p) _________p1 = READ_ONCE(p); \
	smp_read_barrier_depends(); /* Dependency order vs. p above. */ \
	(_________p1); \
})

Or am I missing your point?

> >   Transitivity is
> 
> Peter Zijlstra recently wrote: "In particular we're very much all
> 'confused' about the various notions of transitivity". I am confused
> too, so - please use some more simple way to explain your words.
> Sorry, but we need a common ground first.

OK, how about an example?  (Z6.3 in the ppcmem naming scheme.)

	int x, y, z;

	void cpu0(void)
	{
		WRITE_ONCE(x, 1);
		smp_wmb();
		WRITE_ONCE(y, 1);
	}

	void cpu1(void)
	{
		WRITE_ONCE(y, 2);
		smp_wmb();
		WRITE_ONCE(z, 1);
	}

	void cpu2(void)
	{
		r1 = READ_ONCE(z);
		smp_rmb();
		r2 = read_once(x);
	}

If smp_rmb() and smp_wmb() provided transitive ordering, then cpu2()
would see cpu0()'s ordering.  But they do not, so the ordering is
visible at best to the adjacent CPU.  This means that the final value
of y can be 2, while at the same time r1==1 && r2==0.

Now the full barrier, smp_mb(), does provide transitive ordering,
so if the three barriers in the above example are replaced with
smp_mb() the y==2 && r1==1 && r2==0 outcome will be prohibited.

So smp_mb() provides transitivity, as do pairs of smp_store_release()
and smp_read_acquire(), as do RCU grace periods.  The exact interactions
between transitive and non-transitive ordering is a work in progress.
That said, if a series of transitive segments ends in a write, which
connects to a single non-transitive segment starting with a read,
you should be good.  And in fact in the example above, you can replace
the smp_wmb()s with smp_mb() and leave the smp_rmb() and still
prohibit the "cyclic" outcome.

If you want a more formal definition, I must refer you back to the
ppcmem and herd references.

Does that help?

							Thanx, Paul
