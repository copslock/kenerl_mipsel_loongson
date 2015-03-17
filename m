Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Mar 2015 13:16:59 +0100 (CET)
Received: from mail-oi0-f42.google.com ([209.85.218.42]:36472 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008388AbbCQMQ5nGhz6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Mar 2015 13:16:57 +0100
Received: by oigv203 with SMTP id v203so6222758oig.3
        for <linux-mips@linux-mips.org>; Tue, 17 Mar 2015 05:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=JHLHc2hTVxewxsgkfvzz0GvB8+9khM4g0doIVEC+Ft0=;
        b=FCX1Vcc/xkatCJM5W4xPuzViEdIX/JpskccqHd+Ijpv1cBFVR996zua0nofVbiKue0
         ADN1LipBp4vSFxQegewaOiJRRuZV5+GbPeUlhX+MVfR5Q6my4vMobbDf9aH2prZgKGny
         BwwfjGXwDs7Kmnp90aZ7Jz9c4Bncou6diMKZ8FAX0ghbEwg00ApolYTrKDMwEO2SFuk5
         qWoaeIaGFFfNIPTgG588UpNfJfuh3/71PKYn9ib5W0AeEHZiO/5X/V0av13ThxeieE20
         EBtsDTvTJ8bwMssfXNKpSNmXY03R38tnf6oYS7GDI4htJ2IdAaZX2YHrfOV50gOs9phM
         sOHQ==
X-Gm-Message-State: ALoCoQlT1bnskn/Ai0wWWwX5q0jAR9sFupT3yorqJ+sX1MKCT6wAd7q8zq9pQAKIMFYn937PUwgL
MIME-Version: 1.0
X-Received: by 10.182.241.99 with SMTP id wh3mr9014415obc.81.1426594612456;
 Tue, 17 Mar 2015 05:16:52 -0700 (PDT)
Received: by 10.182.132.45 with HTTP; Tue, 17 Mar 2015 05:16:52 -0700 (PDT)
In-Reply-To: <CAL1qeaHzpi3_PNpxnLOf=b8d2n5DrRrnB_yiZFHpiP8C7b0hSg@mail.gmail.com>
References: <1424744104-14151-1-git-send-email-abrestic@chromium.org>
        <1424744104-14151-3-git-send-email-abrestic@chromium.org>
        <CACRpkdbqioAreyDwM2JN87=gH20n1OkUXPjdkW885iDWUV1NnA@mail.gmail.com>
        <CAL1qeaHzpi3_PNpxnLOf=b8d2n5DrRrnB_yiZFHpiP8C7b0hSg@mail.gmail.com>
Date:   Tue, 17 Mar 2015 13:16:52 +0100
Message-ID: <CACRpkdbt4MQYY7MqjFN-1Dp0am1PaOZ1YL+bKc8SJrtFDnSW_Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: Add Pistachio SoC pin control driver
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Alexandre Courbot <gnurou@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Govindraj Raja <govindraj.raja@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Fri, Mar 6, 2015 at 7:51 PM, Andrew Bresticker <abrestic@chromium.org> wrote:
> On Fri, Mar 6, 2015 at 3:55 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

>>> +static inline void gpio_writel(struct pistachio_gpio_bank *bank, u32 val,
>>> +                              u32 reg)
>>> +{
>>> +       writel(val, bank->base + reg);
>>> +}
>>
>> I don't see the point of these special readl/writel accessors. Just
>> use readl/writel
>> directly. Or consider readl/writel_relaxed() if MIPS has this.
>
> I actually find these useful for tracing MMIO accesses within a driver
> and it seems many other drivers do this too.  I can drop them though
> if you'd prefer.

OK does it turn up in ftrace etc? I was thinking these would be
inlined by the compiler (especially since you even state they shall
be inlined) and the symbols trashed?

>> (...)
>>> +static int pistachio_gpio_register(struct pistachio_pinctrl *pctl)
>>> +{
>>> +       struct device_node *child, *node = pctl->dev->of_node;
>>> +       struct pistachio_gpio_bank *bank;
>>> +       unsigned int i = 0;
>>> +       int irq, ret = 0;
>>> +
>>> +       for_each_child_of_node(node, child) {
>>> +               if (!of_find_property(child, "gpio-controller", NULL))
>>> +                       continue;
>>
>> So why not instead specify "simple-bus" as compatible on the parent node
>> and have each subnode be its own device (simple-bus will spawn platform
>> devices for all subnodes).
>>
>> Overall this composite-device pattern is discouraged if we can instead have
>> unique devices for each bank.
>
> I think there's an issue here though if some other device probes
> between the pinctrl driver and the gpiochip drivers.  Since all these
> pins are configured as GPIOs at POR, the pinctrl driver needs to clear
> the GPIO enable bit on a pin when enabling a pinmux function for that
> pin (see pistachio_pinmux_enable()).  If the gpiochip driver has yet
> to probe, attempting to map the pinctrl pin to a GPIO range/pin (via
> pinctrl_find_gpio_range_from_pin()) will fail and we won't be able to
> disable the GPIO function for that pin.

I was thinking the GPIO driver part should get a -EPROBE_DEFER when
trying to call gpiochip_add_pin_range() and continue later when the
pin controller is available?

And all drivers using GPIOs in turn get a -EPROBE_DEFER when
trying to get GPIOs on a not-yet registered GPIO chip.

Sorry if I don't really know how things work now... :(
It seems like a logical way to me.

>  Also it doesn't look like
> there's a good way to tell gpiolib to disable a GPIO form the pinctrl
> driver.

Define exactly what you mean by "disable". There is
pinctrl_free_gpio().

>  Any ideas?  I suppose I could keep the pin-to-GPIO mapping in
> the pinctrl driver in addition to expressing it in the DT with
> gpio-ranges, but that doesn't seem too nice.

The ranges shall definately be registered from the GPIO side of
the driver, that much I can tell you for sure...

Yours,
Linus Walleij
