Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jul 2015 10:41:36 +0200 (CEST)
Received: from smtp6-g21.free.fr ([212.27.42.6]:53215 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006887AbbGWIleAmXlX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Jul 2015 10:41:34 +0200
Received: from tock (unknown [46.114.105.85])
        (Authenticated sender: albeu)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id 41AF08229E;
        Thu, 23 Jul 2015 10:35:23 +0200 (CEST)
Date:   Thu, 23 Jul 2015 10:40:56 +0200
From:   Alban <albeu@free.fr>
To:     Manuel Lauss <manuel.lauss@gmail.com>
Cc:     Aban Bedel <albeu@free.fr>, Linux-MIPS <linux-mips@linux-mips.org>,
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
Subject: Re: [PATCH] MIPS: Remove most of the custom gpio.h
Message-ID: <20150723104056.3cb903d0@tock>
In-Reply-To: <CAOLZvyE=PJUEzp7NqN+g9N1FASxSpfRJTV_uJeAppTxF3sRLhQ@mail.gmail.com>
References: <1437586416-14735-1-git-send-email-albeu@free.fr>
        <CAOLZvyE=PJUEzp7NqN+g9N1FASxSpfRJTV_uJeAppTxF3sRLhQ@mail.gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

On Wed, 22 Jul 2015 19:47:18 +0200
Manuel Lauss <manuel.lauss@gmail.com> wrote:

> On Wed, Jul 22, 2015 at 7:33 PM, Alban Bedel <albeu@free.fr> wrote:
> > Currently CONFIG_ARCH_HAVE_CUSTOM_GPIO_H is defined for all MIPS
> > machines, and each machine type provides its own gpio.h. However
> > only the Alchemy machine really use the feature, all other machines
> > only use the default wrappers.
> >
> > For most machine types we can just remove the custom gpio.h, as well
> > as the custom wrappers if some exists. A few more fixes are need in
> > a few drivers as they rely on linux/gpio.h to provides some machine
> > specific definitions, or used asm/gpio.h instead of linux/gpio.h for
> > the gpio API.
> >
> > Signed-off-by: Alban Bedel <albeu@free.fr>
> > ---
> >
> > This patch is based on my previous serie:
> > "MIPS: ath79: Move the GPIO driver to drivers/gpio".
> >
> > For testing I tried to build all mips defconfig, however my
> > toolchain couldn't handle a few configs: ip28 malta_qemu_32r6
> > maltasmvp_eva sead3micro. If somebody can test these that would be
> > more than welcome.
> >
> > It might well be that some more drivers for MIPS devices that are
> > not enabled in the defconfig will break because of this change, so
> > more testing would be nice :)
> >
> > Regarding Alchemy I'm not sure what to do. It use a little more
> > complex setup, quoting arch/mips/include/asm/mach-au1x00/gpio.h:
> >
> > /* Linux gpio framework integration.
> > *
> > * 4 use cases of Alchemy GPIOS:
> > *(1) GPIOLIB=y, ALCHEMY_GPIO_INDIRECT=y:
> > *       Board must register gpiochips.
> > *(2) GPIOLIB=y, ALCHEMY_GPIO_INDIRECT=n:
> > *       A gpiochip for the 75 GPIOs is registered.
> > *
> > *(3) GPIOLIB=n, ALCHEMY_GPIO_INDIRECT=y:
> > *       the boards' gpio.h must provide the linux gpio wrapper
> > functions,
> > *
> > *(4) GPIOLIB=n, ALCHEMY_GPIO_INDIRECT=n:
> > *       inlinable gpio functions are provided which enable access
> > to the
> > *       Au1300 gpios only by using the numbers straight out of the
> > data-
> > *       sheets.
> >
> > * Cases 1 and 3 are intended for boards which want to provide their
> > own
> > * GPIO namespace and -operations (i.e. for example you have 8 GPIOs
> > * which are in part provided by spare Au1300 GPIO pins and in part
> > by
> > * an external FPGA but you still want them to be accssible in linux
> > * as gpio0-7. The board can of course use the alchemy_gpioX_*
> > functions
> > * as required).
> > */
> >
> > This sound to me like this is really not needed anymore. Is there
> > any users of this left, or can it just go?
> 
> There are no in-tree users of this, but a few out-of-tree ones (all
> made by me) Does it have to be removed?  Is it blocking anything?

It is not blocking anything, but I see little gain in it. Cases 1 and 3
should nowadays be handled using normal GPIO drivers, and not with such
platform specific constructs.

Alban
