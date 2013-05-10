Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 May 2013 10:18:12 +0200 (CEST)
Received: from sauhun.de ([89.238.76.85]:45527 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823907Ab3EJIRuwvg30 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 May 2013 10:17:50 +0200
Received: from p5b38793b.dip0.t-ipconnect.de ([91.56.121.59]:46406 helo=localhost)
        by pokefinder.org with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.69)
        (envelope-from <wsa@the-dreams.de>)
        id 1UaiUq-0001AO-KL; Fri, 10 May 2013 10:16:10 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-kernel@vger.kernel.org
Cc:     Wolfram Sang <wsa@the-dreams.de>, ac100@lists.launchpad.net,
        Alan Stern <stern@rowland.harvard.edu>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
        Barry Song <baohua.song@csr.com>,
        Ben Dooks <ben-linux@fluff.org>, cpufreq@vger.kernel.org,
        Dan Williams <djbw@fb.com>, David Airlie <airlied@linux.ie>,
        David Woodhouse <dwmw2@infradead.org>,
        davinci-linux-open-source@linux.davincidsp.com,
        Deepak Saxena <dsaxena@plexity.net>,
        devel@driverdev.osuosl.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Felipe Balbi <balbi@ti.com>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Grant Likely <grant.likely@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Inki Dae <inki.dae@samsung.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Julian Andres Klode <jak@jak-linux.org>,
        Kevin Hilman <khilman@deeprootsystems.com>,
        Kukjin Kim <kgene.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-input@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Marc Dietrich <marvin24@gmx.de>,
        Mark Brown <broonie@kernel.org>,
        Matt Mackall <mpm@selenic.com>, netdev@vger.kernel.org,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Paul Zimmerman <paulz@synopsys.com>,
        "Rafael J. Wysocki" <rjw@sisk.pl>,
        Ralf Baechle <ralf@linux-mips.org>, rtc-linux@googlegroups.com,
        Russell King <linux@arm.linux.org.uk>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        spear-devel@list.st.com, spi-devel-general@lists.sourceforge.net,
        Stephen Warren <swarren@wwwdotorg.org>,
        Takashi Iwai <tiwai@suse.de>, Tejun Heo <tj@kernel.org>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Vinod Koul <vinod.koul@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <viresh.linux@gmail.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [RFC 00/42] devm improvement series, part #1
Date:   Fri, 10 May 2013 10:16:45 +0200
Message-Id: <1368173847-5661-1-git-send-email-wsa@the-dreams.de>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36375
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

Lately, I have been experimenting how to improve the devm interface to make
writing device drivers easier and less error prone while also getting rid of
its subtle issues. I think it has more potential but still needs work and
definately conistency, especiall in its usage.

The first thing I come up with is a low hanging fruit regarding
devm_ioremap_resouce(). This function already checks if the passed resource is
valid and gives an error message if not. So, we can remove similar checks from
the drivers and get rid of a bit of code and a number of inconsistent error
strings.

If generally accepted, I'd suggest I rerun my scripts again when rc1 is out and
ask Linus to pull this branch [1] directly? This series is merely to show what
I am up to.

Thanks,

   Wolfram

[1] git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git devm_no_resource_check

