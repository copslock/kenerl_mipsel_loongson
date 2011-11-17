Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 23:14:26 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:46688 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1904062Ab1KQWOU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Nov 2011 23:14:20 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id E70A8140470;
        Thu, 17 Nov 2011 23:14:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AUhp7UCRPl5S; Thu, 17 Nov 2011 23:14:14 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 3A46C1403E1;
        Thu, 17 Nov 2011 23:14:14 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Imre Kaloz <kaloz@openwrt.org>, linux-mips@linux-mips.org,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 1/6] MIPS: ath79: store the SoC revision in a global variable
Date:   Thu, 17 Nov 2011 23:13:42 +0100
Message-Id: <1321568027-32066-2-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1321568027-32066-1-git-send-email-juhosg@openwrt.org>
References: <1321568027-32066-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 31748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14878

Knowing the exact revision of the SoC is required
to make runtime decisions in various code paths.
We have determined the SoC revision already, so
we only need to store that in a global variable.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/common.c                 |    1 +
 arch/mips/ath79/setup.c                  |    2 ++
 arch/mips/include/asm/mach-ath79/ath79.h |    1 +
 3 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/mips/ath79/common.c b/arch/mips/ath79/common.c
index 38c2ad7..f0fda98 100644
--- a/arch/mips/ath79/common.c
+++ b/arch/mips/ath79/common.c
@@ -30,6 +30,7 @@ u32 ath79_ddr_freq;
 EXPORT_SYMBOL_GPL(ath79_ddr_freq);
 
 enum ath79_soc_type ath79_soc;
+unsigned int ath79_soc_rev;
 
 void __iomem *ath79_pll_base;
 void __iomem *ath79_reset_base;
diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 4187a11..61bf339 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -149,6 +149,8 @@ static void __init ath79_detect_sys_type(void)
 		panic("ath79: unknown SoC, id:0x%08x\n", id);
 	}
 
+	ath79_soc_rev = rev;
+
 	sprintf(ath79_sys_type, "Atheros AR%s rev %u", chip, rev);
 	pr_info("SoC: %s\n", ath79_sys_type);
 }
diff --git a/arch/mips/include/asm/mach-ath79/ath79.h b/arch/mips/include/asm/mach-ath79/ath79.h
index 407c935..6d0c6c9 100644
--- a/arch/mips/include/asm/mach-ath79/ath79.h
+++ b/arch/mips/include/asm/mach-ath79/ath79.h
@@ -32,6 +32,7 @@ enum ath79_soc_type {
 };
 
 extern enum ath79_soc_type ath79_soc;
+extern unsigned int ath79_soc_rev;
 
 static inline int soc_is_ar71xx(void)
 {
-- 
1.7.2.1
