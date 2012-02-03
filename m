Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2012 11:27:00 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:36368 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903878Ab2BCK0x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Feb 2012 11:26:53 +0100
Received: by bke5 with SMTP id 5so3709412bke.36
        for <multiple recipients>; Fri, 03 Feb 2012 02:26:46 -0800 (PST)
Received: by 10.204.136.197 with SMTP id s5mr3214501bkt.9.1328264806434;
        Fri, 03 Feb 2012 02:26:46 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-86-184.pppoe.mtu-net.ru. [91.79.86.184])
        by mx.google.com with ESMTPS id d2sm15516991bky.11.2012.02.03.02.26.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Feb 2012 02:26:45 -0800 (PST)
Message-ID: <4F2BB61F.8010708@mvista.com>
Date:   Fri, 03 Feb 2012 14:25:35 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
MIME-Version: 1.0
To:     Jonas Gorski <jonas.gorski@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH] MIPS: BCM63XX: add missing include for bcm63xx_gpio.h
References: <1328215931-24817-1-git-send-email-jonas.gorski@gmail.com>
In-Reply-To: <1328215931-24817-1-git-send-email-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 03-02-2012 0:52, Jonas Gorski wrote:

> bcm63xx_gpio.h uses macros defined in bcm63xx_cpu.h without including it,
> leading to the following build failure:

>    CC [M]  drivers/mmc/core/cd-gpio.o
> In file included from arch/mips/include/asm/mach-bcm63xx/gpio.h:4:0,
>                   from arch/mips/include/asm/gpio.h:4,
>                   from include/linux/gpio.h:30,
>                   from drivers/mmc/core/cd-gpio.c:12:

> arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h: In function 'bcm63xx_gpio_count':
> arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h:10:2: error: implicit declaration of function 'bcm63xx_get_cpu_id'
> arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h:11:7: error: 'BCM6358_CPU_ID' undeclared (first use in this function)
> arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h:11:7: note: each undeclared identifier is reported only once for each function it appears in
> arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h:13:7: error: 'BCM6338_CPU_ID' undeclared (first use in this function)
> arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h:15:7: error: 'BCM6345_CPU_ID' undeclared (first use in this function)
> arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h:17:7: error: 'BCM6368_CPU_ID' undeclared (first use in this function)
> arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h:19:7: error: 'BCM6348_CPU_ID' undeclared (first use in this function)

> make[7]: *** [drivers/mmc/core/cd-gpio.o] Error 1

> Signed-off-by: Jonas Gorski<jonas.gorski@gmail.com>
> ---

> Looking at the file's history, it looks like the problem was there from
> the beginning. So it probably should go into all supported (stable)
> versions up to 3.3-rc2, even if this particular build failure popped up
> first in 3.3.

    You should then addd "Cc: stable@vger.kernel.org" line after your signoff.

WBR, Sergei
