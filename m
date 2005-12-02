Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Dec 2005 18:52:40 +0000 (GMT)
Received: from amdext4.amd.com ([163.181.251.6]:11687 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133484AbVLBSwU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 2 Dec 2005 18:52:20 +0000
Received: from SAUSGW02.amd.com (sausgw02.amd.com [163.181.250.22])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id jB2Itsmw031880;
	Fri, 2 Dec 2005 12:55:54 -0600
Received: from 163.181.250.1 by SAUSGW02.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Fri, 02 Dec 2005 12:55:49 -0600
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint2.amd.com (8.12.8/8.12.8/AMD) with ESMTP id jB2ItmTw004426; Fri,
 2 Dec 2005 12:55:48 -0600 (CST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 0C7782026; Fri, 2 Dec 2005
 11:55:48 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id jB2J3Z0P031409; Fri, 2 Dec 2005 12:03:35
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id jB2J3ZVS031408; Fri, 2 Dec 2005 12:03:35 -0700
Date:	Fri, 2 Dec 2005 12:03:35 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Subject: [PATCH] ALCHEMY:  AU1200 I2C modifications
Message-ID: <20051202190335.GH28227@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F8E473F2MW515595-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

Modifications to the existing AU1XXX I2C controller for the Au1200.
Sending now to be included in the post 2.6.15 rush.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 arch/mips/au1000/db1x00/board_setup.c     |   37 +++++++++++++++++++++++++++++
 drivers/i2c/busses/Kconfig                |    2 +-
 drivers/i2c/busses/i2c-au1550.c           |   29 ++++++++++++++++++-----
 include/asm-mips/mach-au1x00/au1xxx_psc.h |    7 +++++
 4 files changed, 67 insertions(+), 8 deletions(-)

diff --git a/arch/mips/au1000/db1x00/board_setup.c b/arch/mips/au1000/db1x00/board_setup.c
index f00ec3b..a2638c8 100644
--- a/arch/mips/au1000/db1x00/board_setup.c
+++ b/arch/mips/au1000/db1x00/board_setup.c
@@ -76,6 +76,43 @@ void __init board_setup(void)
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
index 4010fe9..2a26b98 100644
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
index d06edce..4508629 100644
--- a/drivers/i2c/busses/i2c-au1550.c
+++ b/drivers/i2c/busses/i2c-au1550.c
@@ -35,7 +35,15 @@
 #include <linux/i2c.h>
 
 #include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-pb1x00/pb1550.h>
+#if defined(CONFIG_MIPS_PB1550)
+ #include <asm/mach-pb1x00/pb1550.h>
+#endif
+#if defined(CONFIG_MIPS_PB1200)
+ #include <asm/mach-pb1x00/pb1200.h>
+#endif
+#if defined(CONFIG_MIPS_DB1200)
+ #include <asm/mach-db1x00/db1200.h>
+#endif
 #include <asm/mach-au1x00/au1xxx_psc.h>
 
 #include "i2c-au1550.h"
@@ -118,13 +126,20 @@ do_address(struct i2c_au1550_data *adap,
 
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
@@ -367,7 +382,7 @@ static struct i2c_au1550_data pb1550_i2c
 	SMBUS_PSC_BASE, 200, 200
 };
 
-static struct i2c_adapter pb1550_board_adapter = {
+struct i2c_adapter pb1550_board_adapter = {
 	name:              "pb1550 adapter",
 	id:                I2C_HW_AU1550_PSC,
 	algo:              NULL,
@@ -376,6 +391,8 @@ static struct i2c_adapter pb1550_board_a
 	client_unregister: pb1550_unreg,
 };
 
+EXPORT_SYMBOL(pb1550_board_adapter);
+
 /* BIG hack to support the control interface on the Wolfson WM8731
  * audio codec on the Pb1550 board.  We get an address and two data
  * bytes to write, create an i2c message, and send it across the
diff --git a/include/asm-mips/mach-au1x00/au1xxx_psc.h b/include/asm-mips/mach-au1x00/au1xxx_psc.h
index 8e5fb3c..45a05c8 100644
--- a/include/asm-mips/mach-au1x00/au1xxx_psc.h
+++ b/include/asm-mips/mach-au1x00/au1xxx_psc.h
@@ -43,6 +43,11 @@
 #define PSC3_BASE_ADDR		0xb0d00000
 #endif
 
+#ifdef CONFIG_SOC_AU1200
+#define PSC0_BASE_ADDR         0xb1a00000
+#define PSC1_BASE_ADDR         0xb1b00000
+#endif
+
 /* The PSC select and control registers are common to
  * all protocols.
  */
@@ -506,7 +511,7 @@ typedef struct	psc_smb {
 
 /* Transmit register control.
 */
-#define PSC_SMBTXRX_RSR		(1 << 30)
+#define PSC_SMBTXRX_RSR		(1 << 28)
 #define PSC_SMBTXRX_STP		(1 << 29)
 #define PSC_SMBTXRX_DATAMASK	(0xff)
 
