Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2011 19:43:12 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:53694 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491177Ab1JQRnG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Oct 2011 19:43:06 +0200
Received: by wyg8 with SMTP id 8so1968623wyg.36
        for <multiple recipients>; Mon, 17 Oct 2011 10:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=QEI7NqYxWsPFonW3RDDusrVTC8XzBo5Yh4vrhZ97MyA=;
        b=mQytI7Iv/IwJYXv0+zLVqMS558Q7urikQGpPzyqpXITdby0Yq/7EPg2Zou2uIyxwWr
         mRp+iXlNPJSm7TJHXhEXTCoNLgQo8uYAdslV6ED7Lc3Ub8EcN8fXuMiVSKGvuAc4uYdV
         ui4/kDkn21XAQg1jc07BrJzPH2V42C2BTMhAY=
Received: by 10.227.199.18 with SMTP id eq18mr6650360wbb.61.1318873380195;
        Mon, 17 Oct 2011 10:43:00 -0700 (PDT)
Received: from lenovo.localnet (fbx.mimichou.net. [82.247.4.1])
        by mx.google.com with ESMTPS id z9sm32337453wbn.19.2011.10.17.10.42.58
        (version=SSLv3 cipher=OTHER);
        Mon, 17 Oct 2011 10:42:59 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        Greg KH <gregkh@suse.de>
Subject: [PATCH] Revert "MIPS: MTX-1: Make au1000_eth probe all PHY
Date:   Mon, 17 Oct 2011 19:43:06 +0200
User-Agent: KMail/1.13.7 (Linux/3.1.0-rc7-amd64; KDE/4.6.5; x86_64; ; )
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201110171943.06143.florian@openwrt.org>
X-archive-position: 31247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12148

Commit ec3eb823 was not applicable in 2.6.32 and introduces a build breakage.
Revert that commit since it is irrelevant for this kernel version.

CC: stable@kernel.org
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Greg, this is applicable from 2.6.32+ to 2.6.33+ included.

diff --git a/arch/mips/alchemy/mtx-1/platform.c b/arch/mips/alchemy/mtx-1/platform.c
index 956f946..e30e42a 100644
--- a/arch/mips/alchemy/mtx-1/platform.c
+++ b/arch/mips/alchemy/mtx-1/platform.c
@@ -28,8 +28,6 @@
 #include <linux/mtd/physmap.h>
 #include <mtd/mtd-abi.h>
 
-#include <asm/mach-au1x00/au1xxx_eth.h>
-
 static struct gpio_keys_button mtx1_gpio_button[] = {
 	{
 		.gpio = 207,
@@ -142,17 +140,10 @@ static struct __initdata platform_device * mtx1_devs[] = {
 	&mtx1_mtd,
 };
 
-static struct au1000_eth_platform_data mtx1_au1000_eth0_pdata = {
-	.phy_search_highest_addr	= 1,
-	.phy1_search_mac0 		= 1,
-};
-
 static int __init mtx1_register_devices(void)
 {
 	int rc;
 
-	au1xxx_override_eth_cfg(0, &mtx1_au1000_eth0_pdata);
-
 	rc = gpio_request(mtx1_gpio_button[0].gpio,
 					mtx1_gpio_button[0].desc);
 	if (rc < 0) {
-- 
1.7.5.4
