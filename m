Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Mar 2017 14:53:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:65094 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992126AbdCaMxZphKFQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Mar 2017 14:53:25 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5DAFA8C685A49;
        Fri, 31 Mar 2017 13:53:12 +0100 (IST)
Received: from [10.150.130.83] (10.150.130.83) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 31 Mar
 2017 13:53:15 +0100
Subject: Re: [PATCH 1/2] MIPS: Malta: Fix i8259 irqchip setup
To:     Ralf Baechle <ralf@linux-mips.org>
References: <1490958332-31094-1-git-send-email-matt.redfearn@imgtec.com>
 <1490958332-31094-2-git-send-email-matt.redfearn@imgtec.com>
 <20170331124916.GB26330@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <52fea079-fb63-6619-8115-2dbfc5ab022b@imgtec.com>
Date:   Fri, 31 Mar 2017 13:53:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170331124916.GB26330@linux-mips.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57511
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

Hi Ralf,


On 31/03/17 13:49, Ralf Baechle wrote:
> On Fri, Mar 31, 2017 at 12:05:31PM +0100, Matt Redfearn wrote:
>
>> diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
>> index cb675ec6f283..474b372e0dd9 100644
>> --- a/arch/mips/mti-malta/malta-int.c
>> +++ b/arch/mips/mti-malta/malta-int.c
>> @@ -232,6 +232,19 @@ void __init arch_init_irq(void)
>>   {
>>   	int corehi_irq;
>>   
>> +#ifdef CONFIG_I8259
>> +	/*
>> +	 * Preallocate the i8259's expected virq's here. Since irqchip_init()
>> +	 * will probe the irqchips in hierarchial order, i8259 is probed last.
>> +	 * If anything allocates a virq before the i8259 is probed, it will
>> +	 * be given one of the i8259's expected range and consequently setup
>> +	 * of the i8259 will fail.
>> +	 */
>> +	WARN(irq_alloc_descs(I8259A_IRQ_BASE, I8259A_IRQ_BASE,
>> +			    16, numa_node_id()) < 0,
>> +		"Cannot reserve i8259 virqs at IRQ%d\n", I8259A_IRQ_BASE);
>> +#endif /* CONFIG_I8259 */
>> +
>>   	i8259_set_poll(mips_pcibios_iack);
> CONFIG_I8259 is always defined on Malta so the #ifdef is pointless.
>
>    Ralf

Ah, true. I was looking at arch/mips/include/asm/mach-generic/irq.h 
where I8259A_IRQ_BASE is defined, it's wrapped in that CONFIG so I kept 
it here, but you're right of course that Malta always defines it. Would 
you like a v2 with that removed?

Thanks,
Matt
