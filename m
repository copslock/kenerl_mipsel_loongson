Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jul 2017 22:36:25 +0200 (CEST)
Received: from gloria.sntech.de ([95.129.55.99]:47516 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993893AbdGTUgS45rR1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Jul 2017 22:36:18 +0200
Received: from [79.132.247.162] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.1:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <heiko@sntech.de>)
        id 1dYI7u-0004J6-OR; Thu, 20 Jul 2017 22:32:51 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Emilio =?ISO-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>, Adrian Hunter <adrian.hunter@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Alan Tull <atull@kernel.org>, Alexandre Torgue <alexandre.torgue@st.com>, Andrew Lunn <andrew@lunn.ch>, Ben Skeggs <bskeggs@redhat.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Bin Liu <b-liu@ti.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Brian Norris <computersforpeace@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Chen Feng <puck.chen@hisilicon.com>, Chen-Yu Tsai <wens@csie.org>, Corentin Labbe <clabbe.montjoie@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Dan Williams <dan.j.williams@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Airlie <airlied@linux.ie>, David Woodhouse <dwmw2@infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Felipe Balbi <balbi@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Hartmut Knaack <knaack.h@gmx.de>, Herbert Xu <herbert@gondor.apana.org.au>, Jaehoon Chung <jh80.chung@samsung.com>, Jiri Slaby <jslaby@suse.com>, Joachim Eastwood <manabian@gmail.com>, John Youn <johnyoun@synopsys.com>, Jon Hunter <jonathanh@nvidia.com>, Jonathan Cameron <jic23@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Kalle Valo <kvalo@qca.qualcomm.com>, Kishon Vijay Abraham I <kishon@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>, Laxman Dewangan <ldewangan@nvidia.com>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Marc Dietrich <marvin24@gmx.de>, Marek Vasut <marek.vasut@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Yao <mark.yao@rock-chips.com>, Mathias Nyman <mathias.nyman@intel.com>, Matthias Brugger <matthias.bgg@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Michael Turquette <mturquette@baylibre.com>, Moritz Fischer <moritz.fischer@ettus.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Ohad Ben-Cohen <ohad@wizery.com>, Patrice Chotard <patrice.chotard@st.com>, Peter Chen <Peter.Chen@nxp.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Philippe Cornu <philippe.cornu@st.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Rakesh Iyer <riyer@nvidia.com>, Ralf Baechle <ralf@linux-mips.org>, Richard Weinberger <richard@nod.at>, Richard Zhu <hongxing.zhu@nxp.com>, Rongrong Zou <zourongrong@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, Salil Mehta <salil.mehta@huawei.com>, Shawn Lin <shawn.lin@rock-chips.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Stanimir Varbanov <svarbanov@mm-sol.com>, Stephen Boyd <sboyd@codeaurora.org>, Tejun Heo <tj@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Vincent Abriou <vincent.abriou@st.com>, Vinod Koul <vinod.koul@intel.com>, Vivien Didelot <vivien.didelot@savoirfairelinux.com>, Wim Van Sebroeck <wim@iguana.be>, Wolfram Sang <wsa@the-dreams.de>, Xinliang Liu <z.liuxinliang@hisilicon.com>, Xinwei Kong <kong.kongxinwei@hisilicon.com>, Yannick Fertre <yannick.fertre@st.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, Zhang Rui <rui.zhang@intel.com>, alsa-devel@alsa-project.org, ath10k@lists.infradead.org, devel@driverdev.osuosl.org, dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, linSubject: Re: [PATCH 000/102] Convert drivers to explicit reset API
Date:   Thu, 20 Jul 2017 22:32:49 +0200
Message-ID: <1687646.TMvigZNUOP@phil>
User-Agent: KMail/5.2.3 (Linux/4.9.0-2-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <20170719152646.25903-1-p.zabel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Return-Path: <heiko@sntech.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59172
Subject: (no subject)
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: heiko@sntech.de
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

Hi,

>   crypto: rockchip: explicitly request exclusive reset control
>   iio: adc: rockchip_saradc: explicitly request exclusive reset control
>   PCI: rockchip: explicitly request exclusive reset control
>   phy: rockchip-pcie: explicitly request exclusive reset control
>   phy: rockchip-typec: explicitly request exclusive reset control
>   phy: rockchip-usb: explicitly request exclusive reset control
>   thermal: rockchip: explicitly request exclusive reset control

for the driver-related Rockchip changes

Acked-by: Heiko Stuebner <heiko@sntech.de>
