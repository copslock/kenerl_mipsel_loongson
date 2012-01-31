Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 18:20:51 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:57804 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904029Ab2AaRTa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jan 2012 18:19:30 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 61EA44488F3;
        Tue, 31 Jan 2012 18:19:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id skt2pfyVmwvc; Tue, 31 Jan 2012 18:19:30 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 047AB44848A;
        Tue, 31 Jan 2012 18:19:30 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 2/6] MIPS: PNX833x: use IS_ENABLED() macro
Date:   Tue, 31 Jan 2012 18:19:04 +0100
Message-Id: <1328030348-21967-3-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1328030348-21967-1-git-send-email-florian@openwrt.org>
References: <1328030348-21967-1-git-send-email-florian@openwrt.org>
X-archive-position: 32369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/pnx833x/stb22x/board.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pnx833x/stb22x/board.c b/arch/mips/pnx833x/stb22x/board.c
index 644eb7c..4b328ac 100644
--- a/arch/mips/pnx833x/stb22x/board.c
+++ b/arch/mips/pnx833x/stb22x/board.c
@@ -91,7 +91,7 @@ void __init pnx833x_board_setup(void)
 	pnx833x_gpio_select_function_alt(32);
 	pnx833x_gpio_select_function_alt(33);
 
-#if defined(CONFIG_MTD_NAND_PLATFORM) || defined(CONFIG_MTD_NAND_PLATFORM_MODULE)
+#if IS_ENABLED(CONFIG_MTD_NAND_PLATFORM)
 	/* Setup MIU for NAND access on CS0...
 	 *
 	 * (it seems that we must also configure CS1 for reliable operation,
@@ -117,7 +117,7 @@ void __init pnx833x_board_setup(void)
 	pnx833x_gpio_select_output(5);
 	pnx833x_gpio_write(1, 5);
 
-#elif defined(CONFIG_MTD_CFI) || defined(CONFIG_MTD_CFI_MODULE)
+#elif IS_ENABLED(CONFIG_MTD_CFI)
 
 	/* Set up MIU for 16-bit NOR access on CS0 and CS1... */
 
-- 
1.7.5.4
