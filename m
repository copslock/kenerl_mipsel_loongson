Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 May 2006 16:28:25 +0200 (CEST)
Received: from amdext4.amd.com ([163.181.251.6]:63149 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133951AbWESO2N (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 19 May 2006 16:28:13 +0200
Received: from SAUSGW01.amd.com (sausgw01.amd.com [163.181.250.21])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k4JEQwjK012640;
	Fri, 19 May 2006 09:28:58 -0500
Received: from 163.181.22.101 by SAUSGW02.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Fri, 19 May 2006 09:28:01 -0500
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Received: from ldcmail.amd.com ([147.5.200.40]) by sausexbh1.amd.com
 with Microsoft SMTPSVC(6.0.3790.2499); Fri, 19 May 2006 09:27:58 -0500
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 98E3C2028; Fri, 19 May 2006
 08:27:55 -0600 (MDT)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k4JEWlxi023080; Fri, 19 May 2006 08:32:47
 -0600
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k4JEWljO023079; Fri, 19 May 2006 08:32:47
 -0600
Date:	Fri, 19 May 2006 08:32:47 -0600
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Clem Taylor" <clem.taylor@gmail.com>
cc:	linux-mips@linux-mips.org
Subject: Re: I2C troubles with Au1550
Message-ID: <20060519143247.GC9596@cosmic.amd.com>
References: <ecb4efd10605181454v34ef19degf2cdd2535b37fc30@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <ecb4efd10605181454v34ef19degf2cdd2535b37fc30@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 19 May 2006 14:27:58.0480 (UTC)
 FILETIME=[6D1C2900:01C67B50]
X-WSS-ID: 68730A7B27K397638-01-01
Content-Type: multipart/mixed;
 boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips


--5/uDoXvLw7AC5HRs
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On 18/05/06 17:54 -0400, Clem Taylor wrote:
> Maybe Jordan could try again with a fresh patch because it really does
> seem to help...
 
Here you go, fresh out of the oven.. :)

Jordan

---
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

--5/uDoXvLw7AC5HRs
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
 drivers/i2c/busses/i2c-au1550.c           |   29 ++++++++++++++++++-----
 include/asm-mips/mach-au1x00/au1xxx_psc.h |    7 +++++
 4 files changed, 67 insertions(+), 8 deletions(-)

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
index d06edce..4508629 100644
--- a/drivers/i2c/busses/i2c-au1550.c
+++ b/drivers/i2c/busses/i2c-au1550.c
@@ -35,7 +35,15 @@ #include <linux/errno.h>
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
index faa5ffe..a523079 100644
--- a/include/asm-mips/mach-au1x00/au1xxx_psc.h
+++ b/include/asm-mips/mach-au1x00/au1xxx_psc.h
@@ -48,6 +48,11 @@ #define PSC0_BASE_ADDR		0xb1a00000
 #define PSC1_BASE_ADDR		0xb1b00000
 #endif
 
+#ifdef CONFIG_SOC_AU1200
+#define PSC0_BASE_ADDR         0xb1a00000
+#define PSC1_BASE_ADDR         0xb1b00000
+#endif
+
 /* The PSC select and control registers are common to
  * all protocols.
  */
@@ -513,7 +518,7 @@ #define PSC_SMBEVNT_ALLCLR	(PSC_SMBEVNT_
 
 /* Transmit register control.
 */
-#define PSC_SMBTXRX_RSR		(1 << 30)
+#define PSC_SMBTXRX_RSR		(1 << 28)
 #define PSC_SMBTXRX_STP		(1 << 29)
 #define PSC_SMBTXRX_DATAMASK	(0xff)
 

--5/uDoXvLw7AC5HRs--
