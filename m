Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2018 23:22:36 +0100 (CET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:57712 "EHLO
        emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994669AbeAPWW3U5ltg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Jan 2018 23:22:29 +0100
Received: from localhost.localdomain (85-76-68-43-nat.elisa-mobile.fi [85.76.68.43])
        by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 5DD60200A1;
        Wed, 17 Jan 2018 00:22:28 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] MIPS: bcm47xx: enable ZBOOT support
Date:   Wed, 17 Jan 2018 00:21:44 +0200
Message-Id: <20180116222144.20359-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.9.2
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Enable ZBOOT support. The WRT54GL router's bootloader limits kernel
size to 3 MB with the normal load address, which is a bit challenging
vmlinux size with modern Linux. A compressed kernel allows booting
much bigger kernels.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/Kconfig          | 1 +
 arch/mips/bcm47xx/Platform | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 350a990..1a8cd3b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -253,6 +253,7 @@ config BCM47XX
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_MIPS16
+	select SYS_SUPPORTS_ZBOOT
 	select SYS_HAS_EARLY_PRINTK
 	select USE_GENERIC_EARLY_PRINTK_8250
 	select GPIOLIB
diff --git a/arch/mips/bcm47xx/Platform b/arch/mips/bcm47xx/Platform
index 874b7ca..70783b7 100644
--- a/arch/mips/bcm47xx/Platform
+++ b/arch/mips/bcm47xx/Platform
@@ -5,3 +5,4 @@ platform-$(CONFIG_BCM47XX)	+= bcm47xx/
 cflags-$(CONFIG_BCM47XX)	+=					\
 		-I$(srctree)/arch/mips/include/asm/mach-bcm47xx
 load-$(CONFIG_BCM47XX)		:= 0xffffffff80001000
+zload-$(CONFIG_BCM47XX)		+= 0xffffffff80400000
-- 
2.9.2
