Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Feb 2013 15:41:56 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:58619 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827645Ab3BOOifKRlsZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Feb 2013 15:38:35 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7FZt2INfF2Tu; Fri, 15 Feb 2013 15:38:24 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 244B3280329;
        Fri, 15 Feb 2013 15:38:24 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        "Rodriguez, Luis" <rodrigue@qca.qualcomm.com>,
        "Giori, Kathy" <kgiori@qca.qualcomm.com>,
        QCA Linux Team <qca-linux-team@qca.qualcomm.com>
Subject: [PATCH 10/11] MIPS: ath79: add USB controller registration code for the QCA955X SoCs
Date:   Fri, 15 Feb 2013 15:38:24 +0100
Message-Id: <1360939105-23591-11-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1360939105-23591-1-git-send-email-juhosg@openwrt.org>
References: <1360939105-23591-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 35763
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

Register platfom devices for the built-in USB
controllers of the SoCs.

Cc: Rodriguez, Luis <rodrigue@qca.qualcomm.com>
Cc: Giori, Kathy <kgiori@qca.qualcomm.com>
Cc: QCA Linux Team <qca-linux-team@qca.qualcomm.com>
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/dev-usb.c                      |   15 +++++++++++++++
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    3 +++
 2 files changed, 18 insertions(+)

diff --git a/arch/mips/ath79/dev-usb.c b/arch/mips/ath79/dev-usb.c
index 02124d0..8227265 100644
--- a/arch/mips/ath79/dev-usb.c
+++ b/arch/mips/ath79/dev-usb.c
@@ -208,6 +208,19 @@ static void __init ar934x_usb_setup(void)
 			   &ath79_ehci_pdata_v2, sizeof(ath79_ehci_pdata_v2));
 }
 
+static void __init qca955x_usb_setup(void)
+{
+	ath79_usb_register("ehci-platform", 0,
+			   QCA955X_EHCI0_BASE, QCA955X_EHCI_SIZE,
+			   ATH79_IP3_IRQ(0),
+			   &ath79_ehci_pdata_v2, sizeof(ath79_ehci_pdata_v2));
+
+	ath79_usb_register("ehci-platform", 1,
+			   QCA955X_EHCI1_BASE, QCA955X_EHCI_SIZE,
+			   ATH79_IP3_IRQ(1),
+			   &ath79_ehci_pdata_v2, sizeof(ath79_ehci_pdata_v2));
+}
+
 void __init ath79_register_usb(void)
 {
 	if (soc_is_ar71xx())
@@ -222,6 +235,8 @@ void __init ath79_register_usb(void)
 		ar933x_usb_setup();
 	else if (soc_is_ar934x())
 		ar934x_usb_setup();
+	else if (soc_is_qca955x())
+		qca955x_usb_setup();
 	else
 		BUG();
 }
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index b7fa9d1..4de1831 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -109,6 +109,9 @@
 
 #define QCA955X_WMAC_BASE	(AR71XX_APB_BASE + 0x00100000)
 #define QCA955X_WMAC_SIZE	0x20000
+#define QCA955X_EHCI0_BASE	0x1b000000
+#define QCA955X_EHCI1_BASE	0x1b400000
+#define QCA955X_EHCI_SIZE	0x1000
 
 /*
  * DDR_CTRL block
-- 
1.7.10
