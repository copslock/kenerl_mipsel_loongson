Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Nov 2012 22:21:59 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:33484 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823062Ab2K0VVvpXv2s (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 27 Nov 2012 22:21:51 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 31B20B50E7F;
        Tue, 27 Nov 2012 22:21:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id m3NKGJL75Cr0; Tue, 27 Nov 2012 22:21:49 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id D5B7FB50E23;
        Tue, 27 Nov 2012 22:21:49 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     blogic@openwrt.org, linux-mips@linux-mips.org,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH] MIPS: AR7: use part_probe_types to specificy the partition parser to use
Date:   Tue, 27 Nov 2012 22:19:58 +0100
Message-Id: <1354051198-19554-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 35150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

This patch changes the physmap-flash platform data on AR7 to pass the
correct partition parser: ar7part to used by the "physmap-flash" mapping
driver so we get the partitions probed correctly.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/ar7/platform.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index 1bbc24b..7477fd21 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -202,8 +202,11 @@ static struct resource physmap_flash_resource = {
 	.end	= 0x107fffff,
 };
 
+static const char *ar7_probe_types[] = { "ar7part", NULL };
+
 static struct physmap_flash_data physmap_flash_data = {
 	.width	= 2,
+	.part_probe_types = ar7_probe_types,
 };
 
 static struct platform_device physmap_flash = {
-- 
1.7.10.4
