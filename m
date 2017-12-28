Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 17:32:27 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:50804 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990793AbdL1Q37jeymB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 17:29:59 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 6/7] MIPS: qi_lb60: Enable the jz4740-wdt driver
Date:   Thu, 28 Dec 2017 17:29:38 +0100
Message-Id: <20171228162939.3928-7-paul@crapouillou.net>
In-Reply-To: <20171228162939.3928-1-paul@crapouillou.net>
References: <20171228162939.3928-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1514478599; bh=rjYJ75XnjTJhboyaxDNHtzQ8QHFXaUC0+2lHZlhi4cc=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=RQVVQOf/Z0M5HTfIF6dhQSvbHvpTZikJgoWbog6NnIYcKkPQFokNRmpAJ8u94fgcYCHYbbf+nf/lOqQoYkFYwoXhsYu9Aj+WNX87yqwntNJbUWEKXJWhDE9Uas688EBr+mjudQl4CbG5PeDOhbmoXbcbTy1Vx/q7JK7KCIJ0pBQ=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

The watchdog is an useful piece of hardware, so there's no reason not to
enable it.

This commit enables the Kconfig option in the qi_lb60 defconfig.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/configs/qi_lb60_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/configs/qi_lb60_defconfig b/arch/mips/configs/qi_lb60_defconfig
index 3f1333517405..ba8e1c56b626 100644
--- a/arch/mips/configs/qi_lb60_defconfig
+++ b/arch/mips/configs/qi_lb60_defconfig
@@ -73,6 +73,8 @@ CONFIG_POWER_SUPPLY=y
 CONFIG_BATTERY_JZ4740=y
 CONFIG_CHARGER_GPIO=y
 # CONFIG_HWMON is not set
+CONFIG_WATCHDOG=y
+CONFIG_JZ4740_WDT=y
 CONFIG_MFD_JZ4740_ADC=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
-- 
2.11.0
