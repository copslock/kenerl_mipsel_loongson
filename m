Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2016 08:02:06 +0200 (CEST)
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:37100 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041473AbcFJGCE45uRV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jun 2016 08:02:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1465538523; l=3833;
        s=domk; d=li-pro.net;
        h=References:In-Reply-To:Date:Subject:Cc:To:From;
        bh=f3cXKvCHmqdpy91WVEL/x5H9A5XzsseICS1cgW7a0mU=;
        b=ww1NpHuFWHBPQcva4OlMfMLRp9ASmcVndpNEe5ZqiezSbrHOdohA4hu3PwsbIkKJlFG
        Nj7oIwWPK850y9/QgvBy6aWs4PRnLUp+RPvwsZflW7bAOFQrA38EUV+joKtZI51zOM4KG
        eDTqUQ8latT34UUea+LT1zU2AOKCADZKmyQ=
X-RZG-AUTH: :IGUKb2CkcrLHmZv+FHarxbxlXmVV62wuQa970vlgN/Vm4aURpaOv9ql7EmfwzQ==
X-RZG-CLASS-ID: mo00
Received: from li-pro.net (p54B1609A.dip0.t-ipconnect.de [84.177.96.154])
        by smtp.strato.de (RZmta 38.2 DYNA|AUTH)
        with ESMTPSA id t07466s5A622PJQ
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 10 Jun 2016 08:02:02 +0200 (CEST)
From:   Stephan Linz <linz@li-pro.net>
To:     linux-leds@vger.kernel.org, linux-ide@vger.kernel.org
Cc:     Stephan Linz <linz@li-pro.net>, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/7] mips: use the new LED disk activity trigger
Date:   Fri, 10 Jun 2016 08:00:00 +0200
Message-Id: <20160610060021.12382-5-linz@li-pro.net>
X-Mailer: git-send-email 2.8.4
In-Reply-To: <20160610060021.12382-1-linz@li-pro.net>
References: <20160610060021.12382-1-linz@li-pro.net>
Return-Path: <linz@li-pro.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linz@li-pro.net
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

- platform: rename 'ide-disk' to 'disk-activity'
- defconfig: rename 'LEDS_TRIGGER_IDE_DISK' to 'LEDS_TRIGGER_DISK'

Signed-off-by: Stephan Linz <linz@li-pro.net>
---
 arch/mips/configs/malta_qemu_32r6_defconfig | 2 +-
 arch/mips/configs/maltaaprp_defconfig       | 2 +-
 arch/mips/configs/maltasmvp_eva_defconfig   | 2 +-
 arch/mips/configs/maltaup_defconfig         | 2 +-
 arch/mips/configs/rbtx49xx_defconfig        | 2 +-
 arch/mips/txx9/generic/setup.c              | 2 +-
 arch/mips/txx9/rbtx4939/setup.c             | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/configs/malta_qemu_32r6_defconfig b/arch/mips/configs/malta_qemu_32r6_defconfig
index 7f50dd6..65f140e 100644
--- a/arch/mips/configs/malta_qemu_32r6_defconfig
+++ b/arch/mips/configs/malta_qemu_32r6_defconfig
@@ -146,7 +146,7 @@ CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
-CONFIG_LEDS_TRIGGER_IDE_DISK=y
+CONFIG_LEDS_TRIGGER_DISK=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_BACKLIGHT=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
diff --git a/arch/mips/configs/maltaaprp_defconfig b/arch/mips/configs/maltaaprp_defconfig
index a9d433a..799c433 100644
--- a/arch/mips/configs/maltaaprp_defconfig
+++ b/arch/mips/configs/maltaaprp_defconfig
@@ -147,7 +147,7 @@ CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
-CONFIG_LEDS_TRIGGER_IDE_DISK=y
+CONFIG_LEDS_TRIGGER_DISK=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_BACKLIGHT=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
diff --git a/arch/mips/configs/maltasmvp_eva_defconfig b/arch/mips/configs/maltasmvp_eva_defconfig
index 2774ef0..3184600 100644
--- a/arch/mips/configs/maltasmvp_eva_defconfig
+++ b/arch/mips/configs/maltasmvp_eva_defconfig
@@ -152,7 +152,7 @@ CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
-CONFIG_LEDS_TRIGGER_IDE_DISK=y
+CONFIG_LEDS_TRIGGER_DISK=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_BACKLIGHT=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
diff --git a/arch/mips/configs/maltaup_defconfig b/arch/mips/configs/maltaup_defconfig
index 9bbd221..a79107d 100644
--- a/arch/mips/configs/maltaup_defconfig
+++ b/arch/mips/configs/maltaup_defconfig
@@ -146,7 +146,7 @@ CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
-CONFIG_LEDS_TRIGGER_IDE_DISK=y
+CONFIG_LEDS_TRIGGER_DISK=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_BACKLIGHT=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
diff --git a/arch/mips/configs/rbtx49xx_defconfig b/arch/mips/configs/rbtx49xx_defconfig
index f8bf9b4..43d55e5 100644
--- a/arch/mips/configs/rbtx49xx_defconfig
+++ b/arch/mips/configs/rbtx49xx_defconfig
@@ -90,7 +90,7 @@ CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_TRIGGERS=y
-CONFIG_LEDS_TRIGGER_IDE_DISK=y
+CONFIG_LEDS_TRIGGER_DISK=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_INTF_DEV_UIE_EMUL=y
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 108f8a8..ada92db 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -727,7 +727,7 @@ void __init txx9_iocled_init(unsigned long baseaddr,
 	int i;
 	static char *default_triggers[] __initdata = {
 		"heartbeat",
-		"ide-disk",
+		"disk-activity",
 		"nand-disk",
 		NULL,
 	};
diff --git a/arch/mips/txx9/rbtx4939/setup.c b/arch/mips/txx9/rbtx4939/setup.c
index 3703040..8b93730 100644
--- a/arch/mips/txx9/rbtx4939/setup.c
+++ b/arch/mips/txx9/rbtx4939/setup.c
@@ -215,7 +215,7 @@ static int __init rbtx4939_led_probe(struct platform_device *pdev)
 	int i;
 	static char *default_triggers[] __initdata = {
 		"heartbeat",
-		"ide-disk",
+		"disk-activity",
 		"nand-disk",
 	};
 
-- 
2.8.4
