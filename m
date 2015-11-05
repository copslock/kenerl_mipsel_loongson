Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Nov 2015 12:16:41 +0100 (CET)
Received: from conuserg012.nifty.com ([202.248.44.38]:41597 "EHLO
        conuserg012-v.nifty.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009483AbbKELQjBosj7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Nov 2015 12:16:39 +0100
Received: from beagle.diag.org (KD036012008038.au-net.ne.jp [36.12.8.38]) (authenticated)
        by conuserg012-v.nifty.com with ESMTP id tA5BEw4w006852;
        Thu, 5 Nov 2015 20:15:19 +0900
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
        Michael Turquette <mturquette@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Barry Song <baohua@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Tuomas Tynkkynen <ttynkkynen@nvidia.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Jens Kuske <jenskuske@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        linux-tegra@vger.kernel.org,
        Maxime Coquelin <maxime.coquelin@st.com>,
        Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [RFC PATCH 1/7] reset: drop ARCH_HAS_RESET_CONTROLLER
Date:   Thu,  5 Nov 2015 20:15:22 +0900
Message-Id: <1446722128-11961-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1446722128-11961-1-git-send-email-yamada.masahiro@socionext.com>
References: <1446722128-11961-1-git-send-email-yamada.masahiro@socionext.com>
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49848
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

The reset sub-system is supposed to be enabled by two steps:

  - ARCH_HAS_RESET_CONTROLLER is select'ed by such sub-architectures
    that support reset controllers

  - Based on that, RESET_CONTROLLER is configured by "make menuconfig"
    or friends.  (Note that it is a user-configurable option as it has
    a prompt.)

But, this is getting messy in spite of the intention.  Some SoC families
(such as Tegra, sunxi, etc.) select both ARCH_HAS_RESET_CONTROLLER and
RESET_CONTROLLER.  So, it is no longer configurable (i.e. forcibly
select'ed) in the multi-platforms.

Also, many drivers that use reset APIs are accompanied by
"depends on RESET_CONTROLLER".

Like pinctrl, clk sub-systems, reset is a fundamental feature needed
for SoCs to work correctly.

If a particular SoC supports a reset controller driver, it is very
likely to be necessary for that SoC.

So, this commit drops ARCH_HAS_RESET_CONTROLLER, making RESET_CONTROLLER
a user-unconfigurable option.  Going forward, it should be directly
select'ed by relevant SoCs.

This change would also be useful to clean-up "depends on RESET_CONTROLLER"
in other drivers.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/Kconfig               |  3 +--
 arch/arm/mach-berlin/Kconfig   |  2 +-
 arch/arm/mach-imx/Kconfig      |  2 +-
 arch/arm/mach-mmp/Kconfig      |  4 ++--
 arch/arm/mach-prima2/Kconfig   |  2 +-
 arch/arm/mach-rockchip/Kconfig |  2 +-
 arch/arm/mach-sti/Kconfig      |  1 -
 arch/arm/mach-sunxi/Kconfig    |  1 -
 arch/arm/mach-tegra/Kconfig    |  1 -
 arch/arm64/Kconfig.platforms   |  3 +--
 arch/mips/Kconfig              |  4 +---
 drivers/reset/Kconfig          | 12 +++++++-----
 drivers/reset/sti/Kconfig      |  1 -
 13 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f1ed110..55af5e8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -972,7 +972,7 @@ config ARCH_EFM32
 config ARCH_LPC18XX
 	bool "NXP LPC18xx/LPC43xx"
 	depends on ARM_SINGLE_ARMV7M
-	select ARCH_HAS_RESET_CONTROLLER
+	select RESET_CONTROLLER
 	select ARM_AMBA
 	select CLKSRC_LPC32XX
 	select PINCTRL
@@ -983,7 +983,6 @@ config ARCH_LPC18XX
 config ARCH_STM32
 	bool "STMicrolectronics STM32"
 	depends on ARM_SINGLE_ARMV7M
-	select ARCH_HAS_RESET_CONTROLLER
 	select ARMV7M_SYSTICK
 	select CLKSRC_STM32
 	select RESET_CONTROLLER
diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
index 742d53a..1c8e301 100644
--- a/arch/arm/mach-berlin/Kconfig
+++ b/arch/arm/mach-berlin/Kconfig
@@ -1,6 +1,6 @@
 menuconfig ARCH_BERLIN
 	bool "Marvell Berlin SoCs" if ARCH_MULTI_V7
-	select ARCH_HAS_RESET_CONTROLLER
+	select RESET_CONTROLLER
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_GIC
 	select DW_APB_ICTL
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 8ceda28..7773cd7 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -58,7 +58,7 @@ config HAVE_IMX_MMDC
 
 config HAVE_IMX_SRC
 	def_bool y if SMP
-	select ARCH_HAS_RESET_CONTROLLER
+	select RESET_CONTROLLER
 
 config IMX_HAVE_IOMUX_V1
 	bool
diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index fdbfadf..46fdb69 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -90,7 +90,7 @@ config MACH_MMP_DT
 	select PINCTRL
 	select PINCTRL_SINGLE
 	select COMMON_CLK
-	select ARCH_HAS_RESET_CONTROLLER
+	select RESET_CONTROLLER
 	select CPU_MOHAWK
 	help
 	  Include support for Marvell MMP2 based platforms using
@@ -104,7 +104,7 @@ config MACH_MMP2_DT
 	select PINCTRL
 	select PINCTRL_SINGLE
 	select COMMON_CLK
-	select ARCH_HAS_RESET_CONTROLLER
+	select RESET_CONTROLLER
 	select CPU_PJ4
 	help
 	  Include support for Marvell MMP2 based platforms using
diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
index 9ab8932..5d03202 100644
--- a/arch/arm/mach-prima2/Kconfig
+++ b/arch/arm/mach-prima2/Kconfig
@@ -1,6 +1,6 @@
 menuconfig ARCH_SIRF
 	bool "CSR SiRF" if ARCH_MULTI_V7
-	select ARCH_HAS_RESET_CONTROLLER
+	select RESET_CONTROLLER
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_IRQ_CHIP
 	select NO_IOPORT_MAP
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index ae4eb7c..6990c3a 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -2,7 +2,7 @@ config ARCH_ROCKCHIP
 	bool "Rockchip RK2928 and RK3xxx SOCs" if ARCH_MULTI_V7
 	select PINCTRL
 	select PINCTRL_ROCKCHIP
-	select ARCH_HAS_RESET_CONTROLLER
+	select RESET_CONTROLLER
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
 	select ARM_GIC
diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index 125865d..d0606e2 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -6,7 +6,6 @@ menuconfig ARCH_STI
 	select PINCTRL
 	select PINCTRL_ST
 	select MFD_SYSCON
-	select ARCH_HAS_RESET_CONTROLLER
 	select HAVE_ARM_SCU if SMP
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_ERRATA_754322
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 4efe2d4..60b58ca 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1,7 +1,6 @@
 menuconfig ARCH_SUNXI
 	bool "Allwinner SoCs" if ARCH_MULTI_V7
 	select ARCH_REQUIRE_GPIOLIB
-	select ARCH_HAS_RESET_CONTROLLER
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
 	select PINCTRL
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 0fa4c5f..269efaa 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -9,7 +9,6 @@ menuconfig ARCH_TEGRA
 	select HAVE_ARM_TWD if SMP
 	select PINCTRL
 	select PM_OPP
-	select ARCH_HAS_RESET_CONTROLLER
 	select RESET_CONTROLLER
 	select SOC_BUS
 	select USB_ULPI if USB_PHY
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index bb066e0..c455540 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -53,7 +53,7 @@ config ARCH_QCOM
 
 config ARCH_ROCKCHIP
 	bool "Rockchip Platforms"
-	select ARCH_HAS_RESET_CONTROLLER
+	select RESET_CONTROLLER
 	select ARCH_REQUIRE_GPIOLIB
 	select PINCTRL
 	select PINCTRL_ROCKCHIP
@@ -68,7 +68,6 @@ config ARCH_SEATTLE
 
 config ARCH_TEGRA
 	bool "NVIDIA Tegra SoC Family"
-	select ARCH_HAS_RESET_CONTROLLER
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e3aa5b0..da655a0 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -119,7 +119,7 @@ config ATH25
 
 config ATH79
 	bool "Atheros AR71XX/AR724X/AR913X based boards"
-	select ARCH_HAS_RESET_CONTROLLER
+	select RESET_CONTROLLER
 	select ARCH_REQUIRE_GPIOLIB
 	select BOOT_RAW
 	select CEVT_R4K
@@ -329,7 +329,6 @@ config LANTIQ
 	select USE_OF
 	select PINCTRL
 	select PINCTRL_LANTIQ
-	select ARCH_HAS_RESET_CONTROLLER
 	select RESET_CONTROLLER
 
 config LASAT
@@ -555,7 +554,6 @@ config RALINK
 	select SYS_HAS_EARLY_PRINTK
 	select HAVE_MACH_CLKDEV
 	select CLKDEV_LOOKUP
-	select ARCH_HAS_RESET_CONTROLLER
 	select RESET_CONTROLLER
 
 config SGI_IP22
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 0615f50..4ca3cc8 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -1,9 +1,5 @@
-config ARCH_HAS_RESET_CONTROLLER
+config RESET_CONTROLLER
 	bool
-
-menuconfig RESET_CONTROLLER
-	bool "Reset Controller Support"
-	default y if ARCH_HAS_RESET_CONTROLLER
 	help
 	  Generic Reset Controller support.
 
@@ -12,4 +8,10 @@ menuconfig RESET_CONTROLLER
 
 	  If unsure, say no.
 
+
+menu "Reset Controllers"
+	depends on RESET_CONTROLLER
+
 source "drivers/reset/sti/Kconfig"
+
+endmenu
diff --git a/drivers/reset/sti/Kconfig b/drivers/reset/sti/Kconfig
index f8c15a3..6131785 100644
--- a/drivers/reset/sti/Kconfig
+++ b/drivers/reset/sti/Kconfig
@@ -2,7 +2,6 @@ if ARCH_STI
 
 config STI_RESET_SYSCFG
 	bool
-	select RESET_CONTROLLER
 
 config STIH415_RESET
 	bool
-- 
1.9.1
