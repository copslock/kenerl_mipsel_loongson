Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jan 2013 18:40:45 +0100 (CET)
Received: from mail-da0-f46.google.com ([209.85.210.46]:54334 "EHLO
        mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6833292Ab3A2Rknw6HBm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Jan 2013 18:40:43 +0100
Received: by mail-da0-f46.google.com with SMTP id p5so326108dak.5
        for <multiple recipients>; Tue, 29 Jan 2013 09:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=B177XJeqq5MqDbUItDhwRxSvNupJQUKccB1ihWNVOpc=;
        b=mvGkbQWuRpptvt6CeCPNIY1Hylvp55Aw9/kFO8tBeRUVNlBibOufuB1VHYYp71DIXy
         5I6+Cjh6F8kCTZmCWPjQYYBccb8RvWlQaijQZQcJ8tpQoZQAHN8f/JFjiSossMWbhSA8
         rOrty102p648aWX8U73B80WNPmRU0W9/EqisZSOb/f01d1oG9JS2VB2rfZ9zf5POZycI
         cPxLAP8ThnX+y+s5b6SE+ZriJQa+Ca5TbaRk/U6o8rhTTiO/rh8C6XEJr+ICSqtRXkbt
         3I1J6S8NEgx4vpJumu26cp6+HRsxhLNnl3+A0eLwLb42uNVq0ESdIO1tueencDZToo3y
         m/4w==
X-Received: by 10.68.211.42 with SMTP id mz10mr4460902pbc.100.1359481236922;
        Tue, 29 Jan 2013 09:40:36 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id gj1sm8766457pbc.11.2013.01.29.09.40.35
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 29 Jan 2013 09:40:36 -0800 (PST)
Message-ID: <51080992.6030905@gmail.com>
Date:   Tue, 29 Jan 2013 09:40:34 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATCH] MIPS: add irqdomain support for the CPU IRQ controller
References: <1359410344-19737-1-git-send-email-blogic@openwrt.org> <5106F7DC.1040307@openwrt.org>
In-Reply-To: <5106F7DC.1040307@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 35617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 01/28/2013 02:12 PM, Florian Fainelli wrote:
> Le 28/01/2013 22:59, John Crispin a écrit :
>> From: Gabor Juhos <juhosg@openwrt.org>
>>
>> Adds an irqdomain wrapper for the cpu irq controller that can be
>> passed inside
>> the of_device_id to of_irq_init().
>>
>> A device_node inside a dts file would look as such.
>>
>> cpuintc: cpuintc@0 {
>>     #address-cells = <0>;
>>     #interrupt-cells = <1>;
>>     interrupt-controller;
>>     compatible = "mti,cpu-intc";

Is it necessary to use the word 'intc'?  What does that mean?  Perhaps 
"mti,cpu-interrupt-controller"?

>> };
>
> Please use this as an actual device tree documentation binding.

Yes, bindings should be documented in Documentation/devicetree/bindings/mips


Just to satisfy my curiosity, Which drivers are using (or will be using) 
these mapping facilities?  The timer and performance counters already 
work, so it isn't needed for them.  What will use this.

David Daney

>
>>
>> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
>> Signed-off-by: John Crispin <blogic@openwrt.org>
>> ---
>>   arch/mips/include/asm/irq_cpu.h |    6 ++++++
>>   arch/mips/kernel/irq_cpu.c      |   42
>> +++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 48 insertions(+)
>>
>> diff --git a/arch/mips/include/asm/irq_cpu.h
>> b/arch/mips/include/asm/irq_cpu.h
>> index ef6a07c..3f11fdb 100644
>> --- a/arch/mips/include/asm/irq_cpu.h
>> +++ b/arch/mips/include/asm/irq_cpu.h
>> @@ -17,4 +17,10 @@ extern void mips_cpu_irq_init(void);
>>   extern void rm7k_cpu_irq_init(void);
>>   extern void rm9k_cpu_irq_init(void);
>>
>> +#ifdef CONFIG_IRQ_DOMAIN
>> +struct device_node;
>> +extern int mips_cpu_intc_init(struct device_node *of_node,
>> +                  struct device_node *parent);
>> +#endif
>> +
>>   #endif /* _ASM_IRQ_CPU_H */
>> diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
>> index 972263b..49bc9ca 100644
>> --- a/arch/mips/kernel/irq_cpu.c
>> +++ b/arch/mips/kernel/irq_cpu.c
>> @@ -31,6 +31,7 @@
>>   #include <linux/interrupt.h>
>>   #include <linux/kernel.h>
>>   #include <linux/irq.h>
>> +#include <linux/irqdomain.h>
>>
>>   #include <asm/irq_cpu.h>
>>   #include <asm/mipsregs.h>
>> @@ -113,3 +114,44 @@ void __init mips_cpu_irq_init(void)
>>           irq_set_chip_and_handler(i, &mips_cpu_irq_controller,
>>                        handle_percpu_irq);
>>   }
>> +
>> +#ifdef CONFIG_IRQ_DOMAIN
>> +static int mips_cpu_intc_map(struct irq_domain *d, unsigned int irq,
>> +                 irq_hw_number_t hw)
>> +{
>> +    static struct irq_chip *chip;
>> +
>> +    if (hw < 2 && cpu_has_mipsmt) {
>> +        /* Software interrupts are used for MT/CMT IPI */
>> +        chip = &mips_mt_cpu_irq_controller;
>> +    } else {
>> +        chip = &mips_cpu_irq_controller;
>> +    }
>> +
>> +    irq_set_chip_and_handler(irq, chip, handle_percpu_irq);
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct irq_domain_ops mips_cpu_intc_irq_domain_ops = {
>> +    .map = mips_cpu_intc_map,
>> +    .xlate = irq_domain_xlate_onecell,
>> +};
>> +
>> +int __init mips_cpu_intc_init(struct device_node *of_node,
>> +                  struct device_node *parent)
>> +{
>> +    struct irq_domain *domain;
>> +
>> +    /* Mask interrupts. */
>> +    clear_c0_status(ST0_IM);
>> +    clear_c0_cause(CAUSEF_IP);
>> +
>> +    domain = irq_domain_add_legacy(of_node, 8, MIPS_CPU_IRQ_BASE, 0,
>> +                       &mips_cpu_intc_irq_domain_ops, NULL);
>> +    if (!domain)
>> +        panic("Failed to add irqdomain for MIPS CPU\n");
>> +
>> +    return 0;
>> +}
>> +#endif /* CONFIG_IRQ_DOMAIN */
>>
>
>
>
>
