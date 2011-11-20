Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Nov 2011 22:41:31 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:41502 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903635Ab1KTVjc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 20 Nov 2011 22:39:32 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 70D7A140428;
        Sun, 20 Nov 2011 22:39:27 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7fjxOCOWNOFH; Sun, 20 Nov 2011 22:39:27 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id D9B72140463;
        Sun, 20 Nov 2011 22:39:25 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Rene Bolldorf <xsecute@googlemail.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v3 5/7] MIPS: ath79: rename pci-ath724x.c to make it reflect the real SoC name
Date:   Sun, 20 Nov 2011 22:39:09 +0100
Message-Id: <1321825151-16053-6-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1321825151-16053-1-git-send-email-juhosg@openwrt.org>
References: <1321825151-16053-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 31825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16771

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
v3: - no changes
v2: - no changes
---
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
