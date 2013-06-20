Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 20:51:31 +0200 (CEST)
Received: from mail-pd0-f175.google.com ([209.85.192.175]:41681 "EHLO
        mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818712Ab3FTSv3kNZVH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Jun 2013 20:51:29 +0200
Received: by mail-pd0-f175.google.com with SMTP id 4so6542316pdd.34
        for <multiple recipients>; Thu, 20 Jun 2013 11:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Icc2CKTdCR5MIbIKJeeqP8QbNS6fOdtCypBvbw6VL5w=;
        b=vmYDlm1X80VsFJTmm9tFC8TsWmIyo/T/HsWIT+tS0XyVmamihSIO8VxNWgCSgb7NFO
         QyDjfjEGfYIgAQUc1G4TejVoZYzkqicUzktAb84A9OpoYx8tFR36qRNTWKWY1Lj1lsOS
         2OgupdlYDCWWxi58leCtEzz7dlBrCMMyzyd6Y1OuE1hfhXYhgCsbHhqavjmP8DuFPP6G
         ImUsGHhst/BuvVZ0w+eovnb5gUQTd0041GmYEfgnAzLCGWKh6dBRiaskjDqQW3rDsXK6
         ZOl4hHlbR5QjfxxozyLADVwjrDtWs/hH8QN+xhCXQkiDAMV4WCUuDs+9lEu6DbJiFvRi
         e3yQ==
X-Received: by 10.66.144.170 with SMTP id sn10mr12741723pab.42.1371754283155;
        Thu, 20 Jun 2013 11:51:23 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id p2sm1839564pag.22.2013.06.20.11.51.21
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 20 Jun 2013 11:51:22 -0700 (PDT)
Message-ID: <51C34F28.403@gmail.com>
Date:   Thu, 20 Jun 2013 11:51:20 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Joe Perches <joe@perches.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Grant Likely <grant.likely@linaro.org>,
        Rob Herring <rob.herring@calxeda.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] gpio MIPS/OCTEON: Add a driver for OCTEON's on-chip GPIO
 pins.
References: <1371251915-18271-1-git-send-email-ddaney.cavm@gmail.com>  <CACRpkdYHzBBbPNujYRGkMFGuQRzeYKs9jgfc3e3HWyxQFahvRQ@mail.gmail.com>  <51C34584.8070301@gmail.com> <1371752324.2146.25.camel@joe-AO722>  <51C3497D.2050107@gmail.com> <1371753812.2146.37.camel@joe-AO722>
In-Reply-To: <1371753812.2146.37.camel@joe-AO722>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37072
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

On 06/20/2013 11:43 AM, Joe Perches wrote:
> On Thu, 2013-06-20 at 11:27 -0700, David Daney wrote:
>> On 06/20/2013 11:18 AM, Joe Perches wrote:
>>> On Thu, 2013-06-20 at 11:10 -0700, David Daney wrote:
>>>> Sorry for not responding earlier, but my e-mail system seems to have
>>>> malfunctioned with respect to this message...
>>> []
>>>> On 06/17/2013 01:51 AM, Linus Walleij wrote:
>>>>>> +static int octeon_gpio_get(struct gpio_chip *chip, unsigned offset)
>>>>>> +{
>>>>>> +       struct octeon_gpio *gpio = container_of(chip, struct octeon_gpio, chip);
>>>>>> +       u64 read_bits = cvmx_read_csr(gpio->register_base + RX_DAT);
>>>>>> +
>>>>>> +       return ((1ull << offset) & read_bits) != 0;
>>>>>
>>>>> A common idiom we use for this is:
>>>>>
>>>>> return !!(read_bits & (1ull << offset));
>>>>
>>>> I hate that idiom, but if its use is a condition of accepting the patch,
>>>> I will change it.
>>>
>>> Or use an even more common idiom and change the
>>> function to return bool and let the compiler do it.
>>>
>>
>> ... but it is part of the gpiochip system interface, so it would have to
>> be done kernel wide.
>
> Not really.  It's a local static function.

... which we generate a pointer to, and then assign that pointer to a 
variable with a type defined in the gpiochip system interface.  So If we 
do what you suggest, the result is:

   CC      drivers/gpio/gpio-octeon.o
drivers/gpio/gpio-octeon.c: In function 'octeon_gpio_probe':
drivers/gpio/gpio-octeon.c:113:12: warning: assignment from incompatible 
pointer type [enabled by default]



>
>> Really I don't like the idea of GPIO lines having Boolean truth values
>> associated with them.  Some represent things that are active-high and
>> others active-low.  Converting the pin voltage being above or below a
>> given threshold to something other than zero or one would in my opinion
>> be confusing.
>
> No worries, just offering options.  Your code, your choice.
>
>
>
