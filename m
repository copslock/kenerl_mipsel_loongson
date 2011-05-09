Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 May 2011 18:48:56 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:45260 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491104Ab1EIQrj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 May 2011 18:47:39 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org
Subject: [PATCH 3/4] MIPS: lantiq: cleanup machine specific files
Date:   Mon,  9 May 2011 18:49:09 +0200
Message-Id: <1304959750-8557-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1304959750-8557-1-git-send-email-blogic@openwrt.org>
References: <1304959750-8557-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

The platform driver register functions called in every machine init function
get moved to setup-<SOC>.c. Also remove superflous pci register call from
Amazon SE machine code as the device and driver are not present on ASE.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/lantiq/xway/mach-easy50601.c |    8 --------
 arch/mips/lantiq/xway/mach-easy50712.c |    2 --
 2 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/mips/lantiq/xway/mach-easy50601.c b/arch/mips/lantiq/xway/mach-easy50601.c
index 34a41d9..0002128 100644
--- a/arch/mips/lantiq/xway/mach-easy50601.c
+++ b/arch/mips/lantiq/xway/mach-easy50601.c
@@ -50,17 +50,9 @@ static struct physmap_flash_data easy50601_flash_data = {
 #endif
 };
 
-static struct ltq_pci_data ltq_pci_data = {
-	.clock		= PCI_CLOCK_INT,
-	.req_mask	= 0xf,
-};
-
 static void __init easy50601_init(void)
 {
-	ltq_register_gpio();
 	ltq_register_nor(&easy50601_flash_data);
-	ltq_register_wdt();
-	ltq_register_pci(&ltq_pci_data);
 }
 
 MIPS_MACHINE(LTQ_MACH_EASY50601,
diff --git a/arch/mips/lantiq/xway/mach-easy50712.c b/arch/mips/lantiq/xway/mach-easy50712.c
index 0cbb30b..2512561 100644
--- a/arch/mips/lantiq/xway/mach-easy50712.c
+++ b/arch/mips/lantiq/xway/mach-easy50712.c
@@ -65,10 +65,8 @@ static struct ltq_eth_data ltq_eth_data = {
 
 static void __init easy50712_init(void)
 {
-	ltq_register_gpio();
 	ltq_register_gpio_stp();
 	ltq_register_nor(&easy50712_flash_data);
-	ltq_register_wdt();
 	ltq_register_pci(&ltq_pci_data);
 	ltq_register_etop(&ltq_eth_data);
 }
-- 
1.7.2.3
