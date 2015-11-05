Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Nov 2015 12:21:38 +0100 (CET)
Received: from conuserg012.nifty.com ([202.248.44.38]:56637 "EHLO
        conuserg012-v.nifty.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009483AbbKELVhHPdo7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Nov 2015 12:21:37 +0100
Received: from beagle.diag.org (KD036012008038.au-net.ne.jp [36.12.8.38]) (authenticated)
        by conuserg012-v.nifty.com with ESMTP id tA5BEw4v006852;
        Thu, 5 Nov 2015 20:15:12 +0900
X-Nifty-SrcIP: [36.12.8.38]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mips@linux-mips.org,
        Patrice Chotard <patrice.chotard@st.com>,
        Sascha Hauer <kernel@pengutronix.de>, kernel@stlinux.com,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@linaro.org>,
        Vishnu Patekar <vishnupatekar0510@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Barry Song <baohua@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        =?UTF-8?q?Terje=20Bergstr=C3=B6m?= <tbergstrom@nvidia.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Tuomas Tynkkynen <ttynkkynen@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Yao <mark.yao@rock-chips.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Jens Kuske <jenskuske@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org,
        Maxime Coquelin <maxime.coquelin@st.com>,
        Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        linux-spi@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [RFC PATCH 0/7] reset: make RESET_CONTROLLER a select'ed option
Date:   Thu,  5 Nov 2015 20:15:21 +0900
Message-Id: <1446722128-11961-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yamada.masahiro@socionext.com
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

When I was implementing a new reset controller for my SoCs,
I struggled to make my sub-menu shown under the reset
controller menu.
I noticed the Kconfig in reset sub-system are screwed up due to two
config options (ARCH_HAS_RESET_CONTROLLER and RESET_CONTROLLER).

I think only the former should be select'ed by relevant SoCs,
but in fact the latter is also select'ed here and there.
Mixing "select" to a user-configurable option is a mess.

Finally, I started to wonder whether it could be more simpler?

The first patch drops ARCH_HAS_RESET_CONTROLLER.
RESET_CONTROLLER should be directly selected by SoCs.

The rest of this series are minor clean ups in other
sub-systems.
I can postpone them if changes over cross sub-systems
are not preferred.



Masahiro Yamada (7):
  reset: drop ARCH_HAS_RESET_CONTROLLER
  spi: sunxi: remove redundant "depends on RESET_CONTROLLER"
  spi: tegra: remove redundant "depends on RESET_CONTROLLER"
  pinctrl: sunxi: remove redundant "depends on RESET_CONTROLLER"
  drm/sti: replace "select RESET_CONTROLLER" with "depends on ..."
  drm/rockchip: remove redundant "depends on RESET_CONTROLLER"
  drm/tegra: tegra: remove redundant "depends on RESET_CONTROLLER"

 arch/arm/Kconfig                 |  3 +--
 arch/arm/mach-berlin/Kconfig     |  2 +-
 arch/arm/mach-imx/Kconfig        |  2 +-
 arch/arm/mach-mmp/Kconfig        |  4 ++--
 arch/arm/mach-prima2/Kconfig     |  2 +-
 arch/arm/mach-rockchip/Kconfig   |  2 +-
 arch/arm/mach-sti/Kconfig        |  1 -
 arch/arm/mach-sunxi/Kconfig      |  1 -
 arch/arm/mach-tegra/Kconfig      |  1 -
 arch/arm64/Kconfig.platforms     |  3 +--
 arch/mips/Kconfig                |  4 +---
 drivers/gpu/drm/rockchip/Kconfig |  1 -
 drivers/gpu/drm/sti/Kconfig      |  4 ++--
 drivers/gpu/drm/tegra/Kconfig    |  1 -
 drivers/pinctrl/sunxi/Kconfig    |  2 --
 drivers/reset/Kconfig            | 12 +++++++-----
 drivers/reset/sti/Kconfig        |  1 -
 drivers/spi/Kconfig              |  6 ++----
 18 files changed, 20 insertions(+), 32 deletions(-)

-- 
1.9.1
