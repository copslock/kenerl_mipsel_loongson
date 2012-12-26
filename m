Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Dec 2012 22:06:46 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:52769 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816511Ab2LZVGlsZh0Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Dec 2012 22:06:41 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 95AA48F61;
        Wed, 26 Dec 2012 22:06:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nM5QI+3obTqT; Wed, 26 Dec 2012 22:06:33 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 7967E8E1C;
        Wed, 26 Dec 2012 22:06:33 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     john@phrozen.org, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, cernekee@gmail.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH resend 1/2] MIPS: BCM47XX: select BOOT_RAW
Date:   Wed, 26 Dec 2012 22:06:17 +0100
Message-Id: <1356555978-2660-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 35332
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
default. CFE seems to support elf kernel images too, but the default
case is raw for the devices I know of. Select this option to make the
kernel boot on most of the devices with the default options.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d971d15..8e1fd8a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -109,6 +109,7 @@ config ATH79
 config BCM47XX
 	bool "Broadcom BCM47XX based boards"
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select BOOT_RAW
 	select CEVT_R4K
 	select CSRC_R4K
 	select DMA_NONCOHERENT
-- 
1.7.10.4