Wolfram Sang (42):
  drivers/ata: don't check resource with devm_ioremap_resource
  drivers/char/hw_random: don't check resource with
    devm_ioremap_resource
  drivers/cpufreq: don't check resource with devm_ioremap_resource
  drivers/dma: don't check resource with devm_ioremap_resource
  drivers/gpio: don't check resource with devm_ioremap_resource
  drivers/gpu/drm/exynos: don't check resource with
    devm_ioremap_resource
  drivers/gpu/host1x: don't check resource with devm_ioremap_resource
  drivers/gpu/host1x/drm: don't check resource with
    devm_ioremap_resource
  drivers/i2c/busses: don't check resource with devm_ioremap_resource
  drivers/input/keyboard: don't check resource with
    devm_ioremap_resource
  drivers/input/serio: don't check resource with devm_ioremap_resource
  drivers/memory: don't check resource with devm_ioremap_resource
  drivers/mfd: don't check resource with devm_ioremap_resource
  drivers/misc: don't check resource with devm_ioremap_resource
  drivers/mtd/maps: don't check resource with devm_ioremap_resource
  drivers/mtd/nand: don't check resource with devm_ioremap_resource
  drivers/net/ethernet/renesas: don't check resource with
    devm_ioremap_resource
  drivers/pinctrl: don't check resource with devm_ioremap_resource
  drivers/pinctrl/spear: don't check resource with
    devm_ioremap_resource
  drivers/pwm: don't check resource with devm_ioremap_resource
  drivers/remoteproc: don't check resource with devm_ioremap_resource
  drivers/rtc: don't check resource with devm_ioremap_resource
  drivers/spi: don't check resource with devm_ioremap_resource
  drivers/staging/dwc2: don't check resource with devm_ioremap_resource
  drivers/staging/nvec: don't check resource with devm_ioremap_resource
  drivers/thermal: don't check resource with devm_ioremap_resource
  drivers/tty/serial: don't check resource with devm_ioremap_resource
  drivers/usb/chipidea: don't check resource with devm_ioremap_resource
  drivers/usb/gadget: don't check resource with devm_ioremap_resource
  drivers/usb/host: don't check resource with devm_ioremap_resource
  drivers/usb/phy: don't check resource with devm_ioremap_resource
  drivers/video: don't check resource with devm_ioremap_resource
  drivers/video/omap2: don't check resource with devm_ioremap_resource
  drivers/video/omap2/dss: don't check resource with
    devm_ioremap_resource
  drivers/w1/masters: don't check resource with devm_ioremap_resource
  drivers/watchdog: don't check resource with devm_ioremap_resource
  arch/arm/mach-tegra: don't check resource with devm_ioremap_resource
  arch/arm/plat-omap: don't check resource with devm_ioremap_resource
  arch/arm/plat-samsung: don't check resource with
    devm_ioremap_resource
  arch/mips/lantiq/xway: don't check resource with
    devm_ioremap_resource
  sound/soc/fsl: don't check resource with devm_ioremap_resource
  sound/soc/kirkwood: don't check resource with devm_ioremap_resource

 arch/arm/mach-tegra/tegra2_emc.c            |    5 -----
 arch/arm/plat-omap/dmtimer.c                |    7 +------
 arch/arm/plat-samsung/adc.c                 |    5 -----
 arch/mips/lantiq/xway/gptu.c                |    7 +------
 drivers/ata/pata_ep93xx.c                   |    5 -----
 drivers/char/hw_random/mxc-rnga.c           |    6 ------
 drivers/char/hw_random/omap-rng.c           |    5 -----
 drivers/cpufreq/kirkwood-cpufreq.c          |    4 ----
 drivers/dma/tegra20-apb-dma.c               |    5 -----
 drivers/gpio/gpio-mvebu.c                   |   12 +-----------
 drivers/gpio/gpio-spear-spics.c             |    7 +------
 drivers/gpio/gpio-tegra.c                   |    5 -----
 drivers/gpu/drm/exynos/exynos_hdmi.c        |    5 -----
 drivers/gpu/host1x/dev.c                    |    7 +------
 drivers/gpu/host1x/drm/dc.c                 |    5 -----
 drivers/i2c/busses/i2c-davinci.c            |    6 +-----
 drivers/i2c/busses/i2c-designware-platdrv.c |    6 +-----
 drivers/i2c/busses/i2c-imx.c                |    6 +-----
 drivers/i2c/busses/i2c-omap.c               |    6 +-----
 drivers/i2c/busses/i2c-rcar.c               |    7 +------
 drivers/i2c/busses/i2c-s3c2410.c            |    5 -----
 drivers/i2c/busses/i2c-sirf.c               |    6 ------
 drivers/i2c/busses/i2c-tegra.c              |    5 -----
 drivers/input/keyboard/imx_keypad.c         |    7 +------
 drivers/input/keyboard/spear-keyboard.c     |    7 +------
 drivers/input/keyboard/tegra-kbc.c          |    7 +------
 drivers/input/serio/arc_ps2.c               |    7 +------
 drivers/memory/emif.c                       |    6 ------
 drivers/mfd/intel_msic.c                    |    6 +-----
 drivers/misc/atmel-ssc.c                    |    5 -----
 drivers/mtd/maps/autcpu12-nvram.c           |    7 +------
 drivers/mtd/maps/lantiq-flash.c             |    8 +-------
 drivers/mtd/nand/lpc32xx_mlc.c              |    5 -----
 drivers/mtd/nand/lpc32xx_slc.c              |    7 +------
 drivers/net/ethernet/renesas/sh_eth.c       |   14 +-------------
 drivers/pinctrl/pinctrl-at91.c              |    7 +------
 drivers/pinctrl/pinctrl-coh901.c            |    5 -----
 drivers/pinctrl/pinctrl-exynos5440.c        |    5 -----
 drivers/pinctrl/pinctrl-samsung.c           |    5 -----
 drivers/pinctrl/pinctrl-xway.c              |    4 ----
 drivers/pinctrl/spear/pinctrl-plgpio.c      |    7 +------
 drivers/pwm/pwm-imx.c                       |    5 -----
 drivers/pwm/pwm-puv3.c                      |    5 -----
 drivers/pwm/pwm-pxa.c                       |    5 -----
 drivers/pwm/pwm-spear.c                     |    7 +------
 drivers/pwm/pwm-tegra.c                     |    5 -----
 drivers/pwm/pwm-tiecap.c                    |    5 -----
 drivers/pwm/pwm-tiehrpwm.c                  |    5 -----
 drivers/pwm/pwm-tipwmss.c                   |    5 -----
 drivers/pwm/pwm-vt8500.c                    |    5 -----
 drivers/remoteproc/da8xx_remoteproc.c       |   14 +-------------
 drivers/rtc/rtc-nuc900.c                    |    6 +-----
 drivers/rtc/rtc-omap.c                      |    5 -----
 drivers/rtc/rtc-s3c.c                       |    5 -----
 drivers/rtc/rtc-spear.c                     |    7 +------
 drivers/rtc/rtc-tegra.c                     |    6 ------
 drivers/spi/spi-bcm63xx.c                   |    8 +-------
 drivers/spi/spi-ep93xx.c                    |    8 +-------
 drivers/spi/spi-omap2-mcspi.c               |    7 +------
 drivers/spi/spi-s3c64xx.c                   |    7 +------
 drivers/spi/spi-sirf.c                      |    7 +------
 drivers/spi/spi-tegra114.c                  |    7 +------
 drivers/spi/spi-tegra20-sflash.c            |    5 -----
 drivers/spi/spi-tegra20-slink.c             |    7 +------
 drivers/staging/dwc2/platform.c             |    5 -----
 drivers/staging/nvec/nvec.c                 |    5 -----
 drivers/thermal/dove_thermal.c              |   11 +----------
 drivers/thermal/exynos_thermal.c            |    5 -----
 drivers/thermal/kirkwood_thermal.c          |    7 +------
 drivers/thermal/rcar_thermal.c              |    6 +-----
 drivers/tty/serial/serial-tegra.c           |    6 +-----
 drivers/usb/chipidea/core.c                 |    5 -----
 drivers/usb/gadget/bcm63xx_udc.c            |   10 ----------
 drivers/usb/host/ehci-atmel.c               |    9 +--------
 drivers/usb/host/ehci-mxc.c                 |    8 +-------
 drivers/usb/host/ehci-platform.c            |    6 +-----
 drivers/usb/host/ehci-sh.c                  |   10 +---------
 drivers/usb/host/ohci-nxp.c                 |    6 ------
 drivers/usb/host/ohci-platform.c            |    7 +------
 drivers/usb/phy/phy-mv-u3d-usb.c            |    5 -----
 drivers/usb/phy/phy-mxs-usb.c               |    5 -----
 drivers/usb/phy/phy-samsung-usb2.c          |    5 -----
 drivers/usb/phy/phy-samsung-usb3.c          |    5 -----
 drivers/video/mxsfb.c                       |    7 +------
 drivers/video/omap2/dss/hdmi.c              |    7 +------
 drivers/video/omap2/vrfb.c                  |    5 -----
 drivers/w1/masters/omap_hdq.c               |    5 -----
 drivers/watchdog/imx2_wdt.c                 |    5 -----
 sound/soc/fsl/imx-ssi.c                     |    6 ------
 sound/soc/kirkwood/kirkwood-i2s.c           |    5 -----
 90 files changed, 43 insertions(+), 525 deletions(-)

-- 
1.7.10.4
