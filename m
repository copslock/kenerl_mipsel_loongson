Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 08:23:54 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:40552 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990466AbeENGWYyFnYO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 May 2018 08:22:24 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mathieu Malaterre <malat@debian.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 7/8] MIPS: qi_lb60: Enable the jz4740-wdt driver
Date:   Thu, 10 May 2018 20:47:50 +0200
Message-Id: <20180510184751.13416-7-paul@crapouillou.net>
In-Reply-To: <20180510184751.13416-1-paul@crapouillou.net>
References: <20180510184751.13416-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1525978120; bh=3zzI4GyBwG8mFLlX3pr04xREWNwioGuci8T6qaqzgBk=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XrVxuiTElqLVPLSppefcklZPXPmW8w4ywITISavIinku5KsuJBpB35X51FXk3mZ/Lj+TuBPHdnd+eAQJCVoCJ+mVkxQ60RTrdu27CB5lxODvzCcbdcm0wpcokEEhNfZjfDbaKBt8gupcKBTieaSMkxOadxjFIVyR9J3XhEH/TyU=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63914
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

Besides, this is important for restart to work after the change in the
next commit.

This commit enables the Kconfig option in the qi_lb60 defconfig.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: James Hogan <jhogan@kernel.org>
---
 arch/mips/configs/qi_lb60_defconfig | 2 ++
 1 file changed, 2 insertions(+)

 v2: No change
 v3: No change

diff --git a/arch/mips/configs/qi_lb60_defconfig b/arch/mips/configs/qi_lb60_defconfig
index 3b02ff9a7c64..d8b7211a7b0f 100644
--- a/arch/mips/configs/qi_lb60_defconfig
+++ b/arch/mips/configs/qi_lb60_defconfig
@@ -72,6 +72,8 @@ CONFIG_POWER_SUPPLY=y
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
