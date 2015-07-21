Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jul 2015 23:28:54 +0200 (CEST)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:17438 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011489AbbGUV2wq0941 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Jul 2015 23:28:52 +0200
X-IronPort-AV: E=Sophos;i="5.15,519,1432623600"; 
   d="scan'208";a="70518848"
Received: from irvexchcas07.broadcom.com (HELO IRVEXCHCAS07.corp.ad.broadcom.com) ([10.9.208.55])
  by mail-gw1-out.broadcom.com with ESMTP; 21 Jul 2015 15:38:56 -0700
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP Server
 (TLS) id 14.3.235.1; Tue, 21 Jul 2015 14:28:43 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.235.1; Tue, 21 Jul 2015 14:28:42 -0700
Received: from [10.12.156.244] (fainelli-linux [10.12.156.244]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id B44B540FE9;  Tue, 21 Jul
 2015 14:26:32 -0700 (PDT)
Message-ID: <55AEB91C.1020202@broadcom.com>
Date:   Tue, 21 Jul 2015 14:26:52 -0700
From:   Florian Fainelli <fainelli@broadcom.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.8.0
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 1/2] genirq: add chip_{suspend,resume} PM support to irq_chip
References: <20150619224123.GL4917@ld-irv-0074> <1434756403-379-1-git-send-email-computersforpeace@gmail.com> <alpine.DEB.2.11.1506201605290.4107@nanos> <55AE8E5D.8020700@gmail.com> <alpine.DEB.2.11.1507212316530.18576@nanos>
In-Reply-To: <alpine.DEB.2.11.1507212316530.18576@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <fainelli@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fainelli@broadcom.com
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

On 21/07/15 14:23, Thomas Gleixner wrote:
> On Tue, 21 Jul 2015, Florian Fainelli wrote:
>> On 20/06/15 07:11, Thomas Gleixner wrote:
>>> On Fri, 19 Jun 2015, Brian Norris wrote:
>>>> This patch adds a second set of suspend/resume hooks to irq_chip, this
>>>> time to represent *chip* suspend/resume, rather than IRQ suspend/resume.
>>>> These callbacks will always be called for an irqchip and are based on
>>>> the per-chip irq_chip_generic struct, rather than the per-IRQ irq_data
>>>> struct.
>>>
>>> There is no per-chip irq_chip_generic struct. It's only there if the
>>> irq chip has been instantiated as a generic chip.
>>>  
>>>>  /**
>>>>   * struct irq_chip - hardware interrupt chip descriptor
>>>>   *
>>>> @@ -317,6 +319,12 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
>>>>   * @irq_suspend:	function called from core code on suspend once per chip
>>>>   * @irq_resume:		function called from core code on resume once per chip
>>>>   * @irq_pm_shutdown:	function called from core code on shutdown once per chip
>>>> + * @chip_suspend:	function called from core code on suspend once per
>>>> + *			chip; for handling chip details even when no interrupts
>>>> + *			are in use
>>>> + * @chip_resume:	function called from core code on resume once per chip;
>>>> + *			for handling chip details even when no interrupts are
>>>> + *			in use
>>>>   * @irq_calc_mask:	Optional function to set irq_data.mask for special cases
>>>>   * @irq_print_chip:	optional to print special chip info in show_interrupts
>>>>   * @irq_request_resources:	optional to request resources before calling
>>>> @@ -357,6 +365,8 @@ struct irq_chip {
>>>>  	void		(*irq_suspend)(struct irq_data *data);
>>>>  	void		(*irq_resume)(struct irq_data *data);
>>>>  	void		(*irq_pm_shutdown)(struct irq_data *data);
>>>> +	void		(*chip_suspend)(struct irq_chip_generic *gc);
>>>> +	void		(*chip_resume)(struct irq_chip_generic *gc);
>>>
>>> I really don't want to set a precedent for random (*foo)(*bar)
>>> callbacks.
>>>  
>>>> +
>>>> +		if (ct->chip.chip_suspend)
>>>> +			ct->chip.chip_suspend(gc);
>>>
>>> So wouldn't it be the more intuitive solution to make this a callback
>>> in the struct gc itself?
>>
>> Brian can correct me, but his approach is more generic, if there is
>> another irqchip driver needing a similar infrastructure, this would be
>> already there, and directly usable.
> 
> No it's not directly usable. It's only usable with irq_chip_generic
> incarnations.
> 
>> Maybe all we need to is to change the chip_suspend/resume arguments
>> to pass a reference to irq_chip instead?
> 
> I just read back on the problem report which was mentioned in the
> changelog:
> 
> "It's not a problem with patch 7, exactly, it's a problem with the
>  irqchip driver which handles the UART interrupt mask (irq-bcm7120-l2.c).
>  The problem is that with a trimmed down device tree (such as the one
>  found at arch/arm/boot/dts/bcm7445-bcm97445svmb.dtb), none of the child
>  interrupts of the 'irq0_intc' node are described -- we don't have device
>  tree nodes for them yet -- but we still require saving and restoring the
>  forwarding mask (see 'brcm,int-fwd-mask') in order for the UART
>  interrupts to continue operating."
> 
> So you are trying to work around a flaw in the device tree by adding
> random callbacks to the core kernel?

Not quite, you could have your interrupt controller node declared in
Device Tree, but have no "interrupts" property referencing it because:

- the hardware is just not there, but you inherit a common Device Tree
skleten (*.dtsi)
- you could have Device Tree overlays which may or may not be loaded as
a result of finding expansion boards etc...

It just appeared that Brian was specifically testing with something that
exposed the problem.
-- 
Florian
