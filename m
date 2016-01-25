Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2016 17:42:59 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:49686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010210AbcAYQm5gvLJr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jan 2016 17:42:57 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 283493F8;
        Mon, 25 Jan 2016 08:42:10 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A39F33F246;
        Mon, 25 Jan 2016 08:42:45 -0800 (PST)
Date:   Mon, 25 Jan 2016 16:42:43 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
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
Message-ID: <20160125164242.GF22927@arm.com>
References: <20160114121449.GC15828@arm.com>
 <5697F6D2.60409@imgtec.com>
 <20160114203430.GC3818@linux.vnet.ibm.com>
 <56980C91.1010403@imgtec.com>
 <20160114212913.GF3818@linux.vnet.ibm.com>
 <20160115085554.GF3421@worktop>
 <20160115091348.GA27936@worktop>
 <20160115174612.GV3818@linux.vnet.ibm.com>
 <20160115212714.GM3421@worktop>
 <20160115215853.GC3818@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160115215853.GC3818@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <will.deacon@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51354
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

On Fri, Jan 15, 2016 at 01:58:53PM -0800, Paul E. McKenney wrote:
> On Fri, Jan 15, 2016 at 10:27:14PM +0100, Peter Zijlstra wrote:
> > On Fri, Jan 15, 2016 at 09:46:12AM -0800, Paul E. McKenney wrote:
> > > On Fri, Jan 15, 2016 at 10:13:48AM +0100, Peter Zijlstra wrote:
> > 
> > > > And the stuff we're confused about is how best to express the difference
> > > > and guarantees of these two forms of transitivity and how exactly they
> > > > interact.
> > > 
> > > Hoping my memory-barrier.txt patch helps here...
> > 
> > Yes, that seems a good start. But yesterday you raised the 'fun' point
> > of two globally ordered sequences connected by a single local link.
> 
> The conclusion that I am slowly coming to is that litmus tests should
> not be thought of as linear chains, but rather as cycles.  If you think
> of it as a cycle, then it doesn't matter where the local link is, just
> how many of them and how they are connected.

Do you have some examples of this? I'm struggling to make it work in my
mind, or are you talking specifically in the context of the kernel
memory model?

> But I will admit that there are some rather strange litmus tests that
> challenge this cycle-centric view, for example, the one shown below.
> It turns out that herd and ppcmem disagree on the outcome.  (The Power
> architects side with ppcmem.)
> 
> > And I think I'm still confused on LWSYNC (in the smp_wmb case) when one
> > of the stores looses a conflict, and if that scenario matters. If it
> > does, we should inspect the same case for other barriers.
> 
> Indeed.  I am still working on how these should be described.  My
> current thought is to be quite conservative on what ordering is
> actually respected, however, the current task is formalizing how
> RCU plays with the rest of the memory model.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> PPC Overlapping Group-B sets version 4
> ""
> (* When the Group-B sets from two different barriers involve instructions in
>    the same thread, within that thread one set must contain the other.
> 
> 	P0	P1	P2
> 	Rx=1	Wy=1	Wz=2
> 	dep.	lwsync	lwsync
> 	Ry=0	Wz=1	Wx=1
> 	Rz=1
> 
> 	assert(!(z=2))
> 
>    Forbidden by ppcmem, allowed by herd.
> *)
> {
> 0:r1=x; 0:r2=y; 0:r3=z;
> 1:r1=x; 1:r2=y; 1:r3=z; 1:r4=1;
> 2:r1=x; 2:r2=y; 2:r3=z; 2:r4=1; 2:r5=2;
> }
>  P0		| P1		| P2		;
>  lwz r6,0(r1)	| stw r4,0(r2)	| stw r5,0(r3)	;
>  xor r7,r6,r6	| lwsync	| lwsync	;
>  lwzx r7,r7,r2	| stw r4,0(r3)	| stw r4,0(r1)	;
>  lwz r8,0(r3)	|		|		;
> 
> exists
> (z=2 /\ 0:r6=1 /\ 0:r7=0 /\ 0:r8=1)

That really hurts. Assuming that the "assert(!(z=2))" is actually there
to constrain the coherence order of z to be {0->1->2}, then I think that
this test is forbidden on arm using dmb instead of lwsync. That said, I
also don't think the Rz=1 in P0 changes anything.

The double negatives don't help here! (it is forbidden to guarantee that
z is not always 2).

Will
