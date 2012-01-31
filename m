Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 15:09:02 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:60354 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904020Ab2AaOIc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jan 2012 15:08:32 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id C0748352909;
        Tue, 31 Jan 2012 15:08:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PdiBjKP6w0zm; Tue, 31 Jan 2012 15:08:31 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 6612C1119D1;
        Tue, 31 Jan 2012 15:08:31 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 1/2] MIPS: BCM63XX: fix platform_devices id
Date:   Tue, 31 Jan 2012 15:08:07 +0100
Message-Id: <1328018888-5533-2-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1328018888-5533-1-git-send-email-florian@openwrt.org>
References: <1328018888-5533-1-git-send-email-florian@openwrt.org>
X-archive-position: 32346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

There is only one watchdog and VoIP DSP platform devices per board, use
-1 as the platform_device id accordingly.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/bcm63xx/dev-dsp.c |    2 +-
 arch/mips/bcm63xx/dev-wdt.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm63xx/dev-dsp.c b/arch/mips/bcm63xx/dev-dsp.c
index da46d1d..5bb5b15 100644
--- a/arch/mips/bcm63xx/dev-dsp.c
+++ b/arch/mips/bcm63xx/dev-dsp.c
@@ -31,7 +31,7 @@ static struct resource voip_dsp_resources[] = {
 
 static struct platform_device bcm63xx_voip_dsp_device = {
 	.name		= "bcm63xx-voip-dsp",
-	.id		= 0,
+	.id		= -1,
 	.num_resources	= ARRAY_SIZE(voip_dsp_resources),
 	.resource	= voip_dsp_resources,
 };
diff --git a/arch/mips/bcm63xx/dev-wdt.c b/arch/mips/bcm63xx/dev-wdt.c
index 3e6c716..2a2346a 100644
--- a/arch/mips/bcm63xx/dev-wdt.c
+++ b/arch/mips/bcm63xx/dev-wdt.c
@@ -21,7 +21,7 @@ static struct resource wdt_resources[] = {
 
 static struct platform_device bcm63xx_wdt_device = {
 	.name		= "bcm63xx-wdt",
-	.id		= 0,
+	.id		= -1,
 	.num_resources	= ARRAY_SIZE(wdt_resources),
 	.resource	= wdt_resources,
 };
-- 
1.7.5.4
