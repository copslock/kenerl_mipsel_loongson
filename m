Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2014 10:39:53 +0100 (CET)
Received: from mail-ig0-f177.google.com ([209.85.213.177]:52636 "EHLO
        mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011543AbaJ1JjwLdZJ7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2014 10:39:52 +0100
Received: by mail-ig0-f177.google.com with SMTP id h18so663049igc.10
        for <linux-mips@linux-mips.org>; Tue, 28 Oct 2014 02:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ZYIVRkXuKUFWxPinjMMJ5JoQzQlayl5tAmxiA6y2aCo=;
        b=FJM/2Pb8Y5fP5mkxBsJOsy2b75qU3SPoq0R5Wt99QsBK5fUfZr+EIRr7JkCoCHzf38
         kPrlAa6RwYatIogZAX1FmDmNuxVNNghPLTkHhs1W7wh4yHxZ2fHvkjHFA+uopv2AzttJ
         3VBjDCtNQLGsYjugURC1OXPjHdYfXlBj22TCPn4xhbcfe8tBcaTrfRrZJcsPH4OStzer
         9x2zjbHc0GYclmH3qWR8EQPmyHqEy8Y6r60CPeoGTCOrwH5yZXxSomuK5Pl/rFDtzLMu
         q2xzlQ+y9rm/9Ug1dagsdHRXtMihXlOv4nlQU6J/h6u+cu67kcSW56vi4ldgvl6ZGckT
         R6HQ==
X-Gm-Message-State: ALoCoQnVQMTvcetmUEixNBNfSqCK5CDkpu1PeIIidiCrbcw+XhO7NPOkd8LSLwb/zeQs/S4FO1A+
MIME-Version: 1.0
X-Received: by 10.107.165.19 with SMTP id o19mr2326451ioe.1.1414489186419;
 Tue, 28 Oct 2014 02:39:46 -0700 (PDT)
Received: by 10.42.49.141 with HTTP; Tue, 28 Oct 2014 02:39:46 -0700 (PDT)
In-Reply-To: <CAAVeFu+qScOxf1My4K9nj7kaAWRqBGewG-ar6ELY03a2LC7aFA@mail.gmail.com>
References: <1412972930-16777-1-git-send-email-blogic@openwrt.org>
        <1412972930-16777-2-git-send-email-blogic@openwrt.org>
        <CAAVeFu+BAwDOV1siPkRSOes0iJETLWcKEBBFrTn6o=d+CYQPPw@mail.gmail.com>
        <54449D31.9020108@openwrt.org>
        <CAAVeFu+qScOxf1My4K9nj7kaAWRqBGewG-ar6ELY03a2LC7aFA@mail.gmail.com>
Date:   Tue, 28 Oct 2014 10:39:46 +0100
Message-ID: <CACRpkdbHtTcT=1FCtNTu_r2n+zxmpFCT0MK5iyjPRSio7ZRQHg@mail.gmail.com>
Subject: Re: [PATCH 2/5] GPIO: MIPS: ralink: add gpio driver for ralink rt2880 SoC
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Alexandre Courbot <gnurou@gmail.com>
Cc:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43616
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

On Mon, Oct 20, 2014 at 8:19 AM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Mon, Oct 20, 2014 at 2:27 PM, John Crispin <blogic@openwrt.org> wrote:
>> On 20/10/2014 06:41, Alexandre Courbot wrote:
>> On Sat, Oct 11, 2014 at 5:28 AM, John Crispin <blogic@openwrt.org> wrote:

>>> This (and the device tree bindings) seems the indicate that the
>>> registers offset can vary depending on the chip and bank. The chip
>>> can be specified using the compatible property, as for the bank you
>>> can also require a property giving the bank number. With these two
>>> bits of information, this driver should be able to pick the right
>>> register layout out of an in-driver table. This would be much
>>> cleaner that letting the DT specify whatever layout it wants.
>>
>> i tend to disagree. if we put the register offsets into the driver we
>> will have lots of static arrays (5 or 6) and with each new soc we need
>> to potentially need to patch the driver causing us in openwrt to carry
>> lots of patches and have to worry about upstreaming them. From my
>> understanding, the dts has this exact purpose, describing the hardware
>> and in turn reducing the boiler plate and static code in the drivers.
>> If have sent other drivers that do the same and was told there that
>> this is totally legit.
>
> With each new SoC you would have to patch the driver to add the new
> compatible property anyway. If your devices differ as much as by
> having a different register layout, they need a dedicated compatible
> property. In that case, you may as well add the register layout for
> this new property into the driver.

I agree. +1 on this.

Yours,
Linus Walleij
