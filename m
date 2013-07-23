Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jul 2013 20:03:25 +0200 (CEST)
Received: from sauhun.de ([89.238.76.85]:44858 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825727Ab3GWSDXIHjaI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Jul 2013 20:03:23 +0200
Received: from p5b387ff2.dip0.t-ipconnect.de ([91.56.127.242]:51467 helo=localhost)
        by pokefinder.org with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.69)
        (envelope-from <wsa@the-dreams.de>)
        id 1V1gud-0001Q5-C2; Tue, 23 Jul 2013 20:02:17 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-kernel@vger.kernel.org
Cc:     Wolfram Sang <wsa@the-dreams.de>, alsa-devel@alsa-project.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dan Williams <djbw@fb.com>,
        David Woodhouse <dwmw2@infradead.org>,
        devel@driverdev.osuosl.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Eduardo Valentin <eduardo.valentin@ti.com>,
        Eric Miao <eric.y.miao@gmail.com>, Felipe Balbi <balbi@ti.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Grant Likely <grant.likely@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        "James E.J. Bottomley" <JBottomley@parallels.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-input@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Mauro Carvalho Chehab <m.chehab@samsung.com>,
        netdev@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@arm.linux.org.uk>,
        Santosh Y <santoshsy@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Takashi Iwai <tiwai@suse.de>,
        =?UTF-8?q?Terje=20Bergstr=C3=B6m?= <tbergstrom@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 00/27] devm cleanup, part #1, take #3
Date:   Tue, 23 Jul 2013 20:01:33 +0200
Message-Id: <1374602524-3398-1-git-send-email-wsa@the-dreams.de>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsa@the-dreams.de
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

Here is another bit of cleaning up the devm usage. It is again removing the
resource check with devm_ioremap_resource, because a) new drivers came in and
b) coccinelle had a bug and missed to find a couple of occasions. Unlike last
time, I think it is better if these patches go in via the subsystem trees to
reduce merge conflicts. And there is one driver which I fixed manually because
the original code needed some bigger update. All is based on v3.11-rc2 and the
branch can be found at:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git devm_no_resource_check

Other things which happened: I wanted to get rid of devm_request_and_ioremap,
luckily other people are already working on it. Hooray! I already sent a patch
series picking another low hanging fruit, i.e. drivers can skip devm_pinctrl
handling if they are using only the default pin setup. And not devm related,
there is still my proposal to rename INIT_COMPLETION to reinit_completion, that
probably needs some more persistence... Yay, so much to clean up \o/

Regards,

   Wolfram


Wolfram Sang (27):
  arch/mips/lantiq/xway: don't check resource with
    devm_ioremap_resource
  drivers/amba: don't check resource with devm_ioremap_resource
  drivers/cpuidle: don't check resource with devm_ioremap_resource
  drivers/dma: don't check resource with devm_ioremap_resource
  drivers/gpu/host1x/drm: don't check resource with
    devm_ioremap_resource
  drivers/i2c/busses: don't check resource with devm_ioremap_resource
  drivers/input/serio: don't check resource with devm_ioremap_resource
  drivers/iommu: don't check resource with devm_ioremap_resource
  drivers/media/platform: don't check resource with
    devm_ioremap_resource
  drivers/memory: don't check resource with devm_ioremap_resource
  drivers/mtd/nand: don't check resource with devm_ioremap_resource
  drivers/net/ethernet/stmicro/stmmac: don't check resource with
    devm_ioremap_resource
  drivers/pci/host: don't check resource with devm_ioremap_resource
  drivers/pinctrl: don't check resource with devm_ioremap_resource
  drivers/pwm: don't check resource with devm_ioremap_resource
  drivers/scsi/ufs: don't check resource with devm_ioremap_resource
  drivers/spi: don't check resource with devm_ioremap_resource
  drivers/staging/imx-drm: don't check resource with
    devm_ioremap_resource
  drivers/usb/phy: don't check resource with devm_ioremap_resource
  drivers/watchdog: don't check resource with devm_ioremap_resource
  sound/soc/au1x: don't check resource with devm_ioremap_resource
  sound/soc/cirrus: don't check resource with devm_ioremap_resource
  sound/soc/nuc900: don't check resource with devm_ioremap_resource
  sound/soc/pxa: don't check resource with devm_ioremap_resource
  sound/soc/tegra: don't check resource with devm_ioremap_resource
  sound/soc/txx9: don't check resource with devm_ioremap_resource
  thermal: ti-bandgap: cleanup resource allocation

 arch/mips/lantiq/xway/dma.c                        |    4 ----
 drivers/amba/tegra-ahb.c                           |    2 --
 drivers/cpuidle/cpuidle-kirkwood.c                 |    3 ---
 drivers/dma/mmp_pdma.c                             |    3 ---
 drivers/dma/mmp_tdma.c                             |    3 ---
 drivers/gpu/host1x/drm/hdmi.c                      |    3 ---
 drivers/i2c/busses/i2c-stu300.c                    |    3 ---
 drivers/input/serio/olpc_apsp.c                    |    3 ---
 drivers/iommu/tegra-smmu.c                         |    2 --
 drivers/media/platform/coda.c                      |    5 -----
 drivers/memory/tegra20-mc.c                        |    2 --
 drivers/memory/tegra30-mc.c                        |    2 --
 drivers/mtd/nand/mxc_nand.c                        |    5 -----
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |    3 ---
 drivers/pci/host/pcie-designware.c                 |   12 ------------
 drivers/pinctrl/pinctrl-imx.c                      |    3 ---
 drivers/pinctrl/pinctrl-rockchip.c                 |    5 -----
 drivers/pinctrl/pinctrl-u300.c                     |    3 ---
 drivers/pwm/pwm-lpc32xx.c                          |    3 ---
 drivers/pwm/pwm-renesas-tpu.c                      |    5 -----
 drivers/scsi/ufs/ufshcd-pltfrm.c                   |    6 ------
 drivers/spi/spi-bcm2835.c                          |    6 ------
 drivers/staging/imx-drm/imx-tve.c                  |    5 -----
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        |   20 ++++----------------
 drivers/usb/phy/phy-rcar-usb.c                     |    5 -----
 drivers/watchdog/nuc900_wdt.c                      |    5 -----
 drivers/watchdog/ts72xx_wdt.c                      |   10 ----------
 sound/soc/au1x/psc-ac97.c                          |    3 ---
 sound/soc/cirrus/ep93xx-ac97.c                     |    3 ---
 sound/soc/cirrus/ep93xx-i2s.c                      |    3 ---
 sound/soc/nuc900/nuc900-ac97.c                     |    3 ---
 sound/soc/pxa/mmp-sspa.c                           |    3 ---
 sound/soc/tegra/tegra20_ac97.c                     |    7 -------
 sound/soc/txx9/txx9aclc-ac97.c                     |    3 ---
 34 files changed, 4 insertions(+), 152 deletions(-)

-- 
1.7.10.4
