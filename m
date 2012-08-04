Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Aug 2012 18:02:36 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:42820 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903503Ab2HDQBq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 4 Aug 2012 18:01:46 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id A94CF23C008F;
        Sat,  4 Aug 2012 18:01:42 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v3 2/4] MIPS: ath79: use correct IRQ number for the OHCI controller on AR7240
Date:   Sat,  4 Aug 2012 18:01:25 +0200
Message-Id: <1344096087-25044-3-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1344096087-25044-1-git-send-email-juhosg@openwrt.org>
References: <1344096087-25044-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 34055
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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
---
 arch/mips/ath79/dev-usb.c |    2 ++
 1 file changed, 2 insertions(+)

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
1.7.10
