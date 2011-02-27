Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Feb 2011 19:54:10 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:52528 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491171Ab1B0SyD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 27 Feb 2011 19:54:03 +0100
Received: by fxm16 with SMTP id 16so3488527fxm.36
        for <multiple recipients>; Sun, 27 Feb 2011 10:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:subject:date:user-agent
         :organization:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=rwoiswuu8QGlYt3EaFXGvVl9iyrlxbL/ztNafgFuew0=;
        b=pKm9/LN4fR/ri3gI4lH0zZm5b9ejJpdC7H+ukI7ABHo2stdH37qaWpguA3X4sVIRu/
         hcQGj3bQvFqmdE02vZeLY929SCiQ3G4CsEytbuX7tLnQZ4KxZHKwiiGJy9BL64YAJeFU
         2xB1QdRJalJaNlGU25lZrXtAYTLqTTkXZBiQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:organization:mime-version
         :content-type:content-transfer-encoding:message-id;
        b=P8MfBSXrd7r7uQXFg0PvxTglwVTKGaPjUaf07k1S9o/Mpeh8a94urrBRkTpivsFm5W
         Ln4yorssSuG31wNTdBYYXeLJTNAdMZ14gTpkWWVXnyImqVreIQ5BJkhtOzlwn1e8HOfS
         63JlHi+MGqMKuDc2XC+qFCfwi8nkN+U7DyuOA=
Received: by 10.223.116.1 with SMTP id k1mr5503108faq.51.1298832837148;
        Sun, 27 Feb 2011 10:53:57 -0800 (PST)
Received: from bender.localnet (fbx.mimichou.net [82.236.225.16])
        by mx.google.com with ESMTPS id a6sm914159fak.1.2011.02.27.10.53.55
        (version=SSLv3 cipher=OTHER);
        Sun, 27 Feb 2011 10:53:56 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH] MTX-1: make au1000_eth probes all PHY addresses
Date:   Sun, 27 Feb 2011 19:53:53 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.35-25-generic; KDE/4.5.1; x86_64; ; )
Organization: OpenWrt
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201102271953.54065.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

From: Florian Fainelli <florian@openwrt.org>

When au1000_eth probes the MII bus for PHY address, if we do not set au1000_eth
platform data's phy_search_highest_address, the MII probing logic will exit
early and will assume a valid PHY is found at address 0. For MTX-1, the PHY is
at address 31, and without this patch, the link detection/speed/duplex would not
work correctly.

CC: stable@kernel.org
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Stable: 2.6.34+

diff --git a/arch/mips/alchemy/mtx-1/platform.c b/arch/mips/alchemy/mtx-1/platform.c
index e30e42a..956f946 100644
--- a/arch/mips/alchemy/mtx-1/platform.c
+++ b/arch/mips/alchemy/mtx-1/platform.c
@@ -28,6 +28,8 @@
 #include <linux/mtd/physmap.h>
 #include <mtd/mtd-abi.h>
 
+#include <asm/mach-au1x00/au1xxx_eth.h>
+
 static struct gpio_keys_button mtx1_gpio_button[] = {
 	{
 		.gpio = 207,
@@ -140,10 +142,17 @@ static struct __initdata platform_device * mtx1_devs[] = {
 	&mtx1_mtd,
 };
 
+static struct au1000_eth_platform_data mtx1_au1000_eth0_pdata = {
+	.phy_search_highest_addr	= 1,
+	.phy1_search_mac0 		= 1,
+};
+
 static int __init mtx1_register_devices(void)
 {
 	int rc;
 
+	au1xxx_override_eth_cfg(0, &mtx1_au1000_eth0_pdata);
+
 	rc = gpio_request(mtx1_gpio_button[0].gpio,
 					mtx1_gpio_button[0].desc);
 	if (rc < 0) {
-- 
1.7.1
