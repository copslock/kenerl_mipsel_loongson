Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jul 2015 19:48:05 +0200 (CEST)
Received: from mail-wi0-f181.google.com ([209.85.212.181]:36403 "EHLO
        mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010139AbbGVRsDKenRl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Jul 2015 19:48:03 +0200
Received: by wicgb10 with SMTP id gb10so108841620wic.1;
        Wed, 22 Jul 2015 10:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+lC2xl7CtLRDmJjoOw7oOB9GuTAk3t+Vj2pIzxx1Awo=;
        b=u++K/2b5uh+AVO1Fmo9alchhqi9gG83vNQT/ry44GFc6ZqnLCAeEEYSqPIpY1KxWHJ
         SSsScu48saCYc8A4zmVwhdAK5E2/alxcQe+1rmCldDv0r6+2HnHUcYnspiVTOxmsl1YB
         FEbymqzebthCnY6YTVxVC4/DdILqky4tUXrmPrpLQqKrXHCAZeNQWro2deEdHQDT5laF
         vGZoNzl3vr7/rneD3lDPkWI84iC16/IUj+KpDpI7GbGW35VZ9ujxYTAWe2XFnYn42LTn
         XX0NcvnZ881883YoAo2w27A3312a14jTZIWkesrXp2tIXs9Aol1TVEj/SEQ59QmW70L4
         HQ5Q==
X-Received: by 10.180.23.69 with SMTP id k5mr8982746wif.3.1437587277848; Wed,
 22 Jul 2015 10:47:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.248.193 with HTTP; Wed, 22 Jul 2015 10:47:18 -0700 (PDT)
In-Reply-To: <1437586416-14735-1-git-send-email-albeu@free.fr>
References: <1437586416-14735-1-git-send-email-albeu@free.fr>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Wed, 22 Jul 2015 19:47:18 +0200
Message-ID: <CAOLZvyE=PJUEzp7NqN+g9N1FASxSpfRJTV_uJeAppTxF3sRLhQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Remove most of the custom gpio.h
To:     Alban Bedel <albeu@free.fr>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Florian Fainelli <florian@openwrt.org>,
        Joe Perches <joe@perches.com>,
        Daniel Walter <dwalter@google.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        James Hogan <james.hogan@imgtec.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Levente Kurusa <levex@linux.com>,
        abdoulaye berthe <berthe.ab@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48386
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

On Wed, Jul 22, 2015 at 7:33 PM, Alban Bedel <albeu@free.fr> wrote:
> Currently CONFIG_ARCH_HAVE_CUSTOM_GPIO_H is defined for all MIPS
> machines, and each machine type provides its own gpio.h. However only
> the Alchemy machine really use the feature, all other machines only
> use the default wrappers.
>
> For most machine types we can just remove the custom gpio.h, as well
> as the custom wrappers if some exists. A few more fixes are need in
> a few drivers as they rely on linux/gpio.h to provides some machine
> specific definitions, or used asm/gpio.h instead of linux/gpio.h for
> the gpio API.
>
> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
>
> This patch is based on my previous serie:
> "MIPS: ath79: Move the GPIO driver to drivers/gpio".
>
> For testing I tried to build all mips defconfig, however my toolchain
> couldn't handle a few configs: ip28 malta_qemu_32r6 maltasmvp_eva
> sead3micro. If somebody can test these that would be more than welcome.
>
> It might well be that some more drivers for MIPS devices that are not
> enabled in the defconfig will break because of this change, so more
> testing would be nice :)
>
> Regarding Alchemy I'm not sure what to do. It use a little more
> complex setup, quoting arch/mips/include/asm/mach-au1x00/gpio.h:
>
> /* Linux gpio framework integration.
> *
> * 4 use cases of Alchemy GPIOS:
> *(1) GPIOLIB=y, ALCHEMY_GPIO_INDIRECT=y:
> *       Board must register gpiochips.
> *(2) GPIOLIB=y, ALCHEMY_GPIO_INDIRECT=n:
> *       A gpiochip for the 75 GPIOs is registered.
> *
> *(3) GPIOLIB=n, ALCHEMY_GPIO_INDIRECT=y:
> *       the boards' gpio.h must provide the linux gpio wrapper
> functions,
> *
> *(4) GPIOLIB=n, ALCHEMY_GPIO_INDIRECT=n:
> *       inlinable gpio functions are provided which enable access to the
> *       Au1300 gpios only by using the numbers straight out of the data-
> *       sheets.
>
> * Cases 1 and 3 are intended for boards which want to provide their own
> * GPIO namespace and -operations (i.e. for example you have 8 GPIOs
> * which are in part provided by spare Au1300 GPIO pins and in part by
> * an external FPGA but you still want them to be accssible in linux
> * as gpio0-7. The board can of course use the alchemy_gpioX_* functions
> * as required).
> */
>
> This sound to me like this is really not needed anymore. Is there any
> users of this left, or can it just go?

There are no in-tree users of this, but a few out-of-tree ones (all made by me)
Does it have to be removed?  Is it blocking anything?

Manuel
