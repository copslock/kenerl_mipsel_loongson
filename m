Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2017 11:25:46 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:50420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993889AbdAQKZir62pf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jan 2017 11:25:38 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C3641610;
        Tue, 17 Jan 2017 02:25:32 -0800 (PST)
Received: from [10.1.207.16] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 182283F3D6;
        Tue, 17 Jan 2017 02:25:30 -0800 (PST)
Subject: Re: [PATCH v1] irqchip: irq-mips-gic:- Handle return NULL error from
 ioremap_nocache
To:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>, tglx@linutronix.de,
        jason@lakedaemon.net
References: <1483949306-9712-1-git-send-email-arvind.yadav.cs@gmail.com>
 <120995f1-6cdb-9736-f6da-b85925f27451@arm.com>
 <4b306a43-7b8f-e4c4-95f8-bb0cd52f4336@gmail.com>
 <574c27a3-cee8-6649-ef20-9903a1d9850d@imgtec.com>
Cc:     linux-kernel@vger.kernel.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <7b1e2045-9e3c-7101-8750-1c6db90e5953@arm.com>
Date:   Tue, 17 Jan 2017 10:25:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <574c27a3-cee8-6649-ef20-9903a1d9850d@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56341
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

On 17/01/17 10:17, Matt Redfearn wrote:
> 
> 
> On 17/01/17 10:10, Arvind Yadav wrote:
>> Hi Matt,
>>
>> Please Acknowledge this.
>>
>> Regards
>> Arvind Yadav
> 
> Hi Arvind,
> 
> Acked-by: Matt Redfearn <matt.redfearn@imgtec.com>
> 
> 
>>
>> On Monday 09 January 2017 02:30 PM, Marc Zyngier wrote:
>>> On 09/01/17 08:08, Arvind Yadav wrote:
>>>> Here, If ioremap_nocache will fail. It will return NULL.
>>>> Kernel can run into a NULL-pointer dereference.
>>>> This error check will avoid NULL pointer dereference.
>>>>
>>>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>>>> ---
>>>>   drivers/irqchip/irq-mips-gic.c | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/irqchip/irq-mips-gic.c 
>>>> b/drivers/irqchip/irq-mips-gic.c
>>>> index c01c09e..eeea2e8 100644
>>>> --- a/drivers/irqchip/irq-mips-gic.c
>>>> +++ b/drivers/irqchip/irq-mips-gic.c
>>>> @@ -979,6 +979,8 @@ static void __init __gic_init(unsigned long 
>>>> gic_base_addr,
>>>>       __gic_base_addr = gic_base_addr;
>>>>         gic_base = ioremap_nocache(gic_base_addr, gic_addrspace_size);
>>>> +    if (!gic_base)
>>>> +        panic("Failed to map GIC memory");
>>> So you're replacing a panic due to dereferencing a NULL pointer with
>>> another panic -- not much progress here. I appreciate that the message
>>> is a bit more explicit, but is there something slightly less drastic we
>>> could do? Like returning an error code and see if the kernel otherwise
>>> recovers (possibly with reduced functionality)?
> 
> Marc, there's really not much that can be done without the GIC 
> initializing sucessfully. This should not happen if platform code / 
> device tree is set up correctly, so an explicit panic if that is not the 
> case is helpful.

Fair enough, that's your call. I'll pick that up as is.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
