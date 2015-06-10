Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jun 2015 23:01:34 +0200 (CEST)
Received: from smtp1-g21.free.fr ([212.27.42.1]:61342 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008019AbbFJVB2c0wJU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Jun 2015 23:01:28 +0200
Received: from localhost.localdomain (unknown [78.54.109.140])
        (Authenticated sender: albeu)
        by smtp1-g21.free.fr (Postfix) with ESMTPA id 92E169400AD;
        Wed, 10 Jun 2015 22:57:15 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     <linux-mips@linux-mips.org>
Cc:     Alban Bedel <albeu@free.fr>
Subject: [PATCH linux-next] MIPS: pci-ar71xx: Fix left over reference to ath79_ddr_base
Date:   Wed, 10 Jun 2015 23:01:12 +0200
Message-Id: <1433970072-11790-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <5571B520.9040808@roeck-us.net>
References: <5571B520.9040808@roeck-us.net>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

The patch 'MIPS: ath79: Improve the DDR controller interface'
broke the PCI support as it failed to properly removed the use of the
variable 'ath79_ddr_base'. Remove that last reference to fix the build.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/pci/pci-ar71xx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/pci/pci-ar71xx.c b/arch/mips/pci/pci-ar71xx.c
index 72764d8..1391c52 100644
--- a/arch/mips/pci/pci-ar71xx.c
+++ b/arch/mips/pci/pci-ar71xx.c
@@ -318,8 +318,6 @@ static void ar71xx_pci_irq_init(struct ar71xx_pci_controller *apc)
 
 static void ar71xx_pci_reset(void)
 {
-	void __iomem *ddr_base = ath79_ddr_base;
-
 	ath79_device_reset_set(AR71XX_RESET_PCI_BUS | AR71XX_RESET_PCI_CORE);
 	mdelay(100);
 
-- 
2.0.0
