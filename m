Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 May 2011 17:48:55 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:60549 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491084Ab1EIPs1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 May 2011 17:48:27 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mips@linux-mips.org
Subject: [PATCH V3 3/3] MIPS: lantiq: etop board support
Date:   Mon,  9 May 2011 17:49:58 +0200
Message-Id: <1304956198-20426-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1304956198-20426-1-git-send-email-blogic@openwrt.org>
References: <1304956198-20426-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

Register the etop platform device inside the machtype specific init code.

--

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Ralph Hempel <ralph.hempel@lantiq.com>
Cc: linux-mips@linux-mips.org

 arch/mips/lantiq/xway/mach-easy50712.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/lantiq/xway/mach-easy50712.c b/arch/mips/lantiq/xway/mach-easy50712.c
index 5242a27..0cbb30b 100644
--- a/arch/mips/lantiq/xway/mach-easy50712.c
+++ b/arch/mips/lantiq/xway/mach-easy50712.c
@@ -59,6 +59,10 @@ static struct ltq_pci_data ltq_pci_data = {
 	},
 };
 
+static struct ltq_eth_data ltq_eth_data = {
+	.mii_mode = PHY_INTERFACE_MODE_MII,
+};
+
 static void __init easy50712_init(void)
 {
 	ltq_register_gpio();
@@ -66,6 +70,7 @@ static void __init easy50712_init(void)
 	ltq_register_nor(&easy50712_flash_data);
 	ltq_register_wdt();
 	ltq_register_pci(&ltq_pci_data);
+	ltq_register_etop(&ltq_eth_data);
 }
 
 MIPS_MACHINE(LTQ_MACH_EASY50712,
-- 
1.7.2.3
