Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2015 00:56:30 +0200 (CEST)
Received: from mail-qc0-f179.google.com ([209.85.216.179]:33882 "EHLO
        mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011926AbbD1W42mvq00 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Apr 2015 00:56:28 +0200
Received: by qcyk17 with SMTP id k17so5410424qcy.1
        for <linux-mips@linux-mips.org>; Tue, 28 Apr 2015 15:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2PAcYgNmmC+eBDf4jlTWibrt/D5BvNITTXpwbxSPEfg=;
        b=jIUzZaCpqJZ9aVNGtX4l4g80Ae4BXEmiKfFpNjkVsrY9KQrcQSSrZ9ckx/ynrZoyUQ
         BaeLa/+ePzfU7J3yZprMI3wpFZ1CIkNENL1ZWfjbdh9KVwPBbBs3xEB9PsoSd4mzzQ/O
         njGAVON4GfGCuhVSu4jVyEJIxHUxntqOMmZKnPUJEMzqVlvfKBC4OzIaeHtPiKHqBbCu
         B7SAxY12EXGNoqRf2q63EFJ0gtcVaxQ4Xth8MXUMP2GU4X2yPgLZfO32xbSMTDg6MArs
         S+zt2CZsHD5lA7XzYkI9fRUZQW2epvvxDizwLYg1IxTlmSTbI+zVpjmvLTfcjqFH173j
         HdAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2PAcYgNmmC+eBDf4jlTWibrt/D5BvNITTXpwbxSPEfg=;
        b=nvqwC1bXq3RJajjNWooUWx3FKhZyjLVcr0adNauAjBaXKBcaP9DCZLPBANGieqYmSa
         exi08NC/9wdrWNIwgbwBRrFUo4tDfT/zAqBHWCt5nYGXPJ66HlIeX4RgDVDZX80pPoj3
         Caf8RBzVVQu+0z78vr/oIhLcazCTdNlSECMEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=2PAcYgNmmC+eBDf4jlTWibrt/D5BvNITTXpwbxSPEfg=;
        b=BSJuHjvoAMB0RfCf+wsES7h8mAokMqgfoJ+2VkJCFn42BYuxZexaCA9TYUDaUHjW0n
         95BmEsSMeHDFi3v/8PbMPehg5rTnTbyzoCyrb3vY/tsOMQhvB2mxYMU1ztbvic4rAQxz
         IcH79+0g12HmgI5nF0PlZl1QDTMIcRdSFddq8cEJiQZOSn9nhqHDLfElA16jOA3pS65s
         kXYbz8Ov4EN1dYhRuP1GXaZ/eOEw+cemno6vr3K7aWz/D1OmHHGeM47HQWcUKzzOylss
         JS5X4jICP29fkQ0uKkr8WIKCDumZ5nLdJE2uGYH7yr8h4hz6SpxW9GmT0xCBxxSDXiYH
         gHbA==
X-Gm-Message-State: ALoCoQlqS7l/eqHtsPwydKvWqN4XtGUYVWYH/RYQLur5Ow0XJzzYzmg9EK2i+taEZJt9JPSynHJb
MIME-Version: 1.0
X-Received: by 10.55.31.168 with SMTP id n40mr23901963qkh.56.1430261784737;
 Tue, 28 Apr 2015 15:56:24 -0700 (PDT)
Received: by 10.140.23.72 with HTTP; Tue, 28 Apr 2015 15:56:24 -0700 (PDT)
In-Reply-To: <55400C75.9070609@imgtec.com>
References: <1428435862-14354-1-git-send-email-abrestic@chromium.org>
        <1428435862-14354-3-git-send-email-abrestic@chromium.org>
        <55400C75.9070609@imgtec.com>
Date:   Tue, 28 Apr 2015 15:56:24 -0700
X-Google-Sender-Auth: oe95N_MKcCAfWT4d3FQhCmgvLi8
Message-ID: <CAL1qeaHnKDOrmPFuh8=K8Y+r0Ff-0XKu8c1=ecX=Ud+Qk_8dkw@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] pinctrl: Add Pistachio SoC pin control driver
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        Paul Bolle <pebolle@tiscali.nl>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47143
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

