Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2016 08:27:51 +0100 (CET)
Received: from smtp3-g21.free.fr ([212.27.42.3]:34802 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009158AbcAZH1kTV8p8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Jan 2016 08:27:40 +0100
Received: from localhost.localdomain (unknown [78.54.17.127])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id 18B8AA6261;
        Tue, 26 Jan 2016 08:25:53 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Felix Fietkau <nbd@openwrt.org>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, linux-kernel@vger.kernel.org,
        Alban Bedel <albeu@free.fr>
Subject: [PATCH 2/2] MIPS: ath79: Remove the builtin DTB support
Date:   Tue, 26 Jan 2016 08:27:16 +0100
Message-Id: <1453793236-10890-2-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1453793236-10890-1-git-send-email-albeu@free.fr>
References: <1453793236-10890-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

Now that appended DTB is usable we can drop the builtin DTB support.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/ath79/Kconfig         | 12 ------------
 arch/mips/ath79/setup.c         |  4 ----
 arch/mips/boot/dts/qca/Makefile |  3 ---
 3 files changed, 19 deletions(-)

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index 13c04cf..dfc6020 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -71,18 +71,6 @@ config ATH79_MACH_UBNT_XM
 	  Say 'Y' here if you want your kernel to support the
 	  Ubiquiti Networks XM (rev 1.0) board.
 
-choice
-	prompt "Build a DTB in the kernel"
-	optional
-	help
-	  Select a devicetree that should be built into the kernel.
-
-	config DTB_TL_WR1043ND_V1
-		bool "TL-WR1043ND Version 1"
-		select BUILTIN_DTB
-		select SOC_AR913X
-endchoice
-
 endmenu
 
 config SOC_AR71XX
diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 2895e45..01808e8 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -205,10 +205,6 @@ void __init plat_mem_setup(void)
 		__dt_setup_arch((void *)KSEG0ADDR(fdt_start));
 	else if (fw_arg0 == -2)
 		__dt_setup_arch((void *)KSEG0ADDR(fw_arg1));
-#ifdef CONFIG_BUILTIN_DTB
-	else
-		__dt_setup_arch(__dtb_start);
-#endif
 
 	ath79_reset_base = ioremap_nocache(AR71XX_RESET_BASE,
 					   AR71XX_RESET_SIZE);
diff --git a/arch/mips/boot/dts/qca/Makefile b/arch/mips/boot/dts/qca/Makefile
index 2d61455d..14bd225 100644
--- a/arch/mips/boot/dts/qca/Makefile
+++ b/arch/mips/boot/dts/qca/Makefile
@@ -1,9 +1,6 @@
 # All DTBs
 dtb-$(CONFIG_ATH79)			+= ar9132_tl_wr1043nd_v1.dtb
 
-# Select a DTB to build in the kernel
-obj-$(CONFIG_DTB_TL_WR1043ND_V1)	+= ar9132_tl_wr1043nd_v1.dtb.o
-
 # Force kbuild to make empty built-in.o if necessary
 obj-				+= dummy.o
 
-- 
2.0.0
