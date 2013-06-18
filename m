Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 19:56:59 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:2873 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827424Ab3FRR41X-exv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Jun 2013 19:56:27 +0200
Received: from [10.9.208.55] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 18 Jun 2013 10:47:00 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Tue, 18 Jun 2013 10:56:07 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Tue, 18 Jun 2013 10:56:07 -0700
Received: from fainelli-desktop.broadcom.com (
 dhcp-lab-brsc-244.bri.broadcom.com [10.178.5.244]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 840D0F2D73; Tue, 18
 Jun 2013 10:56:06 -0700 (PDT)
From:   "Florian Fainelli" <florian@openwrt.org>
To:     ralf@linux-mips.org
cc:     linux-mips@linux-mips.org, cernekee@gmail.com, jogo@openwrt.org,
        "Florian Fainelli" <florian@openwrt.org>
Subject: [PATCH 1/7] MIPS: BCM63XX: remove bogus Kconfig selects
Date:   Tue, 18 Jun 2013 18:55:38 +0100
Message-ID: <1371578144-12794-2-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1371578144-12794-1-git-send-email-florian@openwrt.org>
References: <1371578144-12794-1-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
X-WSS-ID: 7DDE429E2L834866951-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

Remove the bogus selects on USB-related symbols for 6345 and 6338, not
only we do not yet support USB on BCM63XX, but they also cause the
following warnings:

warning: (BCM63XX_CPU_6338 && BCM63XX_CPU_6345) selects
USB_OHCI_BIG_ENDIAN_MMIO which has unmet direct dependencies
(USB_SUPPORT && USB && USB_OHCI_HCD)
warning: (BCM63XX_CPU_6338 && BCM63XX_CPU_6345) selects
USB_OHCI_BIG_ENDIAN_DESC which has unmet direct dependencies
(USB_SUPPORT && USB && USB_OHCI_HCD)
make[4]: Leaving directory `/home/florian/dev/linux'

Just get rid of these bogus Kconfig selects because neither 6345 nor
6338 actually have built-in USB host controllers.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/bcm63xx/Kconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/mips/bcm63xx/Kconfig b/arch/mips/bcm63xx/Kconfig
index 5639662..165727d 100644
--- a/arch/mips/bcm63xx/Kconfig
+++ b/arch/mips/bcm63xx/Kconfig
@@ -8,14 +8,9 @@ config BCM63XX_CPU_6328
 config BCM63XX_CPU_6338
 	bool "support 6338 CPU"
 	select HW_HAS_PCI
-	select USB_ARCH_HAS_OHCI
-	select USB_OHCI_BIG_ENDIAN_DESC
-	select USB_OHCI_BIG_ENDIAN_MMIO
 
 config BCM63XX_CPU_6345
 	bool "support 6345 CPU"
-	select USB_OHCI_BIG_ENDIAN_DESC
-	select USB_OHCI_BIG_ENDIAN_MMIO
 
 config BCM63XX_CPU_6348
 	bool "support 6348 CPU"
-- 
1.8.1.2
