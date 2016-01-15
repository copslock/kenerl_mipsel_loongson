Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jan 2016 19:54:43 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:43377 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009964AbcAOSylT6qPd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jan 2016 19:54:41 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id D05552A5FE5;
        Fri, 15 Jan 2016 18:54:31 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.235.1; Fri, 15 Jan
 2016 18:54:34 +0000
Received: from [10.20.3.92] (10.20.3.92) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 15 Jan
 2016 10:54:32 -0800
Message-ID: <56994068.4050402@imgtec.com>
Date:   Fri, 15 Jan 2016 10:54:32 -0800
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
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
References: <569565DA.2010903@imgtec.com> <20160113104516.GE25458@arm.com> <56969F4B.7070001@imgtec.com> <20160113204844.GV6357@twins.programming.kicks-ass.net> <5696BA6E.4070508@imgtec.com> <20160114120445.GB15828@arm.com> <56980145.5030901@imgtec.com> <20160114204827.GE3818@linux.vnet.ibm.com> <56981212.7050301@imgtec.com> <20160114222046.GH3818@linux.vnet.ibm.com> <20160115095756.GA2131@arm.com>
In-Reply-To: <20160115095756.GA2131@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.92]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51159
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

On 01/15/2016 01:57 AM, Will Deacon wrote:
> Paul,
>
>
> I think you figured this out while I was sleeping, but just to confirm:
>
>   1. The MIPS64 ISA doc [1] talks about SYNC in a way that applies only
>      to memory accesses appearing in *program-order* before the SYNC
>
>   2. We need WRC+sync+addr to work, which means that the SYNC in P1 must
>      also capture the store in P0 as being "before" the barrier. Leonid
>      reckons it works, but his explanation [2] focussed on the address
>      dependency in P2 as to why this works. If that is the case (i.e.
>      address dependency provides global transitivity), then WRC+addr+addr
>      should also work (even though its not required).

No, it is not correct. There is one old design which provides access to 
core (thread0 + thread1) write-buffers for threads load in advance of it 
is visible to other cores. It means, that WRC+sync+addr passes because 
of SYNC in write thread and register dependency inside other thread but 
WRC+addr+addr may fail because other core may get a stale data.

>
>   3. It seems that WRC+addr+addr doesn't work, so I'm still suspicious
>      about WRC+sync+addr, because neither the architecture document or
>      Leonid's explanation tell me that it should be forbidden.
>
> Will
>
> [1] https://imgtec.com/?do-download=4302
> [2] http://lkml.kernel.org/r/569565DA.2010903@imgtec.com (scroll to the end)
