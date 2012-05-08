Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2012 14:49:29 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:56925 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903688Ab2EHMtI convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 May 2012 14:49:08 +0200
Received: by obqv19 with SMTP id v19so12115049obq.36
        for <multiple recipients>; Tue, 08 May 2012 05:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=JBdnFaMOQXJTYZuafggE4pGVx1jyN+LE2CLLCXVebIg=;
        b=hXP3KDMUecgiAZtWd5mefYFnq/P5Pbzfy9oicFfBaW5nAEc3gR/cVOTwlNHcIbow/3
         Lo1Y9wsz1iMgQPMDQZXKh/3S5RrNBRyQIAyH1kBz76xvk3Qo9CH9ezDyQ0f1RHOipjRB
         U4rHfYzFpoChKk7qSH1WacEO7SwEL9tDbnZR50ywjMMkOtPbmZGVQUj0lJECXLBIBLFx
         d/po5Ed5IDtkTPq6CYUWtOw0D1L8aSvOuCezdQfjsKuZCr2t6O17Poak46214VDj2eAX
         FpMMb65ZGYS9f/sMzoH/sllg8v3C39TJaldDOwFrUWeuXkuSw6vianpngzXJkSGvKvDG
         Gv2Q==
Received: by 10.182.119.101 with SMTP id kt5mr26912112obb.70.1336481342076;
 Tue, 08 May 2012 05:49:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.169.138 with HTTP; Tue, 8 May 2012 05:48:41 -0700 (PDT)
In-Reply-To: <1336472347-25822-1-git-send-email-dedekind1@gmail.com>
References: <1336472347-25822-1-git-send-email-dedekind1@gmail.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Tue, 8 May 2012 14:48:41 +0200
Message-ID: <CAOiHx==iC27f=frCedDH2xahaK=HBzXBxrWhb-AuG+vcCqSUCw@mail.gmail.com>
Subject: Re: [PATCH] mips: bcm63xx: fix compilation problems
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux Kernel Maling List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 33211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Artem,

On 8 May 2012 12:19, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>
> I get the following build error when I am compiling the MTD gpio-nand driver
> for bcm63xx:
>
> In file included from arch/mips/include/asm/mach-bcm63xx/gpio.h:4:0,
>                 from arch/mips/include/asm/gpio.h:4,
>                 from include/linux/gpio.h:36,
>                 from drivers/mtd/maps/gpio-addr-flash.c:16:
> arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h: In function 'bcm63xx_gpio_count':
> arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h:10:2: error: implicit declaration of function 'bcm63xx_get_cpu_id' [-Werror=implicit-function-declaration]
> arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h:11:7: error: 'BCM6358_CPU_ID' undeclared (first use in this function)
> arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h:11:7: note: each undeclared identifier is reported only once for each function it appears in
> arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h:13:7: error: 'BCM6338_CPU_ID' undeclared (first use in this function)
> arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h:15:7: error: 'BCM6345_CPU_ID' undeclared (first use in this function)
> arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h:17:7: error: 'BCM6368_CPU_ID' undeclared (first use in this function)
> arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h:19:7: error: 'BCM6348_CPU_ID' undeclared (first use in this function)
>
> (snip)

I already submitted almost the same patch ~3 months ago:
http://patchwork.linux-mips.org/patch/3351/

> This patch sloves the problem.

"sloves"? ;p


Jonas
