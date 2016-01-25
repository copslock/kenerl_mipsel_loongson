Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2016 19:03:18 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:50635 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011406AbcAYSDKo2wCp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jan 2016 19:03:10 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 282C949;
        Mon, 25 Jan 2016 10:02:23 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7C563F24D;
        Mon, 25 Jan 2016 10:02:58 -0800 (PST)
Date:   Mon, 25 Jan 2016 18:02:34 +0000
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
Message-ID: <20160125180234.GA26732@arm.com>
References: <569565DA.2010903@imgtec.com>
 <20160113104516.GE25458@arm.com>
 <5696CF08.8080700@imgtec.com>
 <20160114121449.GC15828@arm.com>
 <5697F6D2.60409@imgtec.com>
 <20160114203430.GC3818@linux.vnet.ibm.com>
 <56980C91.1010403@imgtec.com>
 <20160114212913.GF3818@linux.vnet.ibm.com>
 <20160115085554.GF3421@worktop>
 <20160115173912.GU3818@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160115173912.GU3818@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <will.deacon@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51356
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

Hi Paul,

On Fri, Jan 15, 2016 at 09:39:12AM -0800, Paul E. McKenney wrote:
> On Fri, Jan 15, 2016 at 09:55:54AM +0100, Peter Zijlstra wrote:
> > On Thu, Jan 14, 2016 at 01:29:13PM -0800, Paul E. McKenney wrote:
> > > So smp_mb() provides transitivity, as do pairs of smp_store_release()
> > > and smp_read_acquire(), 
> > 
> > But they provide different grades of transitivity, which is where all
> > the confusion lays.
> > 
> > smp_mb() is strongly/globally transitive, all CPUs will agree on the order.
> > 
> > Whereas the RCpc release+acquire is weakly so, only the two cpus
> > involved in the handover will agree on the order.
> 
> Good point!
> 
> Using grace periods in place of smp_mb() also provides strong/global
> transitivity, but also insanely high latencies.  ;-)
> 
> The patch below updates Documentation/memory-barriers.txt to define
> local vs. global transitivity.  The corresponding ppcmem litmus test
> is included below as well.
> 
> Should we start putting litmus tests for the various examples
> somewhere, perhaps in a litmus-tests directory within each participating
> architecture?  I have a pile of powerpc-related litmus tests on my laptop,
> but they probably aren't doing all that much good there.

I too would like to have the litmus tests in the kernel so that we can
refer to them from memory-barriers.txt. Ideally they wouldn't be targetted
to a particular arch, however.

> PPC local-transitive
> ""
> {
> 0:r1=1; 0:r2=u; 0:r3=v; 0:r4=x; 0:r5=y; 0:r6=z;
> 1:r1=1; 1:r2=u; 1:r3=v; 1:r4=x; 1:r5=y; 1:r6=z;
> 2:r1=1; 2:r2=u; 2:r3=v; 2:r4=x; 2:r5=y; 2:r6=z;
> 3:r1=1; 3:r2=u; 3:r3=v; 3:r4=x; 3:r5=y; 3:r6=z;
> }
>  P0           | P1           | P2           | P3           ;
>  lwz r9,0(r4) | lwz r9,0(r5) | lwz r9,0(r6) | stw r1,0(r3) ;
>  lwsync       | lwsync       | lwsync       | sync         ;
>  stw r1,0(r2) | lwz r8,0(r3) | stw r1,0(r7) | lwz r9,0(r2) ;
>  lwsync       | lwz r7,0(r2) |              |              ;
>  stw r1,0(r5) | lwsync       |              |              ;
>               | stw r1,0(r6) |              |              ;
> exists
> (* (0:r9=0 /\ 1:r9=1 /\ 2:r9=1 /\ 1:r8=0 /\ 3:r9=0) *)
> (* (0:r9=1 /\ 1:r9=1 /\ 2:r9=1) *)
> (* (0:r9=0 /\ 1:r9=1 /\ 2:r9=1 /\ 1:r7=0) *)
> (0:r9=0 /\ 1:r9=1 /\ 2:r9=1 /\ 1:r7=0)

i.e. we should rewrite this using READ_ONCE/WRITE_ONCE and smp_mb() etc.

