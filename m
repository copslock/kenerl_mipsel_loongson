Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Apr 2012 17:21:12 +0200 (CEST)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:63884 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903589Ab2DOPUz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 Apr 2012 17:20:55 +0200
Received: by eekb45 with SMTP id b45so1112065eek.36
        for <multiple recipients>; Sun, 15 Apr 2012 08:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:organization:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=VYpPZJ9y+H22u3VuUUVyvXr6pog7QOvXYKeUJQo9/yI=;
        b=oliw9cp+1DTEtxK3exJnf5AOnyVrhfjtY3rdI0G81qU3HHuBniAKauqD0w1LGwhAJk
         3UCYy0I0MxK6nPmXrc7Apc632WEeoEtnX2ybpL4/Xu0yJMGF+1QEcZNUbd6gnKCPmNBo
         iy+OfqmoNDykIYjFdzyEFtdJjPp4N9iGwD6Wr1X/ex/yoxZwqU/+MMmt4A2c7FsBhO3/
         8P/g0k+fGQjA0sVkYz2EHM/2Pe5WNetcXLYTrOi64cfgiHpG+ow0MU4labO96pTeW/Gw
         wY/cE3frmYiA3vo7EFmAIvrcHE9vzWferA9QUAx5FvRwC8KP4SBtslylOLLQSZiBhbe3
         fTow==
Received: by 10.213.31.71 with SMTP id x7mr595825ebc.125.1334503250519;
        Sun, 15 Apr 2012 08:20:50 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2f70:4010:1159:12bc:77f7:de98? ([2a01:e35:2f70:4010:1159:12bc:77f7:de98])
        by mx.google.com with ESMTPS id m55sm73456339eei.1.2012.04.15.08.20.47
        (version=SSLv3 cipher=OTHER);
        Sun, 15 Apr 2012 08:20:48 -0700 (PDT)
Message-ID: <4F8AE761.6000205@openwrt.org>
Date:   Sun, 15 Apr 2012 17:21:05 +0200
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     Grant Likely <grant.likely@secretlab.ca>, ralf@linux-mips.org,
        linux-mips@linux-mips.org,
        Linus Walleij <linus.walleij@stericsson.com>,
        Rob Herring <rob.herring@calxeda.com>,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] gpio/MIPS/OCTEON: Add a driver for OCTEON's on-chip
 GPIO pins.
References: <1334275820-7791-1-git-send-email-ddaney.cavm@gmail.com> <1334275820-7791-3-git-send-email-ddaney.cavm@gmail.com> <4F87F868.1080804@openwrt.org> <4F885185.3070005@gmail.com>
In-Reply-To: <4F885185.3070005@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 32943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Le 13/04/2012 18:17, David Daney a écrit :
> On 04/13/2012 02:56 AM, Florian Fainelli wrote:
>> Hi David,
>>
> [...]
>>> +/*
>>> + * The address offset of the GPIO configuration register for a given
>>> + * line.
>>> + */
>>> +static unsigned int bit_cfg_reg(unsigned int gpio)
>>> +{
>>> + if (gpio< 16)
>>> + return 8 * gpio;
>>> + else
>>> + return 8 * (gpio - 16) + 0x100;
>>> +}
>>
>> You could explicitely inline this one, though the compiler will
>> certainly do it by itself.
>>
>
> I always let the compiler decide.
>
>
> [...]
>>> +
>>> + if (OCTEON_IS_MODEL(OCTEON_CN66XX) ||
>>> + OCTEON_IS_MODEL(OCTEON_CN61XX) ||
>>> + OCTEON_IS_MODEL(OCTEON_CNF71XX))
>>> + chip->ngpio = 20;
>>> + else
>>> + chip->ngpio = 16;
>>
>> What about getting the number of gpios from platform_data and/or device
>> tree?
>>
>
> Actually I am thinking about just setting it to 20 unconditionally.
> Anything requesting a non-present GPIO pin is buggy to begin with.

Since it is exposed by the sysfs entry ngpio, you can consider it being 
part of the ABI, and it can be used by an user to query the number of 
gpios available, and will also serve as the maximum number of gpios for 
gpiolib internally, it is certainly best to make it match what the 
hardware can actually do.

>
>>> +
>>> + chip->direction_input = octeon_gpio_dir_in;
>>> + chip->get = octeon_gpio_get;
>>> + chip->direction_output = octeon_gpio_dir_out;
>>> + chip->set = octeon_gpio_set;
>>> + err = gpiochip_add(chip);
>>> + if (err)
>>> + goto out;
>>> +
>>> + dev_info(&pdev->dev, "version: " DRV_VERSION "\n");
>>> +out:
>>> + return err;
>>> +}
>>> +
>>> +static int __exit octeon_gpio_remove(struct platform_device *pdev)
>>> +{
>>> + struct gpio_chip *chip = pdev->dev.platform_data;
>>> + return gpiochip_remove(chip);
>>> +}
>>> +
>>> +static struct of_device_id octeon_gpio_match[] = {
>>> + {
>>> + .compatible = "cavium,octeon-3860-gpio",
>>> + },
>>> + {},
>>> +};
>>> +MODULE_DEVICE_TABLE(of, octeon_mgmt_match);
>>
>> You are using linux/of.h definitions here but you did not include it.
>> Also, there is a typo, you want octeon_gpio_match instead.
>>
>
> Good catch. I will fix that. There is also a section mismatch I need to
> fix.
