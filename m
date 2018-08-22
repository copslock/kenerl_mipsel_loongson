Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Aug 2018 21:15:03 +0200 (CEST)
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:33499 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992869AbeHVTO6xJ3qU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Aug 2018 21:14:58 +0200
Received: from belgarion ([90.89.234.36])
        by mwinf5d35 with ME
        id SKE31y00C0nnJME03KE68D; Wed, 22 Aug 2018 21:14:53 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 22 Aug 2018 21:14:53 +0200
X-ME-IP: 90.89.234.36
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Lukasz Majewski <lukma@denx.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Alexander Clouter <alex@digriz.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Han Xu <han.xu@nxp.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Xiaolei Li <xiaolei.li@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Wan ZongShun <mcuos.com@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>, Stefan Agner <stefan@agner.ch>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH 01/23] mtd: rawnand: plat_nand: Pass a nand_chip object to all platform_nand_ctrl hooks
References: <20180817160922.6224-1-boris.brezillon@bootlin.com>
        <20180817160922.6224-2-boris.brezillon@bootlin.com>
X-URL:  http://belgarath.falguerolles.org/
Date:   Wed, 22 Aug 2018 21:14:02 +0200
In-Reply-To: <20180817160922.6224-2-boris.brezillon@bootlin.com> (Boris
        Brezillon's message of "Fri, 17 Aug 2018 18:09:00 +0200")
Message-ID: <87y3cy8b9h.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <robert.jarzmik@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robert.jarzmik@free.fr
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

Boris Brezillon <boris.brezillon@bootlin.com> writes:

> Let's make the raw NAND API consistent by patching all helpers and
> hooks to take a nand_chip object instead of an mtd_info one or
> remove the mtd_info object when both are passed.
>
> In order to do that, we first need to update the platform_nand_ctrl
> hooks to take a nand_chip object instead of an mtd_info.
>
> We had temporary plat_nand_xxx() wrappers to the do the mtd -> chip
> conversion, but those will be dropped when doing the patching nand_chip
> hooks to take a nand_chip object.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
For mach-pxa:
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
