Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2008 16:03:35 +0100 (BST)
Received: from smtp4.int-evry.fr ([157.159.10.71]:23441 "EHLO
	smtp4.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20030942AbYHVPD3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 22 Aug 2008 16:03:29 +0100
Received: from smtp2.int-evry.fr (smtp2.int-evry.fr [157.159.10.45])
	by smtp4.int-evry.fr (Postfix) with ESMTP id 03DA8FE2EE0;
	Fri, 22 Aug 2008 17:03:24 +0200 (CEST)
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp2.int-evry.fr (Postfix) with ESMTP id 07F223ED527;
	Fri, 22 Aug 2008 17:03:07 +0200 (CEST)
Received: from florian.headquarters.openpattern.org (headquarters.openpattern.org [82.240.17.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 0DD0B90004;
	Fri, 22 Aug 2008 17:03:07 +0200 (CEST)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Fri, 22 Aug 2008 17:03:03 +0200
Subject: [PATCH 5/5] rb532: fix id usage in platform devices
MIME-Version: 1.0
X-Length: 1778
To:	"linux-mips" <linux-mips@linux-mips.org>
Cc:	ralf@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200808221703.04223.florian@openwrt.org>
X-INT-MailScanner-Information: Please contact the ISP for more information
X-MailScanner-ID: 07F223ED527.7A2FF
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-SpamCheck: 
X-INT-MailScanner-From:	florian@openwrt.org
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

When there is only platform device of the same type, id = -1
should be used, fix this.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/rb532/devices.c b/arch/mips/rb532/devices.c
index 7090dc9..31619c6 100644
--- a/arch/mips/rb532/devices.c
+++ b/arch/mips/rb532/devices.c
@@ -84,7 +84,7 @@ static struct korina_device korina_dev0_data = {
 };
 
 static struct platform_device korina_dev0 = {
-	.id = 0,
+	.id = -1,
 	.name = "korina",
 	.dev.platform_data = &korina_dev0_data,
 	.resource = korina_dev0_res,
@@ -108,7 +108,7 @@ static struct cf_device cf_slot0_data = {
 };
 
 static struct platform_device cf_slot0 = {
-	.id = 0,
+	.id = -1,
 	.name = "pata-rb532-cf",
 	.dev.platform_data = &cf_slot0_data,
 	.resource = cf_slot0_res,
@@ -173,7 +173,7 @@ static struct mtd_partition rb532_partition_info[] = {
 
 static struct platform_device rb532_led = {
 	.name = "rb532-led",
-	.id = 0,
+	.id = -1,
 };
 
 static struct gpio_keys_button rb532_gpio_btn[] = {
