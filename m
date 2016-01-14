Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jan 2016 22:24:46 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30920 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010191AbcANVYn6gfqA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jan 2016 22:24:43 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id D12CE6EDF794E;
        Thu, 14 Jan 2016 21:24:33 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.235.1; Thu, 14 Jan
 2016 21:24:37 +0000
Received: from [10.20.3.92] (10.20.3.92) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 14 Jan
 2016 13:24:34 -0800
Message-ID: <56981212.7050301@imgtec.com>
Date:   Thu, 14 Jan 2016 13:24:34 -0800
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     <paulmck@linux.vnet.ibm.com>
CC:     Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        <linux-kernel@vger.kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
        <linux-arch@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        <virtualization@lists.linux-foundation.org>,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Joe Perches <joe@perches.com>,
        David Miller <davem@davemloft.net>,
        <linux-ia64@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-s390@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-metag@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <x86@kernel.org>, <user-mode-linux-devel@lists.sourceforge.net>,
        <adi-buildroot-devel@lists.sourceforge.net>,
        <linux-sh@vger.kernel.org>, <linux-xtensa@linux-xtensa.org>,
        <xen-devel@lists.xenproject.org>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>, <ddaney.cavm@gmail.com>,
        <james.hogan@imgtec.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
References: <20160112102555.GV6373@twins.programming.kicks-ass.net> <20160112104012.GW6373@twins.programming.kicks-ass.net> <20160112114111.GB15737@arm.com> <569565DA.2010903@imgtec.com> <20160113104516.GE25458@arm.com> <56969F4B.7070001@imgtec.com> <20160113204844.GV6357@twins.programming.kicks-ass.net> <5696BA6E.4070508@imgtec.com> <20160114120445.GB15828@arm.com> <56980145.5030901@imgtec.com> <20160114204827.GE3818@linux.vnet.ibm.com>
In-Reply-To: <20160114204827.GE3818@linux.vnet.ibm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.92]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51133
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

On 01/14/2016 12:48 PM, Paul E. McKenney wrote:
>
> So SYNC_RMB is intended to implement smp_rmb(), correct?
Yes.
>
> You could use SYNC_ACQUIRE() to implement read_barrier_depends() and
> smp_read_barrier_depends(), but SYNC_RMB probably does not suffice.

If smp_read_barrier_depends() is used to separate not only two reads but 
read pointer and WRITE basing on that pointer (example below) - yes. I 
just doesn't see any example of this in famous 
Documentation/memory-barriers.txt and had no chance to know what you use 
it in this way too.

> The reason for this is that smp_read_barrier_depends() must order the
> pointer load against any subsequent read or write through a dereference
> of that pointer.

I can't see that requirement anywhere in Documents directory. I mean - 
the words "write through a dereference of that pointer" or similar for 
smp_read_barrier_depends.

>    For example:
>
> 	p = READ_ONCE(gp);
> 	smp_rmb();
> 	r1 = p->a; /* ordered by smp_rmb(). */
> 	p->b = 42; /* NOT ordered by smp_rmb(), BUG!!! */
> 	r2 = x; /* ordered by smp_rmb(), but doesn't need to be. */
>
> In contrast:
>
> 	p = READ_ONCE(gp);
> 	smp_read_barrier_depends();
> 	r1 = p->a; /* ordered by smp_read_barrier_depends(). */
> 	p->b = 42; /* ordered by smp_read_barrier_depends(). */
> 	r2 = x; /* not ordered by smp_read_barrier_depends(), which is OK. */
>
> Again, if your hardware maintains local ordering for address
> and data dependencies, you can have read_barrier_depends() and
> smp_read_barrier_depends() be no-ops like they are for most
> architectures.

It is not so simple, I mean "local ordering for address and data 
dependencies". Local ordering is NOT enough. It happens that current 
MIPS R6 doesn't require in your example smp_read_barrier_depends() but 
in discussion it comes out that it may not. Because without 
smp_read_barrier_depends() your example can be a part of Will's 
WRC+addr+addr and we found some design which easily can bump into this 
test. And that design actually performs "local ordering for address and 
data dependencies" too.

- Leonid.
