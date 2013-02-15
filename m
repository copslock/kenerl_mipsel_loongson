Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Feb 2013 15:39:16 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:58574 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827505Ab3BOOibNIlLP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Feb 2013 15:38:31 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id L96xSFJzxZfw; Fri, 15 Feb 2013 15:38:19 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 46BAD280213;
        Fri, 15 Feb 2013 15:38:19 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        "Rodriguez, Luis" <rodrigue@qca.qualcomm.com>,
        "Giori, Kathy" <kgiori@qca.qualcomm.com>,
        QCA Linux Team <qca-linux-team@qca.qualcomm.com>
Subject: [PATCH 01/11] MIPS: ath79: add early printk support for the QCA955X SoCs
Date:   Fri, 15 Feb 2013 15:38:15 +0100
Message-Id: <1360939105-23591-2-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1360939105-23591-1-git-send-email-juhosg@openwrt.org>
References: <1360939105-23591-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 35755
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

The patch allows to see kernel messages on the
QCA955X SoCs in early boot stage.

Cc: Rodriguez, Luis <rodrigue@qca.qualcomm.com>
Cc: Giori, Kathy <kgiori@qca.qualcomm.com>
Cc: QCA Linux Team <qca-linux-team@qca.qualcomm.com>
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/early_printk.c                 |    2 ++
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/mips/ath79/early_printk.c b/arch/mips/ath79/early_printk.c
index dc938cb..b955faf 100644
--- a/arch/mips/ath79/early_printk.c
+++ b/arch/mips/ath79/early_printk.c
@@ -74,6 +74,8 @@ static void prom_putchar_init(void)
 	case REV_ID_MAJOR_AR9341:
 	case REV_ID_MAJOR_AR9342:
 	case REV_ID_MAJOR_AR9344:
+	case REV_ID_MAJOR_QCA9556:
+	case REV_ID_MAJOR_QCA9558:
 		_prom_putchar = prom_putchar_ar71xx;
 		break;
 
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index a77f6ee..d02c2d4 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -370,6 +370,8 @@
 #define REV_ID_MAJOR_AR9341		0x0120
 #define REV_ID_MAJOR_AR9342		0x1120
 #define REV_ID_MAJOR_AR9344		0x2120
+#define REV_ID_MAJOR_QCA9556		0x0130
+#define REV_ID_MAJOR_QCA9558		0x1130
 
 #define AR71XX_REV_ID_MINOR_MASK	0x3
 #define AR71XX_REV_ID_MINOR_AR7130	0x0
-- 
1.7.10
