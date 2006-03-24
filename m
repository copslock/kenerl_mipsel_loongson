Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2006 20:36:45 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:20924 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133915AbWCXUgZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Mar 2006 20:36:25 +0000
Received: (qmail 28090 invoked from network); 25 Mar 2006 01:47:02 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 25 Mar 2006 01:47:02 -0000
Message-ID: <44245A3E.8070009@ru.mvista.com>
Date:	Fri, 24 Mar 2006 23:44:46 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux MIPS <linux-mips@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Au1550/1200: add missing PSC #define's and make OSS drivers use
 the proper ones
References: <4415B3EB.3010102@ru.mvista.com> <20060313183849.GL29879@cosmic.amd.com>
In-Reply-To: <20060313183849.GL29879@cosmic.amd.com>
Content-Type: multipart/mixed;
 boundary="------------060709020308000104000504"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------060709020308000104000504
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

     Add missing PSC #define's required for the drivers using PSC on DBAu1550
board (fixing PSC3 address for Au1550) and all Au1200-based boards as well.
Make OSS drivers use the correct PSC definitions fo each board.

WBR, Sergei

PS: Looks like this one is stuck too. Reposting with clear description.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------060709020308000104000504
Content-Type: text/plain;
 name="Au1550-Au1200-PSC-defs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Au1550-Au1200-PSC-defs.patch"

diff --git a/include/asm-mips/mach-au1x00/au1xxx_psc.h b/include/asm-mips/mach-au1x00/au1xxx_psc.h
index 8e5fb3c..faa5ffe 100644
--- a/include/asm-mips/mach-au1x00/au1xxx_psc.h
+++ b/include/asm-mips/mach-au1x00/au1xxx_psc.h
@@ -40,7 +40,12 @@
 #define PSC0_BASE_ADDR		0xb1a00000
 #define PSC1_BASE_ADDR		0xb1b00000
 #define PSC2_BASE_ADDR		0xb0a00000
-#define PSC3_BASE_ADDR		0xb0d00000
+#define PSC3_BASE_ADDR		0xb0b00000
+#endif
+
+#ifdef CONFIG_SOC_AU1200
+#define PSC0_BASE_ADDR		0xb1a00000
+#define PSC1_BASE_ADDR		0xb1b00000
 #endif
 
 /* The PSC select and control registers are common to
@@ -228,6 +233,8 @@ typedef struct	psc_i2s {
 #define PSC_I2SCFG_DD_DISABLE	(1 << 27)
 #define PSC_I2SCFG_DE_ENABLE	(1 << 26)
 #define PSC_I2SCFG_SET_WS(x)	(((((x) / 2) - 1) & 0x7f) << 16)
+#define PSC_I2SCFG_WS(n)	((n & 0xFF) << 16)
+#define PSC_I2SCFG_WS_MASK	(PSC_I2SCFG_WS(0x3F))
 #define PSC_I2SCFG_WI		(1 << 15)
 
 #define PSC_I2SCFG_DIV_MASK	(3 << 13)
diff --git a/include/asm-mips/mach-db1x00/db1x00.h b/include/asm-mips/mach-db1x00/db1x00.h
index 7b28b23..4bbfcaf 100644
--- a/include/asm-mips/mach-db1x00/db1x00.h
+++ b/include/asm-mips/mach-db1x00/db1x00.h
@@ -31,8 +31,20 @@
 #include <linux/config.h>
 
 #ifdef CONFIG_MIPS_DB1550
+
+#define DBDMA_AC97_TX_CHAN DSCR_CMD0_PSC1_TX
+#define DBDMA_AC97_RX_CHAN DSCR_CMD0_PSC1_RX
+#define DBDMA_I2S_TX_CHAN  DSCR_CMD0_PSC3_TX
+#define DBDMA_I2S_RX_CHAN  DSCR_CMD0_PSC3_RX
+
+#define SPI_PSC_BASE       PSC0_BASE_ADDR
+#define AC97_PSC_BASE      PSC1_BASE_ADDR
+#define SMBUS_PSC_BASE     PSC2_BASE_ADDR
+#define I2S_PSC_BASE       PSC3_BASE_ADDR
+
 #define BCSR_KSEG1_ADDR 0xAF000000
 #define NAND_PHYS_ADDR  0x20000000
+
 #else
 #define BCSR_KSEG1_ADDR 0xAE000000
 #endif
diff --git a/sound/oss/au1550_ac97.c b/sound/oss/au1550_ac97.c
index 64e2e46..fd40962 100644
--- a/sound/oss/au1550_ac97.c
+++ b/sound/oss/au1550_ac97.c
@@ -55,10 +55,9 @@
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/hardirq.h>
-#include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1xxx_psc.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
-#include <asm/mach-pb1x00/pb1550.h>
+#include <asm/mach-au1x00/au1xxx.h>
 
 #undef OSS_DOCUMENTED_MIXER_SEMANTICS
 
diff --git a/sound/oss/au1550_i2s.c b/sound/oss/au1550_i2s.c
index 529b625..8addad2 100644
--- a/sound/oss/au1550_i2s.c
+++ b/sound/oss/au1550_i2s.c
@@ -63,10 +63,9 @@
 #include <asm/uaccess.h>
 #include <asm/hardirq.h>
 
-#include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1xxx_psc.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
-#include <asm/mach-pb1x00/pb1550.h>
+#include <asm/mach-au1x00/au1xxx.h>
 
 #undef OSS_DOCUMENTED_MIXER_SEMANTICS
 




--------------060709020308000104000504--
