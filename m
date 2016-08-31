Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2016 15:36:51 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50366 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992036AbcHaNgodKA6f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Aug 2016 15:36:44 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 24E6B697ED664;
        Wed, 31 Aug 2016 14:36:24 +0100 (IST)
Received: from [10.150.130.83] (10.150.130.83) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 31 Aug
 2016 14:36:26 +0100
Subject: Re: [PATCH 06/10] MIPS: pm-cps: Use MIPS standard lightweight
 ordering barrier
To:     Peter Zijlstra <peterz@infradead.org>
References: <1472640279-26593-1-git-send-email-matt.redfearn@imgtec.com>
 <1472640279-26593-7-git-send-email-matt.redfearn@imgtec.com>
 <20160831114847.GB10153@twins.programming.kicks-ass.net>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <4c91d6c3-8141-594a-562c-96ea56776d2e@imgtec.com>
Date:   Wed, 31 Aug 2016 14:36:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160831114847.GB10153@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54895
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



On 31/08/16 12:48, Peter Zijlstra wrote:
> On Wed, Aug 31, 2016 at 11:44:35AM +0100, Matt Redfearn wrote:
>> Since R2 of the MIPS architecture, SYNC(0x10) has been an optional but
>> architecturally defined ordering barrier. If a CPU does not implement it,
>> the arch specifies that it must fall back to SYNC(0).
>>
>> Define the barrier type and always use it in the pm-cps code rather than
>> falling back to the heavyweight sync(0) such that we can benefit from
>> the lighter weight sync.
>>
> Changelog does not explain what 0x10 is, nor why its sufficient for this
> case.

Hi Peter,

The code previously had 0x10 as a magic number, this patch just replaces 
that with a #defined name. The value is documented in the MIPS64 
instruction set manual, https://imgtec.com/?do-download=4302, table 6.5.

This sync type has been standard since MIPSr2. That document also states 
that "If an implementation does not use one of these non-zero values to 
define a different synchronization behavior, then that non-zero value of 
stype must act the same as stype zero completion barrier." As such, 
stype_ordering can always be set to this sync type rather than setting 
it only for certain CPUs.

Thanks,
Matt

>
> Changelog also fails to explain why you do this.
> How do you expect anybody to review this?
