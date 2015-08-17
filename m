Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Aug 2015 09:42:05 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:35495 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010411AbbHQHmDWRHo6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Aug 2015 09:42:03 +0200
Received: by obbop1 with SMTP id op1so106189748obb.2;
        Mon, 17 Aug 2015 00:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/WUNMnq9wXX2Tg4uGRzv7KCblSJJvDNODkpPSc+cZEg=;
        b=wiAs3PQRh7kVsi9NbX8p/3Hr1SuhUeBiPZsT/gfLrpT93AJfQk4r29dBsNa133ODl2
         jRis9Np7N3jgSVAgj7o1C361vfEVdP0ClRTdU2ARc4qJAWA+/ugggnqfwdpdiONrHYux
         ZWazCcIzXUjf0l+cyNsMoJV5ImlMCRGA7TWpNbUZDyGuxzIGm7M40RWfIBh09ILJ5fNL
         wGmL1I4Na5vmgY0PLRbjodbZfQZRy28FWEphluJiYmF/fNquIfbYsc+XgrbZ/qHyI14U
         c8fKsR+sBIec9RAC9InzABRZyvQBdmJJmFMHY8UpGI+ABzxgcVTCzm5Ts/kNlvEfvuDU
         Sx+A==
X-Received: by 10.182.24.40 with SMTP id r8mr66965obf.15.1439797317238; Mon,
 17 Aug 2015 00:41:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.73.205 with HTTP; Mon, 17 Aug 2015 00:41:37 -0700 (PDT)
In-Reply-To: <1438678305-25524-1-git-send-email-albeu@free.fr>
References: <1438678305-25524-1-git-send-email-albeu@free.fr>
From:   Alexandre Courbot <gnurou@gmail.com>
Date:   Mon, 17 Aug 2015 16:41:37 +0900
Message-ID: <CAAVeFuK00Gp5mbXAMYp0dM0AmHjeY76jS9CYNJqRS720F1zbDA@mail.gmail.com>
Subject: Re: [PATCH v3] MIPS: Remove all the uses of custom gpio.h
To:     Alban Bedel <albeu@free.fr>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Florian Fainelli <florian@openwrt.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Joe Perches <joe@perches.com>,
        Daniel Walter <dwalter@google.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        James Hartley <james.hartley@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Brian Norris <computersforpeace@gmail.com>,
        Varka Bhadram <varkabhadram@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Masanari Iida <standby24x7@gmail.com>,
        Mauro Carvalho Chehab <m.chehab@samsung.com>,
        Michael Buesch <m@bues.ch>,
        abdoulaye berthe <berthe.ab@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <gnurou@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnurou@gmail.com
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

