Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Aug 2017 21:06:33 +0200 (CEST)
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33634 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994842AbdHGTGTIaITE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Aug 2017 21:06:19 +0200
Received: by mail-wm0-f68.google.com with SMTP id q189so2049266wmd.0;
        Mon, 07 Aug 2017 12:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7aLfl5n9vqBeHN6FpqA5HwpwuWVl+fCjKVp77EqvPPs=;
        b=ghhkfXoVC4EvUnmtdgZp4JEsqIGptO2tBOvOnyBnyki7NDkvj2/rB29AYMKsDkdkNf
         0CX9Su97mpLFAmyeoL5aXdUVBdcgSzdgOfsvJQNopnOASW+tXiTUllDrH5JUsMTdQHyP
         TL4O+OLzPexRTPvO5/33zRGaPeX0nNGnbozh0zOAy5Bu1wZMUk7oU88LrRtS3ptA1XPS
         RsDtNrTwwjzkbYFMzVCAp0b5wvGbJVAdeIsz96FUjzP0iOHpLQJaCzJWQ41Z+qzu1cd0
         dgX574VYxxOO1GYrfKeKWBPSrtQL7Zff7oyhQz79RUqnsWRHK6BVEmc5qnaI2wEde3VM
         Mu8A==
X-Gm-Message-State: AHYfb5iOn8zV6qJcIy+bqzsTO9TKhzvvkzoN2MnlNZhz/U0DJjbewCbK
        zGe3fiKUJZL+Ew==
X-Received: by 10.80.241.195 with SMTP id y3mr1906788edl.66.1502132773785;
        Mon, 07 Aug 2017 12:06:13 -0700 (PDT)
Received: from kozik-lap (pub082136089155.dh-hfc.datazug.ch. [82.136.89.155])
        by smtp.googlemail.com with ESMTPSA id l28sm7341805eda.7.2017.08.07.12.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Aug 2017 12:06:12 -0700 (PDT)
Date:   Mon, 7 Aug 2017 21:06:09 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Boris Brezillon <boris.brezillon@free-electrons.com>
Cc:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Peter Pan <peterpandong@micron.com>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Alexander Clouter <alex@digriz.org.uk>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Kukjin Kim <kgene@kernel.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Steven Miao <realmz6@gmail.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Wenyou Yang <wenyou.yang@atmel.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Han Xu <han.xu@nxp.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Stefan Agner <stefan@agner.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-mediatek@lists.infradead.org,
        linux-oxnas@lists.tuxfamily.org, linuxppc-dev@lists.ozlabs.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH] mtd: nand: Rename nand.h into rawnand.h
Message-ID: <20170807190609.uz6fpatkzijfgifr@kozik-lap>
References: <1501860550-16506-1-git-send-email-boris.brezillon@free-electrons.com>
 <1501860550-16506-2-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1501860550-16506-2-git-send-email-boris.brezillon@free-electrons.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <k.kozlowski.k@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: krzk@kernel.org
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

