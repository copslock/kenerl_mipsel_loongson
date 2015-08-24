Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Aug 2015 03:27:49 +0200 (CEST)
Received: from regular1.263xmail.com ([211.150.99.132]:60791 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011072AbbHXB1e2Xsx8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Aug 2015 03:27:34 +0200
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.192])
        by regular1.263xmail.com (Postfix) with SMTP id 35A638FDE;
        Mon, 24 Aug 2015 09:27:29 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-ADDR-CHECKED: 0
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTP id 840E31EB2A;
        Mon, 24 Aug 2015 09:27:20 +0800 (CST)
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: jh80.chung@samsung.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <4973f4bda373ac9b79efaa4df493e1d7>
X-ATTACHMENT-NUM: 0
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 11670RH0IWL;
        Mon, 24 Aug 2015 09:27:26 +0800 (CST)
From:   Shawn Lin <shawn.lin@rock-chips.com>
To:     jh80.chung@samsung.com, ulf.hansson@linaro.org
Cc:     Vineet.Gupta1@synopsys.com, Wei Xu <xuwei5@hisilicon.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Russell King <linux@arm.linux.org.uk>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Jun Nie <jun.nie@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>, heiko@sntech.de,
        dianders@chromium.org, linux-samsung-soc@vger.kernel.org,
        linux-mips@linux-mips.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH v7 05/10] arc: axs10x_defconfig: remove CONFIG_MMC_DW_IDMAC
Date:   Mon, 24 Aug 2015 09:26:45 +0800
Message-Id: <1440379605-24585-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1440379479-24308-1-git-send-email-shawn.lin@rock-chips.com>
References: <1440379479-24308-1-git-send-email-shawn.lin@rock-chips.com>
Return-Path: <shawn.lin@rock-chips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48988
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

DesignWare MMC Controller's transfer mode should be decided
at runtime instead of compile-time. So we remove this config
option and read dw_mmc's register to select DMA master.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Acked-by: Vineet Gupta <vgupta@synopsys.com>
---

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arc/configs/axs101_defconfig     | 1 -
 arch/arc/configs/axs103_defconfig     | 1 -
 arch/arc/configs/axs103_smp_defconfig | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arc/configs/axs101_defconfig b/arch/arc/configs/axs101_defconfig
index 562dac6..c92c0ef 100644
--- a/arch/arc/configs/axs101_defconfig
+++ b/arch/arc/configs/axs101_defconfig
@@ -89,7 +89,6 @@ CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_DW=y
-CONFIG_MMC_DW_IDMAC=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS=y
diff --git a/arch/arc/configs/axs103_defconfig b/arch/arc/configs/axs103_defconfig
index 83a6d8d..cfac24e 100644
--- a/arch/arc/configs/axs103_defconfig
+++ b/arch/arc/configs/axs103_defconfig
@@ -95,7 +95,6 @@ CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_DW=y
-CONFIG_MMC_DW_IDMAC=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS=y
diff --git a/arch/arc/configs/axs103_smp_defconfig b/arch/arc/configs/axs103_smp_defconfig
index f1e1c84..9922a11 100644
--- a/arch/arc/configs/axs103_smp_defconfig
+++ b/arch/arc/configs/axs103_smp_defconfig
@@ -96,7 +96,6 @@ CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_DW=y
-CONFIG_MMC_DW_IDMAC=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS=y
-- 
2.3.7
