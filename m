Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Mar 2015 17:56:48 +0100 (CET)
Received: from mail-qc0-f178.google.com ([209.85.216.178]:35827 "EHLO
        mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008995AbbCQQ4qihOlO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Mar 2015 17:56:46 +0100
Received: by qcbkw5 with SMTP id kw5so14288784qcb.2
        for <linux-mips@linux-mips.org>; Tue, 17 Mar 2015 09:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=nbc1O8CAWnqWrn5nSUi2ifYbfGEvhEca7D9UVa+g0a4=;
        b=W5VP0WHzuIi0Iih+SntIGns2YUQlWDb3QUjaMIWlOtxIKRtTmotNZTjMHfn9p/lp+K
         zjQjhPMuWuUCGGzWg+J7dT72+HHUhXadFMKOZiYwqoF5BeRRSSmz3DkPNYBAmpKqjDTx
         hny6Tbn7PDtthoaio+MKf+CecCOdOGI/7fiIby0VlFOA9zHnNKoa/KTog6jJfrsAbyZu
         oKmsypq/TfXIbSfaM+HGAK+5N63CWZnQ1D291D/AxDxLxlu5ltde65qR/Lqy3ceYRyn9
         8AtYMfQ5X6CKjQiQYLax05mjWy4oGuGC7FJKnGBPzIR+nhUYKa4oxDzRbqRY7ZNSs0nk
         PUeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=nbc1O8CAWnqWrn5nSUi2ifYbfGEvhEca7D9UVa+g0a4=;
        b=DTAuxxZteKvkYpc6DlMTdDIBsUIiK1tDFo5NrvJjvCvmRksAHpzm1bAc5Eqhs3gY5p
         7I1ErRB2kipU6fK3cVl+UR6aYeklMcKAULNHSn/8+dICT3MQBnZNhju29x1kxvfoEJ9F
         4TsRK3+nxi05EhyG3EhyckT8o+xmBofFu9qug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=nbc1O8CAWnqWrn5nSUi2ifYbfGEvhEca7D9UVa+g0a4=;
        b=TJ5wOtN/0MYsPFIGEZELyuYshtWFQxtDiM/pb8IoaDjiFVcGqwJ9sYo+hwLYzwcujC
         AVZ3IOt4a7Yw71r4aRQ9tiwUe15Qy2I3s3ymIkHyQ/GGeiDlqCUioTD8/9OppnIwVBNt
         UbgOSfi+Y3hvdpGb83NxMXCgwCFny8W2C7GGQjT5jjxYfrE3giVohP5ufwKDt2Fxppe3
         fgxgcc4gnBYQvWKurXaEwAs3WMwD+m6sHG6p94aGC6fcM6/phyOxMp70+cg1BoHC6Qt7
         FEO0chScDhsrQiM+F24dO+l3ErFd0Kyf0aNH3GyHStiJeciMigP7J7I1WOIXtFAn4z7I
         LKIw==
X-Gm-Message-State: ALoCoQmnoMsANGINUUqCsTi7YfxNBAvn2X+ttH3W8lKRxy7D/w3KTOcSITJMrtUa60BIsegE6o3T
MIME-Version: 1.0
X-Received: by 10.55.16.83 with SMTP id a80mr121450106qkh.86.1426611401495;
 Tue, 17 Mar 2015 09:56:41 -0700 (PDT)
Received: by 10.140.19.72 with HTTP; Tue, 17 Mar 2015 09:56:41 -0700 (PDT)
In-Reply-To: <CACRpkdbt4MQYY7MqjFN-1Dp0am1PaOZ1YL+bKc8SJrtFDnSW_Q@mail.gmail.com>
References: <1424744104-14151-1-git-send-email-abrestic@chromium.org>
        <1424744104-14151-3-git-send-email-abrestic@chromium.org>
        <CACRpkdbqioAreyDwM2JN87=gH20n1OkUXPjdkW885iDWUV1NnA@mail.gmail.com>
        <CAL1qeaHzpi3_PNpxnLOf=b8d2n5DrRrnB_yiZFHpiP8C7b0hSg@mail.gmail.com>
        <CACRpkdbt4MQYY7MqjFN-1Dp0am1PaOZ1YL+bKc8SJrtFDnSW_Q@mail.gmail.com>
Date:   Tue, 17 Mar 2015 09:56:41 -0700
X-Google-Sender-Auth: 0reI4D9Xapp2OFIQXXlab1aPllM
Message-ID: <CAL1qeaHCKPeQnf8VPWmz_=uN1=_mxWbMGF+HuPZ_AYOqA+15JA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: Add Pistachio SoC pin control driver
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>
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
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

On Tue, Mar 17, 2015 at 5:16 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Mar 6, 2015 at 7:51 PM, Andrew Bresticker <abrestic@chromium.org> wrote:
>> On Fri, Mar 6, 2015 at 3:55 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>
>>>> +static inline void gpio_writel(struct pistachio_gpio_bank *bank, u32 val,
>>>> +                              u32 reg)
>>>> +{
>>>> +       writel(val, bank->base + reg);
>>>> +}
>>>
>>> I don't see the point of these special readl/writel accessors. Just
>>> use readl/writel
>>> directly. Or consider readl/writel_relaxed() if MIPS has this.
>>
>> I actually find these useful for tracing MMIO accesses within a driver
>> and it seems many other drivers do this too.  I can drop them though
>> if you'd prefer.
>
> OK does it turn up in ftrace etc? I was thinking these would be
> inlined by the compiler (especially since you even state they shall
> be inlined) and the symbols trashed?

Right, the functions as-is won't show up as trace events, but they can
be easily modified to do so.

>>> (...)
>>>> +static int pistachio_gpio_register(struct pistachio_pinctrl *pctl)
>>>> +{
>>>> +       struct device_node *child, *node = pctl->dev->of_node;
>>>> +       struct pistachio_gpio_bank *bank;
>>>> +       unsigned int i = 0;
>>>> +       int irq, ret = 0;
>>>> +
>>>> +       for_each_child_of_node(node, child) {
>>>> +               if (!of_find_property(child, "gpio-controller", NULL))
>>>> +                       continue;
>>>
>>> So why not instead specify "simple-bus" as compatible on the parent node
>>> and have each subnode be its own device (simple-bus will spawn platform
>>> devices for all subnodes).
>>>
>>> Overall this composite-device pattern is discouraged if we can instead have
>>> unique devices for each bank.
>>
>> I think there's an issue here though if some other device probes
>> between the pinctrl driver and the gpiochip drivers.  Since all these
>> pins are configured as GPIOs at POR, the pinctrl driver needs to clear
>> the GPIO enable bit on a pin when enabling a pinmux function for that
>> pin (see pistachio_pinmux_enable()).  If the gpiochip driver has yet
>> to probe, attempting to map the pinctrl pin to a GPIO range/pin (via
>> pinctrl_find_gpio_range_from_pin()) will fail and we won't be able to
>> disable the GPIO function for that pin.
>
> I was thinking the GPIO driver part should get a -EPROBE_DEFER when
> trying to call gpiochip_add_pin_range() and continue later when the
> pin controller is available?

Right.

> And all drivers using GPIOs in turn get a -EPROBE_DEFER when
> trying to get GPIOs on a not-yet registered GPIO chip.

Right.

> Sorry if I don't really know how things work now... :(
> It seems like a logical way to me.

OK, let me try to run through an example:

1) Initially all pins (except for those set up by the firmware) are
configured as GPIOs.
2) The pinctrl driver probes.
3) Another driver, e.g. an I2C controller attempts to probe and
pinmux_enable_setting() is called.
4) The ->set_mux() op must set the proper function for the pin.
5) The ->set_mux() op must also disable the GPIO function for the pin.
To disable the GPIO function, the pinctrl driver must map the pin to a
GPIO bank/offset and disable the GPIO via the GPIO bank's GPIO_EN
register.

Now to map the pin back to a GPIO bank/offset, I had been using
pinctrl_find_gpio_range_from_pin(), which works just fine if the GPIO
driver has already probed.  But in the example above, we haven't
probed the GPIO driver yet so we're unable to do the mapping.  This
particular issue, I think, could by returning -EPROBE_DEFER from
->set_mux() if we're enable to look up the GPIO bank.

>>  Also it doesn't look like
>> there's a good way to tell gpiolib to disable a GPIO form the pinctrl
>> driver.
>
> Define exactly what you mean by "disable". There is
> pinctrl_free_gpio().

Each GPIO bank has a GPIO_EN register which enables the GPIO function
for the corresponding pin, overriding the function selected in the
pinctrl registers.  What I think we need here is pinctrl_free_gpio()
in the reverse direction: a way for the pinctrl driver to tell the
GPIO driver to disable the GPIO function for a particular pin.  Now we
could hack around this by having the pinctrl driver do the mapping
from pin to GPIO bank/offset and modifying the GPIO bank registers
itself, but that seems a bit ugly.

Thanks,
Andrew
