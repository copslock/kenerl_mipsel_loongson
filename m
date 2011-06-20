Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2011 21:27:23 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:35866 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491147Ab1FTT1L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Jun 2011 21:27:11 +0200
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id A106514021B;
        Mon, 20 Jun 2011 21:27:06 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 3D8A1140209;
        Mon, 20 Jun 2011 21:27:06 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Kathy Giori <kgiori@qca.qualcomm.com>,
        "Luis R. Rodriguez" <rodrigue@qca.qualcomm.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 01/13] MIPS: ath79: remove superfluous parentheses
Date:   Mon, 20 Jun 2011 21:26:01 +0200
Message-Id: <1308597973-6037-2-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
References: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A13168597DD | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
X-archive-position: 30453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16489

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/setup.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 159b42f..dea5af1 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -101,19 +101,19 @@ static void __init ath79_detect_sys_type(void)
 	case REV_ID_MAJOR_AR7240:
 		ath79_soc = ATH79_SOC_AR7240;
 		chip = "7240";
-		rev = (id & AR724X_REV_ID_REVISION_MASK);
+		rev = id & AR724X_REV_ID_REVISION_MASK;
 		break;
 
 	case REV_ID_MAJOR_AR7241:
 		ath79_soc = ATH79_SOC_AR7241;
 		chip = "7241";
-		rev = (id & AR724X_REV_ID_REVISION_MASK);
+		rev = id & AR724X_REV_ID_REVISION_MASK;
 		break;
 
 	case REV_ID_MAJOR_AR7242:
 		ath79_soc = ATH79_SOC_AR7242;
 		chip = "7242";
-		rev = (id & AR724X_REV_ID_REVISION_MASK);
+		rev = id & AR724X_REV_ID_REVISION_MASK;
 		break;
 
 	case REV_ID_MAJOR_AR913X:
-- 
1.7.2.1
