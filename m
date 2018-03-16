Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Mar 2018 21:28:24 +0100 (CET)
Received: from mx1.mailbox.org ([80.241.60.212]:64042 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994644AbeCPU1xXmiY1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 16 Mar 2018 21:27:53 +0100
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id EDF3E42A4F;
        Fri, 16 Mar 2018 21:27:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id 4nEU4ASx_lZw; Fri, 16 Mar 2018 21:27:35 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, jhogan@kernel.org
Cc:     john@phrozen.org, dev@kresin.me, linux-mips@linux-mips.org,
        martin.blumenstingl@googlemail.com,
        "# 4 . 14+" <stable@vger.kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 1/3] MIPS: lantiq: fix Danube USB clock
Date:   Fri, 16 Mar 2018 21:27:28 +0100
Message-Id: <20180316202730.598-2-hauke@hauke-m.de>
In-Reply-To: <20180316202730.598-1-hauke@hauke-m.de>
References: <20180316202730.598-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

From: Mathias Kresin <dev@kresin.me>

On Danube the USB0 controller registers are at 1e101000 and the USB0 PHY
register is at 1f203018 similar to all other lantiq SoCs. Activate the
USB controller gating clock thorough the USB controller driver and not
the PHY.

This fixes a problem introduced in a previous commit.

Fixes: dea54fbad332 ("phy: Add an USB PHY driver for the Lantiq SoCs using the RCU module")
Cc: <stable@vger.kernel.org> # 4.14+
Signed-off-by: Mathias Kresin <dev@kresin.me>
Acked-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/lantiq/xway/sysctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 52500d3b7004..f11f1dd10493 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -560,7 +560,7 @@ void __init ltq_soc_init(void)
 	} else {
 		clkdev_add_static(ltq_danube_cpu_hz(), ltq_danube_fpi_hz(),
 				ltq_danube_fpi_hz(), ltq_danube_pp32_hz());
-		clkdev_add_pmu("1f203018.usb2-phy", "ctrl", 1, 0, PMU_USB0);
+		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0);
 		clkdev_add_pmu("1f203018.usb2-phy", "phy", 1, 0, PMU_USB0_P);
 		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
 		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
-- 
2.11.0
