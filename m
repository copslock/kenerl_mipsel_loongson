Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2015 02:49:32 +0200 (CEST)
Received: from mail-qc0-f175.google.com ([209.85.216.175]:32869 "EHLO
        mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026279AbbD2At3PdYAO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Apr 2015 02:49:29 +0200
Received: by qcrf4 with SMTP id f4so6351526qcr.0
        for <linux-mips@linux-mips.org>; Tue, 28 Apr 2015 17:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FmXU0wLJXTZS5PjgwQF+tVgdleNf0QYPhA04UjdC0/A=;
        b=d6HqWPR76cdhIH801NQEb4yw6o9t+9kqicM268F3b7t35/M9tsiYnPhvAraZEkldTx
         Rd5GnBCHOCJzOE/k8y6wa/sYN2UeIYqgXq4klzxxQRrR5G78RHcSTyN6DC4pEHNULMeh
         tnqXTLmO/XG2XLmNeEL1v4j7dnVMK+aiWeEdufp7FYwyHTD/FmVvkLTCO9KlCrnDCq1U
         bMIN25F3JxcsOhI0u0O8Y+mgXvI8rpdxXhTLnKimWx2O5ukDk5R9W/A+YIeETug9Fgbp
         DkY1MR+n3XeXDL8qr5VPUua5JEwlFCR++QhlZ8mTG7EJ8fDvT+aG3MCmbmtyXMpGqscn
         Gz4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FmXU0wLJXTZS5PjgwQF+tVgdleNf0QYPhA04UjdC0/A=;
        b=c2GrakA2lp+faTYzeyOvKns0OsExqBS85D5/ASCMPD7WP/47Tr8fW+8VQfD6o1FddW
         iKH8FV4FgGcAC73fv9hCIunRZ2GJlCGGs9BEXFnQBHFJz14Gc9NJ/SCuyYYEFG/2HPOU
         P3AJptZ9Z5b9YffQWWXyLUmQLLrICW9z2rJRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=FmXU0wLJXTZS5PjgwQF+tVgdleNf0QYPhA04UjdC0/A=;
        b=DUNUqBHLFtHQEKmVVhuXw6TFzsekUEw/p0h5te++oRmY9TyCiv9/kTbDjGqojJBO88
         ufjCp+K0rvHVR2sezMHdMUeIPLMakoRn9LBPWKd8Ct80BiskbjN79K6grDxmhqQ1GwMN
         /AILBG4m9xYl93zmFBufO47r8Vm9htDV66Z+4gKtR0HvHHMBNIXuyIOKFVag6zsS4bUN
         2nkWnSX0C6LKFkiD6KWAfgnueSzgwLpKg1yqTK+Cbb2hLUx5b4kSgimuWX5+uC5b84NN
         inQdX0kvHd90vdU8Em1Dbnh0Tlrm6lJxdd1/gbhMjwff3R5OWtKXTpep/4bCQ8RjflxA
         3QFQ==
X-Gm-Message-State: ALoCoQnRA2SqKUZJF9/m2CzY1p3Pw5xT3jqdOom2EthOmT7x2jUThDAcu8n9wpiX/vcsfHR+3VUy
MIME-Version: 1.0
X-Received: by 10.229.28.9 with SMTP id k9mr15372723qcc.9.1430268565211; Tue,
 28 Apr 2015 17:49:25 -0700 (PDT)
Received: by 10.140.23.72 with HTTP; Tue, 28 Apr 2015 17:49:25 -0700 (PDT)
In-Reply-To: <554016A5.7040209@imgtec.com>
References: <1428435862-14354-1-git-send-email-abrestic@chromium.org>
        <1428435862-14354-3-git-send-email-abrestic@chromium.org>
        <554016A5.7040209@imgtec.com>
Date:   Tue, 28 Apr 2015 17:49:25 -0700
X-Google-Sender-Auth: fmvQGjxSiHCSaMiMeckilmMkLqo
Message-ID: <CAL1qeaH8gg2Df=GbQdW+GvMEzzYgMgAZwO9LSerj=xYYWSnsBA@mail.gmail.com>
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
X-archive-position: 47145
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

On Tue, Apr 28, 2015 at 4:24 PM, Ezequiel Garcia
<ezequiel.garcia@imgtec.com> wrote:
> Andrew,
>
> On 04/07/2015 04:44 PM, Andrew Bresticker wrote:
> [..]
>> +static int pistachio_pinmux_enable(struct pinctrl_dev *pctldev,
>> +                                unsigned func, unsigned group)
>> +{
>> +     struct pistachio_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
>> +     const struct pistachio_pin_group *pg = &pctl->groups[group];
>> +     const struct pistachio_function *pf = &pctl->functions[func];
>> +     struct pinctrl_gpio_range *range;
>> +     unsigned int i;
>> +     u32 val;
>> +
>> +     if (pg->mux_reg > 0) {
>> +             for (i = 0; i < ARRAY_SIZE(pg->mux_option); i++) {
>> +                     if (pg->mux_option[i] == func)
>> +                             break;
>> +             }
>> +             if (i == ARRAY_SIZE(pg->mux_option)) {
>> +                     dev_err(pctl->dev, "Cannot mux pin %u to function %u\n",
>> +                             group, func);
>> +                     return -EINVAL;
>> +             }
>> +
>> +             val = pctl_readl(pctl, pg->mux_reg);
>> +             val &= ~(pg->mux_mask << pg->mux_shift);
>> +             val |= i << pg->mux_shift;
>> +             pctl_writel(pctl, val, pg->mux_reg);
>> +
>> +             if (pf->scenarios) {
>> +                     for (i = 0; i < pf->nscenarios; i++) {
>> +                             if (pf->scenarios[i] == group)
>> +                                     break;
>> +                     }
>> +                     if (WARN_ON(i == pf->nscenarios))
>> +                             return -EINVAL;
>> +
>> +                     val = pctl_readl(pctl, pf->scenario_reg);
>> +                     val &= ~(pf->scenario_mask << pf->scenario_shift);
>> +                     val |= i << pf->scenario_shift;
>> +                     pctl_writel(pctl, val, pf->scenario_reg);
>> +             }
>> +     }
>> +
>> +     range = pinctrl_find_gpio_range_from_pin(pctl->pctldev, group);
>> +     if (range)
>> +             gpio_disable(gc_to_bank(range->gc), group - range->pin_base);
>> +
>
> If you plan to submit a v4, how about using "pg->pins" here instead of "group"?
>
> Using "group" relies on having the same numberspace for the group and the pin,
> and it'll break when introducing the RPU pinctrl.

Sure, will do.

-Andrew
