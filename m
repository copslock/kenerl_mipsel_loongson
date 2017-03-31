Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Mar 2017 15:28:22 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:36154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992155AbdCaN2NTPwCu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 31 Mar 2017 15:28:13 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77AEB28;
        Fri, 31 Mar 2017 06:28:06 -0700 (PDT)
Received: from [10.1.207.16] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 167FC3F220;
        Fri, 31 Mar 2017 06:28:04 -0700 (PDT)
Subject: Re: [PATCH 0/2] Fix v4.11 malta_defconfig regressions
To:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
References: <1490958332-31094-1-git-send-email-matt.redfearn@imgtec.com>
 <d6508e12-07c0-1cf1-97cf-d88b77b3dde4@arm.com>
 <f15b4357-0e26-7c31-a279-d6ecad536d4d@imgtec.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Paul Burton <paul.burton@imgtec.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <75c7527f-50fc-695d-0576-29e76f30a010@arm.com>
Date:   Fri, 31 Mar 2017 14:28:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <f15b4357-0e26-7c31-a279-d6ecad536d4d@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marc.zyngier@arm.com
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

On 31/03/17 13:55, Matt Redfearn wrote:
> Hi Marc,
> 
> 
> On 31/03/17 13:04, Marc Zyngier wrote:
>> Hi Matt,
>>
>> On 31/03/17 12:05, Matt Redfearn wrote:
>>> Since v4.11-rc1, 3 regressions have been observed on the Malta platform,
>>> using malta_defconfig. which prevent it booting. These patches fix 2 of
>>> them. The third one is that malta_defconfig, which uses SMP-MT, no
>>> longer sets up its IPIs correctly resulting is a string of messages
>>> like:
>>>
>>> irq 23: nobody cared (try booting with the "irqpoll" option)
>>> CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W       4.11.0-rc4 #421
>>> Stack : 00000000 00000000 00000000 00000000 807cdff2 00000047 00000000 0000003d
>>>          80741327 8f093194 806c191c 00000000 00000001 807c9acc 80756078 807d0000
>>>          807cdbe4 80177c78 00000003 0000003c 00000006 80177a04 806c70a8 8f02be8c
>>>          00000006 801b4c8c 00000000 00000000 ffffffff 00000000 8f02be8c 80740000
>>>          00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>>>          ...
>>> Call Trace:
>>> [<8010c6c0>] show_stack+0x88/0xa4
>>> [<80380fb8>] dump_stack+0x88/0xd0
>>> [<8017cf64>] __report_bad_irq+0x48/0x108
>>> [<8017d2d4>] note_interrupt+0x1c0/0x2fc
>>> [<80179ed4>] handle_irq_event_percpu+0x4c/0x64
>>> [<8017eafc>] handle_percpu_irq+0x88/0xb8
>>> [<801791c0>] generic_handle_irq+0x40/0x58
>>> [<80108664>] do_IRQ+0x18/0x24
>>> [<803b83fc>] plat_irq_dispatch+0x54/0xa8
>>> handlers:
>>> Disabling IRQ #23
>>>
>>> This regression is fixed by Paul Burtons series "MIPS/irqchip: Use IPI
>>> IRQ domains for CPU interrupt controller IPIs", but it is a large change
>>> for this stage in the cycle so I don't know how best to proceed with
>>> that one.
>>>
>>>
>>>
>>> Matt Redfearn (2):
>>>    MIPS: Malta: Fix i8259 irqchip setup
>>>    irqchip/mips-gic: Fix Local compare interrupt
>>>
>>>   arch/mips/mti-malta/malta-int.c | 13 +++++++++++++
>>>   drivers/irqchip/irq-mips-gic.c  |  4 ++++
>>>   2 files changed, 17 insertions(+)
>>>
>> I can take the GIC patch through the irq tree if that's convenient (I
>> was about to send a PR anyway). Just let me know.
>>
>> Thanks,
>>
>> 	M.
> 
> Yes that would be great, please. Ralf has just acked it.

OK. I'll you and Ralf deal with the i8259 patch separately.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
