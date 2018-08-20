Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Aug 2018 09:57:52 +0200 (CEST)
Received: from mail.kmu-office.ch ([IPv6:2a02:418:6a02::a2]:47154 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993941AbeHTH5tAU7FJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Aug 2018 09:57:49 +0200
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id B92DE5C098D;
        Mon, 20 Aug 2018 09:57:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1534751867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g7AmbXNkQIurVSmibexV7AXumjOYX6OjcNzG5W+/Sjk=;
        b=KtglNBk70xkhSaNPExcs7rTEgRl6uECpyfJquUBrL8ukABQLj69F3RA0ENZraA1BAALNIO
        qIR/I7kRgWpF2SADeEa7qiutB1FA7cTa6nLs/Z7SuM3Y1Tju/c1dG4f/Q4B4O72a1uAzAB
        FTnKEF9jA/KU0l1cstfky5Zg8yTFEWE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Mon, 20 Aug 2018 09:57:47 +0200
From:   Stefan Agner <stefan@agner.ch>
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
        Robert Jarzmik <robert.jarzmik@free.fr>,
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
        Mans Rullgard <mans@mansr.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH 08/23] mtd: rawnand: Pass a nand_chip object to
 ecc->read_xxx() hooks
In-Reply-To: <20180819132615.6c090d12@bbrezillon>
References: <20180817160922.6224-1-boris.brezillon@bootlin.com>
 <20180817160922.6224-9-boris.brezillon@bootlin.com>
 <c08c6ecf720cc6b242094246b2f296c3@agner.ch>
 <20180819132615.6c090d12@bbrezillon>
Message-ID: <f75fc1c2e3c70cdb6c2f9ca2dbba3f2f@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Return-Path: <stefan@agner.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stefan@agner.ch
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

On 19.08.2018 13:26, Boris Brezillon wrote:
> Hi Stefan,
> 
> On Sat, 18 Aug 2018 10:30:13 +0200
> Stefan Agner <stefan@agner.ch> wrote:
> 
>> > diff --git a/drivers/mtd/nand/raw/tegra_nand.c
>> > b/drivers/mtd/nand/raw/tegra_nand.c
>> > index 5dcee20e2a8c..bcc3a2888c4f 100644
>> > --- a/drivers/mtd/nand/raw/tegra_nand.c
>> > +++ b/drivers/mtd/nand/raw/tegra_nand.c
>> > @@ -615,10 +615,10 @@ static int tegra_nand_page_xfer(struct mtd_info
>> > *mtd, struct nand_chip *chip,
>> >  	return ret;
>> >  }
>> >
>> > -static int tegra_nand_read_page_raw(struct mtd_info *mtd,
>> > -				    struct nand_chip *chip, u8 *buf,
>> > +static int tegra_nand_read_page_raw(struct nand_chip *chip, u8 *buf,
>> >  				    int oob_required, int page)
>> >  {
>> > +	struct mtd_info *mtd = nand_to_mtd(chip);
>> >  	void *oob_buf = oob_required ? chip->oob_poi : NULL;
>> >
>> >  	return tegra_nand_page_xfer(mtd, chip, buf, oob_buf,
>>
>> Since mtd is only required to pass it to tegra_nand_page_xfer, it would
>> be better to change tegra_nand_page_xfer to only take chip.
> 
> For sure, but that's the sort of cleanups I'll leave to NAND controller
> driver maintainers (in this case you ;-)). I only take care of the NAND
> API here and try to make things as simple as possible to ease review and
> avoid breaking drivers.

Understand, but that change makes your patch simpler... Or did create
those patches automatically? In that case it makes sense to avoid manual
changes.

I can send a follow up patch no problem, but if you do a v2 and did the
chagnes manually anyway, I really think it can go into this patchset.

--
Stefan
 
