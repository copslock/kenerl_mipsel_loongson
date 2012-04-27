Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Apr 2012 19:11:24 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:55798 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903622Ab2D0RK1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Apr 2012 19:10:27 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 074C923C007B;
        Fri, 27 Apr 2012 19:10:21 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 2/2] MIPS: ath79: use correct IRQ number for the OHCI controller on AR7240
Date:   Fri, 27 Apr 2012 19:10:13 +0200
Message-Id: <1335546613-32078-3-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1335546613-32078-1-git-send-email-juhosg@openwrt.org>
References: <1335546613-32078-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 33031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The currently assigned IRQ number to the OHCI
controller is incorrect for the AR7240 SoC, and
that leads to the following error message from
the OHCI driver:

ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ath79-ohci ath79-ohci: Atheros built-in OHCI controller
ath79-ohci ath79-ohci: new USB bus registered, assigned bus number 1
ath79-ohci ath79-ohci: irq 14, io mem 0x1b000000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
usb 1-1: new full-speed USB device number 2 using ath79-ohci
ath79-ohci ath79-ohci: Unlink after no-IRQ?  Controller is probably using the wrong IRQ.

Fix this by using the correct IRQ number.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>

 arch/mips/ath79/dev-usb.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/ath79/dev-usb.c b/arch/mips/ath79/dev-usb.c
index 36e9570..b2a2311 100644
--- a/arch/mips/ath79/dev-usb.c
+++ b/arch/mips/ath79/dev-usb.c
@@ -145,6 +145,8 @@ static void __init ar7240_usb_setup(void)
 
 	ath79_ohci_resources[0].start = AR7240_OHCI_BASE;
 	ath79_ohci_resources[0].end = AR7240_OHCI_BASE + AR7240_OHCI_SIZE - 1;
+	ath79_ohci_resources[1].start = ATH79_CPU_IRQ_USB;
+	ath79_ohci_resources[1].end = ATH79_CPU_IRQ_USB;
 	platform_device_register(&ath79_ohci_device);
 }
 
-- 
1.7.2.1
