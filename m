Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Aug 2015 10:20:33 +0200 (CEST)
Received: from regular1.263xmail.com ([211.150.99.130]:37084 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011503AbbHEIUb0usa1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Aug 2015 10:20:31 +0200
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.192])
        by regular1.263xmail.com (Postfix) with SMTP id EF3AC6A09;
        Wed,  5 Aug 2015 16:20:25 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-ADDR-CHECKED: 0
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTP id E124E1EF5D;
        Wed,  5 Aug 2015 16:20:09 +0800 (CST)
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: ulf.hansson@linaro.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <99125c57c8791ae83e1c9399f290d23d>
X-ATTACHMENT-NUM: 0
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 18578IARJSW;
        Wed, 05 Aug 2015 16:20:19 +0800 (CST)
From:   Shawn Lin <shawn.lin@rock-chips.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Seungwon Jeon <tgih.jun@samsung.com>
Cc:     dianders@chromium.org, linux-mips@linux-mips.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Stefan Agner <stefan@agner.ch>,
        Zhou Wang <wangzhou.bry@gmail.com>,
        Kumar Gala <galak@codeaurora.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Wang Long <long.wanglong@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Lukasz Majewski <l.majewski@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jun Nie <jun.nie@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Hao <haokexin@gmail.com>,
        Olof Johansson <olof@lixom.net>, Ray Jui <rjui@broadcom.com>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        linux-samsung-soc@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vineet Gupta <vgupta@synopsys.com>,
        Scott Branden <sbranden@broadcom.com>,
        Anand Moon <linux.amoon@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Tushar Behera <trblinux@gmail.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mischa Jonker <mjonker@synopsys.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Vincent Yang <vincent.yang.fujitsu@gmail.com>,
        Stephen Warren <swarren@nvidia.com>,
        devicetree@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Russell King <linux@arm.linux.org.uk>,
        Joachim Eastwood <manabian@gmail.com>,
        Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
        Weijun Yang <Weijun.Yang@csr.com>,
        Peter Griffin <peter.griffin@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        addy ke <addy.ke@rock-chips.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Jean Delvare <jdelvare@suse.de>,
        Kevin Hilman <khilman@linaro.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Andreas Faerber <afaerber@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH v3 0/5] 
Date:   Wed,  5 Aug 2015 16:16:54 +0800
Message-Id: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 1.8.0
Return-Path: <shawn.lin@rock-chips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shawn.lin@rock-chips.com
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

Synopsys DesignWare mobile storage host controller supports three
types of transfer mode: pio, internal dma and external dma. However,
dw_mmc can only supports pio and internal dma now. Thus some platforms
using dw-mshc integrated with generic dma can't work in dma mode. So we
submit this patch to achieve it.

And the config option, CONFIG_MMC_DW_IDMAC, was added by Will Newton
(commit:f95f3850) for the first version of dw_mmc and never be touched from
then. At that time dt-bindings hadn't been introduced into dw_mmc yet means
we should select CONFIG_MMC_DW_IDMAC to enable internal dma mode at compile
time. Nowadays, device-tree helps us to support a variety of boards with one
kernel. That's why we need to remove it and decide the transfer mode at runtime.

This RFC patch needs lots of ACKs. I know it's hard, but it does need someone
to make the running.

Patch does the following things:
- remove CONFIG_MMC_DW_IDMAC config option
- add bindings for idmac and edmac used by synopsys-dw-mshc
  at runtime
- add edmac support for synopsys-dw-mshc

Patch is based on next of git://git.linaro.org/people/ulf.hansson/mmc


Changes in v3:
- choose transfer mode at runtime
- remove all CONFIG_MMC_DW_IDMAC config option
- add supports-idmac property for some platforms

Changes in v2:
- Fix typo of dev_info msg
- remove unused dmach from declaration of dw_mci_dma_slave

Shawn Lin (5):
  mmc: dw_mmc: Add external dma interface support
  Documentation: synopsys-dw-mshc: add bindings for idmac and edmac
  arm: configs: remove CONFIG_MMC_DW_IDMAC
  mips: configs: remove CONFIG_MMC_DW_IDMAC
  ARM: dts: add supports-idmac property

 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  41 +++
 arch/arc/configs/axs101_defconfig                  |   1 -
 arch/arc/configs/axs103_defconfig                  |   1 -
 arch/arc/configs/axs103_smp_defconfig              |   1 -
 arch/arm/boot/dts/exynos3250-monk.dts              |   1 +
 arch/arm/boot/dts/exynos3250-rinato.dts            |   1 +
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   1 +
 arch/arm/boot/dts/exynos4412-origen.dts            |   1 +
 arch/arm/boot/dts/exynos4412-trats2.dts            |   1 +
 arch/arm/boot/dts/exynos4x12.dtsi                  |   1 +
 arch/arm/boot/dts/exynos5250-arndale.dts           |   2 +
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   2 +
 arch/arm/boot/dts/exynos5250-snow.dts              |   3 +
 arch/arm/boot/dts/exynos5250-spring.dts            |   2 +
 arch/arm/boot/dts/exynos5260-xyref5260.dts         |   2 +
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |   2 +
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   2 +
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |   3 +
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |   2 +
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |   2 +
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |   3 +
 arch/arm/boot/dts/hisi-x5hd2.dtsi                  |   2 +
 arch/arm/boot/dts/rk3288-evb.dtsi                  |   2 +
 arch/arm/boot/dts/rk3288-firefly.dtsi              |   3 +
 arch/arm/boot/dts/rk3288-popmetal.dts              |   2 +
 arch/arm/configs/exynos_defconfig                  |   1 -
 arch/arm/configs/hisi_defconfig                    |   1 -
 arch/arm/configs/lpc18xx_defconfig                 |   1 -
 arch/arm/configs/multi_v7_defconfig                |   1 -
 arch/arm/configs/zx_defconfig                      |   1 -
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts    |   2 +
 arch/mips/configs/pistachio_defconfig              |   1 -
 drivers/mmc/host/Kconfig                           |  11 +-
 drivers/mmc/host/dw_mmc-pltfm.c                    |   2 +
 drivers/mmc/host/dw_mmc.c                          | 277 +++++++++++++++++----
 include/linux/mmc/dw_mmc.h                         |  28 ++-
 36 files changed, 338 insertions(+), 72 deletions(-)

-- 
2.3.7
