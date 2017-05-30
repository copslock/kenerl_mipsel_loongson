Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 May 2017 06:35:02 +0200 (CEST)
Received: from ms.tdt.de ([195.243.126.94]:55478 "EHLO mail.dev.tdt.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993302AbdE3EezqQ6u8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 30 May 2017 06:34:55 +0200
Received: from mschiller01.tdtnet.local (unknown [10.1.3.20])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 98F1220835;
        Tue, 30 May 2017 04:34:48 +0000 (UTC)
From:   Martin Schiller <ms@dev.tdt.de>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     john@phrozen.org, ralf@linux-mips.org, hauke@hauke-m.de,
        arnd@arndb.de, nbd@nbd.name, Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH] MIPS: Lantiq: Fix ASC0/ASC1 clocks
Date:   Tue, 30 May 2017 06:34:34 +0200
Message-Id: <1496118874-4251-1-git-send-email-ms@dev.tdt.de>
X-Mailer: git-send-email 2.1.4
Return-Path: <ms@dev.tdt.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ms@dev.tdt.de
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

ASC1 is available on every Lantiq SoC (also AmazonSE) and should be
enabled like the other generic xway clocks instead of ASC0, which is
only available for AR9 and Danube.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 arch/mips/lantiq/xway/sysctrl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 95bec46..cd6dbea 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -484,9 +484,9 @@ void __init ltq_soc_init(void)
 
 	/* add our generic xway clocks */
 	clkdev_add_pmu("10000000.fpi", NULL, 0, 0, PMU_FPI);
-	clkdev_add_pmu("1e100400.serial", NULL, 0, 0, PMU_ASC0);
 	clkdev_add_pmu("1e100a00.gptu", NULL, 1, 0, PMU_GPT);
 	clkdev_add_pmu("1e100bb0.stp", NULL, 1, 0, PMU_STP);
+	clkdev_add_pmu("1e100c00.serial", NULL, 0, 0, PMU_ASC1);
 	clkdev_add_pmu("1e104100.dma", NULL, 1, 0, PMU_DMA);
 	clkdev_add_pmu("1e100800.spi", NULL, 1, 0, PMU_SPI);
 	clkdev_add_pmu("1e105300.ebu", NULL, 0, 0, PMU_EBU);
@@ -501,7 +501,6 @@ void __init ltq_soc_init(void)
 	}
 
 	if (!of_machine_is_compatible("lantiq,ase")) {
-		clkdev_add_pmu("1e100c00.serial", NULL, 0, 0, PMU_ASC1);
 		clkdev_add_pci();
 	}
 
-- 
2.1.4
