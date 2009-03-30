Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Mar 2009 20:55:26 +0100 (BST)
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:42903 "EHLO
	gw02.mail.saunalahti.fi") by ftp.linux-mips.org with ESMTP
	id S20034141AbZC3Txy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Mar 2009 20:53:54 +0100
Received: from localhost.localdomain (a88-114-245-69.elisa-laajakaista.fi [88.114.245.69])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id DF022139601;
	Mon, 30 Mar 2009 22:53:50 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Subject: [PATCH 4/4] [MIPS] gbe: make needlessly global symbols static in drivers/video/gbefb.c
Date:	Mon, 30 Mar 2009 22:53:26 +0300
Message-Id: <1238442806-11013-5-git-send-email-dmitri.vorobiev@movial.com>
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1238442806-11013-1-git-send-email-dmitri.vorobiev@movial.com>
References: <1238442806-11013-1-git-send-email-dmitri.vorobiev@movial.com>
Return-Path: <dmitri.vorobiev@movial.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.com
Precedence: bulk
X-list: linux-mips

The following symbols are needlessly defined global:

default_mode
default_var
gbe_mem_phys
gbe_turn_off
gbefb_exit
gbefb_init
gbefb_setup

This error was noticed by namespacecheck when compiling ip32_defconfig.

This patch makes the symbols static.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
---
 drivers/video/gbefb.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/video/gbefb.c b/drivers/video/gbefb.c
index fe5b519..1a83709 100644
--- a/drivers/video/gbefb.c
+++ b/drivers/video/gbefb.c
@@ -75,7 +75,7 @@ struct gbefb_par {
 static unsigned int gbe_mem_size = CONFIG_FB_GBE_MEM * 1024*1024;
 static void *gbe_mem;
 static dma_addr_t gbe_dma_addr;
-unsigned long gbe_mem_phys;
+static unsigned long gbe_mem_phys;
 
 static struct {
 	uint16_t *cpu;
@@ -185,8 +185,8 @@ static struct fb_videomode default_mode_LCD __initdata = {
 	.vmode		= FB_VMODE_NONINTERLACED,
 };
 
-struct fb_videomode *default_mode __initdata = &default_mode_CRT;
-struct fb_var_screeninfo *default_var __initdata = &default_var_CRT;
+static struct fb_videomode *default_mode __initdata = &default_mode_CRT;
+static struct fb_var_screeninfo *default_var __initdata = &default_var_CRT;
 
 static int flat_panel_enabled = 0;
 
@@ -205,7 +205,7 @@ static void gbe_reset(void)
  *              console.
  */
 
-void gbe_turn_off(void)
+static void gbe_turn_off(void)
 {
 	int i;
 	unsigned int val, x, y, vpixen_off;
@@ -1097,7 +1097,7 @@ static void gbefb_create_sysfs(struct device *dev)
  * Initialization
  */
 
-int __init gbefb_setup(char *options)
+static int __init gbefb_setup(char *options)
 {
 	char *this_opt;
 
@@ -1283,7 +1283,7 @@ static struct platform_driver gbefb_driver = {
 
 static struct platform_device *gbefb_device;
 
-int __init gbefb_init(void)
+static int __init gbefb_init(void)
 {
 	int ret = platform_driver_register(&gbefb_driver);
 	if (!ret) {
@@ -1301,7 +1301,7 @@ int __init gbefb_init(void)
 	return ret;
 }
 
-void __exit gbefb_exit(void)
+static void __exit gbefb_exit(void)
 {
 	platform_device_unregister(gbefb_device);
 	platform_driver_unregister(&gbefb_driver);
-- 
1.5.6.3
