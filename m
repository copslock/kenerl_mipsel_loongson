Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2012 14:53:01 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:50397 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6870544Ab2JJMwtAoWgd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Oct 2012 14:52:49 +0200
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1TLvmK-0006Xd-00; Wed, 10 Oct 2012 14:52:48 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
        id 6FE621DB15; Wed, 10 Oct 2012 14:52:42 +0200 (CEST)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] Switch RM400 serial to SCCNXP driver
To:     linux-mips@linux-mips.org
cc:     ralf@linux-mips.org
Message-Id: <20121010125242.6FE621DB15@solo.franken.de>
Date:   Wed, 10 Oct 2012 14:52:42 +0200 (CEST)
X-archive-position: 34671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
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

The new SCCNXP driver supports the SC2681 chips used in RM400 machines.
We now use the new driver instead of the old SC26xx driver.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

Remark: This patch is against upstream-linus tree

 arch/mips/sni/a20r.c |   27 +++------------------------
 1 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/arch/mips/sni/a20r.c b/arch/mips/sni/a20r.c
index b2d4f49..9cb9d43 100644
--- a/arch/mips/sni/a20r.c
+++ b/arch/mips/sni/a20r.c
@@ -118,26 +118,6 @@ static struct resource sc26xx_rsrc[] = {
 	}
 };
 
-static unsigned int sc26xx_data[2] = {
-	/* DTR   |   RTS    |   DSR    |   CTS     |   DCD     |   RI    */
-	(8 << 0) | (4 << 4) | (6 << 8) | (0 << 12) | (6 << 16) | (0 << 20),
-	(3 << 0) | (2 << 4) | (1 << 8) | (2 << 12) | (3 << 16) | (4 << 20)
-};
-
-static struct platform_device sc26xx_pdev = {
-	.name           = "SC26xx",
-	.num_resources  = ARRAY_SIZE(sc26xx_rsrc),
-	.resource       = sc26xx_rsrc,
-	.dev			= {
-		.platform_data	= sc26xx_data,
-	}
-};
-
-#warning "Please try migrate to use new driver SCCNXP and report the status" \
-	 "in the linux-serial mailing list."
-
-/* The code bellow is a replacement of SC26XX to SCCNXP */
-#if 0
 #include <linux/platform_data/sccnxp.h>
 
 static struct sccnxp_pdata sccnxp_data = {
@@ -155,15 +135,14 @@ static struct sccnxp_pdata sccnxp_data = {
 			  MCTRL_SIG(RNG_IP, LINE_IP3),
 };
 
-static struct platform_device sc2681_pdev = {
+static struct platform_device sc26xx_pdev = {
 	.name		= "sc2681",
-	.resource	= sc2xxx_rsrc,
-	.num_resources	= ARRAY_SIZE(sc2xxx_rsrc),
+	.resource	= sc26xx_rsrc,
+	.num_resources	= ARRAY_SIZE(sc26xx_rsrc),
 	.dev	= {
 		.platform_data	= &sccnxp_data,
 	},
 };
-#endif
 
 static u32 a20r_ack_hwint(void)
 {
