Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2011 21:30:50 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:35942 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491156Ab1FTT1R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Jun 2011 21:27:17 +0200
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id CAF6714021D;
        Mon, 20 Jun 2011 21:27:07 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 63767140214;
        Mon, 20 Jun 2011 21:27:07 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Kathy Giori <kgiori@qca.qualcomm.com>,
        "Luis R. Rodriguez" <rodrigue@qca.qualcomm.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 08/13] MIPS: ath79: add config symbol for the AR933X SoCs
Date:   Mon, 20 Jun 2011 21:26:08 +0200
Message-Id: <1308597973-6037-9-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
References: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A1318E92C3B | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
X-archive-position: 30460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16499

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/Kconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index af01669..90edf276 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -41,6 +41,9 @@ config SOC_AR913X
 	select USB_ARCH_HAS_EHCI
 	def_bool n
 
+config SOC_AR933X
+	def_bool n
+
 config ATH79_DEV_AR913X_WMAC
 	depends on SOC_AR913X
 	def_bool n
-- 
1.7.2.1
