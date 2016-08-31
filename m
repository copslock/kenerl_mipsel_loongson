Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2016 17:49:48 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12432 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992002AbcHaPtlaprJE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Aug 2016 17:49:41 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5E5F2DCD35E44;
        Wed, 31 Aug 2016 16:49:21 +0100 (IST)
Received: from [10.150.130.83] (10.150.130.83) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 31 Aug
 2016 16:49:24 +0100
Subject: Re: [PATCH 06/10] MIPS: pm-cps: Use MIPS standard lightweight
 ordering barrier
To:     Peter Zijlstra <peterz@infradead.org>
References: <1472640279-26593-1-git-send-email-matt.redfearn@imgtec.com>
 <1472640279-26593-7-git-send-email-matt.redfearn@imgtec.com>
 <20160831114847.GB10153@twins.programming.kicks-ass.net>
 <4c91d6c3-8141-594a-562c-96ea56776d2e@imgtec.com>
 <20160831142821.GF10138@twins.programming.kicks-ass.net>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <3ea993af-5b60-8ade-4d79-8f494ecb45a6@imgtec.com>
Date:   Wed, 31 Aug 2016 16:49:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160831142821.GF10138@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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



On 31/08/16 15:28, Peter Zijlstra wrote:
> On Wed, Aug 31, 2016 at 02:36:26PM +0100, Matt Redfearn wrote:
>> The code previously had 0x10 as a magic number, this patch just replaces
>> that with a #defined name. The value is documented in the MIPS64 instruction
>> set manual, https://imgtec.com/?do-download=4302, table 6.5.
>>
>> This sync type has been standard since MIPSr2. That document also states
>> that "If an implementation does not use one of these non-zero values to
>> define a different synchronization behavior, then that non-zero value of
>> stype must act the same as stype zero completion barrier." As such,
>> stype_ordering can always be set to this sync type rather than setting it
>> only for certain CPUs.

Hi Peter,

> Right. We all had a bunch of fun trying to decode that manual a while
> back, and IIRC were left with a bunch of questions on what it all meant
> in 3+ CPU scenarios.

Yes, I remember that fun....

>
> In anycase, not sure why I was Cc'ed to this patch, but in general I

Patman decided to CC you as you've touched arch/mips/include/barrier.h I 
suppose.

> have low confidence in barrier patches that lack lots of detail. And the
> code in question has woefully inadequate comments:
>
>                  /* Ordering barrier */
>                  uasm_i_sync(&p, stype_ordering);
>
> Order what against what and why? Is my first question. A comment really
> should explain.

Fair enough - we'll put something together to improve the comments.

>
> In any case, you've removed the only (runtime) assignment to the
> variable, it can become 'const'.

True enough.

Thanks,
Matt
