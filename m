Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 08:50:06 +0200 (CEST)
Received: from lucky1.263xmail.com ([211.157.147.130]:45969 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011232AbbHFGuBH09Xk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 08:50:01 +0200
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.156])
        by lucky1.263xmail.com (Postfix) with SMTP id 2731C1E3A39;
        Thu,  6 Aug 2015 14:49:56 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-ADDR-CHECKED: 0
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTP id 4F96112566;
        Thu,  6 Aug 2015 14:49:53 +0800 (CST)
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: jh80.chung@samsung.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <964b7ba66bbe7dac9dd5d0b8d969c6e2>
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 120594KRKL1;
        Thu, 06 Aug 2015 14:49:56 +0800 (CST)
From:   Shawn Lin <shawn.lin@rock-chips.com>
To:     jh80.chung@samsung.com, ulf.hansson@linaro.org
Cc:     heiko@sntech.de, dianders@chromium.org, Vineet.Gupta1@synopsys.com,
        Wei Xu <xuwei5@hisilicon.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Russell King <linux@arm.linux.org.uk>,
        Jun Nie <jun.nie@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH v4 7/9] arm: lpc18xx_defconfig: remove CONFIG_MMC_DW_IDMAC
Date:   Thu,  6 Aug 2015 14:46:30 +0800
Message-Id: <1438843590-24101-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1438843469-23807-1-git-send-email-shawn.lin@rock-chips.com>
References: <1438843469-23807-1-git-send-email-shawn.lin@rock-chips.com>
Return-Path: <shawn.lin@rock-chips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48657
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
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/configs/lpc18xx_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index 1c47f86..b7e8cda 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -119,7 +119,6 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
 CONFIG_MMC=y
 CONFIG_MMC_DW=y
-CONFIG_MMC_DW_IDMAC=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_PCA9532=y
-- 
2.3.7
