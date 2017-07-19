Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jul 2017 21:15:35 +0200 (CEST)
Received: from mail.free-electrons.com ([62.4.15.54]:53472 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994781AbdGSTPXVxb3C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jul 2017 21:15:23 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 06A7421DAB; Wed, 19 Jul 2017 21:15:16 +0200 (CEST)
Received: from windsurf (LFbn-1-10680-2.w90-89.abo.wanadoo.fr [90.89.33.2])
        by mail.free-electrons.com (Postfix) with ESMTPSA id B16DE21D9B;
        Wed, 19 Jul 2017 21:15:13 +0200 (CEST)
Date:   Wed, 19 Jul 2017 21:15:15 +0200
From:   Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Chen <Peter.Chen@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, Marc Dietrich <marvin24@gmx.de>,
        Rakesh Iyer <riyer@nvidia.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-clk@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jiri Slaby <jslaby@suse.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Ohad Ben-Cohen <ohad@wizery.com>, linux-pm@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Abriou <vincent.abriou@st.com>, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-spi@vger.kernel.org,
        linux-crypto@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
        David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
        Philippe Cornu <philippe.cornu@st.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Emilio =?UTF-8?B?TMOzcGV6?= <emilio@elopez.com.ar>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        linux-rockchip@lists.infradead.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        linux-media@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-arm-msm@vger.kernel.org,
        Joachim Eastwood <manabian@gmail.com>,
        linux-gpio@vger.kernel.org, linux-mips@linux-mips.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        linux-arm-kernel@lists.infradead.org,
        Patrice Chotard <patrice.chotard@st.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-iio@vger.kernel.org, linux-pci@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-tegra@vger.kernel.org, linux-mtd@lists.infradead.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        ath10k@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org,
        linux-pwm@vger.kernel.org, Chen Feng <puck.chen@hisilicon.com>,
        Mark Brown <broonie@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Salil Mehta <salil.mehta@huawei.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-mmc@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Brian Norris <computersforpeace@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-remoteproc@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-ide@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        devel@driverdev.osuosl.org, Yannick Fertre <yannick.fertre@st.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Richard Weinberger <richard@nod.at>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-serial@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Alan Tull <atull@kernel.org>,
        John Youn <johnyoun@synopsys.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        dmaengine@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Yao <mark.yao@rock-chips.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        netdev@vger.kernel.org,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        linux-fpga@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 000/102] Convert drivers to explicit reset API
Message-ID: <20170719211515.46a1196c@windsurf>
In-Reply-To: <20170719152646.25903-1-p.zabel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
Organization: Free Electrons
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <thomas.petazzoni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@free-electrons.com
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

Hello,

On Wed, 19 Jul 2017 17:25:04 +0200, Philipp Zabel wrote:
> The reset control API has two modes: exclusive access, where the driver
> expects to have full and immediate control over the state of the reset
> line, and shared (clock-like) access, where drivers only request reset
> deassertion while active, but don't care about the state of the reset line
> while inactive.
> 
> Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
> reset lines") started to transition the reset control request API calls
> to explicitly state whether the driver needs exclusive or shared reset
> control behavior.
> 
> This series converts all drivers that currently implicitly request
> exclusive reset controls to the corresponding explicit API call. It is,
> for the most part, generated from the following semantic patch:
> 
> @@
> expression rstc, dev, id;
> @@
> -rstc = reset_control_get(dev, id);
> +rstc = reset_control_get_exclusive(dev, id);

I don't know if it has been discussed in the past, so forgive me if it
has been. Have you considered adding a "int flags" argument to the
existing reset_control_get_*() functions, rather than introducing
separate exclusive variants ?

Indeed, with a "int flags" argument you could in the future add more
variants/behaviors without actually multiplying the number of
functions. Something like the "flags" argument for request_irq() for
example.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
