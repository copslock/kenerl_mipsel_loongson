Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Feb 2018 16:54:54 +0100 (CET)
Received: from mail-oi0-x241.google.com ([IPv6:2607:f8b0:4003:c06::241]:43917
        "EHLO mail-oi0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992923AbeBIPyruAnkS convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Feb 2018 16:54:47 +0100
Received: by mail-oi0-x241.google.com with SMTP id 4so6420769ois.10
        for <linux-mips@linux-mips.org>; Fri, 09 Feb 2018 07:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:in-reply-to:references:mime-version:content-transfer-encoding
         :subject:to:cc:from:message-id;
        bh=p6PfsQvRWEwD4r3RvV1FTetnWdZtrI/ch1GMkWDTq8o=;
        b=AM21kLSTDzE0BRffFdG0dNPIZ0u0Jr6GifJ984Bq4XN/ulnK5LIz/NynJmr472cVh0
         npqZ6wxo8AfahpD1GnqF4K65+WLQN5Rnl89Qgci8Qn6ObPNYhiVznY9hOCjIZQNlkmhQ
         To6fmPCsAhnrNXJu7yZCkexhTF9X4BEU22WQOM/mVMXrHoRqDiNPaFvVoy4LRgTxsUQe
         y3D6ZZpeM+Sn16eQhxXunNzZJ278KyEAq5rSILqMOf+m+KKMx+wk3rYBmmrq007rfhEZ
         FUzVumAk8nwgCSjyaN6eRWYv/bCoDpPH2fgdCDTn8nlHZhHL5+izTsfWYjzdBuzsWVbK
         //TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=p6PfsQvRWEwD4r3RvV1FTetnWdZtrI/ch1GMkWDTq8o=;
        b=f7uzt10lUubmTGWs39p+k96GMfD2uvO9d+EaRVP7pSGdlqQHZxNuR6+oL0r+WAHaWV
         qNQAUtxo5cn6YYjYsptsQLEIErGT0cbDoo0op8AwunSeq0ybTRPPWSAnOhDxBiTaZwM2
         razlejrkXVV4RW4LVi6bhs+qeT91qWBwX/32MuA9/DKNeG1a3bEzM1/dA4yUKjz/4zHO
         Q8N2xBfJIFrqDP185PsKL4epnj9P2vf4u9w3GUQlK+3NigdBpjo4A7kIvUfV05EVHOJ+
         lH8f0o18LBsKnZG4g/OJQRjXjM9pNc8lQ4iFC3KwgSHC/pMnN1GtqacyifUZkGsX0aMK
         jvGg==
X-Gm-Message-State: APf1xPBTotP3Ca4WEk0DPdttv4aUhGkeULrvkMdUoswTTFMZBiiPiwLO
        1mV4zfk21FWIcDFjnc61sHE=
X-Google-Smtp-Source: AH8x225UURbInJbwKGBmdQvIqekJi4USOqdg4wm3V/KTMQf9FojrM7rioLSc+SReNJQSHzBqF55JbA==
X-Received: by 10.202.0.200 with SMTP id 191mr2214633oia.206.1518191681295;
        Fri, 09 Feb 2018 07:54:41 -0800 (PST)
Received: from ?IPv6:2001:470:d:73f:60e3:e791:7e87:2f7e? ([2001:470:d:73f:60e3:e791:7e87:2f7e])
        by smtp.gmail.com with ESMTPSA id r34sm1548403otc.61.2018.02.09.07.54.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 07:54:40 -0800 (PST)
Date:   Fri, 09 Feb 2018 07:54:35 -0800
In-Reply-To: <ba5fb474-4e45-8d8d-ee5d-9f1a211090e3@arm.com>
References: <20180209021031.20631-1-jaedon.shin@gmail.com> <ba5fb474-4e45-8d8d-ee5d-9f1a211090e3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] irqchip: Use %px to print pointer value
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
CC:     Kevin Cernekee <cernekee@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <45424653-235D-4C4B-8908-417943F5283C@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On February 9, 2018 12:51:33 AM PST, Marc Zyngier <marc.zyngier@arm.com> wrote:
>On 09/02/18 02:10, Jaedon Shin wrote:
>> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
>> pointers printed with %p are hashed. Use %px instead of %p to print
>> pointer value.
>> 
>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>> ---
>>  drivers/irqchip/irq-bcm7038-l1.c | 2 +-
>>  drivers/irqchip/irq-bcm7120-l2.c | 2 +-
>>  drivers/irqchip/irq-brcmstb-l2.c | 2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/irqchip/irq-bcm7038-l1.c
>b/drivers/irqchip/irq-bcm7038-l1.c
>> index 55cfb986225b..f604c1d89b3b 100644
>> --- a/drivers/irqchip/irq-bcm7038-l1.c
>> +++ b/drivers/irqchip/irq-bcm7038-l1.c
>> @@ -339,7 +339,7 @@ int __init bcm7038_l1_of_init(struct device_node
>*dn,
>>  		goto out_unmap;
>>  	}
>>  
>> -	pr_info("registered BCM7038 L1 intc (mem: 0x%p, IRQs: %d)\n",
>> +	pr_info("registered BCM7038 L1 intc (mem: 0x%px, IRQs: %d)\n",
>>  		intc->cpus[0]->map_base, IRQS_PER_WORD * intc->n_words);
>>  
>>  	return 0;
>> diff --git a/drivers/irqchip/irq-bcm7120-l2.c
>b/drivers/irqchip/irq-bcm7120-l2.c
>> index 983640eba418..1cc4dd1d584a 100644
>> --- a/drivers/irqchip/irq-bcm7120-l2.c
>> +++ b/drivers/irqchip/irq-bcm7120-l2.c
>> @@ -318,7 +318,7 @@ static int __init bcm7120_l2_intc_probe(struct
>device_node *dn,
>>  		}
>>  	}
>>  
>> -	pr_info("registered %s intc (mem: 0x%p, parent IRQ(s): %d)\n",
>> +	pr_info("registered %s intc (mem: 0x%px, parent IRQ(s): %d)\n",
>>  			intc_name, data->map_base[0], data->num_parent_irqs);
>>  
>>  	return 0;
>> diff --git a/drivers/irqchip/irq-brcmstb-l2.c
>b/drivers/irqchip/irq-brcmstb-l2.c
>> index 691d20eb0bec..6760edeeb666 100644
>> --- a/drivers/irqchip/irq-brcmstb-l2.c
>> +++ b/drivers/irqchip/irq-brcmstb-l2.c
>> @@ -262,7 +262,7 @@ static int __init brcmstb_l2_intc_of_init(struct
>device_node *np,
>>  		ct->chip.irq_set_wake = irq_gc_set_wake;
>>  	}
>>  
>> -	pr_info("registered L2 intc (mem: 0x%p, parent irq: %d)\n",
>> +	pr_info("registered L2 intc (mem: 0x%px, parent irq: %d)\n",
>>  			base, parent_irq);
>>  
>>  	return 0;
>> 
>
>Why is that something useful to do? This just tells you where the
>device
>is mapped in the VA space, and I doubt that's a useful information,
>hashed pointers or not. Am I missing something obvious?

No you are right there is not much value in printing the register virtual address (sometimes there is e.g: on MIPS) either we fix the prints to show the physical address of the base register or we could possibly drop the prints entirely.

-- 
Florian
