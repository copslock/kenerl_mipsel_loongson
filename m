Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jan 2016 22:45:55 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13291 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010028AbcANVpxSpVr7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jan 2016 22:45:53 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id DC42A33253B75;
        Thu, 14 Jan 2016 21:45:42 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (TLS) id 14.3.235.1; Thu, 14 Jan
 2016 21:45:46 +0000
Received: from [10.20.3.92] (10.20.3.92) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 14 Jan
 2016 13:45:44 -0800
Message-ID: <56981708.4000007@imgtec.com>
Date:   Thu, 14 Jan 2016 13:45:44 -0800
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     <paulmck@linux.vnet.ibm.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
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
References: <569565DA.2010903@imgtec.com> <20160113104516.GE25458@arm.com> <56969F4B.7070001@imgtec.com> <20160113204844.GV6357@twins.programming.kicks-ass.net> <5696BA6E.4070508@imgtec.com> <20160114120445.GB15828@arm.com> <20160114161604.GT3818@linux.vnet.ibm.com> <5697FA0A.6040601@imgtec.com> <20160114201513.GI6357@twins.programming.kicks-ass.net> <56980933.2020801@imgtec.com> <20160114213440.GG3818@linux.vnet.ibm.com>
In-Reply-To: <20160114213440.GG3818@linux.vnet.ibm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.92]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51137
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

On 01/14/2016 01:34 PM, Paul E. McKenney wrote:
> On Thu, Jan 14, 2016 at 12:46:43PM -0800, Leonid Yegoshin wrote:
>> On 01/14/2016 12:15 PM, Peter Zijlstra wrote:
>>> On Thu, Jan 14, 2016 at 11:42:02AM -0800, Leonid Yegoshin wrote:
>>>> An the only point - please use an appropriate SYNC_* barriers instead of
>>>> heavy bold hammer. That stuff was design explicitly to support the
>>>> requirements of Documentation/memory-barriers.txt
>>> That's madness. That document changes from version to version as to what
>>> we _think_ the actual hardware does. It is _NOT_ a specification.
>>>
>>> You cannot design hardware from that. Its incomplete and fails to
>>> specify a bunch of things. It not a mathematically sound definition of a
>>> memory model.
>>>
>>> Please stop referring to that document for what a particular barrier
>>> _should_ do.  Explain what MIPS does, so we can attempt to integrate
>>> this knowledge with our knowledge of PPC/ARM/Alpha/x86/etc. and improve
>>> upon our understanding of hardware and improve the Linux memory model.
>> I am afraid I can't help you here. It is very complicated stuff and
>> a model is actually doesn't fit your assumptions about CPUs well
>> without some simplifications which are based on what you want to
>> have.
>>
>> I say that SYNC_ACQUIRE/etc follows what you expect for smp_acquire
>> etc (basing on that document). And at least two CPU models were
>> tested with my patches (see it in LMO) for that last year and that
>> instructions are implemented now in engineering kernel.
>>
>> If you have something else in mind, you can ask me. But I prefer to
>> do not deviate too much from Documentation/memory-barriers.txt, for
>> exam - if it asks to have memory barrier somewhere, then I assume
>> the code should have it, and please - don't ask me a test which
>> violates the current version of document recommendations.
>>
>> For a moment I don't see a significant changes in this document for
>> MIPS Arch at least 1.5 year, and the only significant point is that
>> MIPS CPU Arch doesn't have yet smp_read_barrier_depends() and
>> smp_rmb() should be used instead.
> Is SYNC_ACQUIRE a memory-barrier instruction that orders prior loads
> against later loads and stores?

Yes, it is in MD00087 (table 6.6 of document Ver 6.04) - 
https://imgtec.com/?do-download=4302

>    If so, and if MIPS does not do
> ordering based on address and data dependencies, I suggest making
> read_barrier_depends() be a SYNC_ACQUIRE rather than SYNC_RMB.

I understood that, after I see the example of using it.
Please consider to add that into Documentation/memory-barriers.txt (it 
is not easy to find that this barrier is used for shared WRITE basing on 
shared pointer), it would be helpful.

- Leonid.
