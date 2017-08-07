Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Aug 2017 02:56:15 +0200 (CEST)
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:40751 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23995116AbdHGA4FIiS2h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Aug 2017 02:56:05 +0200
X-IronPort-AV: E=Sophos;i="5.41,335,1498546800"; 
   d="scan'208";a="5802943"
Received: from exsmtp03.microchip.com (HELO email.microchip.com) ([198.175.253.49])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 Aug 2017 17:55:53 -0700
Received: from [10.160.137.65] (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.352.0; Sun, 6 Aug 2017
 17:55:36 -0700
Subject: Re: [PATCH] mtd: nand: Rename nand.h into rawnand.h
To:     Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-mtd@lists.infradead.org>
CC:     David Woodhouse <dwmw2@infradead.org>,
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
        Krzysztof Kozlowski <krzk@kernel.org>,
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
        <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
        <adi-buildroot-devel@lists.sourceforge.net>,
        <linux-cris-kernel@axis.com>, <linux-mips@linux-mips.org>,
        <linux-sh@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-oxnas@lists.tuxfamily.org>, <linuxppc-dev@lists.ozlabs.org>,
        <devel@driverdev.osuosl.org>
References: <1501860550-16506-1-git-send-email-boris.brezillon@free-electrons.com>
 <1501860550-16506-2-git-send-email-boris.brezillon@free-electrons.com>
From:   "Yang, Wenyou" <Wenyou.Yang@Microchip.com>
Message-ID: <fc6e4906-5d76-ab7f-f177-95d77492ba79@Microchip.com>
Date:   Mon, 7 Aug 2017 08:55:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1501860550-16506-2-git-send-email-boris.brezillon@free-electrons.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Return-Path: <Wenyou.Yang@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Wenyou.Yang@Microchip.com
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



On 2017/8/4 23:29, Boris Brezillon wrote:
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
> [...]
>   drivers/mtd/nand/atmel/nand-controller.c        | 2 +-
>   drivers/mtd/nand/atmel/pmecc.c                  | 2 +-
For the Atmel drivers,

Acked-by: Wenyou Yang <wenyou.yang@microchip.com>


Best Regards,
Wenyou Yang
