Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2017 11:18:11 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60953 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992227AbdAQKSD34I8n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2017 11:18:03 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 11C9474E335AA;
        Tue, 17 Jan 2017 10:17:55 +0000 (GMT)
Received: from [10.150.130.83] (10.150.130.83) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 17 Jan
 2017 10:17:56 +0000
Subject: Re: [PATCH v1] irqchip: irq-mips-gic:- Handle return NULL error from
 ioremap_nocache
To:     Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>
References: <1483949306-9712-1-git-send-email-arvind.yadav.cs@gmail.com>
 <120995f1-6cdb-9736-f6da-b85925f27451@arm.com>
 <4b306a43-7b8f-e4c4-95f8-bb0cd52f4336@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <574c27a3-cee8-6649-ef20-9903a1d9850d@imgtec.com>
Date:   Tue, 17 Jan 2017 10:17:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <4b306a43-7b8f-e4c4-95f8-bb0cd52f4336@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56340
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



On 17/01/17 10:10, Arvind Yadav wrote:
> Hi Matt,
>
> Please Acknowledge this.
>
> Regards
> Arvind Yadav

Hi Arvind,

Acked-by: Matt Redfearn <matt.redfearn@imgtec.com>


>
> On Monday 09 January 2017 02:30 PM, Marc Zyngier wrote:
>> On 09/01/17 08:08, Arvind Yadav wrote:
>>> Here, If ioremap_nocache will fail. It will return NULL.
>>> Kernel can run into a NULL-pointer dereference.
>>> This error check will avoid NULL pointer dereference.
>>>
>>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>>> ---
>>>   drivers/irqchip/irq-mips-gic.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/irqchip/irq-mips-gic.c 
>>> b/drivers/irqchip/irq-mips-gic.c
>>> index c01c09e..eeea2e8 100644
>>> --- a/drivers/irqchip/irq-mips-gic.c
>>> +++ b/drivers/irqchip/irq-mips-gic.c
>>> @@ -979,6 +979,8 @@ static void __init __gic_init(unsigned long 
>>> gic_base_addr,
>>>       __gic_base_addr = gic_base_addr;
>>>         gic_base = ioremap_nocache(gic_base_addr, gic_addrspace_size);
>>> +    if (!gic_base)
>>> +        panic("Failed to map GIC memory");
>> So you're replacing a panic due to dereferencing a NULL pointer with
>> another panic -- not much progress here. I appreciate that the message
>> is a bit more explicit, but is there something slightly less drastic we
>> could do? Like returning an error code and see if the kernel otherwise
>> recovers (possibly with reduced functionality)?

Marc, there's really not much that can be done without the GIC 
initializing sucessfully. This should not happen if platform code / 
device tree is set up correctly, so an explicit panic if that is not the 
case is helpful.

Thanks,
Matt

>>
>>>         gicconfig = gic_read(GIC_REG(SHARED, GIC_SH_CONFIG));
>>>       gic_shared_intrs = (gicconfig & GIC_SH_CONFIG_NUMINTRS_MSK) >>
>>>
>> Thanks,
>>
>>     M.
>
