Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jan 2016 20:28:32 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:5165 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009970AbcANT2axAZMZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jan 2016 20:28:30 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 9559EA14DD4CF;
        Thu, 14 Jan 2016 19:28:20 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (TLS) id 14.3.235.1; Thu, 14 Jan
 2016 19:28:24 +0000
Received: from [10.20.3.92] (10.20.3.92) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 14 Jan
 2016 11:28:19 -0800
Message-ID: <5697F6D2.60409@imgtec.com>
Date:   Thu, 14 Jan 2016 11:28:18 -0800
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Will Deacon <will.deacon@arm.com>
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
        <james.hogan@imgtec.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
References: <1452426622-4471-12-git-send-email-mst@redhat.com> <56945366.2090504@imgtec.com> <20160112092711.GP6344@twins.programming.kicks-ass.net> <20160112102555.GV6373@twins.programming.kicks-ass.net> <20160112104012.GW6373@twins.programming.kicks-ass.net> <20160112114111.GB15737@arm.com> <569565DA.2010903@imgtec.com> <20160113104516.GE25458@arm.com> <5696CF08.8080700@imgtec.com> <20160114121449.GC15828@arm.com>
In-Reply-To: <20160114121449.GC15828@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.92]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51123
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

On 01/14/2016 04:14 AM, Will Deacon wrote:
> On Wed, Jan 13, 2016 at 02:26:16PM -0800, Leonid Yegoshin wrote:
>
>>      Moreover, there are voices against guarantee that it will be in future
>> and that voices point me to Documentation/memory-barriers.txt section "DATA
>> DEPENDENCY BARRIERS" examples which require SYNC_RMB between loading
>> address/index and using that for loading data based on that address or index
>> for shared data (look on CPU2 pseudo-code):
>>> To deal with this, a data dependency barrier or better must be inserted
>>> between the address load and the data load:
>>>
>>>         CPU 1                 CPU 2
>>>         ===============       ===============
>>>         { A == 1, B == 2, C = 3, P == &A, Q == &C }
>>>         B = 4;
>>>         <write barrier>
>>>         WRITE_ONCE(P, &B);
>>>                               Q = READ_ONCE(P);
>>>                               <data dependency barrier> <-----------
>>> SYNC_RMB is here
>>>                               D = *Q;
>> ...
>>> Another example of where data dependency barriers might be required is
>>> where a
>>> number is read from memory and then used to calculate the index for an
>>> array
>>> access:
>>>
>>>         CPU 1                 CPU 2
>>>         ===============       ===============
>>>         { M[0] == 1, M[1] == 2, M[3] = 3, P == 0, Q == 3 }
>>>         M[1] = 4;
>>>         <write barrier>
>>>         WRITE_ONCE(P, 1);
>>>                               Q = READ_ONCE(P);
>>>                               <data dependency barrier> <------------
>>> SYNC_RMB is here
>>>                               D = M[Q];
>> That voices say that there is a legitimate reason to relax HW here for
>> performance if SYNC_RMB is needed anyway to work with this sequence of
>> shared data.
> Are you saying that MIPS needs to implement [smp_]read_barrier_depends?

It is not me, it is Documentation/memory-barriers.txt from kernel sources.

HW team can't work on voice statements, it should do a work on written 
documents. If that is written (see above the lines which I marked by 
"SYNC_RMB") then anybody should use it and never mind how many 
CPUs/Threads are in play. This examples explicitly requires to insert 
"data dependency barrier" between reading a shared pointer/index and 
using it to fetch a shared data. So, your WRC+addr+addr test is a 
violation of that recommendation.

- Leonid.
