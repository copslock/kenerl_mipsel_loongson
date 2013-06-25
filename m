Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jun 2013 03:53:49 +0200 (CEST)
Received: from mail-pb0-f52.google.com ([209.85.160.52]:59492 "EHLO
        mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834874Ab3FYBxhVr7xJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jun 2013 03:53:37 +0200
Received: by mail-pb0-f52.google.com with SMTP id xa12so11839833pbc.11
        for <multiple recipients>; Mon, 24 Jun 2013 18:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=cyQnPHmjoOMlg2WTlPP7cGiYSaWbn8efRYJULK3P634=;
        b=us5WEN0D0fSw2WxmRpxS/XR2WD6FmaBqq/fmy4zZ+J2wc2/nYyc6cyQc9RUbAj2ChJ
         qqjTPJCLHO80j0SrU5QShrFwcC7xlwEarRco6PbNqz0sQp6qpS2rY24omD9LqGrhz2ZR
         k2cP7kZ+ogZezGBdyMRGVF+Q8/AA4M04mRgLkefbk8VHmcAbLf3zOoK822co5JDGEKUg
         srL4T1zpPLV5dLrD3a8DYO+FvaPB7dxHvHSkfhFzMjXcsmYuy/KaO9beTUsdELv8bfLz
         3lcGscHRSzDC+MghzO2j7z6655HKX2bWuWGzrQspzQ+667PtbpvuPo/0SFWDR4eWzqG8
         +CCw==
X-Received: by 10.68.233.98 with SMTP id tv2mr25781717pbc.146.1372125209694;
        Mon, 24 Jun 2013 18:53:29 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id pe9sm20566421pbc.35.2013.06.24.18.53.27
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 18:53:28 -0700 (PDT)
Message-ID: <51C8F816.2010502@gmail.com>
Date:   Mon, 24 Jun 2013 18:53:26 -0700
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
Subject: Re: [PATCH] gpio MIPS/OCTEON: Add a driver for OCTEON's on-chip GPIO
 pins.
References: <1371251915-18271-1-git-send-email-ddaney.cavm@gmail.com> <CACRpkdYHzBBbPNujYRGkMFGuQRzeYKs9jgfc3e3HWyxQFahvRQ@mail.gmail.com> <51C34584.8070301@gmail.com> <CACRpkdYmPuyrDYU1n+UpgW-if9-JS-vXJgLVCJ2zrx-4oKBtHw@mail.gmail.com>
In-Reply-To: <CACRpkdYmPuyrDYU1n+UpgW-if9-JS-vXJgLVCJ2zrx-4oKBtHw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37124
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

Thanks for looking at this again.

I will be away from my office until the middle of July, so I will not be 
able to generate and test a revised patch until then.

David Daney



On 06/24/2013 03:06 PM, Linus Walleij wrote:
> On Thu, Jun 20, 2013 at 8:10 PM, David Daney <ddaney.cavm@gmail.com> wrote:
>> On 06/17/2013 01:51 AM, Linus Walleij wrote:
>
>>> +#include <asm/octeon/octeon.h>
>>> +#include <asm/octeon/cvmx-gpio-defs.h>
>>>
>>> I cannot find this in my tree.
>>
>> Weird, I see them here:
>>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/mips/include/asm/octeon/cvmx-gpio-defs.h
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/mips/include/asm/octeon/octeon.h
>>
>> Do you not have these?
>
> Yeah no problem, I must have misgrepped.
> Sorry for the fuzz...
>
>>> depend on OF as well right? Or does the CAVIUM_OCTEON_SOC already
>>> imply that?
>>
>> We already have 'select USE_OF', so I think adding OF here would be
>> redundant.
>
> OK.
>
>>>> +/*
>>>> + * The address offset of the GPIO configuration register for a given
>>>> + * line.
>>>> + */
>>>> +static unsigned int bit_cfg_reg(unsigned int gpio)
>>>
>>> Maybe the passed variable shall be named "offset" here, as it is named
>>> offset on all call sites, and it surely local for this instance?
>>
>> Well it is the gpio line, so perhaps it should universally be change to
>> "line" or "pin"
>
> We use "offset" to signify line enumerators in drivers/gpio/*
> well atleaste if they are local to a piece of hardware.
> (Check the GPIO siblings.)
>
>>>> +{
>>>> +       if (gpio < 16)
>>>> +               return 8 * gpio;
>>>> +       else
>>>> +               return 8 * (gpio - 16) + 0x100;
>>>
>>>
>>> Put this 0x100 in the #defines above with the name something like
>>> STRIDE.
>>
>> But it is not a 'STRIDE', it is a discontinuity compensation and used in
>> exactly one place.
>
> OK what about a comment or something, because it isn't
> exactly intuitive right?
>
>>>> +struct octeon_gpio {
>>>> +       struct gpio_chip chip;
>>>> +       u64 register_base;
>>>> +};
>>>
>>> OMG everything is 64 bit. Well has to come to this I guess.
>>
>> Not everything.  This is custom logic in an SoC with 64-bit wide internal
>> address buses, what would you suggest?
>
> Yep that's what I meant, no big deal. Just first time
> I really see it in driver bases.
>
>>> I'm not a fan of packed bitfields like this, I prefer if you just
>>> OR | and AND & the bits together in the driver.
>
> I see you disregarded this comment, and looking at the header
> files it seems the MIPS arch is a big fan if packed bitfields so
> will live with it for this arch...
>
>>>> +static int octeon_gpio_get(struct gpio_chip *chip, unsigned offset)
>>>> +{
>>>> +       struct octeon_gpio *gpio = container_of(chip, struct octeon_gpio,
>>>> chip);
>>>> +       u64 read_bits = cvmx_read_csr(gpio->register_base + RX_DAT);
>>>> +
>>>> +       return ((1ull << offset) & read_bits) != 0;
>>>
>>> A common idiom we use for this is:
>>>
>>> return !!(read_bits & (1ull << offset));
>>
>> I hate that idiom, but if its use is a condition of accepting the patch, I
>> will change it.
>
> Nah. If a good rational reason like "hate" is given for not using a coding
> idiom I will accept it as it stands ;-)
>
>>>> +       dev_info(&pdev->dev, "OCTEON GPIO\n");
>>>
>>>
>>> This is like shouting "REAL MADRID!" in the bootlog, be a bit more
>>> precise: "octeon GPIO driver probed\n" or something so we know what
>>> is happening.
>>
>> No, more akin to 'Real Madrid', as 'OCTEON' is the correct spelling of its
>> given name.
>>
>> I will happily add "driver probed", and grudgingly switch to lower case if
>> it is a necessary condition of patch acceptance.
>
> I don't know, does this rest of the MIPS drivers emit similar messages
> such that the bootlog will say
>
> OCTEON clocks
> OCTEON irqchip
> OCTEON I2C
> OCTEON GPIO
>
> then I guess it's convention and it can stay like this.
>
> Yours,
> Linus Walleij
>
>