> ------------------------------------------------------------------------
> 
> commit 2cb4e83a1b5c89c8e39b8a64bd89269d05913e41
> Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Date:   Fri Jan 15 09:30:42 2016 -0800
> 
>     documentation: Distinguish between local and global transitivity
>     
>     The introduction of smp_load_acquire() and smp_store_release() had
>     the side effect of introducing a weaker notion of transitivity:
>     The transitivity of full smp_mb() barriers is global, but that
>     of smp_store_release()/smp_load_acquire() chains is local.  This
>     commit therefore introduces the notion of local transitivity and
>     gives an example.
>     
>     Reported-by: Peter Zijlstra <peterz@infradead.org>
>     Reported-by: Will Deacon <will.deacon@arm.com>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index c66ba46d8079..d8109ed99342 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -1318,8 +1318,82 @@ or a level of cache, CPU 2 might have early access to CPU 1's writes.
>  General barriers are therefore required to ensure that all CPUs agree
>  on the combined order of CPU 1's and CPU 2's accesses.
>  
> -To reiterate, if your code requires transitivity, use general barriers
> -throughout.
> +General barriers provide "global transitivity", so that all CPUs will
> +agree on the order of operations.  In contrast, a chain of release-acquire
> +pairs provides only "local transitivity", so that only those CPUs on
> +the chain are guaranteed to agree on the combined order of the accesses.

Thanks for having a go at this. I tried defining something axiomatically,
but got stuck pretty quickly. In my scheme, I used "data-directed
transitivity" instead of "local transitivity", since the latter seems to
be a bit of a misnomer.

> +For example, switching to C code in deference to Herman Hollerith:
> +
> +	int u, v, x, y, z;
> +
> +	void cpu0(void)
> +	{
> +		r0 = smp_load_acquire(&x);
> +		WRITE_ONCE(u, 1);
> +		smp_store_release(&y, 1);
> +	}
> +
> +	void cpu1(void)
> +	{
> +		r1 = smp_load_acquire(&y);
> +		r4 = READ_ONCE(v);
> +		r5 = READ_ONCE(u);
> +		smp_store_release(&z, 1);
> +	}
> +
> +	void cpu2(void)
> +	{
> +		r2 = smp_load_acquire(&z);
> +		smp_store_release(&x, 1);
> +	}
> +
> +	void cpu3(void)
> +	{
> +		WRITE_ONCE(v, 1);
> +		smp_mb();
> +		r3 = READ_ONCE(u);
> +	}
> +
> +Because cpu0(), cpu1(), and cpu2() participate in a local transitive
> +chain of smp_store_release()/smp_load_acquire() pairs, the following
> +outcome is prohibited:
> +
> +	r0 == 1 && r1 == 1 && r2 == 1
> +
> +Furthermore, because of the release-acquire relationship between cpu0()
> +and cpu1(), cpu1() must see cpu0()'s writes, so that the following
> +outcome is prohibited:
> +
> +	r1 == 1 && r5 == 0
> +
> +However, the transitivity of release-acquire is local to the participating
> +CPUs and does not apply to cpu3().  Therefore, the following outcome
> +is possible:
> +
> +	r0 == 0 && r1 == 1 && r2 == 1 && r3 == 0 && r4 == 0

I think you should be completely explicit and include r5 == 1 here, too.

Also -- where would you add the smp_mb__after_release_acquire to fix
(i.e. forbid) this? Immediately after cpu1()'s read of y?

> +Although cpu0(), cpu1(), and cpu2() will see their respective reads and
> +writes in order, CPUs not involved in the release-acquire chain might
> +well disagree on the order.  This disagreement stems from the fact that
> +the weak memory-barrier instructions used to implement smp_load_acquire()
> +and smp_store_release() are not required to order prior stores against
> +subsequent loads in all cases.  This means that cpu3() can see cpu0()'s
> +store to u as happening -after- cpu1()'s load from v, even though
> +both cpu0() and cpu1() agree that these two operations occurred in the
> +intended order.
> +
> +However, please keep in mind that smp_load_acquire() is not magic.
> +In particular, it simply reads from its argument with ordering.  It does
> +-not- ensure that any particular value will be read.  Therefore, the
> +following outcome is possible:
> +
> +	r0 == 0 && r1 == 0 && r2 == 0 && r5 == 0
> +
> +Note that this outcome can happen even on a mythical sequentially
> +consistent system where nothing is ever reordered.

I'm not sure this last bit is strictly necessary. If somebody thinks that
acquire/release involve some sort of implicit synchronisation, I think
they may have bigger problems with memory-barriers.txt.

Will
