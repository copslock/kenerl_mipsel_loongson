Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Sep 2018 11:13:44 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:50335 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994644AbeIGJNl3z-lO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Sep 2018 11:13:41 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4B7F1208AE; Fri,  7 Sep 2018 11:13:36 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8C0CB207B4;
        Fri,  7 Sep 2018 11:13:25 +0200 (CEST)
Date:   Fri, 7 Sep 2018 11:13:24 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Ladislav Michl <ladis@linux-mips.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Ryan Mallon <rmallon@gmail.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        Alexander Clouter <alex@digriz.org.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH 19/19] mtd: rawnand: Move JEDEC code to nand_jedec.c
Message-ID: <20180907111324.691ba379@bbrezillon>
In-Reply-To: <20180907084044.GA6361@lenoch>
References: <20180906223851.6964-1-boris.brezillon@bootlin.com>
        <20180906223851.6964-20-boris.brezillon@bootlin.com>
        <20180907084044.GA6361@lenoch>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <boris.brezillon@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boris.brezillon@bootlin.com
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

On Fri, 7 Sep 2018 10:40:44 +0200
Ladislav Michl <ladis@linux-mips.org> wrote:

> Hi Boris,
> 
> this patchseries is really amazing clean up. Thank you!

I'm glad I'm not the only one to find it useful :-).

> 
> On Fri, Sep 07, 2018 at 12:38:51AM +0200, Boris Brezillon wrote:
> > This moves ONFI related code to nand_onfi.c and ONFI related
> > struct/macros to include/linux/mtd/onfi.h.  
> 
> Seems above commit log comes from previous patch.

Oops, will fix that.

Thanks,

Boris
