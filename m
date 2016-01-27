Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 23:17:12 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:43244 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007649AbcA0WRKndZzk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 23:17:10 +0100
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id DE82760445;
        Wed, 27 Jan 2016 22:17:02 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D1EE360495; Wed, 27 Jan 2016 22:17:02 +0000 (UTC)
Received: from sboyd-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F327760445;
        Wed, 27 Jan 2016 22:17:00 +0000 (UTC)
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH] clk: Get rid of HAVE_MACH_CLKDEV
Date:   Wed, 27 Jan 2016 14:17:00 -0800
Message-Id: <1453933020-8577-1-git-send-email-sboyd@codeaurora.org>
X-Mailer: git-send-email 2.6.3.369.g91ad409
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sboyd@codeaurora.org
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

This config was used for the ARM port so that it could use a
machine specific clkdev.h include, but those are all gone now.
The MIPS architecture is the last user, and from what I can tell
it doesn't actually use it anyway, so let's remove the config all
together.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

I don't see a problem if this goes through the MIPS tree or the clk tree.
Let me know and I can take it through clk.

 arch/mips/Kconfig       | 2 --
 arch/mips/pic32/Kconfig | 1 -
 drivers/clk/Kconfig     | 3 ---
 3 files changed, 6 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 56f57816613e..8e1be2889af3 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -328,7 +328,6 @@ config LANTIQ
 	select ARCH_REQUIRE_GPIOLIB
 	select SWAP_IO_SPACE
 	select BOOT_RAW
-	select HAVE_MACH_CLKDEV
 	select CLKDEV_LOOKUP
 	select USE_OF
 	select PINCTRL
@@ -590,7 +589,6 @@ config RALINK
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_MIPS16
 	select SYS_HAS_EARLY_PRINTK
-	select HAVE_MACH_CLKDEV
 	select CLKDEV_LOOKUP
 	select ARCH_HAS_RESET_CONTROLLER
 	select RESET_CONTROLLER
diff --git a/arch/mips/pic32/Kconfig b/arch/mips/pic32/Kconfig
index fde56a8b85ca..1985971b9890 100644
--- a/arch/mips/pic32/Kconfig
+++ b/arch/mips/pic32/Kconfig
@@ -15,7 +15,6 @@ config PIC32MZDA
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select ARCH_REQUIRE_GPIOLIB
-	select HAVE_MACH_CLKDEV
 	select COMMON_CLK
 	select CLKDEV_LOOKUP
 	select LIBFDT
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index eca8e019e005..35cbde8449a0 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -6,9 +6,6 @@ config CLKDEV_LOOKUP
 config HAVE_CLK_PREPARE
 	bool
 
-config HAVE_MACH_CLKDEV
-	bool
-
 config COMMON_CLK
 	bool
 	select HAVE_CLK_PREPARE
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
