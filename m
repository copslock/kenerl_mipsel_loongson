Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jun 2013 00:06:31 +0200 (CEST)
Received: from mail-ob0-f175.google.com ([209.85.214.175]:42194 "EHLO
        mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827479Ab3FXWGa0U1e0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jun 2013 00:06:30 +0200
Received: by mail-ob0-f175.google.com with SMTP id xn12so11251227obc.20
        for <linux-mips@linux-mips.org>; Mon, 24 Jun 2013 15:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=1UI+e/6HrnbDRn5AX/AfuXp2XQL4opaHc4fGJXmRFJU=;
        b=JmkqHa/MvZ7Ny7zxUk3qndaAW4BA7HPhwWddikt6QaFEOyAuVxed3jIQaPnQzy1FOw
         m4g978bBs+YzQnX1+4QtSkdb4GJYeIHOIt+kswRqZbuiZDkEQbLQEmKAa5uhVjexOXz1
         kTHPNWsf+0M5Jpy7/QMBq327nigleXPm/KPVgPvwrwvCWFpDJxg6HjrPsQ0hiYFrny9D
         6SQ3jGRLvpB210wtbQCMfYv2WFaACuNSViyKF9W0YFif35XkuRQ9HImUfjrZX/VQSkNV
         UgpSm1B/V6xGvfMw+s41zKOtx1HU0c0O0PllywzE/Y+9z/eoSoujye+BsCYBmAJI96Yc
         MEmw==
MIME-Version: 1.0
X-Received: by 10.182.199.72 with SMTP id ji8mr8899995obc.18.1372111583864;
 Mon, 24 Jun 2013 15:06:23 -0700 (PDT)
Received: by 10.182.120.7 with HTTP; Mon, 24 Jun 2013 15:06:23 -0700 (PDT)
In-Reply-To: <51C34584.8070301@gmail.com>
References: <1371251915-18271-1-git-send-email-ddaney.cavm@gmail.com>
        <CACRpkdYHzBBbPNujYRGkMFGuQRzeYKs9jgfc3e3HWyxQFahvRQ@mail.gmail.com>
        <51C34584.8070301@gmail.com>
Date:   Tue, 25 Jun 2013 00:06:23 +0200
Message-ID: <CACRpkdYmPuyrDYU1n+UpgW-if9-JS-vXJgLVCJ2zrx-4oKBtHw@mail.gmail.com>
Subject: Re: Re: [PATCH] gpio MIPS/OCTEON: Add a driver for OCTEON's on-chip
 GPIO pins.
From:   Linus Walleij <linus.walleij@linaro.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Grant Likely <grant.likely@linaro.org>,
        Rob Herring <rob.herring@calxeda.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        David Daney <david.daney@cavium.com>
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQmeohoF6vLGLBlL96qGGnylsdd6lSGxqz7ZffFQlj0+67bLrJFwLp0mVp9223SggcxghtmJ
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37119
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

On Thu, Jun 20, 2013 at 8:10 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> On 06/17/2013 01:51 AM, Linus Walleij wrote:

>> +#include <asm/octeon/octeon.h>
>> +#include <asm/octeon/cvmx-gpio-defs.h>
>>
>> I cannot find this in my tree.
>
> Weird, I see them here:
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/mips/include/asm/octeon/cvmx-gpio-defs.h
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/mips/include/asm/octeon/octeon.h
>
> Do you not have these?

Yeah no problem, I must have misgrepped.
Sorry for the fuzz...

>> depend on OF as well right? Or does the CAVIUM_OCTEON_SOC already
>> imply that?
>
> We already have 'select USE_OF', so I think adding OF here would be
> redundant.

OK.

>>> +/*
>>> + * The address offset of the GPIO configuration register for a given
>>> + * line.
>>> + */
>>> +static unsigned int bit_cfg_reg(unsigned int gpio)
>>
>> Maybe the passed variable shall be named "offset" here, as it is named
>> offset on all call sites, and it surely local for this instance?
>
> Well it is the gpio line, so perhaps it should universally be change to
> "line" or "pin"

We use "offset" to signify line enumerators in drivers/gpio/*
well atleaste if they are local to a piece of hardware.
(Check the GPIO siblings.)

>>> +{
>>> +       if (gpio < 16)
>>> +               return 8 * gpio;
>>> +       else
>>> +               return 8 * (gpio - 16) + 0x100;
>>
>>
>> Put this 0x100 in the #defines above with the name something like
>> STRIDE.
>
> But it is not a 'STRIDE', it is a discontinuity compensation and used in
> exactly one place.

OK what about a comment or something, because it isn't
exactly intuitive right?

>>> +struct octeon_gpio {
>>> +       struct gpio_chip chip;
>>> +       u64 register_base;
>>> +};
>>
>> OMG everything is 64 bit. Well has to come to this I guess.
>
> Not everything.  This is custom logic in an SoC with 64-bit wide internal
> address buses, what would you suggest?

Yep that's what I meant, no big deal. Just first time
I really see it in driver bases.

>> I'm not a fan of packed bitfields like this, I prefer if you just
>> OR | and AND & the bits together in the driver.

I see you disregarded this comment, and looking at the header
files it seems the MIPS arch is a big fan if packed bitfields so
will live with it for this arch...

>>> +static int octeon_gpio_get(struct gpio_chip *chip, unsigned offset)
>>> +{
>>> +       struct octeon_gpio *gpio = container_of(chip, struct octeon_gpio,
>>> chip);
>>> +       u64 read_bits = cvmx_read_csr(gpio->register_base + RX_DAT);
>>> +
>>> +       return ((1ull << offset) & read_bits) != 0;
>>
>> A common idiom we use for this is:
>>
>> return !!(read_bits & (1ull << offset));
>
> I hate that idiom, but if its use is a condition of accepting the patch, I
> will change it.

Nah. If a good rational reason like "hate" is given for not using a coding
idiom I will accept it as it stands ;-)

>>> +       dev_info(&pdev->dev, "OCTEON GPIO\n");
>>
>>
>> This is like shouting "REAL MADRID!" in the bootlog, be a bit more
>> precise: "octeon GPIO driver probed\n" or something so we know what
>> is happening.
>
> No, more akin to 'Real Madrid', as 'OCTEON' is the correct spelling of its
> given name.
>
> I will happily add "driver probed", and grudgingly switch to lower case if
> it is a necessary condition of patch acceptance.

I don't know, does this rest of the MIPS drivers emit similar messages
such that the bootlog will say

OCTEON clocks
OCTEON irqchip
OCTEON I2C
OCTEON GPIO

then I guess it's convention and it can stay like this.

Yours,
Linus Walleij
