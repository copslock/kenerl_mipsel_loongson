Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Apr 2012 18:17:37 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:43031 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903651Ab2DMQRV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Apr 2012 18:17:21 +0200
Received: by obhx4 with SMTP id x4so5279741obh.36
        for <multiple recipients>; Fri, 13 Apr 2012 09:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=R3T3qLY3gHsVzkegKlabmG/lo8L6gyQUS9yb/CePuq0=;
        b=xYPurOwJQNLLvb+yGOitHkq3Mhsk60+OmXfUKf+BemeQJzHAhyFCJn3tuReEPzVjGw
         2VPe4MfEz54wgDBIrs1Rsqco2pJbZSpgtAFQFdR4b6hj2P514OeEFZG8g4Rk7zLV+kj0
         buCMptu6G3qdYVHHWsdmlbATlqxxNgXfcj+COM7PTdg6b1h/0BCKfXjb9hKIgqYYi+iV
         0sN8lWHSCMDDnXGu1nvSQR6yogDLpNZplRoc4ji6c+xmq/5e4z6BbFsLu0OH/PqqDH5u
         qFk90r+S7ZmLB+epYIP8pAtYDOAC/upRE6IgU/OhfBF/Qcsa54Bso3Ig3nNhMOXcnqMh
         9Mng==
Received: by 10.182.136.41 with SMTP id px9mr3055988obb.21.1334333832578;
        Fri, 13 Apr 2012 09:17:12 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id d9sm10640428obq.0.2012.04.13.09.17.10
        (version=SSLv3 cipher=OTHER);
        Fri, 13 Apr 2012 09:17:11 -0700 (PDT)
Message-ID: <4F885185.3070005@gmail.com>
Date:   Fri, 13 Apr 2012 09:17:09 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Grant Likely <grant.likely@secretlab.ca>, ralf@linux-mips.org,
        linux-mips@linux-mips.org,
        Linus Walleij <linus.walleij@stericsson.com>,
        Rob Herring <rob.herring@calxeda.com>,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] gpio/MIPS/OCTEON: Add a driver for OCTEON's on-chip
 GPIO pins.
References: <1334275820-7791-1-git-send-email-ddaney.cavm@gmail.com> <1334275820-7791-3-git-send-email-ddaney.cavm@gmail.com> <4F87F868.1080804@openwrt.org>
In-Reply-To: <4F87F868.1080804@openwrt.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 04/13/2012 02:56 AM, Florian Fainelli wrote:
> Hi David,
>
[...]
>> +/*
>> + * The address offset of the GPIO configuration register for a given
>> + * line.
>> + */
>> +static unsigned int bit_cfg_reg(unsigned int gpio)
>> +{
>> + if (gpio< 16)
>> + return 8 * gpio;
>> + else
>> + return 8 * (gpio - 16) + 0x100;
>> +}
>
> You could explicitely inline this one, though the compiler will
> certainly do it by itself.
>

I always let the compiler decide.


[...]
>> +
>> + if (OCTEON_IS_MODEL(OCTEON_CN66XX) ||
>> + OCTEON_IS_MODEL(OCTEON_CN61XX) ||
>> + OCTEON_IS_MODEL(OCTEON_CNF71XX))
>> + chip->ngpio = 20;
>> + else
>> + chip->ngpio = 16;
>
> What about getting the number of gpios from platform_data and/or device
> tree?
>

Actually I am thinking about just setting it to 20 unconditionally. 
Anything requesting a non-present GPIO pin is buggy to begin with.

>> +
>> + chip->direction_input = octeon_gpio_dir_in;
>> + chip->get = octeon_gpio_get;
>> + chip->direction_output = octeon_gpio_dir_out;
>> + chip->set = octeon_gpio_set;
>> + err = gpiochip_add(chip);
>> + if (err)
>> + goto out;
>> +
>> + dev_info(&pdev->dev, "version: " DRV_VERSION "\n");
>> +out:
>> + return err;
>> +}
>> +
>> +static int __exit octeon_gpio_remove(struct platform_device *pdev)
>> +{
>> + struct gpio_chip *chip = pdev->dev.platform_data;
>> + return gpiochip_remove(chip);
>> +}
>> +
>> +static struct of_device_id octeon_gpio_match[] = {
>> + {
>> + .compatible = "cavium,octeon-3860-gpio",
>> + },
>> + {},
>> +};
>> +MODULE_DEVICE_TABLE(of, octeon_mgmt_match);
>
> You are using linux/of.h definitions here but you did not include it.
> Also, there is a typo, you want octeon_gpio_match instead.
>

Good catch.  I will fix that.  There is also a section mismatch I need 
to fix.
