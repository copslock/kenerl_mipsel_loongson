Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2012 10:40:54 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:34322 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903730Ab2CNJkG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2012 10:40:06 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 553C723C00C9;
        Wed, 14 Mar 2012 10:09:30 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>,
        mcgrof@infradead.org, juhosg@openwrt.org
Subject: [PATCH v2 02/13] MIPS: ath79: sort case statements in ath79_detect_sys_type
Date:   Wed, 14 Mar 2012 11:45:20 +0100
Message-Id: <1331721931-4334-3-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1331721931-4334-1-git-send-email-juhosg@openwrt.org>
References: <1331721931-4334-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 32695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Sort the case statements alphabetically in order to improve
readability.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Acked-by: Luis R. Rodriguez <mcgrof@qca.qualcomm.com>
---
v2: - no changes

 arch/mips/ath79/setup.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 80a7d40..24dfedf 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -116,18 +116,6 @@ static void __init ath79_detect_sys_type(void)
 		rev = id & AR724X_REV_ID_REVISION_MASK;
 		break;
 
-	case REV_ID_MAJOR_AR9330:
-		ath79_soc = ATH79_SOC_AR9330;
-		chip = "9330";
-		rev = id & AR933X_REV_ID_REVISION_MASK;
-		break;
-
-	case REV_ID_MAJOR_AR9331:
-		ath79_soc = ATH79_SOC_AR9331;
-		chip = "9331";
-		rev = id & AR933X_REV_ID_REVISION_MASK;
-		break;
-
 	case REV_ID_MAJOR_AR913X:
 		minor = id & AR913X_REV_ID_MINOR_MASK;
 		rev = id >> AR913X_REV_ID_REVISION_SHIFT;
@@ -145,6 +133,18 @@ static void __init ath79_detect_sys_type(void)
 		}
 		break;
 
+	case REV_ID_MAJOR_AR9330:
+		ath79_soc = ATH79_SOC_AR9330;
+		chip = "9330";
+		rev = id & AR933X_REV_ID_REVISION_MASK;
+		break;
+
+	case REV_ID_MAJOR_AR9331:
+		ath79_soc = ATH79_SOC_AR9331;
+		chip = "9331";
+		rev = id & AR933X_REV_ID_REVISION_MASK;
+		break;
+
 	default:
 		panic("ath79: unknown SoC, id:0x%08x", id);
 	}
-- 
1.7.2.1
