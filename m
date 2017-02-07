Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2017 07:14:42 +0100 (CET)
Received: from smtp.gentoo.org ([140.211.166.183]:34044 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992036AbdBGGOLRSt7r (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Feb 2017 07:14:11 +0100
Received: from helcaraxe.arda (c-73-201-78-97.hsd1.md.comcast.net [73.201.78.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kumba)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 9C61A341699;
        Tue,  7 Feb 2017 06:14:04 +0000 (UTC)
From:   Joshua Kinard <kumba@gentoo.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>
Subject: [PATCH 01/12] MIPS: BRIDGE: Rename pci-ip27.c to pci-bridge.c
Date:   Tue,  7 Feb 2017 01:13:45 -0500
Message-Id: <20170207061356.8270-2-kumba@gentoo.org>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170207061356.8270-1-kumba@gentoo.org>
References: <20170207061356.8270-1-kumba@gentoo.org>
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

From: Joshua Kinard <kumba@gentoo.org>

Rename arch/mips/pci/pci-ip27.c to arch/mips/pci/pci-bridge.c so that
it can become a generic driver for all BRIDGE/XBRIDGE-based systems
and update the Makefile for this change.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/pci/Makefile                     | 2 +-
 arch/mips/pci/{pci-ip27.c => pci-bridge.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 4b821481dd44..7ff66cce2cf7 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -37,7 +37,7 @@ obj-$(CONFIG_MIPS_MALTA)	+= fixup-malta.o pci-malta.o
 obj-$(CONFIG_PMC_MSP7120_GW)	+= fixup-pmcmsp.o ops-pmcmsp.o
 obj-$(CONFIG_PMC_MSP7120_EVAL)	+= fixup-pmcmsp.o ops-pmcmsp.o
 obj-$(CONFIG_PMC_MSP7120_FPGA)	+= fixup-pmcmsp.o ops-pmcmsp.o
-obj-$(CONFIG_SGI_IP27)		+= ops-bridge.o pci-ip27.o
+obj-$(CONFIG_SGI_IP27)		+= ops-bridge.o pci-bridge.o
 obj-$(CONFIG_SGI_IP32)		+= fixup-ip32.o ops-mace.o pci-ip32.o
 obj-$(CONFIG_SIBYTE_SB1250)	+= fixup-sb1250.o pci-sb1250.o
 obj-$(CONFIG_SIBYTE_BCM112X)	+= fixup-sb1250.o pci-sb1250.o
diff --git a/arch/mips/pci/pci-ip27.c b/arch/mips/pci/pci-bridge.c
similarity index 100%
rename from arch/mips/pci/pci-ip27.c
rename to arch/mips/pci/pci-bridge.c
-- 
2.11.1
