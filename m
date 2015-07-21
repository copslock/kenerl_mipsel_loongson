Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jul 2015 20:26:33 +0200 (CEST)
Received: from mail-pd0-f181.google.com ([209.85.192.181]:35187 "EHLO
        mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011417AbbGUS0bApuRl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Jul 2015 20:26:31 +0200
Received: by pdrg1 with SMTP id g1so124555093pdr.2
        for <linux-mips@linux-mips.org>; Tue, 21 Jul 2015 11:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=+99wxfmf720HzyEfuvXa7ns0aPFuWa4WPs6Bh5Xfqh0=;
        b=tA1TE5tNi3ZfPUP24CFmgrK8OXyw3FZSTDsrqsxD1UEv8tS5NzTSfNH0L17mp33Vtl
         3ERDTHgAHlQyI2iA21j30dRF8VOdbS0+Svchj5AWRPaSLKiIuunNJXT/6QMiMNQAgS8r
         z5E/tH4ElGFj4KlnZ5FKJfMiFkdP2YztG1CYK9tEPLhq885DCCi4/QaKoudj0GEZmMKH
         c+Pwf/zH5/gNtfEf/ys3e2nJ4v3p+bRW7Rx3aoTUVoGoD9zWTayTrSY2PPrlhcnXs03m
         VWv4BNfU4fIMJ/wjSC6pEe1PwwBm6wyOZ6e7a1G+1L9KSVSvMjSwh+03/d0v9vSD9/4d
         1qTA==
X-Received: by 10.70.53.99 with SMTP id a3mr75894776pdp.169.1437503184835;
        Tue, 21 Jul 2015 11:26:24 -0700 (PDT)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id db1sm28766083pdb.50.2015.07.21.11.26.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2015 11:26:23 -0700 (PDT)
Message-ID: <55AE8E5D.8020700@gmail.com>
Date:   Tue, 21 Jul 2015 11:24:29 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>,
        Brian Norris <computersforpeace@gmail.com>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Kevin Cernekee <cernekee@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 1/2] genirq: add chip_{suspend,resume} PM support to irq_chip
References: <20150619224123.GL4917@ld-irv-0074> <1434756403-379-1-git-send-email-computersforpeace@gmail.com> <alpine.DEB.2.11.1506201605290.4107@nanos>
In-Reply-To: <alpine.DEB.2.11.1506201605290.4107@nanos>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48366
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

On 20/06/15 07:11, Thomas Gleixner wrote:
> On Fri, 19 Jun 2015, Brian Norris wrote:
>> This patch adds a second set of suspend/resume hooks to irq_chip, this
>> time to represent *chip* suspend/resume, rather than IRQ suspend/resume.
>> These callbacks will always be called for an irqchip and are based on
>> the per-chip irq_chip_generic struct, rather than the per-IRQ irq_data
>> struct.
> 
> There is no per-chip irq_chip_generic struct. It's only there if the
> irq chip has been instantiated as a generic chip.
>  
>>  /**
>>   * struct irq_chip - hardware interrupt chip descriptor
>>   *
>> @@ -317,6 +319,12 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
>>   * @irq_suspend:	function called from core code on suspend once per chip
>>   * @irq_resume:		function called from core code on resume once per chip
>>   * @irq_pm_shutdown:	function called from core code on shutdown once per chip
>> + * @chip_suspend:	function called from core code on suspend once per
>> + *			chip; for handling chip details even when no interrupts
>> + *			are in use
>> + * @chip_resume:	function called from core code on resume once per chip;
>> + *			for handling chip details even when no interrupts are
>> + *			in use
>>   * @irq_calc_mask:	Optional function to set irq_data.mask for special cases
>>   * @irq_print_chip:	optional to print special chip info in show_interrupts
>>   * @irq_request_resources:	optional to request resources before calling
>> @@ -357,6 +365,8 @@ struct irq_chip {
>>  	void		(*irq_suspend)(struct irq_data *data);
>>  	void		(*irq_resume)(struct irq_data *data);
>>  	void		(*irq_pm_shutdown)(struct irq_data *data);
>> +	void		(*chip_suspend)(struct irq_chip_generic *gc);
>> +	void		(*chip_resume)(struct irq_chip_generic *gc);
> 
> I really don't want to set a precedent for random (*foo)(*bar)
> callbacks.
>  
>> +
>> +		if (ct->chip.chip_suspend)
>> +			ct->chip.chip_suspend(gc);
> 
> So wouldn't it be the more intuitive solution to make this a callback
> in the struct gc itself?

Brian can correct me, but his approach is more generic, if there is
another irqchip driver needing a similar infrastructure, this would be
already there, and directly usable. Maybe all we need to is to change
the chip_suspend/resume arguments to pass a reference to irq_chip instead?

I can go ahead and rewrite that part of the patch to make this is
exclusively located to the irq_chip_generic structure instead.
--
Florian
