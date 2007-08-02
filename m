Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 12:24:11 +0100 (BST)
Received: from arrakis.dune.hu ([195.56.146.235]:46795 "EHLO arrakis.dune.hu")
	by ftp.linux-mips.org with ESMTP id S20022086AbXHBLYJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Aug 2007 12:24:09 +0100
Received: from localhost (localhost [127.0.0.1])
	by arrakis.dune.hu (Postfix) with ESMTP id 1504D7840C5;
	Thu,  2 Aug 2007 13:23:39 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from arrakis.dune.hu ([127.0.0.1])
	by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mjSwpKdOZtdr; Thu,  2 Aug 2007 13:23:35 +0200 (CEST)
Received: from ecaz.afh.b-m.hu (firewall.ahiv.hu [195.228.168.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by arrakis.dune.hu (Postfix) with ESMTP id 72FD57840B5;
	Thu,  2 Aug 2007 13:23:35 +0200 (CEST)
Date:	Thu, 02 Aug 2007 13:23:30 +0200
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Sync SiByte system code to the new DUART driver - try 2
From:	"Imre Kaloz" <kaloz@openwrt.org>
Organization: OpenWrt - Wireless Freedom
Cc:	"Ralf Baechle" <ralf@linux-mips.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-ID: <op.twfi9gbp2s3iss@ecaz.afh.b-m.hu>
Return-Path: <kaloz@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaloz@openwrt.org
Precedence: bulk
X-list: linux-mips

The new upstream SiByte DUART driver uses a different config option then
the old one, so the SiByte target doesn't compile currently.
This patch fixes the problem and also syncs the defconfig files.

Signed-off-by: Imre Kaloz <kaloz@openwrt.org>

---

  arch/mips/configs/bigsur_defconfig       |    4 ++--
  arch/mips/configs/sb1250-swarm_defconfig |    4 ++--
  arch/mips/sibyte/bcm1480/irq.c           |    4 ++--
  arch/mips/sibyte/cfe/console.c           |    2 +-
  arch/mips/sibyte/sb1250/irq.c            |    4 ++--
  5 files changed, 9 insertions(+), 9 deletions(-)


diff --git a/arch/mips/configs/bigsur_defconfig b/arch/mips/configs/bigsur_defconfig
index 67a80f4..700a3a2 100644
--- a/arch/mips/configs/bigsur_defconfig
+++ b/arch/mips/configs/bigsur_defconfig
@@ -663,8 +663,8 @@ CONFIG_MOXA_SMARTIO_NEW=m
  # CONFIG_SX is not set
  # CONFIG_RIO is not set
  # CONFIG_STALDRV is not set
-CONFIG_SIBYTE_SB1250_DUART=y
-CONFIG_SIBYTE_SB1250_DUART_CONSOLE=y
+CONFIG_SERIAL_SB1250_DUART=y
+CONFIG_SERIAL_SB1250_DUART_CONSOLE=y

  #
  # Serial drivers
diff --git a/arch/mips/configs/sb1250-swarm_defconfig b/arch/mips/configs/sb1250-swarm_defconfig
index e72fdf3..93f9e83 100644
--- a/arch/mips/configs/sb1250-swarm_defconfig
+++ b/arch/mips/configs/sb1250-swarm_defconfig
@@ -655,8 +655,8 @@ CONFIG_MOXA_SMARTIO_NEW=m
  # CONFIG_SX is not set
  # CONFIG_RIO is not set
  # CONFIG_STALDRV is not set
-CONFIG_SIBYTE_SB1250_DUART=y
-CONFIG_SIBYTE_SB1250_DUART_CONSOLE=y
+CONFIG_SERIAL_SB1250_DUART=y
+CONFIG_SERIAL_SB1250_DUART_CONSOLE=y

  #
  # Serial drivers
diff --git a/arch/mips/sibyte/bcm1480/irq.c b/arch/mips/sibyte/bcm1480/irq.c
index ba0c4b7..79ae6ef 100644
--- a/arch/mips/sibyte/bcm1480/irq.c
+++ b/arch/mips/sibyte/bcm1480/irq.c
@@ -76,7 +76,7 @@ __setup("nokgdb", nokgdb);

  /* Default to UART1 */
  int kgdb_port = 1;
-#ifdef CONFIG_SIBYTE_SB1250_DUART
+#ifdef CONFIG_SERIAL_SB1250_DUART
  extern char sb1250_duart_present[];
  #endif
  #endif
@@ -404,7 +404,7 @@ void __init arch_init_irq(void)
  	if (kgdb_flag) {
  		kgdb_irq = K_BCM1480_INT_UART_0 + kgdb_port;

-#ifdef CONFIG_SIBYTE_SB1250_DUART
+#ifdef CONFIG_SERIAL_SB1250_DUART
  		sb1250_duart_present[kgdb_port] = 0;
  #endif
  		/* Setup uart 1 settings, mapper */
diff --git a/arch/mips/sibyte/cfe/console.c b/arch/mips/sibyte/cfe/console.c
index c6ec748..4cec9d7 100644
--- a/arch/mips/sibyte/cfe/console.c
+++ b/arch/mips/sibyte/cfe/console.c
@@ -46,7 +46,7 @@ static int cfe_console_setup(struct console *cons, char *str)
  	/* XXXKW think about interaction with 'console=' cmdline arg */
  	/* If none of the console options are configured, the build will break. */
  	if (cfe_getenv("BOOT_CONSOLE", consdev, 32) >= 0) {
-#ifdef CONFIG_SIBYTE_SB1250_DUART
+#ifdef CONFIG_SERIAL_SB1250_DUART
  		if (!strcmp(consdev, "uart0")) {
  			setleds("u0cn");
  		} else if (!strcmp(consdev, "uart1")) {
diff --git a/arch/mips/sibyte/sb1250/irq.c b/arch/mips/sibyte/sb1250/irq.c
index 0e6a13c..ad593a6 100644
--- a/arch/mips/sibyte/sb1250/irq.c
+++ b/arch/mips/sibyte/sb1250/irq.c
@@ -61,7 +61,7 @@ static int kgdb_irq;

  /* Default to UART1 */
  int kgdb_port = 1;
-#ifdef CONFIG_SIBYTE_SB1250_DUART
+#ifdef CONFIG_SERIAL_SB1250_DUART
  extern char sb1250_duart_present[];
  #endif
  #endif
@@ -359,7 +359,7 @@ void __init arch_init_irq(void)
  	if (kgdb_flag) {
  		kgdb_irq = K_INT_UART_0 + kgdb_port;

-#ifdef CONFIG_SIBYTE_SB1250_DUART
+#ifdef CONFIG_SERIAL_SB1250_DUART
  		sb1250_duart_present[kgdb_port] = 0;
  #endif
  		/* Setup uart 1 settings, mapper */
