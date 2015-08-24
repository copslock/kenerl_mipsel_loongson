Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Aug 2015 03:28:27 +0200 (CEST)
Received: from regular1.263xmail.com ([211.150.99.135]:48477 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011249AbbHXB141l-J8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Aug 2015 03:27:56 +0200
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.153])
        by regular1.263xmail.com (Postfix) with SMTP id B894D1B01A;
        Mon, 24 Aug 2015 09:27:53 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-ADDR-CHECKED: 0
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTP id B1B9624744;
        Mon, 24 Aug 2015 09:27:48 +0800 (CST)
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: jh80.chung@samsung.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <e878d2350e9c419708be27a11bc131e6>
X-ATTACHMENT-NUM: 0
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 56639CO872;
        Mon, 24 Aug 2015 09:27:51 +0800 (CST)
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
Subject: [RFC PATCH v7 07/10] arm: hisi_defconfig: remove CONFIG_MMC_DW_IDMAC
Date:   Mon, 24 Aug 2015 09:27:12 +0800
Message-Id: <1440379632-24679-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1440379479-24308-1-git-send-email-shawn.lin@rock-chips.com>
References: <1440379479-24308-1-git-send-email-shawn.lin@rock-chips.com>
Return-Path: <shawn.lin@rock-chips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48990
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
Acked-by: Wei Xu <xuwei5@hisilicon.com>
---

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/configs/hisi_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/hisi_defconfig b/arch/arm/configs/hisi_defconfig
index 5997dbc..b2e340b 100644
--- a/arch/arm/configs/hisi_defconfig
+++ b/arch/arm/configs/hisi_defconfig
@@ -69,7 +69,6 @@ CONFIG_NOP_USB_XCEIV=y
 CONFIG_MMC=y
 CONFIG_RTC_CLASS=y
 CONFIG_MMC_DW=y
-CONFIG_MMC_DW_IDMAC=y
 CONFIG_MMC_DW_PLTFM=y
 CONFIG_RTC_DRV_PL031=y
 CONFIG_DMADEVICES=y
-- 
2.3.7
