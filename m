Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 12:54:26 +0100 (CET)
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:55453 "EHLO
	gw02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492988AbZKWLyT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Nov 2009 12:54:19 +0100
Received: from localhost.localdomain (a88-114-232-190.elisa-laajakaista.fi [88.114.232.190])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id 22E211397CB;
	Mon, 23 Nov 2009 13:54:14 +0200 (EET)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Subject: [PATCH] [MIPS] Move several variables from .bss to .init.data
Date:	Mon, 23 Nov 2009 13:53:37 +0200
Message-Id: <1258977217-25461-1-git-send-email-dmitri.vorobiev@movial.com>
X-Mailer: git-send-email 1.6.3.3
Return-Path: <dmitri.vorobiev@movial.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25055
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.com
Precedence: bulk
X-list: linux-mips

Several static uninitialized variables are used in the scope of
__init functions but are themselves not marked as __initdata.
This patch is to put those variables to where they belong and
to reduce the memory footprint a little bit.

Also, a couple of lines with spaces instead of tabs were fixed.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
---
 arch/mips/ar7/platform.c        |    2 +-
 arch/mips/sgi-ip22/ip22-eisa.c  |    4 ++--
 arch/mips/sgi-ip22/ip22-setup.c |    2 +-
 arch/mips/sgi-ip32/ip32-setup.c |    2 +-
 arch/mips/sni/setup.c           |    2 +-
 arch/mips/txx9/generic/setup.c  |    2 +-
 arch/mips/txx9/rbtx4939/setup.c |    4 ++--
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index 835f3f0..85169c0 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -505,7 +505,7 @@ static int __init ar7_register_devices(void)
 	int res;
 	u32 *bootcr, val;
 #ifdef CONFIG_SERIAL_8250
-	static struct uart_port uart_port[2];
+	static struct uart_port uart_port[2] __initdata;
 
 	memset(uart_port, 0, sizeof(struct uart_port) * 2);
 
diff --git a/arch/mips/sgi-ip22/ip22-eisa.c b/arch/mips/sgi-ip22/ip22-eisa.c
index 1617241..da44ccb 100644
--- a/arch/mips/sgi-ip22/ip22-eisa.c
+++ b/arch/mips/sgi-ip22/ip22-eisa.c
@@ -50,9 +50,9 @@
 
 static char __init *decode_eisa_sig(unsigned long addr)
 {
-        static char sig_str[EISA_SIG_LEN];
+	static char sig_str[EISA_SIG_LEN] __initdata;
 	u8 sig[4];
-        u16 rev;
+	u16 rev;
 	int i;
 
 	for (i = 0; i < 4; i++) {
diff --git a/arch/mips/sgi-ip22/ip22-setup.c b/arch/mips/sgi-ip22/ip22-setup.c
index b9a9313..5deeb68 100644
--- a/arch/mips/sgi-ip22/ip22-setup.c
+++ b/arch/mips/sgi-ip22/ip22-setup.c
@@ -67,7 +67,7 @@ void __init plat_mem_setup(void)
 	cserial = ArcGetEnvironmentVariable("ConsoleOut");
 
 	if ((ctype && *ctype == 'd') || (cserial && *cserial == 's')) {
-		static char options[8];
+		static char options[8] __initdata;
 		char *baud = ArcGetEnvironmentVariable("dbaud");
 		if (baud)
 			strcpy(options, baud);
diff --git a/arch/mips/sgi-ip32/ip32-setup.c b/arch/mips/sgi-ip32/ip32-setup.c
index c5a5d4a..3abd146 100644
--- a/arch/mips/sgi-ip32/ip32-setup.c
+++ b/arch/mips/sgi-ip32/ip32-setup.c
@@ -90,7 +90,7 @@ void __init plat_mem_setup(void)
 	{
 		char* con = ArcGetEnvironmentVariable("console");
 		if (con && *con == 'd') {
-			static char options[8];
+			static char options[8] __initdata;
 			char *baud = ArcGetEnvironmentVariable("dbaud");
 			if (baud)
 				strcpy(options, baud);
diff --git a/arch/mips/sni/setup.c b/arch/mips/sni/setup.c
index a49272c..d16b462 100644
--- a/arch/mips/sni/setup.c
+++ b/arch/mips/sni/setup.c
@@ -60,7 +60,7 @@ static void __init sni_console_setup(void)
 	char *cdev;
 	char *baud;
 	int port;
-	static char options[8];
+	static char options[8] __initdata;
 
 	cdev = prom_getenv("console_dev");
 	if (strncmp(cdev, "tty", 3) == 0) {
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 06e801c..2cb8c49 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -664,7 +664,7 @@ void __init txx9_physmap_flash_init(int no, unsigned long addr,
 	};
 	struct platform_device *pdev;
 #ifdef CONFIG_MTD_PARTITIONS
-	static struct mtd_partition parts[2];
+	static struct mtd_partition parts[2] __initdata;
 	struct physmap_flash_data pdata_part;
 
 	/* If this area contained boot area, make separate partition */
diff --git a/arch/mips/txx9/rbtx4939/setup.c b/arch/mips/txx9/rbtx4939/setup.c
index b0c241e..64914d4 100644
--- a/arch/mips/txx9/rbtx4939/setup.c
+++ b/arch/mips/txx9/rbtx4939/setup.c
@@ -379,8 +379,8 @@ static void __init rbtx4939_mtd_init(void)
 		struct rbtx4939_flash_data data;
 	} pdevs[4];
 	int i;
-	static char names[4][8];
-	static struct mtd_partition parts[4];
+	static char names[4][8] __initdata;
+	static struct mtd_partition parts[4] __initdata;
 	struct rbtx4939_flash_data *boot_pdata = &pdevs[0].data;
 	u8 bdipsw = readb(rbtx4939_bdipsw_addr) & 0x0f;
 
-- 
1.6.3.3