On Tue, Apr 28, 2015 at 3:40 PM, Ezequiel Garcia
<ezequiel.garcia@imgtec.com> wrote:
> Just a silly comment.
>
> On 04/07/2015 04:44 PM, Andrew Bresticker wrote:
> [..]
>> +
>> +static const struct pinmux_ops pistachio_pinmux_ops = {
>> +     .get_functions_count = pistachio_pinmux_get_functions_count,
>> +     .get_function_name = pistachio_pinmux_get_function_name,
>> +     .get_function_groups = pistachio_pinmux_get_function_groups,
>> +     .set_mux = pistachio_pinmux_enable,
>> +};
>> +
>> +static int pistachio_pinconf_get(struct pinctrl_dev *pctldev, unsigned pin,
>> +                              unsigned long *config)
>> +{
>> +     struct pistachio_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
>> +     enum pin_config_param param = pinconf_to_config_param(*config);
>> +     u32 val, arg;
>> +
>> +     switch (param) {
>> +     case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
>> +             val = pctl_readl(pctl, PADS_SCHMITT_EN_REG(pin));
>> +             arg = !!(val & PADS_SCHMITT_EN_BIT(pin));
>> +             break;
>> +     case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
>> +             val = pctl_readl(pctl, PADS_PU_PD_REG(pin)) >>
>> +                     PADS_PU_PD_SHIFT(pin);
>> +             arg = (val & PADS_PU_PD_MASK) == PADS_PU_PD_HIGHZ;
>> +             break;
>> +     case PIN_CONFIG_BIAS_PULL_UP:
>> +             val = pctl_readl(pctl, PADS_PU_PD_REG(pin)) >>
>> +                     PADS_PU_PD_SHIFT(pin);
>> +             arg = (val & PADS_PU_PD_MASK) == PADS_PU_PD_UP;
>> +             break;
>> +     case PIN_CONFIG_BIAS_PULL_DOWN:
>> +             val = pctl_readl(pctl, PADS_PU_PD_REG(pin)) >>
>> +                     PADS_PU_PD_SHIFT(pin);
>> +             arg = (val & PADS_PU_PD_MASK) == PADS_PU_PD_DOWN;
>> +             break;
>> +     case PIN_CONFIG_BIAS_BUS_HOLD:
>> +             val = pctl_readl(pctl, PADS_PU_PD_REG(pin)) >>
>> +                     PADS_PU_PD_SHIFT(pin);
>> +             arg = (val & PADS_PU_PD_MASK) == PADS_PU_PD_BUS;
>> +             break;
>> +     case PIN_CONFIG_SLEW_RATE:
>> +             val = pctl_readl(pctl, PADS_SLEW_RATE_REG(pin));
>> +             arg = !!(val & PADS_SLEW_RATE_BIT(pin));
>> +             break;
>> +     case PIN_CONFIG_DRIVE_STRENGTH:
>> +             val = pctl_readl(pctl, PADS_DRIVE_STRENGTH_REG(pin)) >>
>> +                     PADS_DRIVE_STRENGTH_SHIFT(pin);
>> +             switch (val & PADS_DRIVE_STRENGTH_MASK) {
>> +             case PADS_DRIVE_STRENGTH_2MA:
>> +                     arg = 2;
>> +                     break;
>> +             case PADS_DRIVE_STRENGTH_4MA:
>> +                     arg = 4;
>> +                     break;
>> +             case PADS_DRIVE_STRENGTH_8MA:
>> +                     arg = 8;
>> +                     break;
>> +             case PADS_DRIVE_STRENGTH_12MA:
>> +             default:
>> +                     arg = 12;
>> +                     break;
>> +             }
>> +             break;
>> +     default:
>> +             dev_err(pctl->dev, "Property %u not supported\n", param);
>
> Probably just a nitpick, but maybe this should be dev_dbg. Otherwise,
> we'll get a ton of these errors when cat'ing pinconf-pins in debugfs.
>
>> +             return -EINVAL;
>
> And this should be -ENOTSUPP. I guess it doesn't matter much.

Ah, you're right.  I meant to this for V3 but I guess I forgot.  Will fix.

-Andrew
