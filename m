Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Nov 2013 17:55:52 +0100 (CET)
Received: from mail-ob0-f181.google.com ([209.85.214.181]:43876 "EHLO
        mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823162Ab3K2Qzqa0t4c convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 29 Nov 2013 17:55:46 +0100
Received: by mail-ob0-f181.google.com with SMTP id uy5so10168354obc.40
        for <multiple recipients>; Fri, 29 Nov 2013 08:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=kQGCBSbvVAkdM5Apcz5/BmrBd+G3I+vg4KIdheU9sYQ=;
        b=gxNvO4IaQQFpAYMKfG1k3WbXhBLSAkcMCYhDRQkiG2oCfYsKrfBkXiiHtx1AJEBzLE
         Yg1vfH3SezdnrSdPTXgmO6Ea0DsFhayXe/gjDb5pYRpTMRRgmv6nvzPwij0VDUCJAO1o
         BbUmmEplJHzYlRM1R2EmmzUXa+fSI84AIrAgovVYNn49C/IgDOqSN1/3suZoLNJI7DRb
         vVMOZl1GT2+EKBflpxsBW/dKWf0Ie7A5RJTFxUCCRmmgnc0mw+1dLk7Ej8PHz9bGvzyP
         yvUmGcgdg1+Rlm+Zqr/Ckahl4wQypKgG8IE3F5Ad/sCO4O1S8YR2hHe0bPIAGUdmQqoV
         SVYw==
MIME-Version: 1.0
X-Received: by 10.182.246.98 with SMTP id xv2mr1619048obc.92.1385744139927;
 Fri, 29 Nov 2013 08:55:39 -0800 (PST)
Received: by 10.76.73.8 with HTTP; Fri, 29 Nov 2013 08:55:39 -0800 (PST)
In-Reply-To: <5298C15F.2040101@hauke-m.de>
References: <1385741397-32740-1-git-send-email-zajec5@gmail.com>
        <5298C15F.2040101@hauke-m.de>
Date:   Fri, 29 Nov 2013 17:55:39 +0100
Message-ID: <CACna6rwcvcZAtiynsPk1T4OdZxOQCEs3SQYC_4_RKMSd5mLjGg@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] bcma: gpio: add own IRQ domain
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

2013/11/29 Hauke Mehrtens <hauke@hauke-m.de>:
> On 11/29/2013 05:09 PM, Rafał Miłecki wrote:
>> Input GPIO changes can generate interrupts, but we need kind of ACK for
>> them by changing IRQ polarity. This is required to stop hardware from
>> keep generating interrupts and generate another one on the next GPIO
>> state change.
>> This code allows using GPIOs with standard interrupts and add for
>> example GPIO buttons support.
>
> As far as I know IRQs for GPIOs are only support on SoCs and not on PCIe
> wifi cards like the BCM43224. I think the dependency to IRQ_DOMAIN
> should only be added when BCMA_HOST_SOC is set.

Sounds sane.


>> +     for_each_set_bit(gpio, (unsigned long *)&irqs, cc->gpio.ngpio) {
>> +             generic_handle_irq(bcma_gpio_to_irq(&cc->gpio, gpio));
>> +             bcma_chipco_gpio_polarity(cc, BIT(gpio),
>> +                                       (val & BIT(gpio)) ? BIT(gpio) : 0);
>
> What about setting this once for all irqs at the end of this function?
> bcma_chipco_gpio_polarity() takes an lock.

OK


>>  int bcma_gpio_init(struct bcma_drv_cc *cc)
>>  {
>>       struct gpio_chip *chip = &cc->gpio;
>> +     unsigned int hwirq, gpio;
>> +     int err;
>>
>> +     /*
>> +      * GPIO chip
>> +      */
>>       chip->label             = "bcma_gpio";
>>       chip->owner             = THIS_MODULE;
>>       chip->request           = bcma_gpio_request;
>> @@ -104,8 +152,48 @@ int bcma_gpio_init(struct bcma_drv_cc *cc)
>>               chip->base              = 0;
>>       else
>>               chip->base              = -1;
>> +     err = gpiochip_add(chip);
>> +     if (err)
>> +             goto err_gpiochip_add;
>
> Shouldn't the gpio chip be registered after we set up the irq handling
> so no one uses it before?

I don't know.

gpio-tegra.c calls functions in this order:
1) gpiochip_add
2) irq_create_mapping3
3) irq_set_chip_and_handler
4) irq_set_chained_handler

gpio-msm-v2:
1) gpiochip_add
2) irq_domain_add_linear
3) irq_set_chained_handler

gpio-mpc8xxx.c: like above

gpio-adnp.c on the other hand:
1) irq_domain_add_linear
2) request_threaded_irq
3) gpiochip_add

gpio-grgpio.c:
1) irq_domain_add_linear
2) gpiochip_add

So that differs pretty much between the drivers.

But I think calling "gpiochip_add" at the end makes some sense. I
guess I was looking at gpio-tegra.c too much.


>> +     for (gpio = 0; gpio < chip->ngpio; gpio++) {
>> +             int irq = irq_create_mapping(cc->irq_domain, gpio);
>> +
>> +             irq_set_chip_data(irq, cc);
>> +             irq_set_chip_and_handler(irq, &bcma_gpio_irq_chip,
>> +                                      handle_simple_irq);
>> +     }
>
> Is there some method needed to free or unregister these functions? This
> could be build as an module when it is not used on a SoC.

Yes: irq_dispose_mapping (it calls irq_set_chip_and_handler with NULL
and NULL for us). I'll use it.

-- 
Rafał
