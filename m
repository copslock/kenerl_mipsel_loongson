Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Apr 2015 18:57:41 +0200 (CEST)
Received: from smtp1-g21.free.fr ([212.27.42.1]:10743 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009522AbbDRQ5jI7rdh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 18 Apr 2015 18:57:39 +0200
Received: from tock (unknown [80.171.212.207])
        (Authenticated sender: albeu)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 61BE89400A8;
        Sat, 18 Apr 2015 18:55:11 +0200 (CEST)
Date:   Sat, 18 Apr 2015 18:57:21 +0200
From:   Alban <albeu@free.fr>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Aban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/14] MIPS: ath79: Add OF support to the GPIO driver
Message-ID: <20150418185721.3e9afaba@tock>
In-Reply-To: <4071167.An8CoV6UJC@wuerfel>
References: <1429280669-2986-1-git-send-email-albeu@free.fr>
        <1429280669-2986-12-git-send-email-albeu@free.fr>
        <4071167.An8CoV6UJC@wuerfel>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46911
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

On Fri, 17 Apr 2015 16:53:31 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Friday 17 April 2015 16:24:26 Alban Bedel wrote:
> > Replace the simple GPIO chip registration by a platform driver
> > and make ath79_gpio_init() just register the device.
> > 
> > Signed-off-by: Alban Bedel <albeu@free.fr>
> > ---
> >  arch/mips/ath79/dev-common.c | 13 ++++++++
> >  arch/mips/ath79/gpio.c       | 73
> > +++++++++++++++++++++++++++++++++++++++++--- 2 files changed, 81
> > insertions(+), 5 deletions(-)
> 
> Could you move the driver to drivers/gpio/ now?

Sure, I'll add a patch to move it there.

> > +void __init ath79_gpio_init(void)
> > +{
> > +	struct resource res;
> > +
> > +	memset(&res, 0, sizeof(res));
> > +
> > +	res.flags = IORESOURCE_MEM;
> > +	res.start = AR71XX_GPIO_BASE;
> > +	res.end = res.start + AR71XX_GPIO_SIZE - 1;
> > +
> > +	platform_device_register_simple("ath79-gpio", -1, &res, 1);
> > +}
> 
> Your code looks correct, but could be shortened to 
> 
> 	struct resource mem = DEFINE_RES_MEM(AR71XX_GPIO_BASE,
> AR71XX_GPIO_SIZE);

I'll do that.

> >  
> > -void __init ath79_gpio_init(void)
> > +static const struct of_device_id ath79_gpio_of_match[] = {
> > +	{
> > +		.compatible = "qca,ar7100-gpio",
> > +		.data = (void *)AR71XX_GPIO_COUNT,
> > +	},
> > +	{
> > +		.compatible = "qca,ar7240-gpio",
> > +		.data = (void *)AR7240_GPIO_COUNT,
> > +	},
> > +	{
> > +		.compatible = "qca,ar7241-gpio",
> > +		.data = (void *)AR7241_GPIO_COUNT,
> > +	},
> > +	{
> > +		.compatible = "qca,ar9130-gpio",
> > +		.data = (void *)AR913X_GPIO_COUNT,
> > +	},
> > +	{
> > +		.compatible = "qca,ar9330-gpio",
> > +		.data = (void *)AR933X_GPIO_COUNT,
> > +	},
> > +	{
> > +		.compatible = "qca,ar9340-gpio",
> > +		.data = (void *)AR934X_GPIO_COUNT,
> > +	},
> > +	{
> > +		.compatible = "qca,qca9550-gpio",
> > +		.data = (void *)QCA955X_GPIO_COUNT,
> > +	},
> > +	{},
> > +};
> 
> How about putting the number into an 'ngpios' property like some other
> bindings do?

I'll do that, it would make things simpler.

Alban
