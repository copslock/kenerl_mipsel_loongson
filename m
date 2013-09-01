Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Sep 2013 19:39:09 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:37152 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6815748Ab3IARjHl8T-f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 1 Sep 2013 19:39:07 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH] MIPS: ralink: add RESET_CONTROLLER to the defconfig
Date:   Sun,  1 Sep 2013 19:38:47 +0200
Message-Id: <1378057127-21984-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Without this symbol being set, we get an undefined symbol compile error.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/configs/rt305x_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/configs/rt305x_defconfig b/arch/mips/configs/rt305x_defconfig
index d1741bc..a222319 100644
--- a/arch/mips/configs/rt305x_defconfig
+++ b/arch/mips/configs/rt305x_defconfig
@@ -131,6 +131,7 @@ CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_STAGING=y
 # CONFIG_IOMMU_SUPPORT is not set
+CONFIG_RESET_CONTROLLER=y
 # CONFIG_DNOTIFY is not set
 # CONFIG_PROC_PAGE_MONITOR is not set
 CONFIG_TMPFS=y
-- 
1.7.10.4