On Fri, Aug 04, 2017 at 05:29:10PM +0200, Boris Brezillon wrote:
> We are planning to share more code between different NAND based
> devices (SPI NAND, OneNAND and raw NANDs), but before doing that
> we need to move the existing include/linux/mtd/nand.h file into
> include/linux/mtd/rawnand.h so we can later create a nand.h header
> containing all common structure and function prototypes.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Peter Pan <peterpandong@micron.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: Krzysztof Halasa <khalasa@piap.pl>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Alexander Clouter <alex@digriz.org.uk>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Simtec Linux Team <linux@simtec.co.uk>
> Cc: Steven Miao <realmz6@gmail.com>
> Cc: Mikael Starvik <starvik@axis.com>
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Wenyou Yang <wenyou.yang@atmel.com>
> Cc: Josh Wu <rainyfeeling@outlook.com>
> Cc: Kamal Dasu <kdasu.kdev@gmail.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Han Xu <han.xu@nxp.com>
> Cc: Harvey Hunt <harveyhuntnexus@gmail.com>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Wan ZongShun <mcuos.com@gmail.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Cc: Maxim Levitsky <maximlevitsky@gmail.com>
> Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: adi-buildroot-devel@lists.sourceforge.net
> Cc: linux-cris-kernel@axis.com
> Cc: linux-mips@linux-mips.org
> Cc: linux-sh@vger.kernel.org
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-oxnas@lists.tuxfamily.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: devel@driverdev.osuosl.org
> ---
> Hi All,
> 
> Sorry for the huge Cc list, but I'd like to collect as much acks as
> possible for this patch which is actually part of a bigger series [1].
> 
> Note that there's nothing complicated here, it's just a mechanical
> s/nand\.h/rawnand\.h/ replacement, but it impacts several architectures,
> the doc and staging directories.
> 
> Regards,
> 
> Boris
> 
> [1]https://lwn.net/Articles/723694/
> ---
>  Documentation/driver-api/mtdnand.rst            | 8 ++++----
>  MAINTAINERS                                     | 2 +-
>  arch/arm/mach-davinci/board-da850-evm.c         | 2 +-
>  arch/arm/mach-davinci/board-dm355-evm.c         | 2 +-
>  arch/arm/mach-davinci/board-dm355-leopard.c     | 2 +-
>  arch/arm/mach-davinci/board-dm365-evm.c         | 2 +-
>  arch/arm/mach-davinci/board-dm644x-evm.c        | 2 +-
>  arch/arm/mach-davinci/board-dm646x-evm.c        | 2 +-
>  arch/arm/mach-davinci/board-sffsdr.c            | 2 +-
>  arch/arm/mach-dove/dove-db-setup.c              | 2 +-
>  arch/arm/mach-ep93xx/snappercl15.c              | 2 +-
>  arch/arm/mach-ep93xx/ts72xx.c                   | 2 +-
>  arch/arm/mach-imx/mach-qong.c                   | 2 +-
>  arch/arm/mach-ixp4xx/ixdp425-setup.c            | 2 +-
>  arch/arm/mach-mmp/aspenite.c                    | 2 +-
>  arch/arm/mach-omap1/board-fsample.c             | 2 +-
>  arch/arm/mach-omap1/board-h2.c                  | 2 +-
>  arch/arm/mach-omap1/board-h3.c                  | 2 +-
>  arch/arm/mach-omap1/board-nand.c                | 2 +-
>  arch/arm/mach-omap1/board-perseus2.c            | 2 +-
>  arch/arm/mach-orion5x/db88f5281-setup.c         | 2 +-
>  arch/arm/mach-orion5x/kurobox_pro-setup.c       | 2 +-
>  arch/arm/mach-orion5x/ts209-setup.c             | 2 +-
>  arch/arm/mach-orion5x/ts78xx-setup.c            | 2 +-
>  arch/arm/mach-pxa/balloon3.c                    | 2 +-
>  arch/arm/mach-pxa/em-x270.c                     | 2 +-
>  arch/arm/mach-pxa/eseries.c                     | 2 +-
>  arch/arm/mach-pxa/palmtx.c                      | 2 +-
>  arch/arm/mach-pxa/tosa.c                        | 2 +-
>  arch/arm/mach-s3c24xx/common-smdk.c             | 2 +-
>  arch/arm/mach-s3c24xx/mach-anubis.c             | 2 +-
>  arch/arm/mach-s3c24xx/mach-at2440evb.c          | 2 +-
>  arch/arm/mach-s3c24xx/mach-bast.c               | 2 +-
>  arch/arm/mach-s3c24xx/mach-gta02.c              | 2 +-
>  arch/arm/mach-s3c24xx/mach-jive.c               | 2 +-
>  arch/arm/mach-s3c24xx/mach-mini2440.c           | 2 +-
>  arch/arm/mach-s3c24xx/mach-osiris.c             | 2 +-
>  arch/arm/mach-s3c24xx/mach-qt2410.c             | 2 +-
>  arch/arm/mach-s3c24xx/mach-rx3715.c             | 2 +-
>  arch/arm/mach-s3c24xx/mach-vstms.c              | 2 +-

For s3c24xx:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
