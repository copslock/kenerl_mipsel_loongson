Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2012 10:24:05 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:34758 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903652Ab2CNJXI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2012 10:23:08 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 71F4F23C00C9;
        Wed, 14 Mar 2012 09:52:41 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, juhosg@openwrt.org,
        stable@vger.kernel.org
Subject: [PATCH 1/2] MIPS: ath79: fix AR933X WMAC reset code
Date:   Wed, 14 Mar 2012 11:28:35 +0100
Message-Id: <1331720916-4015-2-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1331720916-4015-1-git-send-email-juhosg@openwrt.org>
References: <1331720916-4015-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 32671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The current code puts the built-in WMAC device of the
AR933X SoCs into reset instead of starting it. This
causes a hard lock on AR933X based boards when the
wireless driver tries to access the device.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Cc: stable@vger.kernel.org

 arch/mips/ath79/dev-wmac.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/ath79/dev-wmac.c b/arch/mips/ath79/dev-wmac.c
index e215070..9c717bf 100644
--- a/arch/mips/ath79/dev-wmac.c
+++ b/arch/mips/ath79/dev-wmac.c
@@ -58,8 +58,8 @@ static void __init ar913x_wmac_setup(void)
 
 static int ar933x_wmac_reset(void)
 {
-	ath79_device_reset_clear(AR933X_RESET_WMAC);
 	ath79_device_reset_set(AR933X_RESET_WMAC);
+	ath79_device_reset_clear(AR933X_RESET_WMAC);
 
 	return 0;
 }
-- 
1.7.2.1
