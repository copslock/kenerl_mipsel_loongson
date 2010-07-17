Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Jul 2010 16:39:03 +0200 (CEST)
Received: from mail-out.m-online.net ([212.18.0.9]:34555 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491070Ab0GQOi4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Jul 2010 16:38:56 +0200
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
        by mail-out.m-online.net (Postfix) with ESMTP id 191751C15645
        for <linux-mips@linux-mips.org>; Sat, 17 Jul 2010 16:38:48 +0200 (CEST)
X-Auth-Info: rTDRGLuibTqJ83lFAcsBP4cv8UUAAwWmj8d6QwBV2vc=
Received: from mail.denx.de (host-82-135-33-74.customer.m-online.net [82.135.33.74])
        by smtp-auth.mnet-online.de (Postfix) with ESMTPA id ED9981C0033A
        for <linux-mips@linux-mips.org>; Sat, 17 Jul 2010 16:38:48 +0200 (CEST)
Received: from pollux.denx.de (pollux [192.168.1.1])
        by mail.denx.de (Postfix) with ESMTP id D5D46413AF3C
        for <linux-mips@linux-mips.org>; Sat, 17 Jul 2010 16:38:48 +0200 (CEST)
Received: by pollux.denx.de (Postfix, from userid 504)
        id 91F631010FAD2; Sat, 17 Jul 2010 16:38:48 +0200 (CEST)
From:   Wolfgang Grandegger <wg@grandegger.com>
To:     linux-mips@linux-mips.org
Cc:     Wolfgang Grandegger <wg@denx.de>
Subject: [PATCH] mips/alchemy: define eth platform devices in the correct order
Date:   Sat, 17 Jul 2010 16:38:48 +0200
Message-Id: <1279377528-3190-1-git-send-email-wg@grandegger.com>
X-Mailer: git-send-email 1.6.2.5
Return-Path: <wg@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wg@grandegger.com
Precedence: bulk
X-list: linux-mips

From: Wolfgang Grandegger <wg@denx.de>

Currently, the eth devices are probed in the inverse order, first
au1xxx_eth1_device and then au1xxx_eth0_device. On the GPR board,
this makes trouble:

  # ifconfig|grep HWaddr
  eth0      Link encap:Ethernet  HWaddr 00:50:C2:0C:30:01
  eth1      Link encap:Ethernet  HWaddr 66:22:01:80:38:10

A bogous ethernet hwaddr is assigned to the first device and
au1xxx_eth0_device is mapped to eth1, which even does not work
properly. With this patch, the problems are gone:

  # ifconfig|grep HWaddr
  eth0      Link encap:Ethernet  HWaddr 66:22:11:32:38:10
  eth1      Link encap:Ethernet  HWaddr 66:22:11:32:38:11

Signed-off-by: Wolfgang Grandegger <wg@denx.de>
---
 arch/mips/alchemy/common/platform.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 2580e77..f9e5622 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -435,20 +435,21 @@ static struct platform_device *au1xxx_platform_devices[] __initdata = {
 static int __init au1xxx_platform_init(void)
 {
 	unsigned int uartclk = get_au1x00_uart_baud_base() * 16;
-	int i;
+	int err, i;
 
 	/* Fill up uartclk. */
 	for (i = 0; au1x00_uart_data[i].flags; i++)
 		au1x00_uart_data[i].uartclk = uartclk;
 
+	err = platform_add_devices(au1xxx_platform_devices,
+				   ARRAY_SIZE(au1xxx_platform_devices));
 #ifndef CONFIG_SOC_AU1100
 	/* Register second MAC if enabled in pinfunc */
-	if (!(au_readl(SYS_PINFUNC) & (u32)SYS_PF_NI2))
+	if (!err && !(au_readl(SYS_PINFUNC) & (u32)SYS_PF_NI2))
 		platform_device_register(&au1xxx_eth1_device);
 #endif
 
-	return platform_add_devices(au1xxx_platform_devices,
-				    ARRAY_SIZE(au1xxx_platform_devices));
+	return err;
 }
 
 arch_initcall(au1xxx_platform_init);
-- 
1.6.2.5
