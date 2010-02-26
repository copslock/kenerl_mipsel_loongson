Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Feb 2010 17:21:17 +0100 (CET)
Received: from mail-bw0-f215.google.com ([209.85.218.215]:64226 "EHLO
        mail-bw0-f215.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491816Ab0BZQVM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Feb 2010 17:21:12 +0100
Received: by bwz7 with SMTP id 7so214511bwz.24
        for <multiple recipients>; Fri, 26 Feb 2010 08:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=faevTyH3enUe4WmghMHUmbnnHWZOPODBgl1VFIeTIDY=;
        b=Y32Rq0GUKcWQLyWpJqB5vv/d2kdK+Yjg0WmQ0Zu1v0qanj7McmXgJqwW/IXWH1MjGD
         5pkwecxGCHPo+ZvkC14aZWPPYCaySmvAQsYOQ61f4/N2l1uw3/ntq7yzPsppgOGmZUi0
         R0GE6kPpktoiGG1Uc7SO4pQMocRNNzAPpiJCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hS/PHnjiCjs/swFxBzwFnwQlq9Ik3tlfhCQRM9UJw165vkfTf0fr7GJkgdD1MxZhi+
         mzpYxv46pwUUc/IrfjbF51Lc7Mti2i2cgURh/26IJey11/MDzt1ZyxTlHXZgZSiZhLGW
         1j0nN/uEekaEeuqlKlnfuL2Aa60cU2q5yvphY=
Received: by 10.204.32.206 with SMTP id e14mr458845bkd.45.1267201265415;
        Fri, 26 Feb 2010 08:21:05 -0800 (PST)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id 15sm147563bwz.8.2010.02.26.08.21.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Feb 2010 08:21:04 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 1/2] MIPS: Alchemy: Repair db1500/bosporus builds
Date:   Fri, 26 Feb 2010 17:22:01 +0100
Message-Id: <1267201322-28069-2-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.7.0
In-Reply-To: <1267201322-28069-1-git-send-email-manuel.lauss@gmail.com>
References: <1267201322-28069-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

A few hunks somehow ended up outside their #ifdef/endif blocks,
leading to -Werror-induces build failures.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/devboards/db1x00/board_setup.c |   52 ++++++++++++----------
 1 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1x00/board_setup.c b/arch/mips/alchemy/devboards/db1x00/board_setup.c
index 559d9b2..50c9bef 100644
--- a/arch/mips/alchemy/devboards/db1x00/board_setup.c
+++ b/arch/mips/alchemy/devboards/db1x00/board_setup.c
@@ -46,19 +46,25 @@ char irq_tab_alchemy[][5] __initdata = {
 	[13] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, AU1500_PCI_INTC, AU1500_PCI_INTD }, /* IDSEL 13 - PCI slot */
 };
 
-static void bosporus_power_off(void)
-{
-	printk(KERN_INFO "It's now safe to turn off power\n");
-	while (1)
-		asm volatile (".set mips3 ; wait ; .set mips0");
-}
+#endif
 
-const char *get_system_type(void)
-{
-	return "Alchemy Bosporus Gateway Reference";
-}
+
+#ifdef CONFIG_MIPS_DB1550
+char irq_tab_alchemy[][5] __initdata = {
+	[11] = { -1, AU1550_PCI_INTC, 0xff, 0xff, 0xff }, /* IDSEL 11 - on-board HPT371 */
+	[12] = { -1, AU1550_PCI_INTB, AU1550_PCI_INTC, AU1550_PCI_INTD, AU1550_PCI_INTA }, /* IDSEL 12 - PCI slot 2 (left) */
+	[13] = { -1, AU1550_PCI_INTA, AU1550_PCI_INTB, AU1550_PCI_INTC, AU1550_PCI_INTD }, /* IDSEL 13 - PCI slot 1 (right) */
+};
 #endif
 
+
+#ifdef CONFIG_MIPS_BOSPORUS
+char irq_tab_alchemy[][5] __initdata = {
+	[11] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, 0xff, 0xff }, /* IDSEL 11 - miniPCI  */
+	[12] = { -1, AU1500_PCI_INTA, 0xff, 0xff, 0xff }, /* IDSEL 12 - SN1741   */
+	[13] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, AU1500_PCI_INTC, AU1500_PCI_INTD }, /* IDSEL 13 - PCI slot */
+};
+
 /*
  * Micrel/Kendin 5 port switch attached to MAC0,
  * MAC0 is associated with PHY address 5 (== WAN port)
@@ -71,16 +77,20 @@ static struct au1000_eth_platform_data eth0_pdata = {
 	.phy_addr		= 5,
 };
 
-#ifdef CONFIG_MIPS_BOSPORUS
-char irq_tab_alchemy[][5] __initdata = {
-	[11] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, 0xff, 0xff }, /* IDSEL 11 - miniPCI  */
-	[12] = { -1, AU1500_PCI_INTA, 0xff, 0xff, 0xff }, /* IDSEL 12 - SN1741   */
-	[13] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, AU1500_PCI_INTC, AU1500_PCI_INTD }, /* IDSEL 13 - PCI slot */
-};
-
+static void bosporus_power_off(void)
+{
+	printk(KERN_INFO "It's now safe to turn off power\n");
+	while (1)
+		asm volatile (".set mips3 ; wait ; .set mips0");
+}
 
+const char *get_system_type(void)
+{
+	return "Alchemy Bosporus Gateway Reference";
+}
 #endif
 
+
 #ifdef CONFIG_MIPS_MIRAGE
 char irq_tab_alchemy[][5] __initdata = {
 	[11] = { -1, AU1500_PCI_INTD, 0xff, 0xff, 0xff }, /* IDSEL 11 - SMI VGX */
@@ -99,13 +109,6 @@ const char *get_system_type(void)
 }
 #endif
 
-#ifdef CONFIG_MIPS_DB1550
-char irq_tab_alchemy[][5] __initdata = {
-	[11] = { -1, AU1550_PCI_INTC, 0xff, 0xff, 0xff }, /* IDSEL 11 - on-board HPT371 */
-	[12] = { -1, AU1550_PCI_INTB, AU1550_PCI_INTC, AU1550_PCI_INTD, AU1550_PCI_INTA }, /* IDSEL 12 - PCI slot 2 (left) */
-	[13] = { -1, AU1550_PCI_INTA, AU1550_PCI_INTB, AU1550_PCI_INTC, AU1550_PCI_INTD }, /* IDSEL 13 - PCI slot 1 (right) */
-};
-#endif
 
 #if defined(CONFIG_MIPS_BOSPORUS) || defined(CONFIG_MIPS_MIRAGE)
 static void mips_softreset(void)
@@ -121,6 +124,7 @@ const char *get_system_type(void)
 }
 #endif
 
+
 void __init board_setup(void)
 {
 	unsigned long bcsr1, bcsr2;
-- 
1.7.0
