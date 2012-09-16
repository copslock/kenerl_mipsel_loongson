Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Sep 2012 16:48:47 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:46459 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903241Ab2IPOso (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Sep 2012 16:48:44 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 8E4B88E1C;
        Sun, 16 Sep 2012 16:48:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IAKcFK4e-Woz; Sun, 16 Sep 2012 16:48:40 +0200 (CEST)
Received: from hauke.lan (unknown [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id C817E87B9;
        Sun, 16 Sep 2012 16:48:39 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, john@phrozen.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/2] MIPS: BCM47XX: select BOOT_RAW
Date:   Sun, 16 Sep 2012 16:48:34 +0200
Message-Id: <1347806915-25132-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 34517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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
Return-Path: <linux-mips-bounce@linux-mips.org>

All the boot loaders I have seen are booting the kernel in raw mode by
default. CFE seams to support elf kernel images too, but the default
case is raw for the devices I know of. Select this option to make the
kernel boot on most of the devices with the default options.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index fa171a3..564a06f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -102,6 +102,7 @@ config ATH79
 config BCM47XX
 	bool "Broadcom BCM47XX based boards"
 	select ARCH_REQUIRE_GPIOLIB
+	select BOOT_RAW
 	select CEVT_R4K
 	select CSRC_R4K
 	select DMA_NONCOHERENT
-- 
1.7.9.5
