Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2012 10:26:29 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:34875 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903711Ab2CNJXs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2012 10:23:48 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 706FE23C00C9;
        Wed, 14 Mar 2012 09:53:23 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, juhosg@openwrt.org
Subject: [PATCH v5 5/7] MIPS: ath79: rename pci-ath724x.c to make it reflect the real SoC name
Date:   Wed, 14 Mar 2012 11:29:25 +0100
Message-Id: <1331720967-4049-6-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1331720967-4049-1-git-send-email-juhosg@openwrt.org>
References: <1331720967-4049-1-git-send-email-juhosg@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 32677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Acked-by: René Bolldorf <xsecute@googlemail.com>
---
v5: - no changes
v4: - add an Acked-by tag from René
v3: - no changes
v2: - no changes

 arch/mips/pci/Makefile                        |    2 +-
 arch/mips/pci/{pci-ath724x.c => pci-ar724x.c} |    0
 2 files changed, 1 insertions(+), 1 deletions(-)
 rename arch/mips/pci/{pci-ath724x.c => pci-ar724x.c} (100%)

diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index c3ac4b0..172277c 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -19,7 +19,7 @@ obj-$(CONFIG_BCM47XX)		+= pci-bcm47xx.o
 obj-$(CONFIG_BCM63XX)		+= pci-bcm63xx.o fixup-bcm63xx.o \
 					ops-bcm63xx.o
 obj-$(CONFIG_MIPS_ALCHEMY)	+= pci-alchemy.o
-obj-$(CONFIG_SOC_AR724X)	+= pci-ath724x.o
+obj-$(CONFIG_SOC_AR724X)	+= pci-ar724x.o
 
 #
 # These are still pretty much in the old state, watch, go blind.
diff --git a/arch/mips/pci/pci-ath724x.c b/arch/mips/pci/pci-ar724x.c
similarity index 100%
rename from arch/mips/pci/pci-ath724x.c
rename to arch/mips/pci/pci-ar724x.c
-- 
1.7.2.1
