Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Oct 2015 22:42:45 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:43139 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006157AbbJKUmoS1YEA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Oct 2015 22:42:44 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZlNQx-0005DV-Aw; Sun, 11 Oct 2015 22:41:31 +0200
Date:   Sun, 11 Oct 2015 22:40:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mans Rullgard <mans@mansr.com>
cc:     Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@deeprootsystems.com>,
        Russell King <linux@arm.linux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Ryan Mallon <rmallon@gmail.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
        Maxime Coquelin <maxime.coquelin@st.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>,
        =?ISO-8859-15?Q?S=F6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Carlo Caione <carlo@caione.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Barry Song <baohua@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-cris-kernel@axis.com,
        linux-mips@linux-mips.org, linux-xtensa@linux-xtensa.org,
        kernel@stlinux.com, linux-rpi-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] sched_clock: add data pointer argument to read
 callback
In-Reply-To: <1444427858-576-1-git-send-email-mans@mansr.com>
Message-ID: <alpine.DEB.2.11.1510112238380.6097@nanos>
References: <1444427858-576-1-git-send-email-mans@mansr.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

Mans,

On Fri, 9 Oct 2015, Mans Rullgard wrote:

> This passes a data pointer specified in the sched_clock_register()
> call to the read callback allowing simpler implementations thereof.
>
> In this patch, existing uses of this interface are simply updated
> with a null pointer.

I can't see any simplifaction of any driver. This is called in hot
pathes and that extra unused argument just adds register pressure for
no value.

What are you actually trying to solve?

Thanks,

	tglx
