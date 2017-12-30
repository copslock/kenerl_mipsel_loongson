Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Dec 2017 14:54:03 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:38038 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990436AbdL3NvhB-b10 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Dec 2017 14:51:37 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 7/8] MIPS: qi_lb60: Enable the jz4740-wdt driver
Date:   Sat, 30 Dec 2017 14:51:07 +0100
Message-Id: <20171230135108.6834-7-paul@crapouillou.net>
In-Reply-To: <20171230135108.6834-1-paul@crapouillou.net>
References: <20171228162939.3928-2-paul@crapouillou.net>
 <20171230135108.6834-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1514641896; bh=NlVHr20kxoSRmBR7LmLep/C2YDEeRVGUajWNDsCnLE0=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=u5HF7u2o14ypbTHjLZnSDeD+XSkMoYtHLUgK0caJwronvxp+weSlAa/Semzimkco0m18WtMwd3qxMd8sBqlzSAj6NCSYpc2QTqDGbod1wJQpjJ/2W14Mv/f5gWcfG9CxeDOKFotC01grUHrJZ4xebCQZtM9ciXKtuOKFAG1Abpc=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61784
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

 v2: No change

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