On Tue, Aug 4, 2015 at 5:50 PM, Alban Bedel <albeu@free.fr> wrote:
> Currently CONFIG_ARCH_HAVE_CUSTOM_GPIO_H is defined for all MIPS
> machines, and each machine type provides its own gpio.h. However
> only a handful really implement the GPIO API, most just forward
> everythings to gpiolib.
>
> The Alchemy machine is notable as it provides a system to allow
> implementing the GPIO API at the board level. But it is not used by
> any board currently supported, so it can also be removed.
>
> For most machine types we can just remove the custom gpio.h, as well
> as the custom wrappers if some exists. Some of the code found in
> the wrappers must be moved to the respective GPIO driver.
>
> A few more fixes are need in some drivers as they rely on linux/gpio.h
> to provides some machine specific definitions, or used asm/gpio.h
> instead of linux/gpio.h for the gpio API.
>
> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
>
> This patch is based on my previous serie:
> "MIPS: ath79: Move the GPIO driver to drivers/gpio".
>
> It supercede my previous patch named:
> "MIPS: Remove most of the custom gpio.h"
>
> Changelog:
> v3: * Add the missing includes to fix the build on jz4740 machines
> v2: * Don't remove AR7_GPIO_MAX and TITAN_GPIO_MAX, that's for another
>       patch
> v1: * Fixed gpio_to_irq on jz4740 and rb532
>     * Cleaned up alchemy as well
>     * Removed asm/gpio.h
>
> For testing I tried to build all mips defconfig, however my toolchain
> couldn't handle a few configs: ip28 malta_qemu_32r6 maltasmvp_eva
> sead3micro. If somebody can test these that would be more than welcome.
>
> Now a few stats about the state of CONFIG_ARCH_HAVE_CUSTOM_GPIO_H
> after appling this patch. Of the 31 supportd arch, 15 still have
> asm/gpio.h, of these 9 are just a "#warning Include linux/gpio.h
> instead of asm/gpio.h". So we have 6 arch left: arm, avr32, blackfin,
> m68k, sh and unicore32. But only m68k and unicore32 really provides
> custom wrappers, all the others only forward to gpiolib.
>
> On the drivers side we only have 13 occurences of '#include
> <asm/gpio.h>' left, mostly in drivers used on ARM SoC.
>
> So the work left to phase out the legacy GPIO is really not that much
> anymore.
>
> Alban
> ---
>  arch/mips/Kconfig                               |   1 -
>  arch/mips/alchemy/Kconfig                       |   7 --
>  arch/mips/alchemy/board-gpr.c                   |   1 +
>  arch/mips/alchemy/board-mtx1.c                  |   1 +
>  arch/mips/alchemy/common/Makefile               |   7 +-
>  arch/mips/alchemy/devboards/db1000.c            |   1 +
>  arch/mips/alchemy/devboards/db1300.c            |   1 +
>  arch/mips/alchemy/devboards/db1550.c            |   1 +
>  arch/mips/alchemy/devboards/pm.c                |   2 +-
>  arch/mips/ar7/gpio.c                            |   5 +-
>  arch/mips/ar7/platform.c                        |   1 -
>  arch/mips/ar7/setup.c                           |   1 -
>  arch/mips/include/asm/gpio.h                    |   6 -
>  arch/mips/include/asm/mach-ar7/ar7.h            |   4 +
>  arch/mips/include/asm/mach-ar7/gpio.h           |  41 -------
>  arch/mips/include/asm/mach-ath25/gpio.h         |  16 ---
>  arch/mips/include/asm/mach-ath79/gpio.h         |  26 -----
>  arch/mips/include/asm/mach-au1x00/gpio-au1000.h | 148 ++----------------------
>  arch/mips/include/asm/mach-au1x00/gpio.h        |  86 --------------
>  arch/mips/include/asm/mach-bcm47xx/gpio.h       |  17 ---
>  arch/mips/include/asm/mach-bcm63xx/gpio.h       |  15 ---
>  arch/mips/include/asm/mach-cavium-octeon/gpio.h |  21 ----
>  arch/mips/include/asm/mach-generic/gpio.h       |  21 ----
>  arch/mips/include/asm/mach-jz4740/gpio.h        |   2 -
>  arch/mips/include/asm/mach-lantiq/gpio.h        |  13 ---
>  arch/mips/include/asm/mach-loongson64/gpio.h    |  36 ------
>  arch/mips/include/asm/mach-pistachio/gpio.h     |  21 ----
>  arch/mips/include/asm/mach-rc32434/gpio.h       |  12 --
>  arch/mips/jz4740/board-qi_lb60.c                |   1 +
>  arch/mips/jz4740/gpio.c                         |  21 ++--
>  arch/mips/pci/pci-lantiq.c                      |   1 -
>  arch/mips/rb532/devices.c                       |   1 +
>  arch/mips/rb532/gpio.c                          |   6 +
>  arch/mips/txx9/generic/setup.c                  |  16 ---
>  drivers/ata/pata_rb532_cf.c                     |   3 +-
>  drivers/gpio/gpio-ath79.c                       |  32 -----
>  drivers/input/misc/rb532_button.c               |   1 +
>  drivers/net/ethernet/ti/cpmac.c                 |   2 +
>  38 files changed, 47 insertions(+), 551 deletions(-)

Acked-by: Alexandre Courbot <acourbot@nvidia.com>

Great cleanup job!
