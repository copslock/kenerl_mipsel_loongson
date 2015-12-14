Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Dec 2015 10:18:12 +0100 (CET)
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34660 "EHLO
        mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013758AbbLNJSLC1qgb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Dec 2015 10:18:11 +0100
Received: by obciw8 with SMTP id iw8so126917592obc.1
        for <linux-mips@linux-mips.org>; Mon, 14 Dec 2015 01:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zCmIjte1j2RGWaFNZu4OUXss+BrV2KVsrIBIsHhjpbI=;
        b=UO7LsbFtih6WTKuUvjfBIcoN2KRFIXo6oDqUc9Om0BDsVTMiLrPIWDgsDHgZ0N3WDP
         3re451mjmiGEbEcs14MYJOAuUpiAIamPRWHwVCIwlYswi/YkThakFuPqLVra1ksgKSA3
         jBdWwuQbZHBCIGUe90GKLcLVmnYmUFk4E58QRk4+MR4vlRzBdOadMsudJ4lHEzK5suOT
         w7+bEOD/l+nM5TzfvP5ftfGMkE0jSP1AEgL/hJ1kQU7yrsm1lIDbh40WJkHdXJH3lhFn
         hFsJo1jKOLSI3WT1bKoAcXkNCs+NcGMutJc16/6pMqlpMMY1A5+hG4psxF5obe8AMpqO
         ZVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zCmIjte1j2RGWaFNZu4OUXss+BrV2KVsrIBIsHhjpbI=;
        b=RZEa0PzHWfQzBeDSkm1SrnG9PV6sATsn11tec4frGIIqT9nwfSJrzTMZdlJ74FTTt3
         PmYLmLDXIBK1acNj2l4axmbQgq46w1gIcTJsk7mKICdfoilRrzdaHlnkk8PeE+a4E3C2
         b5GhQCD85S9XNConY9SZYWx6akWyctmTWbWOpSdXca4oXeHV8Mr2EphulVZFXUJuJNC+
         JBlTsXp8apm908NMberYlBT9URN6qx8FVXRQSxggiP0L2Lafc6xn52AKvIxPrxptBxZ8
         bxfkjCHi8ZqPFsnzhvZ7qMwBWeLrGTCYKQY0lCT7pOn5/BH3qNfBz8teIjaql8nuqXxp
         rH/g==
X-Gm-Message-State: ALoCoQnqNwExFv7nlVOzWwXZWdE+vZ7cQsLR2njDaXahSlLhQPwyXxbXyU8YO7XWjgK59tRoaTdgRSumm7DI9/2A+hFVX7fQkD+U4P7qZrQk969+yixdpGU=
MIME-Version: 1.0
X-Received: by 10.182.120.37 with SMTP id kz5mr24047540obb.81.1450084684851;
 Mon, 14 Dec 2015 01:18:04 -0800 (PST)
Received: by 10.182.32.70 with HTTP; Mon, 14 Dec 2015 01:18:04 -0800 (PST)
In-Reply-To: <20151209193034.GE27131@dtor-ws>
References: <1449666515-23343-1-git-send-email-linus.walleij@linaro.org>
        <20151209193034.GE27131@dtor-ws>
Date:   Mon, 14 Dec 2015 10:18:04 +0100
Message-ID: <CACRpkdZDFPFOH=9FfYzLeKo5b-oXG4rPjoU4Rpq9Wv1-RvY6uQ@mail.gmail.com>
Subject: Re: [PATCH 000/182] Rid struct gpio_chip from container_of() usage
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Alexandre Courbot <acourbot@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Welling <mwelling@ieee.org>,
        Markus Pargmann <mpa@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "arm@kernel.org" <arm@kernel.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Sonic Zhang <sonic.zhang@analog.com>,
        Greg Ungerer <gerg@uclinux.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Anatolij Gustschin <agust@denx.de>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50584
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

On Wed, Dec 9, 2015 at 8:30 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Dec 09, 2015 at 02:08:35PM +0100, Linus Walleij wrote:
>> This removes the use of container_of() constructions from *all*
>> GPIO drivers in the kernel. It is done by instead adding an
>> optional void *data pointer to the struct gpio_chip and an
>> accessor function, gpiochip_get_data() to get it from a driver.
>>
>> WHY?
>>
>> Because we want to have a proper userspace ABI for GPIO chips,
>> which involves using a character device that the user opens
>> and closes. While the character device is open, the underlying
>> kernel objects must not go away.
>>
>> Currently the GPIO drivers keep their state in the struct
>> gpio_chip, and that is often allocated by the drivers, very
>> often as a part of a containing per-instance state container
>> struct for the driver:
>>
>> struct foo_state {
>>    struct gpio_chip chip;  <- OMG my state is there
>> };
>>
>> Drivers cannot allocate and manage this state: if a user has the
>> character device open, the objects allocated must stay around
>> even if the driver goes away. Instead drivers need to pass a
>> descriptor to the GPIO core, and then the core should allocate
>> and manage the lifecycle of things related to the device, such
>> as the chardev itself or the struct device related to the GPIO
>> device.
>
> Yes, but it does not mean that the object that is being maintained by
> the subsystem and that us attached to character device needs to be
> gpio_chip itself. You can have something like
>
> struct gpio_chip_chardev {
>         struct cdev chardev;
>         struct gpio_chip *chip;
>         bool dead;
> };

There needs to be a struct device too, amongst other things.

>
> struct gpio_chip {
>         ...
>         struct gpio_chip_chardev *chardev;
>         ...
> };
>
> You alloctae the new structure when you register/export gpio chip in
> gpio subsystem core and leave all the individual drivers alone.

The current idea I have is something in the middle. Drivers have to
change a bit. The important part is that gpiolib handles allocation of
anything containing states. I'm thinking along the lines of Russell's
proposal to use netdev_alloc()'s design pattern.

The problem is that currently gpio_chip contains a lot of
stateful variables (like the dynamically allocated array of GPIO descriptors
etc) and those are used by the gpiolib core, so they have to be moved away
from gpio_chip.

So what happens if I don't change the design pattern:

int ret = gpiochip_add(&my_chip);
...
gpiochip_remove(&my_chip);

At this point we have to cross-reference the pointer to my chip to
find the chip to remove. This goes for anything that takes the struct
gpio_chip *
as parameter, like gpiochip_add_pin_range(), gpiochip_request_own_desc()
etc etc. So something inside gpiolib must take a gpio_chip * pointer and
turn that into the actual state container, e.g, a struct gpio_device.
Since struct gpio_chip needs to be static and stateless, it cannot contain
a pointer back to its struct gpio_device.

That means basically comparing pointers across a list of gpio_device's
to find it. And that's ... very kludgy. But if people think it's better to avoid
changing all drivers I will consider it.

I think it is better if the GPIO drivers get a handle on the
real gpio_device * to be used when calling these gpiochip_* related
functions and also in the callbacks, which is a bigger refactoring
indeed.

Part of this is trying to be elegant and mimic other subsystems and not
have GPIO be too hopelessly wayward about things.

If I compare to how struct input_dev is done, you appear to also use the
pattern Russell suggested with input_dev_allocate() akin to
netdev_alloc(), and the allocated struct holds all the vtable and states etc,
and I think it is a good pattern, and that GPIO should conform.

This current patch series however, just give us the equivalent of
input_get_drvdata()/input_set_drvdata() and that seems valuable on its
own, as it reduces code size and make things more readable.

Yours,
Linus Walleij
