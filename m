Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Mar 2015 19:52:01 +0100 (CET)
Received: from mail-qc0-f182.google.com ([209.85.216.182]:40316 "EHLO
        mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008276AbbCFSv7MwBji (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Mar 2015 19:51:59 +0100
Received: by qcvs11 with SMTP id s11so18681746qcv.7
        for <linux-mips@linux-mips.org>; Fri, 06 Mar 2015 10:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=rzZmu1iCduyWGHtd6BqQTbSckWXyAS5G+9SDwjgHDVU=;
        b=lOi0Dqkd7BNHxfrpH/LxxpoK+FZZMhNN+DCZBgPKhmSw49bvflL7jdFLCoMsngA4A9
         C+h5V8Q7EPQFViqtVYX80n7lz01HxRVuOJlY0isTW5kN4uu7Rfr2dk7JuMb+cjBvX5q+
         Ow7d9m//ScJI6qC7K2Nq58KREVyfXSqRS4AWJvt21qV57yASVHEKlFHHGgCJ+UCzgsBm
         mLuiHmf0vrcMN4kuoTb6DAXc/s9oNnLXQIyBHuBO0km5RCO6qwRTB3ml0odjLDEpfkaG
         O973pDOMj0yAou7PhMU/vASTbsCTpKdEslYQ8Jti+n9kFSPXziu5t8NMVJXjyrQOG6RS
         yfcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=rzZmu1iCduyWGHtd6BqQTbSckWXyAS5G+9SDwjgHDVU=;
        b=cPS+HpUdibsIenLPkPKxwbuylT8v4ZcZ1O2YrNYYoLR+axMi7GXnRUpUhwKySKuHff
         tuklziKNaPDmwdvQBJDlP8hcGvj2nZ7ZZ11827f+EBVTsuWK6XnaB0sq37oLL1LCJUqV
         ef2yNu41ct82+M483XitR2gfD6mAcTnt7phbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=rzZmu1iCduyWGHtd6BqQTbSckWXyAS5G+9SDwjgHDVU=;
        b=ftd60UN5rH6CV9oCj7Iqj+s05Ote6wK3woKJoFrKiX1ndUFBD78gKGwuAoGnzL3thn
         wu4HILGThuqHqfph7u4HjVRK05cZp9D0DyaXsz/Wmt2l8uhMKGJp1APd72a7mnAKG8fh
         B3EZMyUY3egx4RzSrj/AVAWgyAG03+39TtFoLJMc5Wuat11mbpASKF8ng+frVaBr3+QS
         yV4lhOm2vyIcYgPxKM28swfVgWc+XtReu2lsCm1HWIlFgwwJrYRZvQUGvNDF+mZHGH5P
         ulcFU+H5dTx2sDB9eNpbhHl1gtytYj1VSf7DmIaxQOUDx1uJ1u7C3h9NFtWdy2jOU+Sl
         QHRQ==
X-Gm-Message-State: ALoCoQm8TBcJVRl7TwAErGvs6QskszxT3UNXTQbZJsayZvsyz4Cc6jwaIlAGo6SW+c3urJAR7dBD
MIME-Version: 1.0
X-Received: by 10.140.151.13 with SMTP id 13mr21785879qhx.68.1425667913795;
 Fri, 06 Mar 2015 10:51:53 -0800 (PST)
Received: by 10.140.19.72 with HTTP; Fri, 6 Mar 2015 10:51:53 -0800 (PST)
In-Reply-To: <CACRpkdbqioAreyDwM2JN87=gH20n1OkUXPjdkW885iDWUV1NnA@mail.gmail.com>
References: <1424744104-14151-1-git-send-email-abrestic@chromium.org>
        <1424744104-14151-3-git-send-email-abrestic@chromium.org>
        <CACRpkdbqioAreyDwM2JN87=gH20n1OkUXPjdkW885iDWUV1NnA@mail.gmail.com>
Date:   Fri, 6 Mar 2015 10:51:53 -0800
X-Google-Sender-Auth: 7IL1l-9z4Im9fFiZ1rnTbjECYaQ
Message-ID: <CAL1qeaHzpi3_PNpxnLOf=b8d2n5DrRrnB_yiZFHpiP8C7b0hSg@mail.gmail.com>
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
X-archive-position: 46242
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

On Fri, Mar 6, 2015 at 3:55 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Feb 24, 2015 at 3:15 AM, Andrew Bresticker
> <abrestic@chromium.org> wrote:
>
>> Add a driver for the pin controller present on the IMG Pistachio SoC.
>> This driver provides pinmux and pinconfig operations as well as GPIO
>> and IRQ chips for the GPIO banks.
>>
>> Signed-off-by: Damien Horsley <Damien.Horsley@imgtec.com>
>> Signed-off-by: Govindraj Raja <govindraj.raja@imgtec.com>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>
> (...)
>> +static inline u32 pctl_readl(struct pistachio_pinctrl *pctl, u32 reg)
>> +{
>> +       return readl(pctl->base + reg);
>> +}
>> +
>> +static inline void pctl_writel(struct pistachio_pinctrl *pctl, u32 val, u32 reg)
>> +{
>> +       writel(val, pctl->base + reg);
>> +}
>> +
>> +static inline u32 gpio_readl(struct pistachio_gpio_bank *bank, u32 reg)
>> +{
>> +       return readl(bank->base + reg);
>> +}
>> +
>> +static inline void gpio_writel(struct pistachio_gpio_bank *bank, u32 val,
>> +                              u32 reg)
>> +{
>> +       writel(val, bank->base + reg);
>> +}
>
> I don't see the point of these special readl/writel accessors. Just
> use readl/writel
> directly. Or consider readl/writel_relaxed() if MIPS has this.

I actually find these useful for tracing MMIO accesses within a driver
and it seems many other drivers do this too.  I can drop them though
if you'd prefer.

>> +static inline void gpio_mask_writel(struct pistachio_gpio_bank *bank,
>> +                                   u32 reg, unsigned int bit, u32 val)
>> +{
>> +       gpio_writel(bank, (0x10000 | val) << bit, reg);
>> +}
>
> Magic mask? Some comment on what is happening here when OR:in
> on 0x10000?

Sure.

> (...)
>> +static int pistachio_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
>> +{
>> +       struct pistachio_gpio_bank *bank = gc_to_bank(chip);
>> +
>> +       if (gpio_readl(bank, GPIO_OUTPUT_EN) & BIT(offset))
>> +               return GPIOF_DIR_OUT;
>> +       return GPIOF_DIR_IN;
>> +}
>
> These flags are not for the driver API.
>
> Do this:
>
> return !gpio_readl(bank, GPIO_OUTPUT_EN) & BIT(offset));

Ok.

> (...)
>> +static void pistachio_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>> +{
>> +       struct gpio_chip *gc = irq_get_handler_data(irq);
>> +       struct pistachio_gpio_bank *bank = gc_to_bank(gc);
>> +       struct irq_chip *chip = irq_get_chip(irq);
>> +       unsigned long pending;
>> +       unsigned int pin, virq;
>
> Don't call it virq, just call it irq. All Linux irq numbers are virtual
> so just go with irq.

Ok.

> (...)
>> +static int pistachio_gpio_register(struct pistachio_pinctrl *pctl)
>> +{
>> +       struct device_node *child, *node = pctl->dev->of_node;
>> +       struct pistachio_gpio_bank *bank;
>> +       unsigned int i = 0;
>> +       int irq, ret = 0;
>> +
>> +       for_each_child_of_node(node, child) {
>> +               if (!of_find_property(child, "gpio-controller", NULL))
>> +                       continue;
>
> So why not instead specify "simple-bus" as compatible on the parent node
> and have each subnode be its own device (simple-bus will spawn platform
> devices for all subnodes).
>
> Overall this composite-device pattern is discouraged if we can instead have
> unique devices for each bank.

I think there's an issue here though if some other device probes
between the pinctrl driver and the gpiochip drivers.  Since all these
pins are configured as GPIOs at POR, the pinctrl driver needs to clear
the GPIO enable bit on a pin when enabling a pinmux function for that
pin (see pistachio_pinmux_enable()).  If the gpiochip driver has yet
to probe, attempting to map the pinctrl pin to a GPIO range/pin (via
pinctrl_find_gpio_range_from_pin()) will fail and we won't be able to
disable the GPIO function for that pin.  Also it doesn't look like
there's a good way to tell gpiolib to disable a GPIO form the pinctrl
driver.  Any ideas?  I suppose I could keep the pin-to-GPIO mapping in
the pinctrl driver in addition to expressing it in the DT with
gpio-ranges, but that doesn't seem too nice.

> Apart from these things the driver looks very nice!

Thanks for the review!

-Andrew
