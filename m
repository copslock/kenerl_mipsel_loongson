Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jan 2016 21:45:26 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45280 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010521AbcALUpYQ9dvE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Jan 2016 21:45:24 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 4CDB98B66F6AB;
        Tue, 12 Jan 2016 20:45:14 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (TLS) id 14.3.235.1; Tue, 12 Jan
 2016 20:45:17 +0000
Received: from [10.20.3.92] (10.20.3.92) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 12 Jan
 2016 12:45:15 -0800
Message-ID: <569565DA.2010903@imgtec.com>
Date:   Tue, 12 Jan 2016 12:45:14 -0800
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "Michael S. Tsirkin" <mst@redhat.com>,
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
        <james.hogan@imgtec.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
References: <1452426622-4471-12-git-send-email-mst@redhat.com> <56945366.2090504@imgtec.com> <20160112092711.GP6344@twins.programming.kicks-ass.net> <20160112102555.GV6373@twins.programming.kicks-ass.net> <20160112104012.GW6373@twins.programming.kicks-ass.net> <20160112114111.GB15737@arm.com>
In-Reply-To: <20160112114111.GB15737@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.92]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51083
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

(I try to answer on multiple mails in one)

First of all, it seems like some generic notes should be given here:

1. Generic MIPS "SYNC" (aka "SYNC 0") instruction is a very heavy in 
some CPUs. On that CPUs it basically kills pipelines in each CPU, can do 
a special memory/IO bus transaction (similar to "fence") and hold a 
system until all R/W is completed. It is like Big Kernel Lock but worse. 
So, the move to SMP_* kind of barriers is needed to improve performance, 
especially on newest CPUs with long pipelines.

2. MIPS Arch document may be misleading because words "ordering" and 
"completion" means different from Linux, the SYNC instruction 
description is written for HW engineers. I wrote that in a separate 
patch of the same patchset - 
http://patchwork.linux-mips.org/patch/10505/ "MIPS: R6: Use lightweight 
SYNC instruction in smp_* memory barriers":

> This instructions were specifically designed to work for smp_*() sort of
> memory barriers in MIPS R2/R3/R5 and R6.
>
> Unfortunately, it's description is very cryptic and is done in HW engineering
> style which prevents use of it by SW.

3. I bother MIPS Arch team long time until I completely understood that 
MIPS SYNC_WMB, SYNC_MB, SYNC_RMB, SYNC_RELEASE and SYNC_ACQUIRE do an 
exactly that is required in Documentation/memory-barriers.txt


In Peter Zijlstra mail:

> 1) you do not make such things selectable; either the hardware needs
> them or it doesn't. If it does you_must_  use them, however unlikely.
It is selectable only for MIPS R2 but not MIPS R6. The reason is - most 
of MIPS R2 CPUs have short pipeline and that SYNC is just waste of CPU 
resource, especially taking into account that "lightweight syncs" are 
converted to a heavy "SYNC 0" in many of that CPUs. However the latest 
MIPS/Imagination CPU have a pipeline long enough to hit a problem - 
absence of SYNC at LL/SC inside atomics, barriers etc.

> And reading the MIPS64 v6.04 instruction set manual, I think 0x11/0x12
> are_NOT_  transitive and therefore cannot be used to implement the
> smp_mb__{before,after} stuff.
>
> That is, in MIPS speak, those SYNC types are Ordering Barriers, not
> Completion Barriers.

Please see above, point 2.

> That is, currently all architectures -- with exception of PPC -- have
> RCsc locks, but using these non-transitive things will get you RCpc
> locks.
>
> So yes, MIPS can go RCpc for its locks and share the burden of pain with
> PPC, but that needs to be a very concious decision.

I don't understand that - I tried hard but I can't find any word like 
"RCsc", "RCpc" in Documents/ directory. Web search goes nowhere, of course.


In Will Deacon mail:

> The issue I have with the SYNC description in the text above is that it
> describes the single CPU (program order) and the dual-CPU (confusingly
> named global order) cases, but then doesn't generalise any further. That
> means we can't sensibly reason about transitivity properties when a third
> agent is involved. For example, the WRC+sync+addr test:
>
>
> P0:
> Wx = 1
>
> P1:
> Rx == 1
> SYNC
> Wy = 1
>
> P2:
> Ry == 1
> <address dep>
> Rx = 0
>
>
> I can't find anything to forbid that, given the text. The main problem
> is having the SYNC on P1 affect the write by P0.

As I understand that test, the visibility of P0: W[x] = 1 is identical 
to P1 and P2 here. If P1 got X before SYNC and write to Y after SYNC 
then instruction source register dependency tracking in P2 prevents a 
speculative load of X before P2 obtains Y from the same place as P0/P1 
and calculate address of X. If some load of X in P2 happens before 
address dependency calculation it's result is discarded.

Yes, you can't find that in MIPS SYNC instruction description, it is 
more likely in CM (Coherence Manager) area. I just pointed our arch team 
member responsible for documents and he will think how to explain that.

- Leonid.
