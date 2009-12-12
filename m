Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Dec 2009 17:57:50 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:51622 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493127AbZLLQ5q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Dec 2009 17:57:46 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id F186A341810B;
        Sat, 12 Dec 2009 17:57:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id icghIFP+iGM6; Sat, 12 Dec 2009 17:57:43 +0100 (CET)
Received: from lenovo.localnet (florian.mimichou.net [88.178.11.95])
        by zmc.proxad.net (Postfix) with ESMTPSA id 76DFD34180CD;
        Sat, 12 Dec 2009 17:57:43 +0100 (CET)
From:   Florian Fainelli <ffainelli@freebox.fr>
To:     linux-mips@linux-mips.org
Subject: [PATCH 1/2] bcm63xx: fix tabs/space damaged board_bcm963xx.c
Date:   Sat, 12 Dec 2009 17:57:39 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.30-2-686; KDE/4.3.2; i686; ; )
Organization: Freebox
Cc:     ralf@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200912121757.41116.ffainelli@freebox.fr>
Return-Path: <ffainelli@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ffainelli@freebox.fr
Precedence: bulk
X-list: linux-mips

This patch fixes a board definition which was tabs/space
damaged.

Signed-off-by: Florian Fainelli <ffainelli@freebox.fr>
---
diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 78e155d..94c8dd3 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -347,27 +347,26 @@ static struct board_info __initdata board_96348gw = {
 };
 
 static struct board_info __initdata board_FAST2404 = {
-        .name                           = "F@ST2404",
-        .expected_cpu_id                = 0x6348,
-
-        .has_enet0                      = 1,
-        .has_enet1                      = 1,
-        .has_pci                        = 1,
+	.name				= "F@ST2404",
+	.expected_cpu_id		= 0x6348,
 
-        .enet0 = {
-                .has_phy                = 1,
-                .use_internal_phy       = 1,
-        },
+	.has_enet0			= 1,
+	.has_enet1			= 1,
+	.has_pci			= 1,
 
-        .enet1 = {
-                .force_speed_100        = 1,
-                .force_duplex_full      = 1,
-        },
+	.enet0 = {
+		.has_phy		= 1,
+		.use_internal_phy	= 1,
+	},
 
+	.enet1 = {
+		.force_speed_100	= 1,
+		.force_duplex_full	= 1,
+	},
 
-        .has_ohci0 = 1,
-        .has_pccard = 1,
-        .has_ehci0 = 1,
+	.has_ohci0			= 1,
+	.has_pccard			= 1,
+	.has_ehci0			= 1,
 };
 
 static struct board_info __initdata board_DV201AMR = {
-- 
