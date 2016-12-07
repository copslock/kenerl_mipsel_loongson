Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Dec 2016 10:30:37 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50543 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992309AbcLGJaaR7uLt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Dec 2016 10:30:30 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B8CB4803264B8;
        Wed,  7 Dec 2016 09:30:21 +0000 (GMT)
Received: from [10.150.130.83] (10.150.130.83) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 7 Dec
 2016 09:30:23 +0000
Subject: Re: [PATCH 0/5] MIPS: Add per-cpu IRQ stack
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <1480685957-18809-1-git-send-email-matt.redfearn@imgtec.com>
 <CAHmME9pEB6uBJN0AWh4igmfbxSya1e8eYXdDp_dwRZZZGPjVug@mail.gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Petr Mladek <pmladek@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrea Gelmini <andrea.gelmini@gelma.net>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Jiri Slaby <jslaby@suse.cz>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <9f778311-6d4d-cc57-00db-db2141803416@imgtec.com>
Date:   Wed, 7 Dec 2016 09:30:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAHmME9pEB6uBJN0AWh4igmfbxSya1e8eYXdDp_dwRZZZGPjVug@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55953
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

Hi Jason,


On 06/12/16 22:09, Jason A. Donenfeld wrote:
> Hi Matt,
>
> Thanks for submitting this. A happy OpenWRT/WireGuard user has
> reported to me that this patch set frees ~1300 bytes of stack on a
> small MIPS router. This kind of savings should allow me to reintroduce
> my crypto operations to be on the stack, rather than the conditional
> MIPS kmallocing, which will be a performance win.

Excellent.

>
> By the way, it looks like x86 and SPARC have separately allocated hard
> IRQ and soft IRQ stacks. ARM has only one for both, similar to this
> MIPS patchset.

The separate stack for soft-IRQs could be added as well, but of course 
there is a tradeoff against the additional memory consumed by it. I 
believe that most soft IRQs will now be handled on the new irq stack, 
because HAVE_IRQ_EXIT_ON_IRQ_STACK causes them to be invoked within 
irq_exit, while still executing on the irq stack

Thanks,
Matt

>
> Jason
>
> On Fri, Dec 2, 2016 at 2:39 PM, Matt Redfearn <matt.redfearn@imgtec.com> wrote:
>> This series adds a separate stack for each CPU wihin the system to use
>> when handling IRQs. Previously IRQs were handled on the kernel stack of
>> the current task. If that task was deep down a call stack at the point
>> of the interrupt, and handling the interrupt required a deep IRQ stack,
>> then there was a likelihood of stack overflow. Since the kernel stack
>> is in normal unmapped memory, overflowing it can lead to silent
>> corruption of other kernel data, with weird and wonderful results.
>>
>> Before this patch series, ftracing the maximum stack size of a v4.9-rc6
>> kernel running on a Ci40 board gave:
>> 4996
>>
>> And with this series:
>> 4084
>>
>> Handling interrupts on a separate stack reduces the maximum kernel stack
>> usage in this configuration by ~900 bytes.
>>
>> Since do_IRQ is now invoked on a separate stack, we select
>> HAVE_IRQ_EXIT_ON_IRQ_STACK so that softirqs will also be executed on the
>> irq stack rather than attempting to switch with do_softirq_own_stack().
>>
>> This series has been tested on MIPS Boston, Malta and SEAD3 platforms,
>> Pistachio on the Creator Ci40 board and Cavium Octeon III.
>>
>>
>>
>> Matt Redfearn (5):
>>    MIPS: Introduce irq_stack
>>    MIPS: Stack unwinding while on IRQ stack
>>    MIPS: Only change $28 to thread_info if coming from user mode
>>    MIPS: Switch to the irq_stack in interrupts
>>    MIPS: Select HAVE_IRQ_EXIT_ON_IRQ_STACK
>>
>>   arch/mips/Kconfig                  |  1 +
>>   arch/mips/include/asm/irq.h        | 12 ++++++
>>   arch/mips/include/asm/stackframe.h | 10 +++++
>>   arch/mips/kernel/asm-offsets.c     |  1 +
>>   arch/mips/kernel/genex.S           | 81 +++++++++++++++++++++++++++++++++++---
>>   arch/mips/kernel/irq.c             | 11 ++++++
>>   arch/mips/kernel/process.c         | 15 ++++++-
>>   7 files changed, 125 insertions(+), 6 deletions(-)
>>
>> --
>> 2.7.4
>>
