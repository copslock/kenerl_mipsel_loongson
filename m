Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 May 2006 19:03:17 +0200 (CEST)
Received: from amdext4.amd.com ([163.181.251.6]:14798 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133951AbWESRDI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 19 May 2006 19:03:08 +0200
Received: from SAUSGW02.amd.com (sausgw02.amd.com [163.181.250.22])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k4JH3n3j003262;
	Fri, 19 May 2006 12:03:54 -0500
Received: from 163.181.22.101 by SAUSGW02.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Fri, 19 May 2006 12:03:00 -0500
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Received: from ldcmail.amd.com ([147.5.200.40]) by sausexbh1.amd.com
 with Microsoft SMTPSVC(6.0.3790.2499); Fri, 19 May 2006 12:02:56 -0500
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 9DC7B202D; Fri, 19 May 2006
 11:02:53 -0600 (MDT)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k4JH7rcN024807; Fri, 19 May 2006 11:07:53
 -0600
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k4JH7rMq024806; Fri, 19 May 2006 11:07:53
 -0600
Date:	Fri, 19 May 2006 11:07:53 -0600
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Clem Taylor" <clem.taylor@gmail.com>
cc:	linux-mips@linux-mips.org
Subject: [PATCH] I2C:  Add Au1200 I2C support
Message-ID: <20060519170753.GE9596@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 19 May 2006 17:02:56.0855 (UTC)
 FILETIME=[135F9670:01C67B66]
X-WSS-ID: 687325CE27K430572-01-01
Content-Type: multipart/mixed;
 boundary=xesSdrSSBC0PokLI
Content-Disposition: inline
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips


--xesSdrSSBC0PokLI
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Another try.. now without redundant declarations.

Jordan

--xesSdrSSBC0PokLI
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=i2c.patch
Content-Transfer-Encoding: 7bit

ALCHEMY:  AU1200 I2C modifications

From: Jordan Crouse <jordan.crouse@amd.com>

Modifications to the existing AU1XXX I2C controller for the Au1200.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 arch/mips/au1000/db1x00/board_setup.c     |   37 +++++++++++++++++++++++++++++
 drivers/i2c/busses/Kconfig                |    2 +-
 drivers/i2c/busses/i2c-au1550.c           |   22 ++++++++++++-----
 include/asm-mips/mach-au1x00/au1xxx_psc.h |    2 +-
 4 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/arch/mips/au1000/db1x00/board_setup.c b/arch/mips/au1000/db1x00/board_setup.c
index f00ec3b..a2638c8 100644
--- a/arch/mips/au1000/db1x00/board_setup.c
+++ b/arch/mips/au1000/db1x00/board_setup.c
@@ -76,6 +76,43 @@ #if defined(CONFIG_IRDA) && (defined(CON
 #endif
 	bcsr->pcmcia = 0x0000; /* turn off PCMCIA power */
 
+#if defined(CONFIG_I2C_AU1550) && defined(CONFIG_MIPS_DB1200)
+	{
+	u32 freq0, clksrc;
+
+	/* Select SMBUS in CPLD */
+	bcsr->resets &= ~(BCSR_RESETS_PCS0MUX);
+
+	pin_func = au_readl(SYS_PINFUNC);
+	au_sync();
+	pin_func &= ~(3<<17 | 1<<4);
+	/* Set GPIOs correctly */
+	pin_func |= 2<<17;
+	au_writel(pin_func, SYS_PINFUNC);
+	au_sync();
+
+	/* The i2c driver depends on 50Mhz clock */
+	freq0 = au_readl(SYS_FREQCTRL0);
+	au_sync();
+	freq0 &= ~(SYS_FC_FRDIV1_MASK | SYS_FC_FS1 | SYS_FC_FE1);
+	freq0 |= (3<<SYS_FC_FRDIV1_BIT);
+	/* 396Mhz / (3+1)*2 == 49.5Mhz */
+	au_writel(freq0, SYS_FREQCTRL0);
+	au_sync();
+	freq0 |= SYS_FC_FE1;
+	au_writel(freq0, SYS_FREQCTRL0);
+	au_sync();
+
+	clksrc = au_readl(SYS_CLKSRC);
+	au_sync();
+	clksrc &= ~0x01f00000;
+	/* bit 22 is EXTCLK0 for PSC0 */
+	clksrc |= (0x3 << 22);
+	au_writel(clksrc, SYS_CLKSRC);
+	au_sync();
+	}
+#endif
+
 #ifdef CONFIG_MIPS_MIRAGE
 	/* enable GPIO[31:0] inputs */
 	au_writel(0, SYS_PININPUTEN);
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index d6d4494..e023563 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -76,7 +76,7 @@ config I2C_AMD8111
 
 config I2C_AU1550
 	tristate "Au1550 SMBus interface"
-	depends on I2C && SOC_AU1550
+	depends on I2C && (SOC_AU1550 || SOC_AU1200)
 	help
 	  If you say yes to this option, support will be included for the
 	  Au1550 SMBus interface.
diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
index d06edce..368fd96 100644
--- a/drivers/i2c/busses/i2c-au1550.c
+++ b/drivers/i2c/busses/i2c-au1550.c
@@ -34,8 +34,7 @@ #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/i2c.h>
 
-#include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-pb1x00/pb1550.h>
+#include <asm/mach-au1x00/au1xxx.h>
 #include <asm/mach-au1x00/au1xxx_psc.h>
 
 #include "i2c-au1550.h"
@@ -118,13 +117,20 @@ do_address(struct i2c_au1550_data *adap,
 
 	/* Reset the FIFOs, clear events.
 	*/
-	sp->psc_smbpcr = PSC_SMBPCR_DC;
+	stat = sp->psc_smbstat;
 	sp->psc_smbevnt = PSC_SMBEVNT_ALLCLR;
 	au_sync();
-	do {
-		stat = sp->psc_smbpcr;
+
+	if (!(stat & PSC_SMBSTAT_TE) || !(stat & PSC_SMBSTAT_RE))
+	{
+		sp->psc_smbpcr = PSC_SMBPCR_DC;
 		au_sync();
-	} while ((stat & PSC_SMBPCR_DC) != 0);
+		do {
+			stat = sp->psc_smbpcr;
+			au_sync();
+		} while ((stat & PSC_SMBPCR_DC) != 0);
+		udelay(50);
+	}
 
 	/* Write out the i2c chip address and specify operation
 	*/
@@ -367,7 +373,7 @@ static struct i2c_au1550_data pb1550_i2c
 	SMBUS_PSC_BASE, 200, 200
 };
 
-static struct i2c_adapter pb1550_board_adapter = {
+struct i2c_adapter pb1550_board_adapter = {
 	name:              "pb1550 adapter",
 	id:                I2C_HW_AU1550_PSC,
 	algo:              NULL,
@@ -376,6 +382,8 @@ static struct i2c_adapter pb1550_board_a
 	client_unregister: pb1550_unreg,
 };
 
+EXPORT_SYMBOL(pb1550_board_adapter);
+
 /* BIG hack to support the control interface on the Wolfson WM8731
  * audio codec on the Pb1550 board.  We get an address and two data
  * bytes to write, create an i2c message, and send it across the
diff --git a/include/asm-mips/mach-au1x00/au1xxx_psc.h b/include/asm-mips/mach-au1x00/au1xxx_psc.h
index faa5ffe..c097ac3 100644
--- a/include/asm-mips/mach-au1x00/au1xxx_psc.h
+++ b/include/asm-mips/mach-au1x00/au1xxx_psc.h
@@ -513,7 +513,7 @@ #define PSC_SMBEVNT_ALLCLR	(PSC_SMBEVNT_
 
 /* Transmit register control.
 */
-#define PSC_SMBTXRX_RSR		(1 << 30)
+#define PSC_SMBTXRX_RSR		(1 << 28)
 #define PSC_SMBTXRX_STP		(1 << 29)
 #define PSC_SMBTXRX_DATAMASK	(0xff)
 

--xesSdrSSBC0PokLI--
