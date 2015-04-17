Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Apr 2015 18:39:29 +0200 (CEST)
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33918 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010896AbbDQQj1nuKSM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Apr 2015 18:39:27 +0200
Received: by qkgx75 with SMTP id x75so147172592qkg.1
        for <linux-mips@linux-mips.org>; Fri, 17 Apr 2015 09:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=h6RgWbDXS6YIGrvMTeGfFmJnKjJhURjKZj8e3U4ZLhU=;
        b=fWLus6d73HzcWsa8Fwe4xzm8CPlt5X/uPlsut7mZMK+waVHDmZqX4qLm8GBygxjOWz
         2Zw4+KYJEJ2YGojwv/jSK8xPxll5TndEO+fH06iM4AGkZGXqJB/85ycWn54tOtp2jLHo
         GlRxb+ZrilFPBoZ+Oap9GWgz/wAbUOZnY5gEhuQDStYz20Hvp69mDHREE18cwgpioAZi
         0/fWs0FQ9NiZcC8sdbDowsSlozxRG+9cgBHrDWhHs0XjXptROzQMcEXPZPhYaP9tx4/3
         xKEpfXbEu8QBSqXWjddeKTzRVWrMOTZyWb9hrB7JwaucDHTZGdyV/jL0CJ1lqQ6qa6ic
         EnXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=h6RgWbDXS6YIGrvMTeGfFmJnKjJhURjKZj8e3U4ZLhU=;
        b=ZjkfU+asEwP5uLVZQyrL8EtfqqGUqYPgwuwhnEmu+G/NYLXSoz8EpARR/6ggSzGA0G
         offb8Qo3hLX9YzCDR7vNu7ehHiI8/lF1RegMMXxfP3vhrgc1AfRHxaMh3+zV2zs6jX+j
         0yeGtaZR2A/hbJIJrb2ra2Vr9Trc+iS4i+DzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=h6RgWbDXS6YIGrvMTeGfFmJnKjJhURjKZj8e3U4ZLhU=;
        b=g6y061NgFG3r7StnWjEUZdKTaNunXS7RpNp8X9mPiltqhFE5TiAss+NvAVEipU9LOT
         87qzP/r1Jcf8BVp5QtvJVjM5jdQL2La0xwfm6h1O5C8HCRoUea1Y3L+JM+N7vS4t4VSZ
         Ejq1Fvn6XIfv+itZgPzLV6dv3mhJ+xv6P1yaryQfTxbHdBjYp9YVYeCtlk7UaRG2af7v
         ZGLnT11Ya+Mo80dKPtu60RwiR/GQSY6JhUqd3AQabLxz+elffG04Z1QWYqcoiNC4h8MD
         rAOOl6lf0dP5vDTpSCzZA4UG4pHqEfxSZOvdCUCCV5IqJJ5r+l6yLuA/SziZ/jgnK1oM
         KS5Q==
X-Gm-Message-State: ALoCoQnp2AqI5mFVDsKApU3vDJldRatWjn5/HCjwhn8CRbMGFrPQCjTTYS+1ora1CEhKRg2ZLbzx
MIME-Version: 1.0
X-Received: by 10.140.133.207 with SMTP id 198mr4689273qhf.15.1429288763341;
 Fri, 17 Apr 2015 09:39:23 -0700 (PDT)
Received: by 10.140.19.104 with HTTP; Fri, 17 Apr 2015 09:39:23 -0700 (PDT)
In-Reply-To: <553099AF.3060108@imgtec.com>
References: <1428435862-14354-1-git-send-email-abrestic@chromium.org>
        <1428435862-14354-3-git-send-email-abrestic@chromium.org>
        <553099AF.3060108@imgtec.com>
Date:   Fri, 17 Apr 2015 09:39:23 -0700
X-Google-Sender-Auth: MfBrNMHP5SOjFmr-3-0G9Fm5HvQ
Message-ID: <CAL1qeaEd67bGw9Qw5DGwHeuPjEqdRdNz6bvCJ+OtCKuuZ4h1wA@mail.gmail.com>
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
X-archive-position: 46900
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

Hi Ezequiel,

On Thu, Apr 16, 2015 at 10:27 PM, Ezequiel Garcia
<ezequiel.garcia@imgtec.com> wrote:
>
> Hi Andrew,
>
> On 04/07/2015 04:44 PM, Andrew Bresticker wrote:
> [..]
>> +static int pistachio_gpio_register(struct pistachio_pinctrl *pctl)
>> +{
>> +     struct device_node *node = pctl->dev->of_node;
>> +     struct pistachio_gpio_bank *bank;
>> +     unsigned int i;
>> +     int irq, ret = 0;
>> +
>> +     for (i = 0; i < pctl->nbanks; i++) {
>> +             char child_name[sizeof("gpioXX")];
>> +             struct device_node *child;
>
> The first submission used for_each_child_of_node, and I can't find
> any review comments explaining why you've changed it to a regular for
> loop.

The reason for this was the change to looking for particular node
names (gpio0, gpio1, ...) instead of assuming they'd be in order.  It
seemed cleaner to me to do the above rather than:

        for_each_child_of_node()
                if (strcmp(node->name, ...) == 0)

>> +
>> +             snprintf(child_name, sizeof(child_name), "gpio%d", i);
>
> This assumes the GPIO bank nodes are called gpio0, gpio1, ... and so on.
> Do we really want to assume that?

Linus suggested using aliases [1] in a previous review, but that
obviously won't work when we have the RPU pinctrl as well since there
will be multiple "gpio0"s, so I decided to use node names instead.
The Rockchip and Samsung pinctrl drivers do something similar.

[1] http://patchwork.linux-mips.org/patch/9307/

Thanks,
Andrew
