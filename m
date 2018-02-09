Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Feb 2018 17:05:12 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:53110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992917AbeBIQFFJtspS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Feb 2018 17:05:05 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FD181435;
        Fri,  9 Feb 2018 08:04:57 -0800 (PST)
Received: from [10.1.207.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 241A33F487;
        Fri,  9 Feb 2018 08:04:55 -0800 (PST)
Subject: Re: [PATCH] irqchip: Use %px to print pointer value
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180209021031.20631-1-jaedon.shin@gmail.com>
 <ba5fb474-4e45-8d8d-ee5d-9f1a211090e3@arm.com>
 <45424653-235D-4C4B-8908-417943F5283C@gmail.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <6bf05e81-2334-f3ac-08a7-e53ee59bb4c0@arm.com>
Date:   Fri, 9 Feb 2018 16:04:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <45424653-235D-4C4B-8908-417943F5283C@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62475
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

On 09/02/18 15:54, Florian Fainelli wrote:
> On February 9, 2018 12:51:33 AM PST, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 09/02/18 02:10, Jaedon Shin wrote:
>>> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
>>> pointers printed with %p are hashed. Use %px instead of %p to print
>>> pointer value.
>>>
>>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>>> ---
>>>  drivers/irqchip/irq-bcm7038-l1.c | 2 +-
>>>  drivers/irqchip/irq-bcm7120-l2.c | 2 +-
>>>  drivers/irqchip/irq-brcmstb-l2.c | 2 +-
>>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/irqchip/irq-bcm7038-l1.c
>> b/drivers/irqchip/irq-bcm7038-l1.c
>>> index 55cfb986225b..f604c1d89b3b 100644
>>> --- a/drivers/irqchip/irq-bcm7038-l1.c
>>> +++ b/drivers/irqchip/irq-bcm7038-l1.c
>>> @@ -339,7 +339,7 @@ int __init bcm7038_l1_of_init(struct device_node
>> *dn,
>>>  		goto out_unmap;
>>>  	}
>>>  
>>> -	pr_info("registered BCM7038 L1 intc (mem: 0x%p, IRQs: %d)\n",
>>> +	pr_info("registered BCM7038 L1 intc (mem: 0x%px, IRQs: %d)\n",
>>>  		intc->cpus[0]->map_base, IRQS_PER_WORD * intc->n_words);
>>>  
>>>  	return 0;
>>> diff --git a/drivers/irqchip/irq-bcm7120-l2.c
>> b/drivers/irqchip/irq-bcm7120-l2.c
>>> index 983640eba418..1cc4dd1d584a 100644
>>> --- a/drivers/irqchip/irq-bcm7120-l2.c
>>> +++ b/drivers/irqchip/irq-bcm7120-l2.c
>>> @@ -318,7 +318,7 @@ static int __init bcm7120_l2_intc_probe(struct
>> device_node *dn,
>>>  		}
>>>  	}
>>>  
>>> -	pr_info("registered %s intc (mem: 0x%p, parent IRQ(s): %d)\n",
>>> +	pr_info("registered %s intc (mem: 0x%px, parent IRQ(s): %d)\n",
>>>  			intc_name, data->map_base[0], data->num_parent_irqs);
>>>  
>>>  	return 0;
>>> diff --git a/drivers/irqchip/irq-brcmstb-l2.c
>> b/drivers/irqchip/irq-brcmstb-l2.c
>>> index 691d20eb0bec..6760edeeb666 100644
>>> --- a/drivers/irqchip/irq-brcmstb-l2.c
>>> +++ b/drivers/irqchip/irq-brcmstb-l2.c
>>> @@ -262,7 +262,7 @@ static int __init brcmstb_l2_intc_of_init(struct
>> device_node *np,
>>>  		ct->chip.irq_set_wake = irq_gc_set_wake;
>>>  	}
>>>  
>>> -	pr_info("registered L2 intc (mem: 0x%p, parent irq: %d)\n",
>>> +	pr_info("registered L2 intc (mem: 0x%px, parent irq: %d)\n",
>>>  			base, parent_irq);
>>>  
>>>  	return 0;
>>>
>>
>> Why is that something useful to do? This just tells you where the
>> device
>> is mapped in the VA space, and I doubt that's a useful information,
>> hashed pointers or not. Am I missing something obvious?
> 
> No you are right there is not much value in printing the register
> virtual address (sometimes there is e.g: on MIPS) either we fix the
> prints to show the physical address of the base register or we could
> possibly drop the prints entirely.

Displaying the PA can be useful if you have several identical blocks in
your system and you want to be able to identify them. Given that there
is probably only one of these controllers per system, the address is
pretty pointless.

If you send me a patch removing the prints, I'll queue it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
