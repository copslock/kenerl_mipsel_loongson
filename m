Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2006 01:40:07 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:15878 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133654AbWCABjt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Mar 2006 01:39:49 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 7309D64D3D; Wed,  1 Mar 2006 01:47:31 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id F26EB81F5; Wed,  1 Mar 2006 02:47:23 +0100 (CET)
Date:	Wed, 1 Mar 2006 01:47:23 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Mark E Mason <mark.e.mason@broadcom.com>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] Offer Sibyte IDE driver only on platforms that have IDE
Message-ID: <20060301014723.GA16315@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

Mark, can you ack this patch?


[PATCH] Offer Sibyte IDE driver only on platforms that have IDE

Currently Kconfig allows you to select the Sibyte IDE driver on
any SB1 based SOC platform.  However, not all of them actually
have IDE.  Nor do they import the correct files needed to compile
the Sibyte (SWARM) IDE driver, leading to the compilation failure
below on a SB1A 1480 board.

The situation can be improved by adding a SIBYTE_HAS_IDE Kconfig
variable and change the dependency of the Sibyte IDE driver
accordingly.

  CC      drivers/ide/mips/swarm.o
drivers/ide/mips/swarm.c: In function ‘swarm_ide_probe’:
drivers/ide/mips/swarm.c:95: error: ‘A_PHYS_GENBUS’ undeclared (first use in this function)
drivers/ide/mips/swarm.c:95: error: (Each undeclared identifier is reported only once
drivers/ide/mips/swarm.c:95: error: for each function it appears in.)
drivers/ide/mips/swarm.c:95: error: ‘A_PHYS_GENBUS_END’ undeclared (first use in this function)
drivers/ide/mips/swarm.c:125: error: ‘K_INT_GPIO_0’ undeclared (first use
in this function)

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -619,6 +619,8 @@ config SIBYTE_SWARM
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SIBYTE_HAS_IDE
+	select SIBYTE_HAS_PCMCIA
 
 config SIBYTE_SENTOSA
 	bool "Support for Sibyte BCM91250E-Sentosa"
@@ -664,6 +666,8 @@ config SIBYTE_PTSWARM
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SIBYTE_HAS_IDE
+	select SIBYTE_HAS_PCMCIA
 
 config SIBYTE_LITTLESUR
 	bool "Support for Sibyte BCM91250C2-LittleSur"
@@ -676,6 +680,7 @@ config SIBYTE_LITTLESUR
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SIBYTE_HAS_IDE
 
 config SIBYTE_CRHINE
 	bool "Support for Sibyte BCM91120C-CRhine"
diff --git a/arch/mips/sibyte/Kconfig b/arch/mips/sibyte/Kconfig
index 816aee7..12712ef 100644
--- a/arch/mips/sibyte/Kconfig
+++ b/arch/mips/sibyte/Kconfig
@@ -95,6 +95,14 @@ config SIBYTE_HAS_LDT
 	depends on PCI && (SIBYTE_SB1250 || SIBYTE_BCM1125H)
 	default y
 
+config SIBYTE_HAS_IDE
+	bool
+	default n
+
+config SIBYTE_HAS_PCMCIA
+	bool
+	default n
+
 config SIMULATION
 	bool "Running under simulation"
 	depends on SIBYTE_SB1xxx_SOC
diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index d633081..91514c5 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -782,7 +782,7 @@ config BLK_DEV_IDE_PMAC_BLINK
 
 config BLK_DEV_IDE_SWARM
 	tristate "IDE for Sibyte evaluation boards"
-	depends on SIBYTE_SB1xxx_SOC
+	depends on SIBYTE_HAS_IDE
 
 config BLK_DEV_IDE_AU1XXX
        bool "IDE for AMD Alchemy Au1200"
diff --git a/drivers/ide/mips/swarm.c b/drivers/ide/mips/swarm.c
index 66f6064..55f77fc 100644
--- a/drivers/ide/mips/swarm.c
+++ b/drivers/ide/mips/swarm.c
@@ -33,8 +33,7 @@
  * other PCI devices, for example, will require swapping).  Any
  * SiByte-targetted kernel including IDE support will include this
  * file.  Probing of a Generic Bus for an IDE device is controlled by
- * the definition of "SIBYTE_HAVE_IDE", which is provided by
- * <asm/sibyte/board.h> for Broadcom boards.
+ * the definition of "SIBYTE_HAS_IDE".
  */
 
 #include <linux/ide.h>
@@ -71,9 +70,6 @@ static int __devinit swarm_ide_probe(str
 	phys_t offset, size;
 	int i;
 
-	if (!SIBYTE_HAVE_IDE)
-		return -ENODEV;
-
 	/* Find an empty slot.  */
 	for (i = 0; i < MAX_HWIFS; i++)
 		if (!ide_hwifs[i].io_ports[IDE_DATA_OFFSET])
diff --git a/include/asm-mips/sibyte/swarm.h b/include/asm-mips/sibyte/swarm.h
index 06e1d52..a560c4c 100644
--- a/include/asm-mips/sibyte/swarm.h
+++ b/include/asm-mips/sibyte/swarm.h
@@ -24,44 +24,34 @@
 
 #ifdef CONFIG_SIBYTE_SWARM
 #define SIBYTE_BOARD_NAME "BCM91250A (SWARM)"
-#define SIBYTE_HAVE_PCMCIA 1
-#define SIBYTE_HAVE_IDE    1
 #endif
 #ifdef CONFIG_SIBYTE_PTSWARM
 #define SIBYTE_BOARD_NAME "PTSWARM"
-#define SIBYTE_HAVE_PCMCIA 1
-#define SIBYTE_HAVE_IDE    1
 #define SIBYTE_DEFAULT_CONSOLE "ttyS0,115200"
 #endif
 #ifdef CONFIG_SIBYTE_LITTLESUR
 #define SIBYTE_BOARD_NAME "BCM91250C2 (LittleSur)"
-#define SIBYTE_HAVE_PCMCIA 0
-#define SIBYTE_HAVE_IDE    1
 #define SIBYTE_DEFAULT_CONSOLE "cfe0"
 #endif
 #ifdef CONFIG_SIBYTE_CRHONE
 #define SIBYTE_BOARD_NAME "BCM91125C (CRhone)"
-#define SIBYTE_HAVE_PCMCIA 0
-#define SIBYTE_HAVE_IDE    0
 #endif
 #ifdef CONFIG_SIBYTE_CRHINE
 #define SIBYTE_BOARD_NAME "BCM91120C (CRhine)"
-#define SIBYTE_HAVE_PCMCIA 0
-#define SIBYTE_HAVE_IDE    0
 #endif
 
 /* Generic bus chip selects */
 #define LEDS_CS         3
 #define LEDS_PHYS       0x100a0000
 
-#ifdef SIBYTE_HAVE_IDE
+#ifdef CONFIG_SIBYTE_HAS_IDE
 #define IDE_CS          4
 #define IDE_PHYS        0x100b0000
 #define K_GPIO_GB_IDE   4
 #define K_INT_GB_IDE    (K_INT_GPIO_0 + K_GPIO_GB_IDE)
 #endif
 
-#ifdef SIBYTE_HAVE_PCMCIA
+#ifdef CONFIG_SIBYTE_HAS_PCMCIA
 #define PCMCIA_CS       6
 #define PCMCIA_PHYS     0x11000000
 #define K_GPIO_PC_READY 9

-- 
Martin Michlmayr
http://www.cyrius.com/
