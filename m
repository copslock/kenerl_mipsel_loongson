Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Nov 2018 11:09:02 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:54470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990434AbeKSKI5t7LMb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Nov 2018 11:08:57 +0100
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14F03206BA;
        Mon, 19 Nov 2018 10:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542622136;
        bh=z6QRhXORicQ9kDgje8vuxX9AoHAQ0BqOS3DpOXqT1Bc=;
        h=From:To:Cc:Subject:Date:From;
        b=LIBcFG1Rj1xngH7WGaP6udkmQMSSQ2OUrsqA4/Oik2kUdDn8b6U/yNNZuD/TQKyfl
         NpSv+wSL4dfLv6tz4I12TJhJ9QgSqw6qtIi8MXLUFwmBSQUG/NYLKzPrGtBBRLI0o2
         sKkIy6oieMmRs0yg95tM1nhe3BBJUlPWHDpfC1OM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] MIPS: defconfigs: Remove obsolete ATH_CARDS
Date:   Mon, 19 Nov 2018 11:08:51 +0100
Message-Id: <1542622131-18009-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Return-Path: <krzk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: krzk@kernel.org
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

CONFIG_ATH_CARDS was replaced with CONFIG_WLAN_VENDOR_ATH in
commit b5c9b4f91a6f ("ath: unify Kconfig with other vendors").  Anyway
it is being selected automatically as dependency on chosen Atheros
driver.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/mips/configs/bcm47xx_defconfig   | 1 -
 arch/mips/configs/loongson3_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/mips/configs/bcm47xx_defconfig b/arch/mips/configs/bcm47xx_defconfig
index ba800a892384..745daaec13cb 100644
--- a/arch/mips/configs/bcm47xx_defconfig
+++ b/arch/mips/configs/bcm47xx_defconfig
@@ -48,7 +48,6 @@ CONFIG_NETDEVICES=y
 CONFIG_B44=y
 CONFIG_TIGON3=y
 CONFIG_BGMAC=y
-CONFIG_ATH_CARDS=y
 CONFIG_ATH5K=y
 CONFIG_B43=y
 CONFIG_B43LEGACY=y
diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
index 324dfee23dfb..e100575625cc 100644
--- a/arch/mips/configs/loongson3_defconfig
+++ b/arch/mips/configs/loongson3_defconfig
@@ -215,7 +215,6 @@ CONFIG_PPPOE=m
 CONFIG_PPPOL2TP=m
 CONFIG_PPP_ASYNC=m
 CONFIG_PPP_SYNC_TTY=m
-CONFIG_ATH_CARDS=m
 CONFIG_ATH9K=m
 CONFIG_HOSTAP=m
 CONFIG_INPUT_POLLDEV=m
-- 
2.7.4
