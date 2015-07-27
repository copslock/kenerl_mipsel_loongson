Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jul 2015 15:20:15 +0200 (CEST)
Received: from mail-ob0-f176.google.com ([209.85.214.176]:35859 "EHLO
        mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011094AbbG0NUOV4h30 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jul 2015 15:20:14 +0200
Received: by obnw1 with SMTP id w1so58832468obn.3
        for <linux-mips@linux-mips.org>; Mon, 27 Jul 2015 06:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=9z6byQbMLQoob6PiW8nkLXYKuVIo74fP2a6+YiZr/3s=;
        b=QWAXDzJ0mzYSs+EBPxAao9OOhKNUFxb060iyW6U3xIcID8+yb40XwVWbD4hwELDJY7
         QISqJ0ppdwkaXorm9QYezzJUYPqz4YkqqqPS/g7tBObKfgcyzoKc3QGoDlwKTal0Arvo
         OMN4FcrmrC/xBBWxBypM8C3ykKyuc6g/JECdEwV78Uk07rdCFgqI6sRKiBLdbJhlhanw
         nd6wAI21HNemH3DrT+IW9BQGN/ozIAtPRzeo84djBPhYVVkVn0u1NqvZWnmrbDh+IFrC
         +0TqPg1uPbTsi52iTQtxUZJs9m9GoeHYOMQy8YUTdw0Q5eYgZCsudNJJerL54dlMfIMh
         Sr2g==
X-Gm-Message-State: ALoCoQkRQfdV9FVXtsGbGp0O6UNrc3ek1/5A6GYlDZHyCSGZcgU5p1GzKC2m0C9Ga8SJs90cY6bx
MIME-Version: 1.0
X-Received: by 10.60.155.97 with SMTP id vv1mr29050309oeb.15.1438003208385;
 Mon, 27 Jul 2015 06:20:08 -0700 (PDT)
Received: by 10.182.204.41 with HTTP; Mon, 27 Jul 2015 06:20:08 -0700 (PDT)
In-Reply-To: <55B131B1.10302@metafoo.de>
References: <1437586416-14735-1-git-send-email-albeu@free.fr>
        <55B131B1.10302@metafoo.de>
Date:   Mon, 27 Jul 2015 15:20:08 +0200
Message-ID: <CACRpkdZon9XHSMyieGDU8F037+4TxyCq=6z5vJwQ3k6QJm6MTg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Remove most of the custom gpio.h
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Alban Bedel <albeu@free.fr>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Florian Fainelli <florian@openwrt.org>,
        Joe Perches <joe@perches.com>,
        Daniel Walter <dwalter@google.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        James Hogan <james.hogan@imgtec.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Levente Kurusa <levex@linux.com>,
        abdoulaye berthe <berthe.ab@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48435
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

On Thu, Jul 23, 2015 at 8:25 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 07/22/2015 07:33 PM, Alban Bedel wrote:
>>
>> diff --git a/arch/mips/jz4740/gpio.c b/arch/mips/jz4740/gpio.c
>> index 54c80d4..3dc500c 100644
>> --- a/arch/mips/jz4740/gpio.c
>> +++ b/arch/mips/jz4740/gpio.c
>> @@ -262,18 +262,6 @@ uint32_t jz_gpio_port_get_value(int port, uint32_t
>> mask)
>>   }
>>   EXPORT_SYMBOL(jz_gpio_port_get_value);
>>
>> -int gpio_to_irq(unsigned gpio)
>> -{
>> -       return JZ4740_IRQ_GPIO(0) + gpio;
>> -}
>> -EXPORT_SYMBOL_GPL(gpio_to_irq);
>
>
> This need to be hooked up the gpio_to_irq() callback of the gpio_chip struct
> of this driver rather than completely removing it. Otherwise this
> functionality will be broken.
>
> Similar for other platforms which implement the function.

Even better is to see if we can convert the driver to
GPIOLIB_IRQCHIP which moves the handling of IRQ mapping
to the gpiolib core. This works for all simple cascading GPIO-with-IRQ
controllers with a local mask register. (Not when the system intcon
and GPIO is mashed up though.)

But no hurry with that.

Yours,
Linus Walleij
