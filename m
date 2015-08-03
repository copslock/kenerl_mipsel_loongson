Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Aug 2015 09:13:36 +0200 (CEST)
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35565 "EHLO
        mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010201AbbHCHNdpM-5O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Aug 2015 09:13:33 +0200
Received: by obbop1 with SMTP id op1so92983745obb.2
        for <linux-mips@linux-mips.org>; Mon, 03 Aug 2015 00:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=7IamHPHfXjmbbh5kJYKwaVT6f6sgvrjdZchdXqmKZf8=;
        b=RlgAWCNCYOBoAiIQV8YML5KFRoQBAvc318wAw1GuThrifW9c7HIJE97kCogpvWO4Jo
         /SBsHuUNFloSS9tiBc8Pde3dUdBtgou0hJYpfRemcmyK5evp808evmhUr7lRYmb4lzM0
         F2w5fO45lfSBEoDmzL+A/y2ogV5KvDughat4IbkUHJSCynD79XBzvvvnEFhoFeebd2ri
         zEZ8/Y/J5Qgel3PgrZnRnLNTlfA7hxYjo3XbTd1b/WkcRXBn6mMyCkOuUcO0vS+RxAZL
         +M0Axtx8nFp2fuZn+n44CedOXmvZPXrP9wBrrBpkl9wAlr5cSv2MuInblIPEHcHZNO+O
         1/HA==
X-Gm-Message-State: ALoCoQlKiqAijoa2bOWmmmsLbMdCPgmZmsIe8vmr2Mg4aLnVtsprmiT5SmAy3xqys1HWkApvFa2b
MIME-Version: 1.0
X-Received: by 10.182.133.42 with SMTP id oz10mr14753536obb.76.1438586007647;
 Mon, 03 Aug 2015 00:13:27 -0700 (PDT)
Received: by 10.182.204.100 with HTTP; Mon, 3 Aug 2015 00:13:27 -0700 (PDT)
In-Reply-To: <1438277338-7246-1-git-send-email-albeu@free.fr>
References: <1438277338-7246-1-git-send-email-albeu@free.fr>
Date:   Mon, 3 Aug 2015 09:13:27 +0200
Message-ID: <CACRpkdbUhYysC+mGuJY6Y8kd18LQLoWu+av81+ZD4UZo2nM-Yw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Remove all the uses of custom gpio.h
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Alban Bedel <albeu@free.fr>
Cc:     Linux MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Florian Fainelli <florian@openwrt.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Joe Perches <joe@perches.com>,
        Daniel Walter <dwalter@google.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Varka Bhadram <varkabhadram@gmail.com>,
        Masanari Iida <standby24x7@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Michael Buesch <m@bues.ch>,
        Mauro Carvalho Chehab <m.chehab@samsung.com>,
        abdoulaye berthe <berthe.ab@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Thu, Jul 30, 2015 at 7:28 PM, Alban Bedel <albeu@free.fr> wrote:

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
> Compared to the previous patch:
> * Fixed gpio_to_irq on jz4740 and rb532
> * Cleaned up alchemy as well
> * Removed asm/gpio.h
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

Very good job being done here.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I guess this better go in through the MIPS tree.
Given all the OpenWRT ports using MIPS this is excellent
progress for a large hobbyist community.

Yours,
Linus Walleij
