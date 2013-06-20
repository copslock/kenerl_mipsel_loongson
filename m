Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jun 2013 12:02:20 +0200 (CEST)
Received: from mail-pd0-f175.google.com ([209.85.192.175]:53621 "EHLO
        mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823001Ab3FTSKVgCI5A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Jun 2013 20:10:21 +0200
Received: by mail-pd0-f175.google.com with SMTP id 4so6463990pdd.6
        for <multiple recipients>; Thu, 20 Jun 2013 11:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Q9LqeAOxLpoh4tYYxZ2io5/fKQz9sLa+TTPWCQuozMk=;
        b=RXeU5kjkW0abmOsnooTGnECdDXZM3DyKgbP2OH4wjG4xIIGjEFTdH307DGZYSi2F/R
         OMZOmvNHrbX5B8n0OR14Icx8hYHqlNsIt2bKy+7CHFaFVoQedDRErHID8Kj4VGQFmWgi
         DsbOOsCk/rJlPNKcxMHa1CEDRlOZOaUBFmeqt42zkjnHE8wrKufCVKyOMDGfvmN1xmdJ
         Xus6xQSG3rAcm/KL1AQxUPUYPnZsy9rL3EYQytby2MRIvLIfX2h2ADVYBBcBRgOEEhn1
         y160ulGob1e7VT+HaL0/QtKRM6orAM4TS1R3pGAd9MPSIck043IElWsT0rtMueazsFUX
         7eFQ==
X-Received: by 10.66.122.67 with SMTP id lq3mr10897197pab.147.1371751814853;
        Thu, 20 Jun 2013 11:10:14 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id u6sm1094456pbb.46.2013.06.20.11.10.12
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 20 Jun 2013 11:10:13 -0700 (PDT)
Message-ID: <51C34584.8070301@gmail.com>
Date:   Thu, 20 Jun 2013 11:10:12 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Grant Likely <grant.likely@linaro.org>,
        Rob Herring <rob.herring@calxeda.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: Re: [PATCH] gpio MIPS/OCTEON: Add a driver for OCTEON's on-chip
 GPIO pins.
References: <1371251915-18271-1-git-send-email-ddaney.cavm@gmail.com> <CACRpkdYHzBBbPNujYRGkMFGuQRzeYKs9jgfc3e3HWyxQFahvRQ@mail.gmail.com>
In-Reply-To: <CACRpkdYHzBBbPNujYRGkMFGuQRzeYKs9jgfc3e3HWyxQFahvRQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37197
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

Sorry for not responding earlier, but my e-mail system seems to have 
malfunctioned with respect to this message...


On 06/17/2013 01:51 AM, Linus Walleij wrote:
> On Sat, Jun 15, 2013 at 1:18 AM, David Daney <ddaney.cavm@gmail.com> wrote:
>
>> From: David Daney <david.daney@cavium.com>
>>
>> The SOCs in the OCTEON family have 16 (or in some cases 20) on-chip
>> GPIO pins, this driver handles them all.  Configuring the pins as
>> interrupt sources is handled elsewhere (OCTEON's irq handling code).
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>
>> This patch depends somewhat on patches in Ralf's MIPS/Linux -next tree
>> where we have patches that enable the Kconfig CAVIUM_OCTEON_SOC and
>> ARCH_REQUIRE_GPIOLIB symbols.  Apart from that it is stand-alone and
>> is probably suitable for merging via the GPIO tree.
>
> Really? You're using this:
>
> +#include <asm/octeon/octeon.h>
> +#include <asm/octeon/cvmx-gpio-defs.h>
>
> I cannot find this in my tree.

Weird, I see them here:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/mips/include/asm/octeon/cvmx-gpio-defs.h
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/mips/include/asm/octeon/octeon.h

Do you not have these?

>
> Further I ask why that second file is not part of *this* patch?
> It surely seems GPIO-related, and would probably need to
> go into include/linux/platform_data/gpio-octeon.h or something
> rather than such platform dirs.
>
> (...)
>> +config GPIO_OCTEON
>> +       tristate "Cavium OCTEON GPIO"
>> +       depends on GPIOLIB && CAVIUM_OCTEON_SOC
>
> depend on OF as well right? Or does the CAVIUM_OCTEON_SOC already
> imply that?

We already have 'select USE_OF', so I think adding OF here would be 
redundant.


>
> (...)
>> +++ b/drivers/gpio/gpio-octeon.c
>
>
>> +#define RX_DAT 0x80
>> +#define TX_SET 0x88
>> +#define TX_CLEAR 0x90
>
>
>> +/*
>> + * The address offset of the GPIO configuration register for a given
>> + * line.
>> + */
>> +static unsigned int bit_cfg_reg(unsigned int gpio)

>
> Maybe the passed variable shall be named "offset" here, as it is named
> offset on all call sites, and it surely local for this instance?

Well it is the gpio line, so perhaps it should universally be change to 
"line" or "pin"


>
>> +{
>> +       if (gpio < 16)
>> +               return 8 * gpio;
>> +       else
>> +               return 8 * (gpio - 16) + 0x100;
>
> Put this 0x100 in the #defines above with the name something like
> STRIDE.

But it is not a 'STRIDE', it is a discontinuity compensation and used in 
exactly one place.


>
>> +struct octeon_gpio {
>> +       struct gpio_chip chip;
>> +       u64 register_base;
>> +};
>
> OMG everything is 64 bit. Well has to come to this I guess.

Not everything.  This is custom logic in an SoC with 64-bit wide 
internal address buses, what would you suggest?


>
>> +static void octeon_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
>> +{
>> +       struct octeon_gpio *gpio = container_of(chip, struct octeon_gpio, chip);
>> +       u64 mask = 1ull << offset;
>
> And now BIT(offset) does not work anymore because it is defined as
> #define BIT(nr)                 (1UL << (nr))
> OK we will have to live with this FTM I guess.
>
>> +static int octeon_gpio_dir_out(struct gpio_chip *chip, unsigned offset,
>> +                              int value)
>> +{
>> +       struct octeon_gpio *gpio = container_of(chip, struct octeon_gpio, chip);
>> +       union cvmx_gpio_bit_cfgx cfgx;
>> +
>> +       octeon_gpio_set(chip, offset, value);
>> +
>> +       cfgx.u64 = 0;
>> +       cfgx.s.tx_oe = 1;
>
> This makes me want to review that magic header file of yours,
> I guess this comes from <asm/octeon/cvmx-gpio-defs.h>?

Not really magic, but yes that is where it comes from.

>
> Should not this latter variable be a bool?

I don't think so, it is not the result of a comparison operator.

>
> I'm not a fan of packed bitfields like this, I prefer if you just
> OR | and AND & the bits together in the driver.
>
>> +static int octeon_gpio_get(struct gpio_chip *chip, unsigned offset)
>> +{
>> +       struct octeon_gpio *gpio = container_of(chip, struct octeon_gpio, chip);
>> +       u64 read_bits = cvmx_read_csr(gpio->register_base + RX_DAT);
>> +
>> +       return ((1ull << offset) & read_bits) != 0;
>
> A common idiom we use for this is:
>
> return !!(read_bits & (1ull << offset));

I hate that idiom, but if its use is a condition of accepting the patch, 
I will change it.

>
>> +       pdev->dev.platform_data = chip;
>> +       chip->label = "octeon-gpio";
>> +       chip->dev = &pdev->dev;
>> +       chip->owner = THIS_MODULE;
>> +       chip->base = 0;
>> +       chip->can_sleep = 0;
>> +       chip->ngpio = 20;
>> +       chip->direction_input = octeon_gpio_dir_in;
>> +       chip->get = octeon_gpio_get;
>> +       chip->direction_output = octeon_gpio_dir_out;
>> +       chip->set = octeon_gpio_set;
>> +       err = gpiochip_add(chip);
>> +       if (err)
>> +               goto out;
>> +
>> +       dev_info(&pdev->dev, "OCTEON GPIO\n");
>
> This is like shouting "REAL MADRID!" in the bootlog, be a bit more
> precise: "octeon GPIO driver probed\n" or something so we know what
> is happening.

No, more akin to 'Real Madrid', as 'OCTEON' is the correct spelling of 
its given name.

I will happily add "driver probed", and grudgingly switch to lower case 
if it is a necessary condition of patch acceptance.

David Daney
