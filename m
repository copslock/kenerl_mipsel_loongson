Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jun 2012 10:28:25 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:49433 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903642Ab2FLIYn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Jun 2012 10:24:43 +0200
Received: by mail-bk0-f49.google.com with SMTP id j4so5334481bkw.36
        for <multiple recipients>; Tue, 12 Jun 2012 01:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=V+33AX4HD+wBdtlZ70NqNIS/Z+qcKFcwS3zXYN4+9iQ=;
        b=WZNrzMzqE348udlxfQznIQatK2b6pOm+kpTQl9twd4Scs/mcozkoIGQ9qBsDPm737+
         ce14SXUYB+jtpqod8PXxVrM9mXALX5rSyFfg80KSbMIcQpZmawaO4lyBbM4K3uRYXoYO
         wJfT+jicQwHC9ZIeXf65TTt3Lqm68+SbntUsye0HjPoNPfPomF3PuyqpDHJOXmJ8cVHc
         FFXTrwqiBQrQVAt2P/r1j0sUTHSBAVlNK/L+1IgiMxCivG1/X15SavukZQr2J53F1/sr
         lrmRqxpgeXq7adOgClBkAO5ywDm76dD0jgLa+ABWnqlnYmEgnnMhCTmBvdmUec6r2Pwo
         GHYg==
Received: by 10.204.145.78 with SMTP id c14mr11231806bkv.43.1339489482791;
        Tue, 12 Jun 2012 01:24:42 -0700 (PDT)
Received: from shaker64.lan (dslb-088-073-055-195.pools.arcor-ip.net. [88.73.55.195])
        by mx.google.com with ESMTPS id h18sm19177912bkh.8.2012.06.12.01.24.41
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jun 2012 01:24:42 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 8/8] MIPS: BCM63XX: add 96328avng reference board
Date:   Tue, 12 Jun 2012 10:23:45 +0200
Message-Id: <1339489425-19037-9-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1339489425-19037-1-git-send-email-jonas.gorski@gmail.com>
References: <1339489425-19037-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 33618
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

This allows booting to command line. Ethernet is not supported yet,
but PCIe connected wireless should work.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/boards/board_bcm963xx.c |   45 +++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index be7498a..feb0525 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -33,6 +33,48 @@ static unsigned int mac_addr_used;
 static struct board_info board;
 
 /*
+ * known 6328 boards
+ */
+#ifdef CONFIG_BCM63XX_CPU_6328
+static struct board_info __initdata board_96328avng = {
+	.name				= "96328avng",
+	.expected_cpu_id		= 0x6328,
+
+	.has_uart0			= 1,
+	.has_pci			= 1,
+
+	.leds = {
+		{
+			.name		= "96328avng::ppp-fail",
+			.gpio		= 2,
+			.active_low	= 1,
+		},
+		{
+			.name		= "96328avng::power",
+			.gpio		= 4,
+			.active_low	= 1,
+			.default_trigger = "default-on",
+		},
+		{
+			.name		= "96328avng::power-fail",
+			.gpio		= 8,
+			.active_low	= 1,
+		},
+		{
+			.name		= "96328avng::wps",
+			.gpio		= 9,
+			.active_low	= 1,
+		},
+		{
+			.name		= "96328avng::ppp",
+			.gpio		= 11,
+			.active_low	= 1,
+		},
+	},
+};
+#endif
+
+/*
  * known 6338 boards
  */
 #ifdef CONFIG_BCM63XX_CPU_6338
@@ -591,6 +633,9 @@ static struct board_info __initdata board_DWVS0 = {
  * all boards
  */
 static const struct board_info __initdata *bcm963xx_boards[] = {
+#ifdef CONFIG_BCM63XX_CPU_6328
+	&board_96328avng,
+#endif
 #ifdef CONFIG_BCM63XX_CPU_6338
 	&board_96338gw,
 	&board_96338w,
-- 
1.7.2.5
