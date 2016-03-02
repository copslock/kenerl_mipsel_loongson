Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Mar 2016 10:26:45 +0100 (CET)
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38885 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007233AbcCBJ0nBhmPs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Mar 2016 10:26:43 +0100
Received: by mail-wm0-f43.google.com with SMTP id l68so68843250wml.1;
        Wed, 02 Mar 2016 01:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N/EigDRBDCLFLiwf7gWE1IjD0KFkAYaPTnV35pX8gBk=;
        b=AAz4M4YD5z45PXg89se7Dorq1luAQNHkryLtGULIaWW36HDuDNpsngwrxWHlvudF66
         0WjU7sN7jgv4nTP+iJGhJNdPQtLx06r/GCOoW44G/thXq25n/hKneysznKk6xCafV3LI
         msnb3htXfqLFuOpt0it8ionFmgr0HVXHXXFUw/YZGpi3MnbbtmFnEMO4P8iiiQdlggX4
         fpowvlC5hbzL69HdK4vLaHoTYoEZTREzcCTvC00h1uHsL7vq8YiL3+rYyoHcLzeELNGu
         690DTgqZbL0c1P7FwHaBiB4r8PZz9qPX9r5aZMno3RNc01+xctORpSnUPgvAWmKjweBB
         b0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N/EigDRBDCLFLiwf7gWE1IjD0KFkAYaPTnV35pX8gBk=;
        b=E9zN4gE7/FK1uj1eErKcBlMf/bso5oVB4zym7fEC4Tc04jY+LjuDEwaKm1U0rLxz2g
         7HE+69s7amZa1thdYGYXO5GDeMl/RhrK96PWogEcJa4u6NgN06kmoLSa8FMUu9jkWESe
         nk/3Wd0sIKNeF5d3vTdQ7giMehSVnEvO7c5PvP9f2Ef3PpqLXxUEtebNq6LSQ8/ziIPd
         qgQd9hNtqOKkFGX2/uDKw/QCQcPCMtACKUNI18ZEJFlkMmef00VSwKv9rbfQm5tmNKlU
         kmCCNm808EKsg2tzgIyqf5k6ftu7C190Oc8mJ7H5mq9s1ltu4mnyEtfr52aaNtAPwcRg
         WIZg==
X-Gm-Message-State: AD7BkJJiKNX0tFplqItZRx2m/+I82bIYYD33x5dnNQ85MMgDCbbn7Mx5ixMXh2A5wkv3Orr8GeVP4VNP/a9APA==
X-Received: by 10.194.186.170 with SMTP id fl10mr29660721wjc.29.1456910797758;
 Wed, 02 Mar 2016 01:26:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.136.206 with HTTP; Wed, 2 Mar 2016 01:25:58 -0800 (PST)
In-Reply-To: <10378188.DNrgKt6rYE@wuerfel>
References: <1456906572-101795-1-git-send-email-manuel.lauss@gmail.com> <10378188.DNrgKt6rYE@wuerfel>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Wed, 2 Mar 2016 10:25:58 +0100
Message-ID: <CAOLZvyFdr-56pvoOKUFxFLa4rPn2fk-E1vW-tzVe8sAioZ2COg@mail.gmail.com>
Subject: Re: [PATCH] pcmcia: db1xxx_ss: fix last irq_to_gpio user
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-pcmcia <linux-pcmcia@lists.infradead.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Wed, Mar 2, 2016 at 10:01 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 02 March 2016 09:16:12 Manuel Lauss wrote:
>> remove the usage of removed irq_to_gpio() function.  On pre-DB1200
>> boards, pass the actual carddetect GPIO number instead of the IRQ,
>> because we need the gpio to actually test card status (inserted or
>> not) and can get the irq number with gpio_to_irq() instead.
>>
>> Tested on DB1300 and DB1500, this patch fixes PCMCIA on the DB1500,
>> which used irq_to_gpio().
>>
>> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
>
> Thanks for addressing this
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> You should probably add the fixes line from my earlier patch,
> and add Cc:stable so it gets backported to 4.4.

Done, will send a v2 soon.


> My first approach was to pass the gpio number as platform_data, but
> that seemed to get rather complicated, so I dropped the initial
> patch.
>
> Passing it as an IORESOURCE_IRQ is a bit weird too, but I guess it
> gets the job done.

It's not the nicest solution, true, but it gets the job done, and the
driver isn't used outside the old alchemy development boards.
I apparently am the only remaining user of this code with hardware
to test on :)

Thank you!
      Manuel
