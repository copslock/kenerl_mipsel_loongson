Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jan 2013 08:28:19 +0100 (CET)
Received: from moutng.kundenserver.de ([212.227.126.187]:64886 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821310Ab3APH2OY1peR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jan 2013 08:28:14 +0100
Received: from mailbox.adnet.avionic-design.de (mailbox.avionic-design.de [109.75.18.3])
        by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
        id 0LzDgT-1Srk7N3Upt-014WFQ; Wed, 16 Jan 2013 08:28:08 +0100
Received: from localhost (localhost [127.0.0.1])
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id 3478B2A28109;
        Wed, 16 Jan 2013 08:28:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at avionic-design.de
Received: from mailbox.adnet.avionic-design.de ([127.0.0.1])
        by localhost (mailbox.avionic-design.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fRo54UK1HdOJ; Wed, 16 Jan 2013 08:28:07 +0100 (CET)
Received: from mailman.adnet.avionic-design.de (mailman.adnet.avionic-design.de [172.20.31.172])
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id 35BBB2A28154;
        Wed, 16 Jan 2013 08:28:07 +0100 (CET)
Received: from localhost (avionic-0098.adnet.avionic-design.de [172.20.31.233])
        by mailman.adnet.avionic-design.de (Postfix) with ESMTP id 73E87100424;
        Wed, 16 Jan 2013 08:28:03 +0100 (CET)
From:   Thierry Reding <thierry.reding@avionic-design.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: bcm47xx: Fix BCMA build failure
Date:   Wed, 16 Jan 2013 08:28:06 +0100
Message-Id: <1358321286-8695-1-git-send-email-thierry.reding@avionic-design.de>
X-Mailer: git-send-email 1.8.1
X-Provags-ID: V02:K0:M7pFCoCq2kerIonxw1txCFC9Hr1ZIbB2kA7ptbgUAGu
 ajZIjrxz56PxHnOP3W6QnryiWGpEFXUSJYpcYsAvHpqPN+suVQ
 6Ylw1tsJeCueOQUyflCHUUH10Oj4TXW7DHlV0yWK1RFWtneyEH
 jSoXZqx+D//xmTKYtkvoyXY6OFXux196r9fZHZDKBNfN3FBijD
 ntJHgT0wK4EN0f4vvtMRwAP4QvH6z6su1m6rF9Ve65czmz3r5s
 n2b0CzqzLIgKtrCCT5+VexNPjoVj1dakHZElgn69LYUPgYtpcJ
 gPua8h9UjXLiwCe6C3w4H0ixpzragqzlAmvlvhlpGU2LLzI56b
 oaabgQy2z719eKUl5SFun+82coHwrVkjtq2IJ7H3m01DMqGcfq
 dTIDjg68y67WiGLAApGzxvTnlCrLKN3D93ifF+5ffqToiHZUSr
 puz1c
X-archive-position: 35457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@avionic-design.de
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Enabling the BCMA driver automatically selects BCMA_DRIVER_GPIO, which
in turn depends on GPIOLIB. GPIOLIB support is not enabled by default,
however, so Kconfig complains about it:

	warning: (BCM47XX_BCMA) selects BCMA_DRIVER_GPIO which has unmet direct dependencies (BCMA_POSSIBLE && BCMA && GPIOLIB)
	warning: (BCM47XX_SSB) selects SSB_DRIVER_GPIO which has unmet direct dependencies (SSB_POSSIBLE && SSB && GPIOLIB)
	warning: (BCM47XX_SSB) selects SSB_DRIVER_GPIO which has unmet direct dependencies (SSB_POSSIBLE && SSB && GPIOLIB)
	warning: (BCM47XX_BCMA) selects BCMA_DRIVER_GPIO which has unmet direct dependencies (BCMA_POSSIBLE && BCMA && GPIOLIB)

This patch fixes the issue by explicitly selecting GPIOLIB if
BCM47XX_BCMA is enabled.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 arch/mips/bcm47xx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/bcm47xx/Kconfig b/arch/mips/bcm47xx/Kconfig
index d7af29f..0f95b5e 100644
--- a/arch/mips/bcm47xx/Kconfig
+++ b/arch/mips/bcm47xx/Kconfig
@@ -19,6 +19,7 @@ config BCM47XX_SSB
 config BCM47XX_BCMA
 	bool "BCMA Support for Broadcom BCM47XX"
 	select SYS_HAS_CPU_MIPS32_R2
+	select GPIOLIB
 	select BCMA
 	select BCMA_HOST_SOC
 	select BCMA_DRIVER_MIPS
-- 
1.8.1
