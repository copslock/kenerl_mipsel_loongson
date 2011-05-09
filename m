Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 May 2011 18:48:33 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:45256 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491099Ab1EIQrj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 May 2011 18:47:39 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org
Subject: [PATCH 1/4] MIPS: lantiq: move IRQ_RES macro to a headerfile
Date:   Mon,  9 May 2011 18:49:07 +0200
Message-Id: <1304959750-8557-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1304959750-8557-1-git-send-email-blogic@openwrt.org>
References: <1304959750-8557-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

The IRQ_RES macro should be located at a place where other *.c files can easily
reuse it.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/lantiq/devices.c |    3 ---
 arch/mips/lantiq/devices.h |    3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/lantiq/devices.c b/arch/mips/lantiq/devices.c
index e758863..7b82c34 100644
--- a/arch/mips/lantiq/devices.c
+++ b/arch/mips/lantiq/devices.c
@@ -28,9 +28,6 @@
 
 #include "devices.h"
 
-#define IRQ_RES(resname, irq) \
-	{.name = #resname, .start = (irq), .flags = IORESOURCE_IRQ}
-
 /* nor flash */
 static struct resource ltq_nor_resource = {
 	.name	= "nor",
diff --git a/arch/mips/lantiq/devices.h b/arch/mips/lantiq/devices.h
index 069006c..2947bb1 100644
--- a/arch/mips/lantiq/devices.h
+++ b/arch/mips/lantiq/devices.h
@@ -12,6 +12,9 @@
 #include <lantiq_platform.h>
 #include <linux/mtd/physmap.h>
 
+#define IRQ_RES(resname, irq) \
+	{.name = #resname, .start = (irq), .flags = IORESOURCE_IRQ}
+
 extern void ltq_register_nor(struct physmap_flash_data *data);
 extern void ltq_register_wdt(void);
 extern void ltq_register_asc(int port);
-- 
1.7.2.3
