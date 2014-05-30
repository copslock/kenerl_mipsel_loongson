Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2014 19:33:47 +0200 (CEST)
Received: from mail-ie0-f169.google.com ([209.85.223.169]:37876 "EHLO
        mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817294AbaE3RdqMoThs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 May 2014 19:33:46 +0200
Received: by mail-ie0-f169.google.com with SMTP id rp18so833935iec.28
        for <linux-mips@linux-mips.org>; Fri, 30 May 2014 10:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=lMG4PGyq69XzPjBrVWe4SaATOQL56sWeB0kS41Le3M0=;
        b=wTYjqXR3Ph+VxvxuPVCC9ifVDDR44ExmbvLPaZnf5Q/SURT5IFLF4r9vFp+4pz4st6
         JcpKhf1QfP9VcAvudgTCU8W2IwJTG+AQX/kzypJG6BXhEnAZqD5tHHb9rx2wHtkgLQ0n
         WbwEbrg6OouXc4qKJokWk2+0aKTgIUhmtiJIJ+VPPrFT29vkDwLY5OwmWwxZEBXG2Mr2
         PEli9OzWGsZgUH0J+HrL2rO98xbBT1TRF6fEcA36x7KvzVPJQytyvCAZUVldDF2DB3HH
         wJ9HR89CzVrQ6Unv9KJrWK6Nna5UojN3Jxc9NSM5YVwxxwPzNtOpN1IIdOwfGm8/DfnZ
         5ajA==
X-Received: by 10.42.85.19 with SMTP id o19mr17860762icl.34.1401471219986;
        Fri, 30 May 2014 10:33:39 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ri2sm6921193igc.1.2014.05.30.10.33.37
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 30 May 2014 10:33:39 -0700 (PDT)
Message-ID: <5388C0F1.90503@gmail.com>
Date:   Fri, 30 May 2014 10:33:37 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     abdoulaye berthe <berthe.ab@gmail.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>, m@bues.ch,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        patches@opensource.wolfsonmicro.com,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-samsungsoc@vger.kernel.org, spear-devel@list.st.com,
        platform-driver-x86@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>
Subject: Re: [PATCH 2/2] gpio: gpiolib: set gpiochip_remove retval to void
References: <20140530094025.3b78301e@canb.auug.org.au>        <1401449454-30895-1-git-send-email-berthe.ab@gmail.com>        <1401449454-30895-2-git-send-email-berthe.ab@gmail.com> <CAMuHMdV6AtjD2aqO3buzj8Eo7A7xc_+ROYnxEi2sdjMaqFiAuA@mail.gmail.com>
In-Reply-To: <CAMuHMdV6AtjD2aqO3buzj8Eo7A7xc_+ROYnxEi2sdjMaqFiAuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40391
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

On 05/30/2014 04:39 AM, Geert Uytterhoeven wrote:
> On Fri, May 30, 2014 at 1:30 PM, abdoulaye berthe <berthe.ab@gmail.com> wrote:
>> --- a/drivers/gpio/gpiolib.c
>> +++ b/drivers/gpio/gpiolib.c
>> @@ -1263,10 +1263,9 @@ static void gpiochip_irqchip_remove(struct gpio_chip *gpiochip);
>>    *
>>    * A gpio_chip with any GPIOs still requested may not be removed.
>>    */
>> -int gpiochip_remove(struct gpio_chip *chip)
>> +void gpiochip_remove(struct gpio_chip *chip)
>>   {
>>          unsigned long   flags;
>> -       int             status = 0;
>>          unsigned        id;
>>
>>          acpi_gpiochip_remove(chip);
>> @@ -1278,24 +1277,15 @@ int gpiochip_remove(struct gpio_chip *chip)
>>          of_gpiochip_remove(chip);
>>
>>          for (id = 0; id < chip->ngpio; id++) {
>> -               if (test_bit(FLAG_REQUESTED, &chip->desc[id].flags)) {
>> -                       status = -EBUSY;
>> -                       break;
>> -               }
>> -       }
>> -       if (status == 0) {
>> -               for (id = 0; id < chip->ngpio; id++)
>> -                       chip->desc[id].chip = NULL;
>> -
>> -               list_del(&chip->list);
>> +               if (test_bit(FLAG_REQUESTED, &chip->desc[id].flags))
>> +                       panic("gpio: removing gpiochip with gpios still requested\n");
>
> panic?

NACK to the patch for this reason.  The strongest thing you should do 
here is WARN.

That said, I am not sure why we need this whole patch set in the first 
place.

David Daney



>
> Is this likely to happen?
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
>
>
