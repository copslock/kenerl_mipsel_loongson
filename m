Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Aug 2017 19:38:03 +0200 (CEST)
Received: from metis.ext.pengutronix.de ([IPv6:2001:67c:670:201:290:27ff:fe1d:cc33]:33431
        "EHLO metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23995095AbdHDRh5bWqyp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Aug 2017 19:37:57 +0200
Received: from [2001:67c:670:100:5054:ff:fe2a:3aa] (helo=pty.hi.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ddgWU-0006eQ-5G; Fri, 04 Aug 2017 19:36:30 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ddgWK-0005iL-Rf; Fri, 04 Aug 2017 19:36:20 +0200
Date:   Fri, 4 Aug 2017 19:36:20 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Boris Brezillon <boris.brezillon@free-electrons.com>
Cc:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        Andrew Lunn <andrew@lunn.ch>, Rich Felker <dalias@libc.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, linux-mips@linux-mips.org,
        Sekhar Nori <nsekhar@ti.com>, Stefan Agner <stefan@agner.ch>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Alexander Clouter <alex@digriz.org.uk>,
        devel@driverdev.osuosl.org,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        linux-omap@vger.kernel.org,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org,
        Josh Wu <rainyfeeling@outlook.com>, linux-doc@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Jason Cooper <jason@lakedaemon.net>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Steven Miao <realmz6@gmail.com>,
        linux-samsung-soc@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Mikael Starvik <starvik@axis.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Han Xu <han.xu@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Simtec Linux Team <linux@simtec.co.uk>,
        linux-arm-kernel@lists.infradead.org,
        Brian Norris <computersforpeace@gmail.com>,
        Eric Miao <eric.y.miao@gmail.com>, linux-cris-kernel@axis.com,
        linux-oxnas@lists.tuxfamily.org,
        David Woodhouse <dwmw2@infradead.org>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Wenyou Yang <wenyou.yang@atmel.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Imre Kaloz <kaloz@openwrt.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        Peter Pan <peterpandong@micron.com>
Subject: Re: [PATCH] mtd: nand: Rename nand.h into rawnand.h
Message-ID: <20170804173620.xf3lyhcr2725geex@pengutronix.de>
References: <1501860550-16506-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1501860550-16506-1-git-send-email-boris.brezillon@free-electrons.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:5054:ff:fe2a:3aa
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
Return-Path: <ukl@pengutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59372
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ukl@pengutronix.de
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

Hello Boris,

you could easily split this patch per architecture/subsystem if you in a
first patch move the content of nand.h to rawnand.h and make nand.h just
#include rawnand.h. Then you can switch one user at a time and when all
are converted to use rawnand.h you can drop the #include.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
