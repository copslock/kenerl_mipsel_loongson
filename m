Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jul 2010 22:14:15 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:35856 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492705Ab0G0UNF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Jul 2010 22:13:05 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 4201F85DC;
        Tue, 27 Jul 2010 22:13:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tfsN2-qlYnCs; Tue, 27 Jul 2010 22:12:57 +0200 (CEST)
Received: from localhost.localdomain (host-091-097-249-197.ewe-ip-backbone.de [91.97.249.197])
        by hauke-m.de (Postfix) with ESMTPSA id B381385E1;
        Tue, 27 Jul 2010 22:12:54 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/4] MIPS: BCM47xx: Activate SSB_B43_PCI_BRIDGE by default
Date:   Tue, 27 Jul 2010 22:12:45 +0200
Message-Id: <1280261566-8247-4-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280261566-8247-1-git-send-email-hauke@hauke-m.de>
References: <1280261566-8247-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips

The b43_pci_bridge is needed to use the b43 driver with brcm47xx.
Activate it by default if pci is available.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 85dac72..aaca439 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -71,6 +71,7 @@ config BCM47XX
 	select SSB_DRIVER_MIPS
 	select SSB_DRIVER_EXTIF
 	select SSB_EMBEDDED
+	select SSB_B43_PCI_BRIDGE if PCI
 	select SSB_PCICORE_HOSTMODE if PCI
 	select GENERIC_GPIO
 	select SYS_HAS_EARLY_PRINTK
-- 
1.7.0.4
