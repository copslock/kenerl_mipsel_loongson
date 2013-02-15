Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Feb 2013 15:38:51 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:58577 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827501Ab3BOOibGGcXP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Feb 2013 15:38:31 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mjuJUfVBZ77c; Fri, 15 Feb 2013 15:38:20 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id D1E642801AE;
        Fri, 15 Feb 2013 15:38:19 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        "Rodriguez, Luis" <rodrigue@qca.qualcomm.com>,
        "Giori, Kathy" <kgiori@qca.qualcomm.com>,
        QCA Linux Team <qca-linux-team@qca.qualcomm.com>
Subject: [PATCH 02/11] MIPS: ath79: add SoC detection code for the QCA955X SoCs
Date:   Fri, 15 Feb 2013 15:38:16 +0100
Message-Id: <1360939105-23591-3-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1360939105-23591-1-git-send-email-juhosg@openwrt.org>
References: <1360939105-23591-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 35754
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

Also add 'soc_is_qca955[68x]' helper functions
and a Kconfig symbol for the SoC family.

Cc: Rodriguez, Luis <rodrigue@qca.qualcomm.com>
Cc: Giori, Kathy <kgiori@qca.qualcomm.com>
Cc: QCA Linux Team <qca-linux-team@qca.qualcomm.com>
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/Kconfig                        |    4 ++++
 arch/mips/ath79/setup.c                        |   18 +++++++++++++++++-
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    2 ++
 arch/mips/include/asm/mach-ath79/ath79.h       |   17 +++++++++++++++++
 4 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index f44feee..cffdc8e 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -88,6 +88,10 @@ config SOC_AR934X
 	select PCI_AR724X if PCI
 	def_bool n
 
+config SOC_QCA955X
+	select USB_ARCH_HAS_EHCI
+	def_bool n
+
 config PCI_AR724X
 	def_bool n
 
diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 60d212e..d5b3c90 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -164,13 +164,29 @@ static void __init ath79_detect_sys_type(void)
 		rev = id & AR934X_REV_ID_REVISION_MASK;
 		break;
 
+	case REV_ID_MAJOR_QCA9556:
+		ath79_soc = ATH79_SOC_QCA9556;
+		chip = "9556";
+		rev = id & QCA955X_REV_ID_REVISION_MASK;
+		break;
+
+	case REV_ID_MAJOR_QCA9558:
+		ath79_soc = ATH79_SOC_QCA9558;
+		chip = "9558";
+		rev = id & QCA955X_REV_ID_REVISION_MASK;
+		break;
+
 	default:
 		panic("ath79: unknown SoC, id:0x%08x", id);
 	}
 
 	ath79_soc_rev = rev;
 
-	sprintf(ath79_sys_type, "Atheros AR%s rev %u", chip, rev);
+	if (soc_is_qca955x())
+		sprintf(ath79_sys_type, "Qualcomm Atheros QCA%s rev %u",
+			chip, rev);
+	else
+		sprintf(ath79_sys_type, "Atheros AR%s rev %u", chip, rev);
 	pr_info("SoC: %s\n", ath79_sys_type);
 }
 
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index d02c2d4..63a9f2b 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -392,6 +392,8 @@
 
 #define AR934X_REV_ID_REVISION_MASK     0xf
 
+#define QCA955X_REV_ID_REVISION_MASK	0xf
+
 /*
  * SPI block
  */
diff --git a/arch/mips/include/asm/mach-ath79/ath79.h b/arch/mips/include/asm/mach-ath79/ath79.h
index 4f248c3..1557934 100644
--- a/arch/mips/include/asm/mach-ath79/ath79.h
+++ b/arch/mips/include/asm/mach-ath79/ath79.h
@@ -32,6 +32,8 @@ enum ath79_soc_type {
 	ATH79_SOC_AR9341,
 	ATH79_SOC_AR9342,
 	ATH79_SOC_AR9344,
+	ATH79_SOC_QCA9556,
+	ATH79_SOC_QCA9558,
 };
 
 extern enum ath79_soc_type ath79_soc;
@@ -98,6 +100,21 @@ static inline int soc_is_ar934x(void)
 	return soc_is_ar9341() || soc_is_ar9342() || soc_is_ar9344();
 }
 
+static inline int soc_is_qca9556(void)
+{
+	return ath79_soc == ATH79_SOC_QCA9556;
+}
+
+static inline int soc_is_qca9558(void)
+{
+	return ath79_soc == ATH79_SOC_QCA9558;
+}
+
+static inline int soc_is_qca955x(void)
+{
+	return soc_is_qca9556() || soc_is_qca9558();
+}
+
 extern void __iomem *ath79_ddr_base;
 extern void __iomem *ath79_pll_base;
 extern void __iomem *ath79_reset_base;
-- 
1.7.10
