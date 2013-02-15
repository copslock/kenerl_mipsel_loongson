Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Feb 2013 15:40:39 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:58599 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827517Ab3BOOidZWqGA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Feb 2013 15:38:33 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FDE-hEGORjyq; Fri, 15 Feb 2013 15:38:22 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id EAF7228039B;
        Fri, 15 Feb 2013 15:38:21 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        "Rodriguez, Luis" <rodrigue@qca.qualcomm.com>,
        "Giori, Kathy" <kgiori@qca.qualcomm.com>,
        QCA Linux Team <qca-linux-team@qca.qualcomm.com>
Subject: [PATCH 06/11] MIPS: ath79: add QCA955X specific glue to ath79_device_reset_{set,clear}
Date:   Fri, 15 Feb 2013 15:38:20 +0100
Message-Id: <1360939105-23591-7-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1360939105-23591-1-git-send-email-juhosg@openwrt.org>
References: <1360939105-23591-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 35759
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

The ath79_device_reset_* are causing BUG when
those are used on the QCA955x SoCs. The patch
adds the required code to avoid that.

Cc: Rodriguez, Luis <rodrigue@qca.qualcomm.com>
Cc: Giori, Kathy <kgiori@qca.qualcomm.com>
Cc: QCA Linux Team <qca-linux-team@qca.qualcomm.com>
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/common.c                       |    4 ++++
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/mips/ath79/common.c b/arch/mips/ath79/common.c
index 5a4adfc..eb3966c 100644
--- a/arch/mips/ath79/common.c
+++ b/arch/mips/ath79/common.c
@@ -72,6 +72,8 @@ void ath79_device_reset_set(u32 mask)
 		reg = AR933X_RESET_REG_RESET_MODULE;
 	else if (soc_is_ar934x())
 		reg = AR934X_RESET_REG_RESET_MODULE;
+	else if (soc_is_qca955x())
+		reg = QCA955X_RESET_REG_RESET_MODULE;
 	else
 		BUG();
 
@@ -98,6 +100,8 @@ void ath79_device_reset_clear(u32 mask)
 		reg = AR933X_RESET_REG_RESET_MODULE;
 	else if (soc_is_ar934x())
 		reg = AR934X_RESET_REG_RESET_MODULE;
+	else if (soc_is_qca955x())
+		reg = QCA955X_RESET_REG_RESET_MODULE;
 	else
 		BUG();
 
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index 4868ed5..bf50ddf 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -299,6 +299,7 @@
 #define AR934X_RESET_REG_BOOTSTRAP		0xb0
 #define AR934X_RESET_REG_PCIE_WMAC_INT_STATUS	0xac
 
+#define QCA955X_RESET_REG_RESET_MODULE		0x1c
 #define QCA955X_RESET_REG_BOOTSTRAP		0xb0
 #define QCA955X_RESET_REG_EXT_INT_STATUS	0xac
 
-- 
1.7.10
