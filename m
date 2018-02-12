Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Feb 2018 23:18:22 +0100 (CET)
Received: from mail-vk0-x243.google.com ([IPv6:2607:f8b0:400c:c05::243]:39188
        "EHLO mail-vk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994554AbeBLWSNxdPXm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Feb 2018 23:18:13 +0100
Received: by mail-vk0-x243.google.com with SMTP id a63so9732935vkg.6
        for <linux-mips@linux-mips.org>; Mon, 12 Feb 2018 14:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Eagvr0K+YHaMC6P2qbIxiyZ9hrIDZGrkCABxeUMMKq0=;
        b=E1/EYJ+gImJwPelG7Zwyw060mF8Wtnp6vwM+ObjfKlyBEmFJ9ySOiRgJIYmBS+hSQi
         l65VIVKxy9sGeZk8cq1R8/JyBoAxdyyqvexZsJ9tzBus+ymWhCnKUuFC4uPDL4oFhG8c
         qj5Lwz1+s/Lp9GfbEe3uHgeTqcuKd5TnH8np/iE7sv3AJYFBY/jOsLkgihKoWr9/Az0a
         BElUnMjIdUtPhNkXFPFDVc/xeJ7QeNUW8ZhS++YrnVQ6wDF5be+Y/xm73addux165JQz
         xNCx0zd0GEFqEJvm4HVItdwNidfThborRshWyRdO6wVKciJ0kzm7HsveIwIjZxf5nrbs
         s1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Eagvr0K+YHaMC6P2qbIxiyZ9hrIDZGrkCABxeUMMKq0=;
        b=LGfEc+j6Qqh6QMYFs8oZcP5TUC/6osk6c9seTB+anDp2PhvzHszXaFLQEkFEoqLMUK
         faw+aefdAm91cmdRUHB3qk+Zohm/THGZDmbXmutd2OBP80doBg31TRRt3ukYJm1v/Edr
         35LAJM39ZzXHaETgEPlp41iB04T0mMYUztya87kaNWkqEhqbLM/PAkIMfG6cMLfwW4Xf
         uPf5u+19e7U9R28gcfJqXxKV48KAHG/Uf0HVm4YowMOltyHvTjNmBNS5wwo389CZDDaT
         w+dwoXgXoNWsw87iI6sSNaUZ2alkdRupn1mTHgJnFgj+GuVB7GEccgu9qZgxh+AUlXs3
         vcKA==
X-Gm-Message-State: APf1xPDmkgbwEYQnXddvpTwLLOP/USM5xYP93mpAMO4JCxyn0r6uAI14
        37hWn6l3EP/zcCmKTvnbBoBUdoGafiov5nNaK0k=
X-Google-Smtp-Source: AH8x227e1t59s1vBHAyPAl3GtIOoB2KZiiHlwoQhotRBCiro5N6Do1ys4tf/j4/VobRVkAeegVwrcqcPmiGNlq5ukqA=
X-Received: by 10.31.73.199 with SMTP id w190mr11603045vka.108.1518473887515;
 Mon, 12 Feb 2018 14:18:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.89.198 with HTTP; Mon, 12 Feb 2018 14:17:47 -0800 (PST)
In-Reply-To: <6bf05e81-2334-f3ac-08a7-e53ee59bb4c0@arm.com>
References: <20180209021031.20631-1-jaedon.shin@gmail.com> <ba5fb474-4e45-8d8d-ee5d-9f1a211090e3@arm.com>
 <45424653-235D-4C4B-8908-417943F5283C@gmail.com> <6bf05e81-2334-f3ac-08a7-e53ee59bb4c0@arm.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Mon, 12 Feb 2018 23:17:47 +0100
Message-ID: <CAOiHx=n7yS2dD9LVeQp7p48Sai51aQHjyLHUQMnBvXjwChoh7g@mail.gmail.com>
Subject: Re: [PATCH] irqchip: Use %px to print pointer value
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Kevin Cernekee <cernekee@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

On 9 February 2018 at 17:04, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 09/02/18 15:54, Florian Fainelli wrote:
>> On February 9, 2018 12:51:33 AM PST, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> On 09/02/18 02:10, Jaedon Shin wrote:
>>>> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
>>>> pointers printed with %p are hashed. Use %px instead of %p to print
>>>> pointer value.
>>>>
>>>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>>>> ---
>>>>  drivers/irqchip/irq-bcm7038-l1.c | 2 +-
>>>>  drivers/irqchip/irq-bcm7120-l2.c | 2 +-
>>>>  drivers/irqchip/irq-brcmstb-l2.c | 2 +-
>>>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/irqchip/irq-bcm7038-l1.c
>>> b/drivers/irqchip/irq-bcm7038-l1.c
>>>> index 55cfb986225b..f604c1d89b3b 100644
>>>> --- a/drivers/irqchip/irq-bcm7038-l1.c
>>>> +++ b/drivers/irqchip/irq-bcm7038-l1.c
>>>> @@ -339,7 +339,7 @@ int __init bcm7038_l1_of_init(struct device_node
>>> *dn,
>>>>             goto out_unmap;
>>>>     }
>>>>
>>>> -   pr_info("registered BCM7038 L1 intc (mem: 0x%p, IRQs: %d)\n",
>>>> +   pr_info("registered BCM7038 L1 intc (mem: 0x%px, IRQs: %d)\n",
>>>>             intc->cpus[0]->map_base, IRQS_PER_WORD * intc->n_words);
>>>>
>>>>     return 0;
>>>> diff --git a/drivers/irqchip/irq-bcm7120-l2.c
>>> b/drivers/irqchip/irq-bcm7120-l2.c
>>>> index 983640eba418..1cc4dd1d584a 100644
>>>> --- a/drivers/irqchip/irq-bcm7120-l2.c
>>>> +++ b/drivers/irqchip/irq-bcm7120-l2.c
>>>> @@ -318,7 +318,7 @@ static int __init bcm7120_l2_intc_probe(struct
>>> device_node *dn,
>>>>             }
>>>>     }
>>>>
>>>> -   pr_info("registered %s intc (mem: 0x%p, parent IRQ(s): %d)\n",
>>>> +   pr_info("registered %s intc (mem: 0x%px, parent IRQ(s): %d)\n",
>>>>                     intc_name, data->map_base[0], data->num_parent_irqs);
>>>>
>>>>     return 0;
>>>> diff --git a/drivers/irqchip/irq-brcmstb-l2.c
>>> b/drivers/irqchip/irq-brcmstb-l2.c
>>>> index 691d20eb0bec..6760edeeb666 100644
>>>> --- a/drivers/irqchip/irq-brcmstb-l2.c
>>>> +++ b/drivers/irqchip/irq-brcmstb-l2.c
>>>> @@ -262,7 +262,7 @@ static int __init brcmstb_l2_intc_of_init(struct
>>> device_node *np,
>>>>             ct->chip.irq_set_wake = irq_gc_set_wake;
>>>>     }
>>>>
>>>> -   pr_info("registered L2 intc (mem: 0x%p, parent irq: %d)\n",
>>>> +   pr_info("registered L2 intc (mem: 0x%px, parent irq: %d)\n",
>>>>                     base, parent_irq);
>>>>
>>>>     return 0;
>>>>
>>>
>>> Why is that something useful to do? This just tells you where the
>>> device
>>> is mapped in the VA space, and I doubt that's a useful information,
>>> hashed pointers or not. Am I missing something obvious?
>>
>> No you are right there is not much value in printing the register
>> virtual address (sometimes there is e.g: on MIPS) either we fix the
>> prints to show the physical address of the base register or we could
>> possibly drop the prints entirely.
>
> Displaying the PA can be useful if you have several identical blocks in
> your system and you want to be able to identify them. Given that there
> is probably only one of these controllers per system, the address is
> pretty pointless.

Multiple instances are actually quite common in the STB SoCs, e.g.
bcm7362 has one instance of bcm7038-l1, two instances of bcm7120-l2
and four instances of brcmstb-l2.


Regards
Jonas

P.S: Also What about bcm6345-l1? It also prints it's mapped VAs, not the PAs.
