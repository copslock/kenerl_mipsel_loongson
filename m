Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Mar 2015 16:55:26 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:53289 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013918AbbCPPzXwF7wo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Mar 2015 16:55:23 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id C2F0F28C61C;
        Mon, 16 Mar 2015 16:54:54 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qc0-f174.google.com (mail-qc0-f174.google.com [209.85.216.174])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 935FB28A22B;
        Mon, 16 Mar 2015 16:54:50 +0100 (CET)
Received: by qcbkw5 with SMTP id kw5so47648590qcb.2;
        Mon, 16 Mar 2015 08:55:14 -0700 (PDT)
X-Received: by 10.55.16.83 with SMTP id a80mr110016357qkh.86.1426521314849;
 Mon, 16 Mar 2015 08:55:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.42.229 with HTTP; Mon, 16 Mar 2015 08:54:54 -0700 (PDT)
In-Reply-To: <1426517616.25162.24.camel@sakura.staff.proxad.net>
References: <1426176058-26114-1-git-send-email-nschichan@freebox.fr> <1426517616.25162.24.camel@sakura.staff.proxad.net>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Mon, 16 Mar 2015 16:54:54 +0100
Message-ID: <CAOiHx==nyb946TouM5-eZKWBzNbhEuworX6bfTZntZTqfK08bQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: bcm63xx: move bcm63xx_gpio_init() to bcm63xx_register_devices().
To:     Maxime Bizon <mbizon@freebox.fr>
Cc:     Nicolas Schichan <nschichan@freebox.fr>,
        Ralf Baechle <ralf@linux-mips.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Mon, Mar 16, 2015 at 3:53 PM, Maxime Bizon <mbizon@freebox.fr> wrote:
>
> On Thu, 2015-03-12 at 17:00 +0100, Nicolas Schichan wrote:
>
>> When called from prom init code, bcm63xx_gpio_init() will fail as it
>> will call gpiochip_add() which relies on a working kmalloc() to alloc
>> the gpio_desc array and kmalloc is not useable yet at prom init time.
>>
>> Move bcm63xx_gpio_init() to bcm63xx_register_devices() (an
>> arch_initcall) where kmalloc works.
>
> no that patch is completely bogus:
>
> 1) bcm63xx_gpio_init() does more than registering the gpio_chip: look at
> bcm63xx_gpio_out_low_reg_init().
>
> We want at least the low lever helpers bcm_gpio_readl()/writel() to work
> early.

bcm_gpio_readl/bcm_gpio_writel() are completely unaffected by anything
done by bcm63xx_gpio_out_low_reg_init(), all they do is access the
gpio register space.

And all of the functions using the gpio_out_low_reg are static and
only accessible through the registered gpio chip, so there can't be
any rouge accesses before the chip is registered.

> 2) look at board_register_devices() in board_bcm963xx.c, it uses the
> gpio API, but is called during arch_initcall() (there was an attempt to
> move it later, but it has been reverted)
>
> so you cannot move that gpiochip registration later as-is, more
> refactoring and *testing* is required.

The only access done in board_register_devices() is the ephy-reset
gpio, and that is still done *after* moving bcm63xx_gpio_init() to
register_devices().

So I don't see how this breaks anything. But for the sake of the
argument, let's give it a spin:

root@OpenWrt:/# uname -a
Linux OpenWrt 4.0.0-rc1+ #383 SMP Mon Mar 16 16:46:49 CET 2015 mips GNU/Linux
root@OpenWrt:/# cat /sys/kernel/debug/gpio
GPIOs 0-39, bcm63xx-gpio:
 gpio-4   (power               ) out hi
 gpio-5   (stop                ) out lo
 gpio-15  (adsl-fail           ) out hi
 gpio-22  (ppp                 ) out hi
 gpio-23  (ppp-fail            ) out hi
 gpio-36  (ephy-reset          ) out hi

Everything seems to work fine.


Jonas
