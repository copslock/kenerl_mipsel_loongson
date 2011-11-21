Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 16:09:15 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:44843 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903768Ab1KUPHV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Nov 2011 16:07:21 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id C65A314045E;
        Mon, 21 Nov 2011 16:07:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id W9S5SO2Qh-IY; Mon, 21 Nov 2011 16:07:16 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id BF3F6140471;
        Mon, 21 Nov 2011 16:06:56 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Rene Bolldorf <xsecute@googlemail.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v4 5/7] MIPS: ath79: rename pci-ath724x.c to make it reflect the real SoC name
Date:   Mon, 21 Nov 2011 16:06:37 +0100
Message-Id: <1321887999-14546-6-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1321887999-14546-1-git-send-email-juhosg@openwrt.org>
References: <1321887999-14546-1-git-send-email-juhosg@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 31876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17387

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Acked-by: René Bolldorf <xsecute@googlemail.com>
---
v4: - add an Acked-by tag from René
v4: - no changes
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
