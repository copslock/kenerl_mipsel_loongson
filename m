Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Apr 2008 20:19:57 +0100 (BST)
Received: from rtsoft3.corbina.net ([85.21.88.6]:53697 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S30617806AbYD3TTe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 30 Apr 2008 20:19:34 +0100
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 371A58815; Thu,  1 May 2008 00:19:13 +0500 (SAMST)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH 1/11] Alchemy common headers style cleanup
Date:	Wed, 30 Apr 2008 23:18:35 +0400
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200804302318.35039.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19055
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Fix several errors and warnings given by checkpatch.pl:

- space after opening and before closing parentheses;

- opening brace following 'struct' not on the same line;

- leading spaces instead of tabs;

- use of C99 // comments;

- macros with complex values not enclosed in parentheses;

- missing space between the type and asterisk in a variable declaration;

- space between asterisk and function name;

- including <asm/io.h> instead of <linux/io.h> and <asm/irq.h> instead of
  <linux/irq.h>;

- use of '__inline__' instead of 'inline';

- space between function name and opening parenthesis;

- line over 80 characters.

In addition to these changes, also do the following:

- remove needless parentheses;

- insert spaces between operator and its operands;

- replace spaces after the macro name with tabs in the #define directives and
  after the type in the structure field declarations;

- remove excess tabs after the macro name in the #define directives and in the
  'extern' variable declarations;

- remove excess spaces between # and define for the SSI_*_MASK macros to align
  with other such macros;

- put '||' operator on the same line with its first operand;

- properly indent multi-line function prototypes;

- make the multi-line comment style consistent with the kernel style elsewhere
  by adding empty first line and/or adding space/asterisk on their left side;

- make two-line comments that only have one line of text one-line;

- convert the large multi-line comment in au1xxx_ide.h into several one-liners,
  replace spaces with tabs there;

- fix typos/errors, capitalize acronyms, etc. in the comments;

- insert missing and remove excess new lines;

- update MontaVista copyright;

- remove Pete Popov's and Steve Longerbeam's old email addresses...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 include/asm-mips/mach-au1x00/au1000.h       | 1680 +++++++++++++---------------
 include/asm-mips/mach-au1x00/au1000_dma.h   |  177 +-
 include/asm-mips/mach-au1x00/au1000_gpio.h  |   18 
 include/asm-mips/mach-au1x00/au1550_spi.h   |    2 
 include/asm-mips/mach-au1x00/au1xxx.h       |    4 
 include/asm-mips/mach-au1x00/au1xxx_dbdma.h |  155 +-
 include/asm-mips/mach-au1x00/au1xxx_ide.h   |  253 ++--
 include/asm-mips/mach-au1x00/au1xxx_psc.h   |  129 --
 8 files changed, 1192 insertions(+), 1226 deletions(-)

Index: linux-2.6/include/asm-mips/mach-au1x00/au1000.h
===================================================================
--- linux-2.6.orig/include/asm-mips/mach-au1x00/au1000.h
+++ linux-2.6/include/asm-mips/mach-au1x00/au1000.h
@@ -40,8 +40,8 @@
 #include <linux/delay.h>
 #include <linux/types.h>
 
-#include <asm/io.h>
-#include <asm/irq.h>
+#include <linux/io.h>
+#include <linux/irq.h>
 
 /* cpu pipeline flush */
 void static inline au_sync(void)
@@ -63,32 +63,32 @@ void static inline au_sync_delay(int ms)
 
 void static inline au_writeb(u8 val, unsigned long reg)
 {
-	*(volatile u8 *)(reg) = val;
+	*(volatile u8 *)reg = val;
 }
 
 void static inline au_writew(u16 val, unsigned long reg)
 {
-	*(volatile u16 *)(reg) = val;
+	*(volatile u16 *)reg = val;
 }
 
 void static inline au_writel(u32 val, unsigned long reg)
 {
-	*(volatile u32 *)(reg) = val;
+	*(volatile u32 *)reg = val;
 }
 
 static inline u8 au_readb(unsigned long reg)
 {
-	return (*(volatile u8 *)reg);
+	return *(volatile u8 *)reg;
 }
 
 static inline u16 au_readw(unsigned long reg)
 {
-	return (*(volatile u16 *)reg);
+	return *(volatile u16 *)reg;
 }
 
 static inline u32 au_readl(unsigned long reg)
 {
-	return (*(volatile u32 *)reg);
+	return *(volatile u32 *)reg;
 }
 
 
@@ -117,76 +117,77 @@ extern struct au1xxx_irqmap au1xxx_irq_m
 #endif /* !defined (_LANGUAGE_ASSEMBLY) */
 
 /*
- * SDRAM Register Offsets
+ * SDRAM register offsets
  */
-#if defined(CONFIG_SOC_AU1000) || defined(CONFIG_SOC_AU1500) || defined(CONFIG_SOC_AU1100)
-#define MEM_SDMODE0		(0x0000)
-#define MEM_SDMODE1		(0x0004)
-#define MEM_SDMODE2		(0x0008)
-#define MEM_SDADDR0		(0x000C)
-#define MEM_SDADDR1		(0x0010)
-#define MEM_SDADDR2		(0x0014)
-#define MEM_SDREFCFG	(0x0018)
-#define MEM_SDPRECMD	(0x001C)
-#define MEM_SDAUTOREF	(0x0020)
-#define MEM_SDWRMD0		(0x0024)
-#define MEM_SDWRMD1		(0x0028)
-#define MEM_SDWRMD2		(0x002C)
-#define MEM_SDSLEEP		(0x0030)
-#define MEM_SDSMCKE		(0x0034)
+#if defined(CONFIG_SOC_AU1000) || defined(CONFIG_SOC_AU1500) || \
+    defined(CONFIG_SOC_AU1100)
+#define MEM_SDMODE0		0x0000
+#define MEM_SDMODE1		0x0004
+#define MEM_SDMODE2		0x0008
+#define MEM_SDADDR0		0x000C
+#define MEM_SDADDR1		0x0010
+#define MEM_SDADDR2		0x0014
+#define MEM_SDREFCFG		0x0018
+#define MEM_SDPRECMD		0x001C
+#define MEM_SDAUTOREF		0x0020
+#define MEM_SDWRMD0		0x0024
+#define MEM_SDWRMD1		0x0028
+#define MEM_SDWRMD2		0x002C
+#define MEM_SDSLEEP		0x0030
+#define MEM_SDSMCKE		0x0034
 
 /*
  * MEM_SDMODE register content definitions
  */
-#define MEM_SDMODE_F		(1<<22)
-#define MEM_SDMODE_SR		(1<<21)
-#define MEM_SDMODE_BS		(1<<20)
-#define MEM_SDMODE_RS		(3<<18)
-#define MEM_SDMODE_CS		(7<<15)
-#define MEM_SDMODE_TRAS		(15<<11)
-#define MEM_SDMODE_TMRD		(3<<9)
-#define MEM_SDMODE_TWR		(3<<7)
-#define MEM_SDMODE_TRP		(3<<5)
-#define MEM_SDMODE_TRCD		(3<<3)
-#define MEM_SDMODE_TCL		(7<<0)
-
-#define MEM_SDMODE_BS_2Bank	(0<<20)
-#define MEM_SDMODE_BS_4Bank	(1<<20)
-#define MEM_SDMODE_RS_11Row	(0<<18)
-#define MEM_SDMODE_RS_12Row	(1<<18)
-#define MEM_SDMODE_RS_13Row	(2<<18)
-#define MEM_SDMODE_RS_N(N)	((N)<<18)
-#define MEM_SDMODE_CS_7Col	(0<<15)
-#define MEM_SDMODE_CS_8Col	(1<<15)
-#define MEM_SDMODE_CS_9Col	(2<<15)
-#define MEM_SDMODE_CS_10Col	(3<<15)
-#define MEM_SDMODE_CS_11Col	(4<<15)
-#define MEM_SDMODE_CS_N(N)		((N)<<15)
-#define MEM_SDMODE_TRAS_N(N)	((N)<<11)
-#define MEM_SDMODE_TMRD_N(N)	((N)<<9)
-#define MEM_SDMODE_TWR_N(N)		((N)<<7)
-#define MEM_SDMODE_TRP_N(N)		((N)<<5)
-#define MEM_SDMODE_TRCD_N(N)	((N)<<3)
-#define MEM_SDMODE_TCL_N(N)		((N)<<0)
+#define MEM_SDMODE_F		(1 << 22)
+#define MEM_SDMODE_SR		(1 << 21)
+#define MEM_SDMODE_BS		(1 << 20)
+#define MEM_SDMODE_RS		(3 << 18)
+#define MEM_SDMODE_CS		(7 << 15)
+#define MEM_SDMODE_TRAS 	(15 << 11)
+#define MEM_SDMODE_TMRD 	(3 << 9)
+#define MEM_SDMODE_TWR		(3 << 7)
+#define MEM_SDMODE_TRP		(3 << 5)
+#define MEM_SDMODE_TRCD 	(3 << 3)
+#define MEM_SDMODE_TCL		(7 << 0)
+
+#define MEM_SDMODE_BS_2Bank	(0 << 20)
+#define MEM_SDMODE_BS_4Bank	(1 << 20)
+#define MEM_SDMODE_RS_11Row	(0 << 18)
+#define MEM_SDMODE_RS_12Row	(1 << 18)
+#define MEM_SDMODE_RS_13Row	(2 << 18)
+#define MEM_SDMODE_RS_N(N)	((N) << 18)
+#define MEM_SDMODE_CS_7Col	(0 << 15)
+#define MEM_SDMODE_CS_8Col	(1 << 15)
+#define MEM_SDMODE_CS_9Col	(2 << 15)
+#define MEM_SDMODE_CS_10Col	(3 << 15)
+#define MEM_SDMODE_CS_11Col	(4 << 15)
+#define MEM_SDMODE_CS_N(N)	((N) << 15)
+#define MEM_SDMODE_TRAS_N(N)	((N) << 11)
+#define MEM_SDMODE_TMRD_N(N)	((N) << 9)
+#define MEM_SDMODE_TWR_N(N)	((N) << 7)
+#define MEM_SDMODE_TRP_N(N)	((N) << 5)
+#define MEM_SDMODE_TRCD_N(N)	((N) << 3)
+#define MEM_SDMODE_TCL_N(N)	((N) << 0)
 
 /*
  * MEM_SDADDR register contents definitions
  */
-#define MEM_SDADDR_E			(1<<20)
-#define MEM_SDADDR_CSBA			(0x03FF<<10)
-#define MEM_SDADDR_CSMASK		(0x03FF<<0)
-#define MEM_SDADDR_CSBA_N(N)	((N)&(0x03FF<<22)>>12)
-#define MEM_SDADDR_CSMASK_N(N)	((N)&(0x03FF<<22)>>22)
+#define MEM_SDADDR_E		(1 << 20)
+#define MEM_SDADDR_CSBA 	(0x03FF << 10)
+#define MEM_SDADDR_CSMASK	(0x03FF << 0)
+#define MEM_SDADDR_CSBA_N(N)	((N) & (0x03FF << 22) >> 12)
+#define MEM_SDADDR_CSMASK_N(N)	((N)&(0x03FF << 22) >> 22)
 
 /*
  * MEM_SDREFCFG register content definitions
  */
-#define MEM_SDREFCFG_TRC		(15<<28)
-#define MEM_SDREFCFG_TRPM		(3<<26)
-#define MEM_SDREFCFG_E			(1<<25)
-#define MEM_SDREFCFG_RE			(0x1ffffff<<0)
-#define MEM_SDREFCFG_TRC_N(N)	((N)<<MEM_SDREFCFG_TRC)
-#define MEM_SDREFCFG_TRPM_N(N)	((N)<<MEM_SDREFCFG_TRPM)
+#define MEM_SDREFCFG_TRC	(15 << 28)
+#define MEM_SDREFCFG_TRPM	(3 << 26)
+#define MEM_SDREFCFG_E		(1 << 25)
+#define MEM_SDREFCFG_RE 	(0x1ffffff << 0)
+#define MEM_SDREFCFG_TRC_N(N)	((N) << MEM_SDREFCFG_TRC)
+#define MEM_SDREFCFG_TRPM_N(N)	((N) << MEM_SDREFCFG_TRPM)
 #define MEM_SDREFCFG_REF_N(N)	(N)
 #endif
 
@@ -199,25 +200,25 @@ extern struct au1xxx_irqmap au1xxx_irq_m
 /***********************************************************************/
 
 #if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
-#define MEM_SDMODE0		(0x0800)
-#define MEM_SDMODE1		(0x0808)
-#define MEM_SDMODE2		(0x0810)
-#define MEM_SDADDR0		(0x0820)
-#define MEM_SDADDR1		(0x0828)
-#define MEM_SDADDR2		(0x0830)
-#define MEM_SDCONFIGA	(0x0840)
-#define MEM_SDCONFIGB	(0x0848)
-#define MEM_SDSTAT		(0x0850)
-#define MEM_SDERRADDR	(0x0858)
-#define MEM_SDSTRIDE0	(0x0860)
-#define MEM_SDSTRIDE1	(0x0868)
-#define MEM_SDSTRIDE2	(0x0870)
-#define MEM_SDWRMD0		(0x0880)
-#define MEM_SDWRMD1		(0x0888)
-#define MEM_SDWRMD2		(0x0890)
-#define MEM_SDPRECMD	(0x08C0)
-#define MEM_SDAUTOREF	(0x08C8)
-#define MEM_SDSREF		(0x08D0)
+#define MEM_SDMODE0		0x0800
+#define MEM_SDMODE1		0x0808
+#define MEM_SDMODE2		0x0810
+#define MEM_SDADDR0		0x0820
+#define MEM_SDADDR1		0x0828
+#define MEM_SDADDR2		0x0830
+#define MEM_SDCONFIGA		0x0840
+#define MEM_SDCONFIGB		0x0848
+#define MEM_SDSTAT		0x0850
+#define MEM_SDERRADDR		0x0858
+#define MEM_SDSTRIDE0		0x0860
+#define MEM_SDSTRIDE1		0x0868
+#define MEM_SDSTRIDE2		0x0870
+#define MEM_SDWRMD0		0x0880
+#define MEM_SDWRMD1		0x0888
+#define MEM_SDWRMD2		0x0890
+#define MEM_SDPRECMD		0x08C0
+#define MEM_SDAUTOREF		0x08C8
+#define MEM_SDSREF		0x08D0
 #define MEM_SDSLEEP		MEM_SDSREF
 
 #endif
@@ -256,9 +257,9 @@ extern struct au1xxx_irqmap au1xxx_irq_m
 #define	SSI0_PHYS_ADDR		0x11600000
 #define	SSI1_PHYS_ADDR		0x11680000
 #define	SYS_PHYS_ADDR		0x11900000
-#define PCMCIA_IO_PHYS_ADDR   0xF00000000ULL
-#define PCMCIA_ATTR_PHYS_ADDR 0xF40000000ULL
-#define PCMCIA_MEM_PHYS_ADDR  0xF80000000ULL
+#define PCMCIA_IO_PHYS_ADDR	0xF00000000ULL
+#define PCMCIA_ATTR_PHYS_ADDR	0xF40000000ULL
+#define PCMCIA_MEM_PHYS_ADDR	0xF80000000ULL
 #endif
 
 /********************************************************************/
@@ -290,13 +291,13 @@ extern struct au1xxx_irqmap au1xxx_irq_m
 #define	UART3_PHYS_ADDR		0x11400000
 #define GPIO2_PHYS_ADDR		0x11700000
 #define	SYS_PHYS_ADDR		0x11900000
-#define PCI_MEM_PHYS_ADDR     0x400000000ULL
-#define PCI_IO_PHYS_ADDR      0x500000000ULL
-#define PCI_CONFIG0_PHYS_ADDR 0x600000000ULL
-#define PCI_CONFIG1_PHYS_ADDR 0x680000000ULL
-#define PCMCIA_IO_PHYS_ADDR   0xF00000000ULL
-#define PCMCIA_ATTR_PHYS_ADDR 0xF40000000ULL
-#define PCMCIA_MEM_PHYS_ADDR  0xF80000000ULL
+#define PCI_MEM_PHYS_ADDR	0x400000000ULL
+#define PCI_IO_PHYS_ADDR	0x500000000ULL
+#define PCI_CONFIG0_PHYS_ADDR	0x600000000ULL
+#define PCI_CONFIG1_PHYS_ADDR	0x680000000ULL
+#define PCMCIA_IO_PHYS_ADDR	0xF00000000ULL
+#define PCMCIA_ATTR_PHYS_ADDR	0xF40000000ULL
+#define PCMCIA_MEM_PHYS_ADDR	0xF80000000ULL
 #endif
 
 /********************************************************************/
@@ -333,9 +334,9 @@ extern struct au1xxx_irqmap au1xxx_irq_m
 #define GPIO2_PHYS_ADDR		0x11700000
 #define	SYS_PHYS_ADDR		0x11900000
 #define LCD_PHYS_ADDR		0x15000000
-#define PCMCIA_IO_PHYS_ADDR   0xF00000000ULL
-#define PCMCIA_ATTR_PHYS_ADDR 0xF40000000ULL
-#define PCMCIA_MEM_PHYS_ADDR  0xF80000000ULL
+#define PCMCIA_IO_PHYS_ADDR	0xF00000000ULL
+#define PCMCIA_ATTR_PHYS_ADDR	0xF40000000ULL
+#define PCMCIA_MEM_PHYS_ADDR	0xF80000000ULL
 #endif
 
 /***********************************************************************/
@@ -360,17 +361,17 @@ extern struct au1xxx_irqmap au1xxx_irq_m
 #define	SYS_PHYS_ADDR		0x11900000
 #define	DDMA_PHYS_ADDR		0x14002000
 #define PE_PHYS_ADDR		0x14008000
-#define PSC0_PHYS_ADDR	 	0x11A00000
-#define PSC1_PHYS_ADDR	 	0x11B00000
-#define PSC2_PHYS_ADDR	 	0x10A00000
-#define PSC3_PHYS_ADDR	 	0x10B00000
-#define PCI_MEM_PHYS_ADDR     0x400000000ULL
-#define PCI_IO_PHYS_ADDR      0x500000000ULL
-#define PCI_CONFIG0_PHYS_ADDR 0x600000000ULL
-#define PCI_CONFIG1_PHYS_ADDR 0x680000000ULL
-#define PCMCIA_IO_PHYS_ADDR   0xF00000000ULL
-#define PCMCIA_ATTR_PHYS_ADDR 0xF40000000ULL
-#define PCMCIA_MEM_PHYS_ADDR  0xF80000000ULL
+#define PSC0_PHYS_ADDR		0x11A00000
+#define PSC1_PHYS_ADDR		0x11B00000
+#define PSC2_PHYS_ADDR		0x10A00000
+#define PSC3_PHYS_ADDR		0x10B00000
+#define PCI_MEM_PHYS_ADDR	0x400000000ULL
+#define PCI_IO_PHYS_ADDR	0x500000000ULL
+#define PCI_CONFIG0_PHYS_ADDR	0x600000000ULL
+#define PCI_CONFIG1_PHYS_ADDR	0x680000000ULL
+#define PCMCIA_IO_PHYS_ADDR	0xF00000000ULL
+#define PCMCIA_ATTR_PHYS_ADDR	0xF40000000ULL
+#define PCMCIA_MEM_PHYS_ADDR	0xF80000000ULL
 #endif
 
 /***********************************************************************/
@@ -397,122 +398,121 @@ extern struct au1xxx_irqmap au1xxx_irq_m
 #define SWCNT_PHYS_ADDR		0x1110010C
 #define MAEFE_PHYS_ADDR		0x14012000
 #define MAEBE_PHYS_ADDR		0x14010000
-#define PCMCIA_IO_PHYS_ADDR   0xF00000000ULL
-#define PCMCIA_ATTR_PHYS_ADDR 0xF40000000ULL
-#define PCMCIA_MEM_PHYS_ADDR  0xF80000000ULL
+#define PCMCIA_IO_PHYS_ADDR	0xF00000000ULL
+#define PCMCIA_ATTR_PHYS_ADDR	0xF40000000ULL
+#define PCMCIA_MEM_PHYS_ADDR	0xF80000000ULL
 #endif
 
-
 /* Static Bus Controller */
-#define MEM_STCFG0                 0xB4001000
-#define MEM_STTIME0                0xB4001004
-#define MEM_STADDR0                0xB4001008
-
-#define MEM_STCFG1                 0xB4001010
-#define MEM_STTIME1                0xB4001014
-#define MEM_STADDR1                0xB4001018
-
-#define MEM_STCFG2                 0xB4001020
-#define MEM_STTIME2                0xB4001024
-#define MEM_STADDR2                0xB4001028
-
-#define MEM_STCFG3                 0xB4001030
-#define MEM_STTIME3                0xB4001034
-#define MEM_STADDR3                0xB4001038
+#define MEM_STCFG0		0xB4001000
+#define MEM_STTIME0		0xB4001004
+#define MEM_STADDR0		0xB4001008
+
+#define MEM_STCFG1		0xB4001010
+#define MEM_STTIME1		0xB4001014
+#define MEM_STADDR1		0xB4001018
+
+#define MEM_STCFG2		0xB4001020
+#define MEM_STTIME2		0xB4001024
+#define MEM_STADDR2		0xB4001028
+
+#define MEM_STCFG3		0xB4001030
+#define MEM_STTIME3		0xB4001034
+#define MEM_STADDR3		0xB4001038
 
 #if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
-#define MEM_STNDCTL                0xB4001100
-#define MEM_STSTAT                 0xB4001104
+#define MEM_STNDCTL		0xB4001100
+#define MEM_STSTAT		0xB4001104
 
-#define MEM_STNAND_CMD                  (0x0)
-#define MEM_STNAND_ADDR                 (0x4)
-#define MEM_STNAND_DATA                (0x20)
+#define MEM_STNAND_CMD		0x0
+#define MEM_STNAND_ADDR 	0x4
+#define MEM_STNAND_DATA 	0x20
 #endif
 
 /* Interrupt Controller 0 */
-#define IC0_CFG0RD                 0xB0400040
-#define IC0_CFG0SET                0xB0400040
-#define IC0_CFG0CLR                0xB0400044
-
-#define IC0_CFG1RD                 0xB0400048
-#define IC0_CFG1SET                0xB0400048
-#define IC0_CFG1CLR                0xB040004C
-
-#define IC0_CFG2RD                 0xB0400050
-#define IC0_CFG2SET                0xB0400050
-#define IC0_CFG2CLR                0xB0400054
-
-#define IC0_REQ0INT                0xB0400054
-#define IC0_SRCRD                  0xB0400058
-#define IC0_SRCSET                 0xB0400058
-#define IC0_SRCCLR                 0xB040005C
-#define IC0_REQ1INT                0xB040005C
-
-#define IC0_ASSIGNRD               0xB0400060
-#define IC0_ASSIGNSET              0xB0400060
-#define IC0_ASSIGNCLR              0xB0400064
-
-#define IC0_WAKERD                 0xB0400068
-#define IC0_WAKESET                0xB0400068
-#define IC0_WAKECLR                0xB040006C
-
-#define IC0_MASKRD                 0xB0400070
-#define IC0_MASKSET                0xB0400070
-#define IC0_MASKCLR                0xB0400074
-
-#define IC0_RISINGRD               0xB0400078
-#define IC0_RISINGCLR              0xB0400078
-#define IC0_FALLINGRD              0xB040007C
-#define IC0_FALLINGCLR             0xB040007C
+#define IC0_CFG0RD		0xB0400040
+#define IC0_CFG0SET		0xB0400040
+#define IC0_CFG0CLR		0xB0400044
+
+#define IC0_CFG1RD		0xB0400048
+#define IC0_CFG1SET		0xB0400048
+#define IC0_CFG1CLR		0xB040004C
+
+#define IC0_CFG2RD		0xB0400050
+#define IC0_CFG2SET		0xB0400050
+#define IC0_CFG2CLR		0xB0400054
+
+#define IC0_REQ0INT		0xB0400054
+#define IC0_SRCRD		0xB0400058
+#define IC0_SRCSET		0xB0400058
+#define IC0_SRCCLR		0xB040005C
+#define IC0_REQ1INT		0xB040005C
+
+#define IC0_ASSIGNRD		0xB0400060
+#define IC0_ASSIGNSET		0xB0400060
+#define IC0_ASSIGNCLR		0xB0400064
+
+#define IC0_WAKERD		0xB0400068
+#define IC0_WAKESET		0xB0400068
+#define IC0_WAKECLR		0xB040006C
+
+#define IC0_MASKRD		0xB0400070
+#define IC0_MASKSET		0xB0400070
+#define IC0_MASKCLR		0xB0400074
+
+#define IC0_RISINGRD		0xB0400078
+#define IC0_RISINGCLR		0xB0400078
+#define IC0_FALLINGRD		0xB040007C
+#define IC0_FALLINGCLR		0xB040007C
 
-#define IC0_TESTBIT                0xB0400080
+#define IC0_TESTBIT		0xB0400080
 
 /* Interrupt Controller 1 */
-#define IC1_CFG0RD                 0xB1800040
-#define IC1_CFG0SET                0xB1800040
-#define IC1_CFG0CLR                0xB1800044
-
-#define IC1_CFG1RD                 0xB1800048
-#define IC1_CFG1SET                0xB1800048
-#define IC1_CFG1CLR                0xB180004C
-
-#define IC1_CFG2RD                 0xB1800050
-#define IC1_CFG2SET                0xB1800050
-#define IC1_CFG2CLR                0xB1800054
-
-#define IC1_REQ0INT                0xB1800054
-#define IC1_SRCRD                  0xB1800058
-#define IC1_SRCSET                 0xB1800058
-#define IC1_SRCCLR                 0xB180005C
-#define IC1_REQ1INT                0xB180005C
-
-#define IC1_ASSIGNRD               0xB1800060
-#define IC1_ASSIGNSET              0xB1800060
-#define IC1_ASSIGNCLR              0xB1800064
-
-#define IC1_WAKERD                 0xB1800068
-#define IC1_WAKESET                0xB1800068
-#define IC1_WAKECLR                0xB180006C
-
-#define IC1_MASKRD                 0xB1800070
-#define IC1_MASKSET                0xB1800070
-#define IC1_MASKCLR                0xB1800074
-
-#define IC1_RISINGRD               0xB1800078
-#define IC1_RISINGCLR              0xB1800078
-#define IC1_FALLINGRD              0xB180007C
-#define IC1_FALLINGCLR             0xB180007C
+#define IC1_CFG0RD		0xB1800040
+#define IC1_CFG0SET		0xB1800040
+#define IC1_CFG0CLR		0xB1800044
+
+#define IC1_CFG1RD		0xB1800048
+#define IC1_CFG1SET		0xB1800048
+#define IC1_CFG1CLR		0xB180004C
+
+#define IC1_CFG2RD		0xB1800050
+#define IC1_CFG2SET		0xB1800050
+#define IC1_CFG2CLR		0xB1800054
+
+#define IC1_REQ0INT		0xB1800054
+#define IC1_SRCRD		0xB1800058
+#define IC1_SRCSET		0xB1800058
+#define IC1_SRCCLR		0xB180005C
+#define IC1_REQ1INT		0xB180005C
+
+#define IC1_ASSIGNRD            0xB1800060
+#define IC1_ASSIGNSET           0xB1800060
+#define IC1_ASSIGNCLR           0xB1800064
+
+#define IC1_WAKERD		0xB1800068
+#define IC1_WAKESET		0xB1800068
+#define IC1_WAKECLR		0xB180006C
+
+#define IC1_MASKRD		0xB1800070
+#define IC1_MASKSET		0xB1800070
+#define IC1_MASKCLR		0xB1800074
+
+#define IC1_RISINGRD		0xB1800078
+#define IC1_RISINGCLR		0xB1800078
+#define IC1_FALLINGRD		0xB180007C
+#define IC1_FALLINGCLR		0xB180007C
 
-#define IC1_TESTBIT                0xB1800080
+#define IC1_TESTBIT		0xB1800080
 
 /* Interrupt Configuration Modes */
-#define INTC_INT_DISABLED                0
-#define INTC_INT_RISE_EDGE             0x1
-#define INTC_INT_FALL_EDGE             0x2
-#define INTC_INT_RISE_AND_FALL_EDGE    0x3
-#define INTC_INT_HIGH_LEVEL            0x5
-#define INTC_INT_LOW_LEVEL             0x6
-#define INTC_INT_HIGH_AND_LOW_LEVEL    0x7
+#define INTC_INT_DISABLED		0x0
+#define INTC_INT_RISE_EDGE		0x1
+#define INTC_INT_FALL_EDGE		0x2
+#define INTC_INT_RISE_AND_FALL_EDGE	0x3
+#define INTC_INT_HIGH_LEVEL		0x5
+#define INTC_INT_LOW_LEVEL		0x6
+#define INTC_INT_HIGH_AND_LOW_LEVEL	0x7
 
 /* Interrupt Numbers */
 /* Au1000 */
@@ -579,18 +579,18 @@ enum soc_au1000_ints {
 	AU1000_GPIO_31,
 };
 
-#define UART0_ADDR                0xB1100000
-#define UART1_ADDR                0xB1200000
-#define UART2_ADDR                0xB1300000
-#define UART3_ADDR                0xB1400000
-
-#define USB_OHCI_BASE             0x10100000 // phys addr for ioremap
-#define USB_HOST_CONFIG           0xB017fffc
-
-#define AU1000_ETH0_BASE      0xB0500000
-#define AU1000_ETH1_BASE      0xB0510000
-#define AU1000_MAC0_ENABLE       0xB0520000
-#define AU1000_MAC1_ENABLE       0xB0520004
+#define UART0_ADDR		0xB1100000
+#define UART1_ADDR		0xB1200000
+#define UART2_ADDR		0xB1300000
+#define UART3_ADDR		0xB1400000
+
+#define USB_OHCI_BASE		0x10100000	/* phys addr for ioremap */
+#define USB_HOST_CONFIG 	0xB017FFFC
+
+#define AU1000_ETH0_BASE	0xB0500000
+#define AU1000_ETH1_BASE	0xB0510000
+#define AU1000_MAC0_ENABLE	0xB0520000
+#define AU1000_MAC1_ENABLE	0xB0520004
 #define NUM_ETH_INTERFACES 2
 #endif /* CONFIG_SOC_AU1000 */
 
@@ -662,16 +662,16 @@ enum soc_au1500_ints {
 #define INTC AU1000_PCI_INTC
 #define INTD AU1000_PCI_INTD
 
-#define UART0_ADDR                0xB1100000
-#define UART3_ADDR                0xB1400000
+#define UART0_ADDR		0xB1100000
+#define UART3_ADDR		0xB1400000
 
-#define USB_OHCI_BASE             0x10100000 // phys addr for ioremap
-#define USB_HOST_CONFIG           0xB017fffc
+#define USB_OHCI_BASE		0x10100000	/* phys addr for ioremap */
+#define USB_HOST_CONFIG 	0xB017fffc
 
-#define AU1500_ETH0_BASE	  0xB1500000
-#define AU1500_ETH1_BASE	  0xB1510000
-#define AU1500_MAC0_ENABLE       0xB1520000
-#define AU1500_MAC1_ENABLE       0xB1520004
+#define AU1500_ETH0_BASE	0xB1500000
+#define AU1500_ETH1_BASE	0xB1510000
+#define AU1500_MAC0_ENABLE	0xB1520000
+#define AU1500_MAC1_ENABLE	0xB1520004
 #define NUM_ETH_INTERFACES 2
 #endif /* CONFIG_SOC_AU1500 */
 
@@ -739,15 +739,15 @@ enum soc_au1100_ints {
 	AU1000_GPIO_31,
 };
 
-#define UART0_ADDR                0xB1100000
-#define UART1_ADDR                0xB1200000
-#define UART3_ADDR                0xB1400000
+#define UART0_ADDR		0xB1100000
+#define UART1_ADDR		0xB1200000
+#define UART3_ADDR		0xB1400000
 
-#define USB_OHCI_BASE             0x10100000 // phys addr for ioremap
-#define USB_HOST_CONFIG           0xB017fffc
+#define USB_OHCI_BASE		0x10100000	/* phys addr for ioremap */
+#define USB_HOST_CONFIG 	0xB017FFFC
 
-#define AU1100_ETH0_BASE	  0xB0500000
-#define AU1100_MAC0_ENABLE       0xB0520000
+#define AU1100_ETH0_BASE	0xB0500000
+#define AU1100_MAC0_ENABLE	0xB0520000
 #define NUM_ETH_INTERFACES 1
 #endif /* CONFIG_SOC_AU1100 */
 
@@ -826,18 +826,18 @@ enum soc_au1550_ints {
 #define INTC AU1550_PCI_INTC
 #define INTD AU1550_PCI_INTD
 
-#define UART0_ADDR                0xB1100000
-#define UART1_ADDR                0xB1200000
-#define UART3_ADDR                0xB1400000
-
-#define USB_OHCI_BASE             0x14020000 // phys addr for ioremap
-#define USB_OHCI_LEN              0x00060000
-#define USB_HOST_CONFIG           0xB4027ffc
-
-#define AU1550_ETH0_BASE      0xB0500000
-#define AU1550_ETH1_BASE      0xB0510000
-#define AU1550_MAC0_ENABLE       0xB0520000
-#define AU1550_MAC1_ENABLE       0xB0520004
+#define UART0_ADDR		0xB1100000
+#define UART1_ADDR		0xB1200000
+#define UART3_ADDR		0xB1400000
+
+#define USB_OHCI_BASE		0x14020000	/* phys addr for ioremap */
+#define USB_OHCI_LEN		0x00060000
+#define USB_HOST_CONFIG 	0xB4027ffc
+
+#define AU1550_ETH0_BASE	0xB0500000
+#define AU1550_ETH1_BASE	0xB0510000
+#define AU1550_MAC0_ENABLE	0xB0520000
+#define AU1550_MAC1_ENABLE	0xB0520004
 #define NUM_ETH_INTERFACES 2
 #endif /* CONFIG_SOC_AU1550 */
 
@@ -911,32 +911,32 @@ enum soc_au1200_ints {
 	AU1000_GPIO_31,
 };
 
-#define UART0_ADDR                0xB1100000
-#define UART1_ADDR                0xB1200000
+#define UART0_ADDR		0xB1100000
+#define UART1_ADDR		0xB1200000
 
-#define USB_UOC_BASE              0x14020020
-#define USB_UOC_LEN               0x20
-#define USB_OHCI_BASE             0x14020100
-#define USB_OHCI_LEN              0x100
-#define USB_EHCI_BASE             0x14020200
-#define USB_EHCI_LEN              0x100
-#define USB_UDC_BASE              0x14022000
-#define USB_UDC_LEN               0x2000
-#define USB_MSR_BASE			  0xB4020000
-#define USB_MSR_MCFG              4
-#define USBMSRMCFG_OMEMEN         0
-#define USBMSRMCFG_OBMEN          1
-#define USBMSRMCFG_EMEMEN         2
-#define USBMSRMCFG_EBMEN          3
-#define USBMSRMCFG_DMEMEN         4
-#define USBMSRMCFG_DBMEN          5
-#define USBMSRMCFG_GMEMEN         6
-#define USBMSRMCFG_OHCCLKEN       16
-#define USBMSRMCFG_EHCCLKEN       17
-#define USBMSRMCFG_UDCCLKEN       18
-#define USBMSRMCFG_PHYPLLEN       19
-#define USBMSRMCFG_RDCOMB         30
-#define USBMSRMCFG_PFEN           31
+#define USB_UOC_BASE		0x14020020
+#define USB_UOC_LEN		0x20
+#define USB_OHCI_BASE		0x14020100
+#define USB_OHCI_LEN		0x100
+#define USB_EHCI_BASE		0x14020200
+#define USB_EHCI_LEN		0x100
+#define USB_UDC_BASE		0x14022000
+#define USB_UDC_LEN		0x2000
+#define USB_MSR_BASE		0xB4020000
+#define USB_MSR_MCFG		4
+#define USBMSRMCFG_OMEMEN	0
+#define USBMSRMCFG_OBMEN	1
+#define USBMSRMCFG_EMEMEN	2
+#define USBMSRMCFG_EBMEN	3
+#define USBMSRMCFG_DMEMEN	4
+#define USBMSRMCFG_DBMEN	5
+#define USBMSRMCFG_GMEMEN	6
+#define USBMSRMCFG_OHCCLKEN	16
+#define USBMSRMCFG_EHCCLKEN	17
+#define USBMSRMCFG_UDCCLKEN	18
+#define USBMSRMCFG_PHYPLLEN	19
+#define USBMSRMCFG_RDCOMB	30
+#define USBMSRMCFG_PFEN 	31
 
 #endif /* CONFIG_SOC_AU1200 */
 
@@ -949,259 +949,258 @@ enum soc_au1200_ints {
 #define INTX			0xFF			/* not valid */
 
 /* Programmable Counters 0 and 1 */
-#define SYS_BASE                   0xB1900000
-#define SYS_COUNTER_CNTRL          (SYS_BASE + 0x14)
-#  define SYS_CNTRL_E1S            (1<<23)
-#  define SYS_CNTRL_T1S            (1<<20)
-#  define SYS_CNTRL_M21            (1<<19)
-#  define SYS_CNTRL_M11            (1<<18)
-#  define SYS_CNTRL_M01            (1<<17)
-#  define SYS_CNTRL_C1S            (1<<16)
-#  define SYS_CNTRL_BP             (1<<14)
-#  define SYS_CNTRL_EN1            (1<<13)
-#  define SYS_CNTRL_BT1            (1<<12)
-#  define SYS_CNTRL_EN0            (1<<11)
-#  define SYS_CNTRL_BT0            (1<<10)
-#  define SYS_CNTRL_E0             (1<<8)
-#  define SYS_CNTRL_E0S            (1<<7)
-#  define SYS_CNTRL_32S            (1<<5)
-#  define SYS_CNTRL_T0S            (1<<4)
-#  define SYS_CNTRL_M20            (1<<3)
-#  define SYS_CNTRL_M10            (1<<2)
-#  define SYS_CNTRL_M00            (1<<1)
-#  define SYS_CNTRL_C0S            (1<<0)
+#define SYS_BASE		0xB1900000
+#define SYS_COUNTER_CNTRL	(SYS_BASE + 0x14)
+#  define SYS_CNTRL_E1S 	(1 << 23)
+#  define SYS_CNTRL_T1S 	(1 << 20)
+#  define SYS_CNTRL_M21 	(1 << 19)
+#  define SYS_CNTRL_M11 	(1 << 18)
+#  define SYS_CNTRL_M01 	(1 << 17)
+#  define SYS_CNTRL_C1S 	(1 << 16)
+#  define SYS_CNTRL_BP		(1 << 14)
+#  define SYS_CNTRL_EN1 	(1 << 13)
+#  define SYS_CNTRL_BT1 	(1 << 12)
+#  define SYS_CNTRL_EN0 	(1 << 11)
+#  define SYS_CNTRL_BT0 	(1 << 10)
+#  define SYS_CNTRL_E0		(1 << 8)
+#  define SYS_CNTRL_E0S 	(1 << 7)
+#  define SYS_CNTRL_32S 	(1 << 5)
+#  define SYS_CNTRL_T0S 	(1 << 4)
+#  define SYS_CNTRL_M20 	(1 << 3)
+#  define SYS_CNTRL_M10 	(1 << 2)
+#  define SYS_CNTRL_M00 	(1 << 1)
+#  define SYS_CNTRL_C0S 	(1 << 0)
 
 /* Programmable Counter 0 Registers */
-#define SYS_TOYTRIM                 (SYS_BASE + 0)
-#define SYS_TOYWRITE                (SYS_BASE + 4)
-#define SYS_TOYMATCH0               (SYS_BASE + 8)
-#define SYS_TOYMATCH1               (SYS_BASE + 0xC)
-#define SYS_TOYMATCH2               (SYS_BASE + 0x10)
-#define SYS_TOYREAD                 (SYS_BASE + 0x40)
+#define SYS_TOYTRIM		(SYS_BASE + 0)
+#define SYS_TOYWRITE		(SYS_BASE + 4)
+#define SYS_TOYMATCH0		(SYS_BASE + 8)
+#define SYS_TOYMATCH1		(SYS_BASE + 0xC)
+#define SYS_TOYMATCH2		(SYS_BASE + 0x10)
+#define SYS_TOYREAD		(SYS_BASE + 0x40)
 
 /* Programmable Counter 1 Registers */
-#define SYS_RTCTRIM                 (SYS_BASE + 0x44)
-#define SYS_RTCWRITE                (SYS_BASE + 0x48)
-#define SYS_RTCMATCH0               (SYS_BASE + 0x4C)
-#define SYS_RTCMATCH1               (SYS_BASE + 0x50)
-#define SYS_RTCMATCH2               (SYS_BASE + 0x54)
-#define SYS_RTCREAD                 (SYS_BASE + 0x58)
+#define SYS_RTCTRIM		(SYS_BASE + 0x44)
+#define SYS_RTCWRITE		(SYS_BASE + 0x48)
+#define SYS_RTCMATCH0		(SYS_BASE + 0x4C)
+#define SYS_RTCMATCH1		(SYS_BASE + 0x50)
+#define SYS_RTCMATCH2		(SYS_BASE + 0x54)
+#define SYS_RTCREAD		(SYS_BASE + 0x58)
 
 /* I2S Controller */
-#define I2S_DATA                    0xB1000000
-#  define I2S_DATA_MASK        (0xffffff)
-#define I2S_CONFIG                0xB1000004
-#  define I2S_CONFIG_XU        (1<<25)
-#  define I2S_CONFIG_XO        (1<<24)
-#  define I2S_CONFIG_RU        (1<<23)
-#  define I2S_CONFIG_RO        (1<<22)
-#  define I2S_CONFIG_TR        (1<<21)
-#  define I2S_CONFIG_TE        (1<<20)
-#  define I2S_CONFIG_TF        (1<<19)
-#  define I2S_CONFIG_RR        (1<<18)
-#  define I2S_CONFIG_RE        (1<<17)
-#  define I2S_CONFIG_RF        (1<<16)
-#  define I2S_CONFIG_PD        (1<<11)
-#  define I2S_CONFIG_LB        (1<<10)
-#  define I2S_CONFIG_IC        (1<<9)
-#  define I2S_CONFIG_FM_BIT    7
-#  define I2S_CONFIG_FM_MASK     (0x3 << I2S_CONFIG_FM_BIT)
-#    define I2S_CONFIG_FM_I2S    (0x0 << I2S_CONFIG_FM_BIT)
-#    define I2S_CONFIG_FM_LJ     (0x1 << I2S_CONFIG_FM_BIT)
-#    define I2S_CONFIG_FM_RJ     (0x2 << I2S_CONFIG_FM_BIT)
-#  define I2S_CONFIG_TN        (1<<6)
-#  define I2S_CONFIG_RN        (1<<5)
-#  define I2S_CONFIG_SZ_BIT    0
-#  define I2S_CONFIG_SZ_MASK     (0x1F << I2S_CONFIG_SZ_BIT)
-
-#define I2S_CONTROL                0xB1000008
-#  define I2S_CONTROL_D         (1<<1)
-#  define I2S_CONTROL_CE        (1<<0)
+#define I2S_DATA		0xB1000000
+#  define I2S_DATA_MASK 	0xffffff
+#define I2S_CONFIG		0xB1000004
+#  define I2S_CONFIG_XU 	(1 << 25)
+#  define I2S_CONFIG_XO 	(1 << 24)
+#  define I2S_CONFIG_RU 	(1 << 23)
+#  define I2S_CONFIG_RO 	(1 << 22)
+#  define I2S_CONFIG_TR 	(1 << 21)
+#  define I2S_CONFIG_TE 	(1 << 20)
+#  define I2S_CONFIG_TF 	(1 << 19)
+#  define I2S_CONFIG_RR 	(1 << 18)
+#  define I2S_CONFIG_RE 	(1 << 17)
+#  define I2S_CONFIG_RF 	(1 << 16)
+#  define I2S_CONFIG_PD 	(1 << 11)
+#  define I2S_CONFIG_LB 	(1 << 10)
+#  define I2S_CONFIG_IC 	(1 << 9)
+#  define I2S_CONFIG_FM_BIT	7
+#  define I2S_CONFIG_FM_MASK	(0x3 << I2S_CONFIG_FM_BIT)
+#    define I2S_CONFIG_FM_I2S	(0x0 << I2S_CONFIG_FM_BIT)
+#    define I2S_CONFIG_FM_LJ	(0x1 << I2S_CONFIG_FM_BIT)
+#    define I2S_CONFIG_FM_RJ	(0x2 << I2S_CONFIG_FM_BIT)
+#  define I2S_CONFIG_TN 	(1 << 6)
+#  define I2S_CONFIG_RN 	(1 << 5)
+#  define I2S_CONFIG_SZ_BIT	0
+#  define I2S_CONFIG_SZ_MASK	(0x1F << I2S_CONFIG_SZ_BIT)
+
+#define I2S_CONTROL		0xB1000008
+#  define I2S_CONTROL_D 	(1 << 1)
+#  define I2S_CONTROL_CE	(1 << 0)
 
 /* USB Host Controller */
 #ifndef USB_OHCI_LEN
-#define USB_OHCI_LEN              0x00100000
+#define USB_OHCI_LEN		0x00100000
 #endif
 
 #ifndef CONFIG_SOC_AU1200
 
 /* USB Device Controller */
-#define USBD_EP0RD                0xB0200000
-#define USBD_EP0WR                0xB0200004
-#define USBD_EP2WR                0xB0200008
-#define USBD_EP3WR                0xB020000C
-#define USBD_EP4RD                0xB0200010
-#define USBD_EP5RD                0xB0200014
-#define USBD_INTEN                0xB0200018
-#define USBD_INTSTAT              0xB020001C
-#  define USBDEV_INT_SOF       (1<<12)
-#  define USBDEV_INT_HF_BIT    6
-#  define USBDEV_INT_HF_MASK   (0x3f << USBDEV_INT_HF_BIT)
-#  define USBDEV_INT_CMPLT_BIT  0
+#define USBD_EP0RD		0xB0200000
+#define USBD_EP0WR		0xB0200004
+#define USBD_EP2WR		0xB0200008
+#define USBD_EP3WR		0xB020000C
+#define USBD_EP4RD		0xB0200010
+#define USBD_EP5RD		0xB0200014
+#define USBD_INTEN		0xB0200018
+#define USBD_INTSTAT		0xB020001C
+#  define USBDEV_INT_SOF	(1 << 12)
+#  define USBDEV_INT_HF_BIT	6
+#  define USBDEV_INT_HF_MASK	0x3f << USBDEV_INT_HF_BIT)
+#  define USBDEV_INT_CMPLT_BIT	0
 #  define USBDEV_INT_CMPLT_MASK (0x3f << USBDEV_INT_CMPLT_BIT)
-#define USBD_CONFIG               0xB0200020
-#define USBD_EP0CS                0xB0200024
-#define USBD_EP2CS                0xB0200028
-#define USBD_EP3CS                0xB020002C
-#define USBD_EP4CS                0xB0200030
-#define USBD_EP5CS                0xB0200034
-#  define USBDEV_CS_SU         (1<<14)
-#  define USBDEV_CS_NAK        (1<<13)
-#  define USBDEV_CS_ACK        (1<<12)
-#  define USBDEV_CS_BUSY       (1<<11)
-#  define USBDEV_CS_TSIZE_BIT  1
-#  define USBDEV_CS_TSIZE_MASK (0x3ff << USBDEV_CS_TSIZE_BIT)
-#  define USBDEV_CS_STALL      (1<<0)
-#define USBD_EP0RDSTAT            0xB0200040
-#define USBD_EP0WRSTAT            0xB0200044
-#define USBD_EP2WRSTAT            0xB0200048
-#define USBD_EP3WRSTAT            0xB020004C
-#define USBD_EP4RDSTAT            0xB0200050
-#define USBD_EP5RDSTAT            0xB0200054
-#  define USBDEV_FSTAT_FLUSH     (1<<6)
-#  define USBDEV_FSTAT_UF        (1<<5)
-#  define USBDEV_FSTAT_OF        (1<<4)
-#  define USBDEV_FSTAT_FCNT_BIT  0
+#define USBD_CONFIG		0xB0200020
+#define USBD_EP0CS		0xB0200024
+#define USBD_EP2CS		0xB0200028
+#define USBD_EP3CS		0xB020002C
+#define USBD_EP4CS		0xB0200030
+#define USBD_EP5CS		0xB0200034
+#  define USBDEV_CS_SU		(1 << 14)
+#  define USBDEV_CS_NAK 	(1 << 13)
+#  define USBDEV_CS_ACK 	(1 << 12)
+#  define USBDEV_CS_BUSY	(1 << 11)
+#  define USBDEV_CS_TSIZE_BIT	1
+#  define USBDEV_CS_TSIZE_MASK	(0x3ff << USBDEV_CS_TSIZE_BIT)
+#  define USBDEV_CS_STALL	(1 << 0)
+#define USBD_EP0RDSTAT		0xB0200040
+#define USBD_EP0WRSTAT		0xB0200044
+#define USBD_EP2WRSTAT		0xB0200048
+#define USBD_EP3WRSTAT		0xB020004C
+#define USBD_EP4RDSTAT		0xB0200050
+#define USBD_EP5RDSTAT		0xB0200054
+#  define USBDEV_FSTAT_FLUSH	(1 << 6)
+#  define USBDEV_FSTAT_UF	(1 << 5)
+#  define USBDEV_FSTAT_OF	(1 << 4)
+#  define USBDEV_FSTAT_FCNT_BIT 0
 #  define USBDEV_FSTAT_FCNT_MASK (0x0f << USBDEV_FSTAT_FCNT_BIT)
-#define USBD_ENABLE               0xB0200058
-#  define USBDEV_ENABLE (1<<1)
-#  define USBDEV_CE     (1<<0)
+#define USBD_ENABLE		0xB0200058
+#  define USBDEV_ENABLE 	(1 << 1)
+#  define USBDEV_CE		(1 << 0)
 
 #endif /* !CONFIG_SOC_AU1200 */
 
 /* Ethernet Controllers  */
 
 /* 4 byte offsets from AU1000_ETH_BASE */
-#define MAC_CONTROL                     0x0
-#  define MAC_RX_ENABLE               (1<<2)
-#  define MAC_TX_ENABLE               (1<<3)
-#  define MAC_DEF_CHECK               (1<<5)
-#  define MAC_SET_BL(X)       (((X)&0x3)<<6)
-#  define MAC_AUTO_PAD                (1<<8)
-#  define MAC_DISABLE_RETRY          (1<<10)
-#  define MAC_DISABLE_BCAST          (1<<11)
-#  define MAC_LATE_COL               (1<<12)
-#  define MAC_HASH_MODE              (1<<13)
-#  define MAC_HASH_ONLY              (1<<15)
-#  define MAC_PASS_ALL               (1<<16)
-#  define MAC_INVERSE_FILTER         (1<<17)
-#  define MAC_PROMISCUOUS            (1<<18)
-#  define MAC_PASS_ALL_MULTI         (1<<19)
-#  define MAC_FULL_DUPLEX            (1<<20)
-#  define MAC_NORMAL_MODE                 0
-#  define MAC_INT_LOOPBACK           (1<<21)
-#  define MAC_EXT_LOOPBACK           (1<<22)
-#  define MAC_DISABLE_RX_OWN         (1<<23)
-#  define MAC_BIG_ENDIAN             (1<<30)
-#  define MAC_RX_ALL                 (1<<31)
-#define MAC_ADDRESS_HIGH                0x4
-#define MAC_ADDRESS_LOW                 0x8
-#define MAC_MCAST_HIGH                  0xC
-#define MAC_MCAST_LOW                  0x10
-#define MAC_MII_CNTRL                  0x14
-#  define MAC_MII_BUSY                (1<<0)
-#  define MAC_MII_READ                     0
-#  define MAC_MII_WRITE               (1<<1)
-#  define MAC_SET_MII_SELECT_REG(X)   (((X)&0x1f)<<6)
-#  define MAC_SET_MII_SELECT_PHY(X)   (((X)&0x1f)<<11)
-#define MAC_MII_DATA                   0x18
-#define MAC_FLOW_CNTRL                 0x1C
-#  define MAC_FLOW_CNTRL_BUSY         (1<<0)
-#  define MAC_FLOW_CNTRL_ENABLE       (1<<1)
-#  define MAC_PASS_CONTROL            (1<<2)
-#  define MAC_SET_PAUSE(X)        (((X)&0xffff)<<16)
-#define MAC_VLAN1_TAG                  0x20
-#define MAC_VLAN2_TAG                  0x24
+#define MAC_CONTROL		0x0
+#  define MAC_RX_ENABLE 	(1 << 2)
+#  define MAC_TX_ENABLE 	(1 << 3)
+#  define MAC_DEF_CHECK 	(1 << 5)
+#  define MAC_SET_BL(X) 	(((X) & 0x3) << 6)
+#  define MAC_AUTO_PAD		(1 << 8)
+#  define MAC_DISABLE_RETRY	(1 << 10)
+#  define MAC_DISABLE_BCAST	(1 << 11)
+#  define MAC_LATE_COL		(1 << 12)
+#  define MAC_HASH_MODE 	(1 << 13)
+#  define MAC_HASH_ONLY 	(1 << 15)
+#  define MAC_PASS_ALL		(1 << 16)
+#  define MAC_INVERSE_FILTER	(1 << 17)
+#  define MAC_PROMISCUOUS	(1 << 18)
+#  define MAC_PASS_ALL_MULTI	(1 << 19)
+#  define MAC_FULL_DUPLEX	(1 << 20)
+#  define MAC_NORMAL_MODE	0
+#  define MAC_INT_LOOPBACK	(1 << 21)
+#  define MAC_EXT_LOOPBACK	(1 << 22)
+#  define MAC_DISABLE_RX_OWN	(1 << 23)
+#  define MAC_BIG_ENDIAN	(1 << 30)
+#  define MAC_RX_ALL		(1 << 31)
+#define MAC_ADDRESS_HIGH	0x4
+#define MAC_ADDRESS_LOW		0x8
+#define MAC_MCAST_HIGH		0xC
+#define MAC_MCAST_LOW		0x10
+#define MAC_MII_CNTRL		0x14
+#  define MAC_MII_BUSY		(1 << 0)
+#  define MAC_MII_READ		0
+#  define MAC_MII_WRITE		(1 << 1)
+#  define MAC_SET_MII_SELECT_REG(X) (((X) & 0x1f) << 6)
+#  define MAC_SET_MII_SELECT_PHY(X) (((X) & 0x1f) << 11)
+#define MAC_MII_DATA		0x18
+#define MAC_FLOW_CNTRL		0x1C
+#  define MAC_FLOW_CNTRL_BUSY	(1 << 0)
+#  define MAC_FLOW_CNTRL_ENABLE (1 << 1)
+#  define MAC_PASS_CONTROL	(1 << 2)
+#  define MAC_SET_PAUSE(X)	(((X) & 0xffff) << 16)
+#define MAC_VLAN1_TAG		0x20
+#define MAC_VLAN2_TAG		0x24
 
 /* Ethernet Controller Enable */
 
-#  define MAC_EN_CLOCK_ENABLE         (1<<0)
-#  define MAC_EN_RESET0               (1<<1)
-#  define MAC_EN_TOSS                 (0<<2)
-#  define MAC_EN_CACHEABLE            (1<<3)
-#  define MAC_EN_RESET1               (1<<4)
-#  define MAC_EN_RESET2               (1<<5)
-#  define MAC_DMA_RESET               (1<<6)
+#  define MAC_EN_CLOCK_ENABLE	(1 << 0)
+#  define MAC_EN_RESET0		(1 << 1)
+#  define MAC_EN_TOSS		(0 << 2)
+#  define MAC_EN_CACHEABLE	(1 << 3)
+#  define MAC_EN_RESET1 	(1 << 4)
+#  define MAC_EN_RESET2 	(1 << 5)
+#  define MAC_DMA_RESET 	(1 << 6)
 
 /* Ethernet Controller DMA Channels */
 
-#define MAC0_TX_DMA_ADDR         0xB4004000
-#define MAC1_TX_DMA_ADDR         0xB4004200
+#define MAC0_TX_DMA_ADDR	0xB4004000
+#define MAC1_TX_DMA_ADDR	0xB4004200
 /* offsets from MAC_TX_RING_ADDR address */
-#define MAC_TX_BUFF0_STATUS             0x0
-#  define TX_FRAME_ABORTED            (1<<0)
-#  define TX_JAB_TIMEOUT              (1<<1)
-#  define TX_NO_CARRIER               (1<<2)
-#  define TX_LOSS_CARRIER             (1<<3)
-#  define TX_EXC_DEF                  (1<<4)
-#  define TX_LATE_COLL_ABORT          (1<<5)
-#  define TX_EXC_COLL                 (1<<6)
-#  define TX_UNDERRUN                 (1<<7)
-#  define TX_DEFERRED                 (1<<8)
-#  define TX_LATE_COLL                (1<<9)
-#  define TX_COLL_CNT_MASK         (0xF<<10)
-#  define TX_PKT_RETRY               (1<<31)
-#define MAC_TX_BUFF0_ADDR                0x4
-#  define TX_DMA_ENABLE               (1<<0)
-#  define TX_T_DONE                   (1<<1)
-#  define TX_GET_DMA_BUFFER(X)    (((X)>>2)&0x3)
-#define MAC_TX_BUFF0_LEN                 0x8
-#define MAC_TX_BUFF1_STATUS             0x10
-#define MAC_TX_BUFF1_ADDR               0x14
-#define MAC_TX_BUFF1_LEN                0x18
-#define MAC_TX_BUFF2_STATUS             0x20
-#define MAC_TX_BUFF2_ADDR               0x24
-#define MAC_TX_BUFF2_LEN                0x28
-#define MAC_TX_BUFF3_STATUS             0x30
-#define MAC_TX_BUFF3_ADDR               0x34
-#define MAC_TX_BUFF3_LEN                0x38
+#define MAC_TX_BUFF0_STATUS	0x0
+#  define TX_FRAME_ABORTED	(1 << 0)
+#  define TX_JAB_TIMEOUT	(1 << 1)
+#  define TX_NO_CARRIER 	(1 << 2)
+#  define TX_LOSS_CARRIER	(1 << 3)
+#  define TX_EXC_DEF		(1 << 4)
+#  define TX_LATE_COLL_ABORT	(1 << 5)
+#  define TX_EXC_COLL		(1 << 6)
+#  define TX_UNDERRUN		(1 << 7)
+#  define TX_DEFERRED		(1 << 8)
+#  define TX_LATE_COLL		(1 << 9)
+#  define TX_COLL_CNT_MASK	(0xF << 10)
+#  define TX_PKT_RETRY		(1 << 31)
+#define MAC_TX_BUFF0_ADDR	0x4
+#  define TX_DMA_ENABLE 	(1 << 0)
+#  define TX_T_DONE		(1 << 1)
+#  define TX_GET_DMA_BUFFER(X)	(((X) >> 2) & 0x3)
+#define MAC_TX_BUFF0_LEN	0x8
+#define MAC_TX_BUFF1_STATUS	0x10
+#define MAC_TX_BUFF1_ADDR	0x14
+#define MAC_TX_BUFF1_LEN	0x18
+#define MAC_TX_BUFF2_STATUS	0x20
+#define MAC_TX_BUFF2_ADDR	0x24
+#define MAC_TX_BUFF2_LEN	0x28
+#define MAC_TX_BUFF3_STATUS	0x30
+#define MAC_TX_BUFF3_ADDR	0x34
+#define MAC_TX_BUFF3_LEN	0x38
 
-#define MAC0_RX_DMA_ADDR         0xB4004100
-#define MAC1_RX_DMA_ADDR         0xB4004300
+#define MAC0_RX_DMA_ADDR	0xB4004100
+#define MAC1_RX_DMA_ADDR	0xB4004300
 /* offsets from MAC_RX_RING_ADDR */
-#define MAC_RX_BUFF0_STATUS              0x0
-#  define RX_FRAME_LEN_MASK           0x3fff
-#  define RX_WDOG_TIMER              (1<<14)
-#  define RX_RUNT                    (1<<15)
-#  define RX_OVERLEN                 (1<<16)
-#  define RX_COLL                    (1<<17)
-#  define RX_ETHER                   (1<<18)
-#  define RX_MII_ERROR               (1<<19)
-#  define RX_DRIBBLING               (1<<20)
-#  define RX_CRC_ERROR               (1<<21)
-#  define RX_VLAN1                   (1<<22)
-#  define RX_VLAN2                   (1<<23)
-#  define RX_LEN_ERROR               (1<<24)
-#  define RX_CNTRL_FRAME             (1<<25)
-#  define RX_U_CNTRL_FRAME           (1<<26)
-#  define RX_MCAST_FRAME             (1<<27)
-#  define RX_BCAST_FRAME             (1<<28)
-#  define RX_FILTER_FAIL             (1<<29)
-#  define RX_PACKET_FILTER           (1<<30)
-#  define RX_MISSED_FRAME            (1<<31)
+#define MAC_RX_BUFF0_STATUS	0x0
+#  define RX_FRAME_LEN_MASK	0x3fff
+#  define RX_WDOG_TIMER 	(1 << 14)
+#  define RX_RUNT		(1 << 15)
+#  define RX_OVERLEN		(1 << 16)
+#  define RX_COLL		(1 << 17)
+#  define RX_ETHER		(1 << 18)
+#  define RX_MII_ERROR		(1 << 19)
+#  define RX_DRIBBLING		(1 << 20)
+#  define RX_CRC_ERROR		(1 << 21)
+#  define RX_VLAN1		(1 << 22)
+#  define RX_VLAN2		(1 << 23)
+#  define RX_LEN_ERROR		(1 << 24)
+#  define RX_CNTRL_FRAME	(1 << 25)
+#  define RX_U_CNTRL_FRAME	(1 << 26)
+#  define RX_MCAST_FRAME	(1 << 27)
+#  define RX_BCAST_FRAME	(1 << 28)
+#  define RX_FILTER_FAIL	(1 << 29)
+#  define RX_PACKET_FILTER	(1 << 30)
+#  define RX_MISSED_FRAME	(1 << 31)
 
 #  define RX_ERROR (RX_WDOG_TIMER | RX_RUNT | RX_OVERLEN |  \
-                    RX_COLL | RX_MII_ERROR | RX_CRC_ERROR | \
-                    RX_LEN_ERROR | RX_U_CNTRL_FRAME | RX_MISSED_FRAME)
-#define MAC_RX_BUFF0_ADDR                0x4
-#  define RX_DMA_ENABLE               (1<<0)
-#  define RX_T_DONE                   (1<<1)
-#  define RX_GET_DMA_BUFFER(X)    (((X)>>2)&0x3)
-#  define RX_SET_BUFF_ADDR(X)     ((X)&0xffffffc0)
-#define MAC_RX_BUFF1_STATUS              0x10
-#define MAC_RX_BUFF1_ADDR                0x14
-#define MAC_RX_BUFF2_STATUS              0x20
-#define MAC_RX_BUFF2_ADDR                0x24
-#define MAC_RX_BUFF3_STATUS              0x30
-#define MAC_RX_BUFF3_ADDR                0x34
-
+		    RX_COLL | RX_MII_ERROR | RX_CRC_ERROR | \
+		    RX_LEN_ERROR | RX_U_CNTRL_FRAME | RX_MISSED_FRAME)
+#define MAC_RX_BUFF0_ADDR	0x4
+#  define RX_DMA_ENABLE 	(1 << 0)
+#  define RX_T_DONE		(1 << 1)
+#  define RX_GET_DMA_BUFFER(X)	(((X) >> 2) & 0x3)
+#  define RX_SET_BUFF_ADDR(X)	((X) & 0xffffffc0)
+#define MAC_RX_BUFF1_STATUS	0x10
+#define MAC_RX_BUFF1_ADDR	0x14
+#define MAC_RX_BUFF2_STATUS	0x20
+#define MAC_RX_BUFF2_ADDR	0x24
+#define MAC_RX_BUFF3_STATUS	0x30
+#define MAC_RX_BUFF3_ADDR	0x34
 
 /* UARTS 0-3 */
-#define UART_BASE                 UART0_ADDR
+#define UART_BASE		UART0_ADDR
 #ifdef	CONFIG_SOC_AU1200
-#define UART_DEBUG_BASE           UART1_ADDR
+#define UART_DEBUG_BASE 	UART1_ADDR
 #else
-#define UART_DEBUG_BASE           UART3_ADDR
+#define UART_DEBUG_BASE 	UART3_ADDR
 #endif
 
 #define UART_RX		0	/* Receive buffer */
@@ -1294,341 +1293,337 @@ enum soc_au1200_ints {
 #define UART_MSR_DCTS	0x01	/* Delta CTS */
 #define UART_MSR_ANY_DELTA 0x0F	/* Any of the delta bits! */
 
-
-
 /* SSIO */
-#define SSI0_STATUS                0xB1600000
-#  define SSI_STATUS_BF              (1<<4)
-#  define SSI_STATUS_OF              (1<<3)
-#  define SSI_STATUS_UF              (1<<2)
-#  define SSI_STATUS_D               (1<<1)
-#  define SSI_STATUS_B               (1<<0)
-#define SSI0_INT                   0xB1600004
-#  define SSI_INT_OI                 (1<<3)
-#  define SSI_INT_UI                 (1<<2)
-#  define SSI_INT_DI                 (1<<1)
-#define SSI0_INT_ENABLE            0xB1600008
-#  define SSI_INTE_OIE               (1<<3)
-#  define SSI_INTE_UIE               (1<<2)
-#  define SSI_INTE_DIE               (1<<1)
-#define SSI0_CONFIG                0xB1600020
-#  define SSI_CONFIG_AO              (1<<24)
-#  define SSI_CONFIG_DO              (1<<23)
-#  define SSI_CONFIG_ALEN_BIT        20
-#    define SSI_CONFIG_ALEN_MASK       (0x7<<20)
-#  define SSI_CONFIG_DLEN_BIT        16
-#    define SSI_CONFIG_DLEN_MASK       (0x7<<16)
-#  define SSI_CONFIG_DD              (1<<11)
-#  define SSI_CONFIG_AD              (1<<10)
-#  define SSI_CONFIG_BM_BIT          8
-#    define SSI_CONFIG_BM_MASK         (0x3<<8)
-#  define SSI_CONFIG_CE              (1<<7)
-#  define SSI_CONFIG_DP              (1<<6)
-#  define SSI_CONFIG_DL              (1<<5)
-#  define SSI_CONFIG_EP              (1<<4)
-#define SSI0_ADATA                 0xB1600024
-#  define SSI_AD_D                   (1<<24)
-#  define SSI_AD_ADDR_BIT            16
-#    define SSI_AD_ADDR_MASK           (0xff<<16)
-#  define SSI_AD_DATA_BIT            0
-#    define SSI_AD_DATA_MASK           (0xfff<<0)
-#define SSI0_CLKDIV                0xB1600028
-#define SSI0_CONTROL               0xB1600100
-#  define SSI_CONTROL_CD             (1<<1)
-#  define SSI_CONTROL_E              (1<<0)
+#define SSI0_STATUS		0xB1600000
+#  define SSI_STATUS_BF 	(1 << 4)
+#  define SSI_STATUS_OF 	(1 << 3)
+#  define SSI_STATUS_UF 	(1 << 2)
+#  define SSI_STATUS_D		(1 << 1)
+#  define SSI_STATUS_B		(1 << 0)
+#define SSI0_INT		0xB1600004
+#  define SSI_INT_OI		(1 << 3)
+#  define SSI_INT_UI		(1 << 2)
+#  define SSI_INT_DI		(1 << 1)
+#define SSI0_INT_ENABLE 	0xB1600008
+#  define SSI_INTE_OIE		(1 << 3)
+#  define SSI_INTE_UIE		(1 << 2)
+#  define SSI_INTE_DIE		(1 << 1)
+#define SSI0_CONFIG		0xB1600020
+#  define SSI_CONFIG_AO 	(1 << 24)
+#  define SSI_CONFIG_DO 	(1 << 23)
+#  define SSI_CONFIG_ALEN_BIT	20
+#  define SSI_CONFIG_ALEN_MASK	(0x7 << 20)
+#  define SSI_CONFIG_DLEN_BIT	16
+#  define SSI_CONFIG_DLEN_MASK	(0x7 << 16)
+#  define SSI_CONFIG_DD 	(1 << 11)
+#  define SSI_CONFIG_AD 	(1 << 10)
+#  define SSI_CONFIG_BM_BIT	8
+#  define SSI_CONFIG_BM_MASK	(0x3 << 8)
+#  define SSI_CONFIG_CE 	(1 << 7)
+#  define SSI_CONFIG_DP 	(1 << 6)
+#  define SSI_CONFIG_DL 	(1 << 5)
+#  define SSI_CONFIG_EP 	(1 << 4)
+#define SSI0_ADATA		0xB1600024
+#  define SSI_AD_D		(1 << 24)
+#  define SSI_AD_ADDR_BIT	16
+#  define SSI_AD_ADDR_MASK	(0xff << 16)
+#  define SSI_AD_DATA_BIT	0
+#  define SSI_AD_DATA_MASK	(0xfff << 0)
+#define SSI0_CLKDIV		0xB1600028
+#define SSI0_CONTROL		0xB1600100
+#  define SSI_CONTROL_CD	(1 << 1)
+#  define SSI_CONTROL_E 	(1 << 0)
 
 /* SSI1 */
-#define SSI1_STATUS                0xB1680000
-#define SSI1_INT                   0xB1680004
-#define SSI1_INT_ENABLE            0xB1680008
-#define SSI1_CONFIG                0xB1680020
-#define SSI1_ADATA                 0xB1680024
-#define SSI1_CLKDIV                0xB1680028
-#define SSI1_ENABLE                0xB1680100
+#define SSI1_STATUS		0xB1680000
+#define SSI1_INT		0xB1680004
+#define SSI1_INT_ENABLE 	0xB1680008
+#define SSI1_CONFIG		0xB1680020
+#define SSI1_ADATA		0xB1680024
+#define SSI1_CLKDIV		0xB1680028
+#define SSI1_ENABLE		0xB1680100
 
 /*
  * Register content definitions
  */
-#define SSI_STATUS_BF				(1<<4)
-#define SSI_STATUS_OF				(1<<3)
-#define SSI_STATUS_UF				(1<<2)
-#define SSI_STATUS_D				(1<<1)
-#define SSI_STATUS_B				(1<<0)
+#define SSI_STATUS_BF		(1 << 4)
+#define SSI_STATUS_OF		(1 << 3)
+#define SSI_STATUS_UF		(1 << 2)
+#define SSI_STATUS_D		(1 << 1)
+#define SSI_STATUS_B		(1 << 0)
 
 /* SSI_INT */
-#define SSI_INT_OI					(1<<3)
-#define SSI_INT_UI					(1<<2)
-#define SSI_INT_DI					(1<<1)
+#define SSI_INT_OI		(1 << 3)
+#define SSI_INT_UI		(1 << 2)
+#define SSI_INT_DI		(1 << 1)
 
 /* SSI_INTEN */
-#define SSI_INTEN_OIE				(1<<3)
-#define SSI_INTEN_UIE				(1<<2)
-#define SSI_INTEN_DIE				(1<<1)
-
-#define SSI_CONFIG_AO				(1<<24)
-#define SSI_CONFIG_DO				(1<<23)
-#define SSI_CONFIG_ALEN				(7<<20)
-#define SSI_CONFIG_DLEN				(15<<16)
-#define SSI_CONFIG_DD				(1<<11)
-#define SSI_CONFIG_AD				(1<<10)
-#define SSI_CONFIG_BM				(3<<8)
-#define SSI_CONFIG_CE				(1<<7)
-#define SSI_CONFIG_DP				(1<<6)
-#define SSI_CONFIG_DL				(1<<5)
-#define SSI_CONFIG_EP				(1<<4)
-#define SSI_CONFIG_ALEN_N(N)		((N-1)<<20)
-#define SSI_CONFIG_DLEN_N(N)		((N-1)<<16)
-#define SSI_CONFIG_BM_HI			(0<<8)
-#define SSI_CONFIG_BM_LO			(1<<8)
-#define SSI_CONFIG_BM_CY			(2<<8)
-
-#define SSI_ADATA_D					(1<<24)
-#define SSI_ADATA_ADDR				(0xFF<<16)
-#define SSI_ADATA_DATA				(0x0FFF)
-#define SSI_ADATA_ADDR_N(N)			(N<<16)
-
-#define SSI_ENABLE_CD				(1<<1)
-#define SSI_ENABLE_E				(1<<0)
+#define SSI_INTEN_OIE		(1 << 3)
+#define SSI_INTEN_UIE		(1 << 2)
+#define SSI_INTEN_DIE		(1 << 1)
+
+#define SSI_CONFIG_AO		(1 << 24)
+#define SSI_CONFIG_DO		(1 << 23)
+#define SSI_CONFIG_ALEN 	(7 << 20)
+#define SSI_CONFIG_DLEN 	(15 << 16)
+#define SSI_CONFIG_DD		(1 << 11)
+#define SSI_CONFIG_AD		(1 << 10)
+#define SSI_CONFIG_BM		(3 << 8)
+#define SSI_CONFIG_CE		(1 << 7)
+#define SSI_CONFIG_DP		(1 << 6)
+#define SSI_CONFIG_DL		(1 << 5)
+#define SSI_CONFIG_EP		(1 << 4)
+#define SSI_CONFIG_ALEN_N(N)	((N-1) << 20)
+#define SSI_CONFIG_DLEN_N(N)	((N-1) << 16)
+#define SSI_CONFIG_BM_HI	(0 << 8)
+#define SSI_CONFIG_BM_LO	(1 << 8)
+#define SSI_CONFIG_BM_CY	(2 << 8)
+
+#define SSI_ADATA_D		(1 << 24)
+#define SSI_ADATA_ADDR		(0xFF << 16)
+#define SSI_ADATA_DATA		0x0FFF
+#define SSI_ADATA_ADDR_N(N)	(N << 16)
 
+#define SSI_ENABLE_CD		(1 << 1)
+#define SSI_ENABLE_E		(1 << 0)
 
 /* IrDA Controller */
-#define IRDA_BASE                 0xB0300000
-#define IR_RING_PTR_STATUS        (IRDA_BASE+0x00)
-#define IR_RING_BASE_ADDR_H       (IRDA_BASE+0x04)
-#define IR_RING_BASE_ADDR_L       (IRDA_BASE+0x08)
-#define IR_RING_SIZE              (IRDA_BASE+0x0C)
-#define IR_RING_PROMPT            (IRDA_BASE+0x10)
-#define IR_RING_ADDR_CMPR         (IRDA_BASE+0x14)
-#define IR_INT_CLEAR              (IRDA_BASE+0x18)
-#define IR_CONFIG_1               (IRDA_BASE+0x20)
-#  define IR_RX_INVERT_LED        (1<<0)
-#  define IR_TX_INVERT_LED        (1<<1)
-#  define IR_ST                   (1<<2)
-#  define IR_SF                   (1<<3)
-#  define IR_SIR                  (1<<4)
-#  define IR_MIR                  (1<<5)
-#  define IR_FIR                  (1<<6)
-#  define IR_16CRC                (1<<7)
-#  define IR_TD                   (1<<8)
-#  define IR_RX_ALL               (1<<9)
-#  define IR_DMA_ENABLE           (1<<10)
-#  define IR_RX_ENABLE            (1<<11)
-#  define IR_TX_ENABLE            (1<<12)
-#  define IR_LOOPBACK             (1<<14)
-#  define IR_SIR_MODE	          (IR_SIR | IR_DMA_ENABLE | \
-		                   IR_RX_ALL | IR_RX_ENABLE | IR_SF | IR_16CRC)
-#define IR_SIR_FLAGS              (IRDA_BASE+0x24)
-#define IR_ENABLE                 (IRDA_BASE+0x28)
-#  define IR_RX_STATUS            (1<<9)
-#  define IR_TX_STATUS            (1<<10)
-#define IR_READ_PHY_CONFIG        (IRDA_BASE+0x2C)
-#define IR_WRITE_PHY_CONFIG       (IRDA_BASE+0x30)
-#define IR_MAX_PKT_LEN            (IRDA_BASE+0x34)
-#define IR_RX_BYTE_CNT            (IRDA_BASE+0x38)
-#define IR_CONFIG_2               (IRDA_BASE+0x3C)
-#  define IR_MODE_INV             (1<<0)
-#  define IR_ONE_PIN              (1<<1)
-#define IR_INTERFACE_CONFIG       (IRDA_BASE+0x40)
+#define IRDA_BASE		0xB0300000
+#define IR_RING_PTR_STATUS	(IRDA_BASE + 0x00)
+#define IR_RING_BASE_ADDR_H	(IRDA_BASE + 0x04)
+#define IR_RING_BASE_ADDR_L	(IRDA_BASE + 0x08)
+#define IR_RING_SIZE		(IRDA_BASE + 0x0C)
+#define IR_RING_PROMPT		(IRDA_BASE + 0x10)
+#define IR_RING_ADDR_CMPR	(IRDA_BASE + 0x14)
+#define IR_INT_CLEAR		(IRDA_BASE + 0x18)
+#define IR_CONFIG_1		(IRDA_BASE + 0x20)
+#  define IR_RX_INVERT_LED	(1 << 0)
+#  define IR_TX_INVERT_LED	(1 << 1)
+#  define IR_ST 		(1 << 2)
+#  define IR_SF 		(1 << 3)
+#  define IR_SIR		(1 << 4)
+#  define IR_MIR		(1 << 5)
+#  define IR_FIR		(1 << 6)
+#  define IR_16CRC		(1 << 7)
+#  define IR_TD 		(1 << 8)
+#  define IR_RX_ALL		(1 << 9)
+#  define IR_DMA_ENABLE 	(1 << 10)
+#  define IR_RX_ENABLE		(1 << 11)
+#  define IR_TX_ENABLE		(1 << 12)
+#  define IR_LOOPBACK		(1 << 14)
+#  define IR_SIR_MODE		(IR_SIR | IR_DMA_ENABLE | \
+				 IR_RX_ALL | IR_RX_ENABLE | IR_SF | IR_16CRC)
+#define IR_SIR_FLAGS		(IRDA_BASE + 0x24)
+#define IR_ENABLE		(IRDA_BASE + 0x28)
+#  define IR_RX_STATUS		(1 << 9)
+#  define IR_TX_STATUS		(1 << 10)
+#define IR_READ_PHY_CONFIG	(IRDA_BASE + 0x2C)
+#define IR_WRITE_PHY_CONFIG	(IRDA_BASE + 0x30)
+#define IR_MAX_PKT_LEN		(IRDA_BASE + 0x34)
+#define IR_RX_BYTE_CNT		(IRDA_BASE + 0x38)
+#define IR_CONFIG_2		(IRDA_BASE + 0x3C)
+#  define IR_MODE_INV		(1 << 0)
+#  define IR_ONE_PIN		(1 << 1)
+#define IR_INTERFACE_CONFIG	(IRDA_BASE + 0x40)
 
 /* GPIO */
-#define SYS_PINFUNC               0xB190002C
-#  define SYS_PF_USB			(1<<15)	/* 2nd USB device/host */
-#  define SYS_PF_U3			(1<<14)	/* GPIO23/U3TXD */
-#  define SYS_PF_U2			(1<<13) /* GPIO22/U2TXD */
-#  define SYS_PF_U1			(1<<12) /* GPIO21/U1TXD */
-#  define SYS_PF_SRC			(1<<11)	/* GPIO6/SROMCKE */
-#  define SYS_PF_CK5			(1<<10)	/* GPIO3/CLK5 */
-#  define SYS_PF_CK4			(1<<9)	/* GPIO2/CLK4 */
-#  define SYS_PF_IRF			(1<<8)	/* GPIO15/IRFIRSEL */
-#  define SYS_PF_UR3			(1<<7)	/* GPIO[14:9]/UART3 */
-#  define SYS_PF_I2D			(1<<6)	/* GPIO8/I2SDI */
-#  define SYS_PF_I2S			(1<<5)	/* I2S/GPIO[29:31] */
-#  define SYS_PF_NI2			(1<<4)	/* NI2/GPIO[24:28] */
-#  define SYS_PF_U0			(1<<3)	/* U0TXD/GPIO20 */
-#  define SYS_PF_RD			(1<<2)	/* IRTXD/GPIO19 */
-#  define SYS_PF_A97			(1<<1)	/* AC97/SSL1 */
-#  define SYS_PF_S0			(1<<0)	/* SSI_0/GPIO[16:18] */
-
-/* Au1100 Only */
-#  define SYS_PF_PC			(1<<18)	/* PCMCIA/GPIO[207:204] */
-#  define SYS_PF_LCD			(1<<17)	/* extern lcd/GPIO[203:200] */
-#  define SYS_PF_CS			(1<<16)	/* EXTCLK0/32khz to gpio2 */
-#  define SYS_PF_EX0			(1<<9)	/* gpio2/clock */
-
-/* Au1550 Only.  Redefines lots of pins */
-#  define SYS_PF_PSC2_MASK		(7 << 17)
-#  define SYS_PF_PSC2_AC97		(0)
-#  define SYS_PF_PSC2_SPI		(0)
-#  define SYS_PF_PSC2_I2S		(1 << 17)
-#  define SYS_PF_PSC2_SMBUS		(3 << 17)
-#  define SYS_PF_PSC2_GPIO		(7 << 17)
-#  define SYS_PF_PSC3_MASK		(7 << 20)
-#  define SYS_PF_PSC3_AC97		(0)
-#  define SYS_PF_PSC3_SPI		(0)
-#  define SYS_PF_PSC3_I2S		(1 << 20)
-#  define SYS_PF_PSC3_SMBUS		(3 << 20)
-#  define SYS_PF_PSC3_GPIO		(7 << 20)
-#  define SYS_PF_PSC1_S1		(1 << 1)
-#  define SYS_PF_MUST_BE_SET		((1 << 5) | (1 << 2))
+#define SYS_PINFUNC		0xB190002C
+#  define SYS_PF_USB		(1 << 15)	/* 2nd USB device/host */
+#  define SYS_PF_U3		(1 << 14)	/* GPIO23/U3TXD */
+#  define SYS_PF_U2		(1 << 13)	/* GPIO22/U2TXD */
+#  define SYS_PF_U1		(1 << 12)	/* GPIO21/U1TXD */
+#  define SYS_PF_SRC		(1 << 11)	/* GPIO6/SROMCKE */
+#  define SYS_PF_CK5		(1 << 10)	/* GPIO3/CLK5 */
+#  define SYS_PF_CK4		(1 << 9)	/* GPIO2/CLK4 */
+#  define SYS_PF_IRF		(1 << 8)	/* GPIO15/IRFIRSEL */
+#  define SYS_PF_UR3		(1 << 7)	/* GPIO[14:9]/UART3 */
+#  define SYS_PF_I2D		(1 << 6)	/* GPIO8/I2SDI */
+#  define SYS_PF_I2S		(1 << 5)	/* I2S/GPIO[29:31] */
+#  define SYS_PF_NI2		(1 << 4)	/* NI2/GPIO[24:28] */
+#  define SYS_PF_U0		(1 << 3)	/* U0TXD/GPIO20 */
+#  define SYS_PF_RD		(1 << 2)	/* IRTXD/GPIO19 */
+#  define SYS_PF_A97		(1 << 1)	/* AC97/SSL1 */
+#  define SYS_PF_S0		(1 << 0)	/* SSI_0/GPIO[16:18] */
+
+/* Au1100 only */
+#  define SYS_PF_PC		(1 << 18)	/* PCMCIA/GPIO[207:204] */
+#  define SYS_PF_LCD		(1 << 17)	/* extern lcd/GPIO[203:200] */
+#  define SYS_PF_CS		(1 << 16)	/* EXTCLK0/32KHz to gpio2 */
+#  define SYS_PF_EX0		(1 << 9)	/* GPIO2/clock */
+
+/* Au1550 only.  Redefines lots of pins */
+#  define SYS_PF_PSC2_MASK	(7 << 17)
+#  define SYS_PF_PSC2_AC97	0
+#  define SYS_PF_PSC2_SPI	0
+#  define SYS_PF_PSC2_I2S	(1 << 17)
+#  define SYS_PF_PSC2_SMBUS	(3 << 17)
+#  define SYS_PF_PSC2_GPIO	(7 << 17)
+#  define SYS_PF_PSC3_MASK	(7 << 20)
+#  define SYS_PF_PSC3_AC97	0
+#  define SYS_PF_PSC3_SPI	0
+#  define SYS_PF_PSC3_I2S	(1 << 20)
+#  define SYS_PF_PSC3_SMBUS	(3 << 20)
+#  define SYS_PF_PSC3_GPIO	(7 << 20)
+#  define SYS_PF_PSC1_S1	(1 << 1)
+#  define SYS_PF_MUST_BE_SET	((1 << 5) | (1 << 2))
 
-/* Au1200 Only */
+/* Au1200 only */
 #ifdef CONFIG_SOC_AU1200
-#define SYS_PINFUNC_DMA		(1<<31)
-#define SYS_PINFUNC_S0A		(1<<30)
-#define SYS_PINFUNC_S1A		(1<<29)
-#define SYS_PINFUNC_LP0		(1<<28)
-#define SYS_PINFUNC_LP1		(1<<27)
-#define SYS_PINFUNC_LD16	(1<<26)
-#define SYS_PINFUNC_LD8		(1<<25)
-#define SYS_PINFUNC_LD1		(1<<24)
-#define SYS_PINFUNC_LD0		(1<<23)
-#define SYS_PINFUNC_P1A		(3<<21)
-#define SYS_PINFUNC_P1B		(1<<20)
-#define SYS_PINFUNC_FS3		(1<<19)
-#define SYS_PINFUNC_P0A		(3<<17)
-#define SYS_PINFUNC_CS		(1<<16)
-#define SYS_PINFUNC_CIM		(1<<15)
-#define SYS_PINFUNC_P1C		(1<<14)
-#define SYS_PINFUNC_U1T		(1<<12)
-#define SYS_PINFUNC_U1R		(1<<11)
-#define SYS_PINFUNC_EX1		(1<<10)
-#define SYS_PINFUNC_EX0		(1<<9)
-#define SYS_PINFUNC_U0R		(1<<8)
-#define SYS_PINFUNC_MC		(1<<7)
-#define SYS_PINFUNC_S0B		(1<<6)
-#define SYS_PINFUNC_S0C		(1<<5)
-#define SYS_PINFUNC_P0B		(1<<4)
-#define SYS_PINFUNC_U0T		(1<<3)
-#define SYS_PINFUNC_S1B		(1<<2)
+#define SYS_PINFUNC_DMA 	(1 << 31)
+#define SYS_PINFUNC_S0A 	(1 << 30)
+#define SYS_PINFUNC_S1A 	(1 << 29)
+#define SYS_PINFUNC_LP0 	(1 << 28)
+#define SYS_PINFUNC_LP1 	(1 << 27)
+#define SYS_PINFUNC_LD16 	(1 << 26)
+#define SYS_PINFUNC_LD8 	(1 << 25)
+#define SYS_PINFUNC_LD1 	(1 << 24)
+#define SYS_PINFUNC_LD0 	(1 << 23)
+#define SYS_PINFUNC_P1A 	(3 << 21)
+#define SYS_PINFUNC_P1B 	(1 << 20)
+#define SYS_PINFUNC_FS3 	(1 << 19)
+#define SYS_PINFUNC_P0A 	(3 << 17)
+#define SYS_PINFUNC_CS		(1 << 16)
+#define SYS_PINFUNC_CIM 	(1 << 15)
+#define SYS_PINFUNC_P1C 	(1 << 14)
+#define SYS_PINFUNC_U1T 	(1 << 12)
+#define SYS_PINFUNC_U1R 	(1 << 11)
+#define SYS_PINFUNC_EX1 	(1 << 10)
+#define SYS_PINFUNC_EX0 	(1 << 9)
+#define SYS_PINFUNC_U0R 	(1 << 8)
+#define SYS_PINFUNC_MC		(1 << 7)
+#define SYS_PINFUNC_S0B 	(1 << 6)
+#define SYS_PINFUNC_S0C 	(1 << 5)
+#define SYS_PINFUNC_P0B 	(1 << 4)
+#define SYS_PINFUNC_U0T 	(1 << 3)
+#define SYS_PINFUNC_S1B 	(1 << 2)
 #endif
 
-#define SYS_TRIOUTRD              0xB1900100
-#define SYS_TRIOUTCLR             0xB1900100
-#define SYS_OUTPUTRD              0xB1900108
-#define SYS_OUTPUTSET             0xB1900108
-#define SYS_OUTPUTCLR             0xB190010C
-#define SYS_PINSTATERD            0xB1900110
-#define SYS_PININPUTEN            0xB1900110
+#define SYS_TRIOUTRD		0xB1900100
+#define SYS_TRIOUTCLR		0xB1900100
+#define SYS_OUTPUTRD		0xB1900108
+#define SYS_OUTPUTSET		0xB1900108
+#define SYS_OUTPUTCLR		0xB190010C
+#define SYS_PINSTATERD		0xB1900110
+#define SYS_PININPUTEN		0xB1900110
 
 /* GPIO2, Au1500, Au1550 only */
-#define GPIO2_BASE                0xB1700000
-#define GPIO2_DIR                 (GPIO2_BASE + 0)
-#define GPIO2_OUTPUT              (GPIO2_BASE + 8)
-#define GPIO2_PINSTATE            (GPIO2_BASE + 0xC)
-#define GPIO2_INTENABLE           (GPIO2_BASE + 0x10)
-#define GPIO2_ENABLE              (GPIO2_BASE + 0x14)
+#define GPIO2_BASE		0xB1700000
+#define GPIO2_DIR		(GPIO2_BASE + 0)
+#define GPIO2_OUTPUT		(GPIO2_BASE + 8)
+#define GPIO2_PINSTATE		(GPIO2_BASE + 0xC)
+#define GPIO2_INTENABLE 	(GPIO2_BASE + 0x10)
+#define GPIO2_ENABLE		(GPIO2_BASE + 0x14)
 
 /* Power Management */
-#define SYS_SCRATCH0              0xB1900018
-#define SYS_SCRATCH1              0xB190001C
-#define SYS_WAKEMSK               0xB1900034
-#define SYS_ENDIAN                0xB1900038
-#define SYS_POWERCTRL             0xB190003C
-#define SYS_WAKESRC               0xB190005C
-#define SYS_SLPPWR                0xB1900078
-#define SYS_SLEEP                 0xB190007C
+#define SYS_SCRATCH0		0xB1900018
+#define SYS_SCRATCH1		0xB190001C
+#define SYS_WAKEMSK		0xB1900034
+#define SYS_ENDIAN		0xB1900038
+#define SYS_POWERCTRL		0xB190003C
+#define SYS_WAKESRC		0xB190005C
+#define SYS_SLPPWR		0xB1900078
+#define SYS_SLEEP		0xB190007C
 
 /* Clock Controller */
-#define SYS_FREQCTRL0             0xB1900020
-#  define SYS_FC_FRDIV2_BIT         22
-#  define SYS_FC_FRDIV2_MASK        (0xff << SYS_FC_FRDIV2_BIT)
-#  define SYS_FC_FE2                (1<<21)
-#  define SYS_FC_FS2                (1<<20)
-#  define SYS_FC_FRDIV1_BIT         12
-#  define SYS_FC_FRDIV1_MASK        (0xff << SYS_FC_FRDIV1_BIT)
-#  define SYS_FC_FE1                (1<<11)
-#  define SYS_FC_FS1                (1<<10)
-#  define SYS_FC_FRDIV0_BIT         2
-#  define SYS_FC_FRDIV0_MASK        (0xff << SYS_FC_FRDIV0_BIT)
-#  define SYS_FC_FE0                (1<<1)
-#  define SYS_FC_FS0                (1<<0)
-#define SYS_FREQCTRL1             0xB1900024
-#  define SYS_FC_FRDIV5_BIT         22
-#  define SYS_FC_FRDIV5_MASK        (0xff << SYS_FC_FRDIV5_BIT)
-#  define SYS_FC_FE5                (1<<21)
-#  define SYS_FC_FS5                (1<<20)
-#  define SYS_FC_FRDIV4_BIT         12
-#  define SYS_FC_FRDIV4_MASK        (0xff << SYS_FC_FRDIV4_BIT)
-#  define SYS_FC_FE4                (1<<11)
-#  define SYS_FC_FS4                (1<<10)
-#  define SYS_FC_FRDIV3_BIT         2
-#  define SYS_FC_FRDIV3_MASK        (0xff << SYS_FC_FRDIV3_BIT)
-#  define SYS_FC_FE3                (1<<1)
-#  define SYS_FC_FS3                (1<<0)
-#define SYS_CLKSRC                0xB1900028
-#  define SYS_CS_ME1_BIT            27
-#  define SYS_CS_ME1_MASK           (0x7<<SYS_CS_ME1_BIT)
-#  define SYS_CS_DE1                (1<<26)
-#  define SYS_CS_CE1                (1<<25)
-#  define SYS_CS_ME0_BIT            22
-#  define SYS_CS_ME0_MASK           (0x7<<SYS_CS_ME0_BIT)
-#  define SYS_CS_DE0                (1<<21)
-#  define SYS_CS_CE0                (1<<20)
-#  define SYS_CS_MI2_BIT            17
-#  define SYS_CS_MI2_MASK           (0x7<<SYS_CS_MI2_BIT)
-#  define SYS_CS_DI2                (1<<16)
-#  define SYS_CS_CI2                (1<<15)
+#define SYS_FREQCTRL0		0xB1900020
+#  define SYS_FC_FRDIV2_BIT	22
+#  define SYS_FC_FRDIV2_MASK	(0xff << SYS_FC_FRDIV2_BIT)
+#  define SYS_FC_FE2		(1 << 21)
+#  define SYS_FC_FS2		(1 << 20)
+#  define SYS_FC_FRDIV1_BIT	12
+#  define SYS_FC_FRDIV1_MASK	(0xff << SYS_FC_FRDIV1_BIT)
+#  define SYS_FC_FE1		(1 << 11)
+#  define SYS_FC_FS1		(1 << 10)
+#  define SYS_FC_FRDIV0_BIT	2
+#  define SYS_FC_FRDIV0_MASK	(0xff << SYS_FC_FRDIV0_BIT)
+#  define SYS_FC_FE0		(1 << 1)
+#  define SYS_FC_FS0		(1 << 0)
+#define SYS_FREQCTRL1		0xB1900024
+#  define SYS_FC_FRDIV5_BIT	22
+#  define SYS_FC_FRDIV5_MASK	(0xff << SYS_FC_FRDIV5_BIT)
+#  define SYS_FC_FE5		(1 << 21)
+#  define SYS_FC_FS5		(1 << 20)
+#  define SYS_FC_FRDIV4_BIT	12
+#  define SYS_FC_FRDIV4_MASK	(0xff << SYS_FC_FRDIV4_BIT)
+#  define SYS_FC_FE4		(1 << 11)
+#  define SYS_FC_FS4		(1 << 10)
+#  define SYS_FC_FRDIV3_BIT	2
+#  define SYS_FC_FRDIV3_MASK	(0xff << SYS_FC_FRDIV3_BIT)
+#  define SYS_FC_FE3		(1 << 1)
+#  define SYS_FC_FS3		(1 << 0)
+#define SYS_CLKSRC		0xB1900028
+#  define SYS_CS_ME1_BIT	27
+#  define SYS_CS_ME1_MASK	(0x7 << SYS_CS_ME1_BIT)
+#  define SYS_CS_DE1		(1 << 26)
+#  define SYS_CS_CE1		(1 << 25)
+#  define SYS_CS_ME0_BIT	22
+#  define SYS_CS_ME0_MASK	(0x7 << SYS_CS_ME0_BIT)
+#  define SYS_CS_DE0		(1 << 21)
+#  define SYS_CS_CE0		(1 << 20)
+#  define SYS_CS_MI2_BIT	17
+#  define SYS_CS_MI2_MASK	(0x7 << SYS_CS_MI2_BIT)
+#  define SYS_CS_DI2		(1 << 16)
+#  define SYS_CS_CI2		(1 << 15)
 #ifdef CONFIG_SOC_AU1100
-#  define SYS_CS_ML_BIT             7
-#  define SYS_CS_ML_MASK            (0x7<<SYS_CS_ML_BIT)
-#  define SYS_CS_DL                 (1<<6)
-#  define SYS_CS_CL                 (1<<5)
+#  define SYS_CS_ML_BIT 	7
+#  define SYS_CS_ML_MASK	(0x7 << SYS_CS_ML_BIT)
+#  define SYS_CS_DL		(1 << 6)
+#  define SYS_CS_CL		(1 << 5)
 #else
-#  define SYS_CS_MUH_BIT            12
-#  define SYS_CS_MUH_MASK           (0x7<<SYS_CS_MUH_BIT)
-#  define SYS_CS_DUH                (1<<11)
-#  define SYS_CS_CUH                (1<<10)
-#  define SYS_CS_MUD_BIT            7
-#  define SYS_CS_MUD_MASK           (0x7<<SYS_CS_MUD_BIT)
-#  define SYS_CS_DUD                (1<<6)
-#  define SYS_CS_CUD                (1<<5)
+#  define SYS_CS_MUH_BIT	12
+#  define SYS_CS_MUH_MASK	(0x7 << SYS_CS_MUH_BIT)
+#  define SYS_CS_DUH		(1 << 11)
+#  define SYS_CS_CUH		(1 << 10)
+#  define SYS_CS_MUD_BIT	7
+#  define SYS_CS_MUD_MASK	(0x7 << SYS_CS_MUD_BIT)
+#  define SYS_CS_DUD		(1 << 6)
+#  define SYS_CS_CUD		(1 << 5)
 #endif
-#  define SYS_CS_MIR_BIT            2
-#  define SYS_CS_MIR_MASK           (0x7<<SYS_CS_MIR_BIT)
-#  define SYS_CS_DIR                (1<<1)
-#  define SYS_CS_CIR                (1<<0)
-
-#  define SYS_CS_MUX_AUX            0x1
-#  define SYS_CS_MUX_FQ0            0x2
-#  define SYS_CS_MUX_FQ1            0x3
-#  define SYS_CS_MUX_FQ2            0x4
-#  define SYS_CS_MUX_FQ3            0x5
-#  define SYS_CS_MUX_FQ4            0x6
-#  define SYS_CS_MUX_FQ5            0x7
-#define SYS_CPUPLL                0xB1900060
-#define SYS_AUXPLL                0xB1900064
+#  define SYS_CS_MIR_BIT	2
+#  define SYS_CS_MIR_MASK	(0x7 << SYS_CS_MIR_BIT)
+#  define SYS_CS_DIR		(1 << 1)
+#  define SYS_CS_CIR		(1 << 0)
+
+#  define SYS_CS_MUX_AUX	0x1
+#  define SYS_CS_MUX_FQ0	0x2
+#  define SYS_CS_MUX_FQ1	0x3
+#  define SYS_CS_MUX_FQ2	0x4
+#  define SYS_CS_MUX_FQ3	0x5
+#  define SYS_CS_MUX_FQ4	0x6
+#  define SYS_CS_MUX_FQ5	0x7
+#define SYS_CPUPLL		0xB1900060
+#define SYS_AUXPLL		0xB1900064
 
 /* AC97 Controller */
-#define AC97C_CONFIG              0xB0000000
-#  define AC97C_RECV_SLOTS_BIT  13
+#define AC97C_CONFIG		0xB0000000
+#  define AC97C_RECV_SLOTS_BIT	13
 #  define AC97C_RECV_SLOTS_MASK (0x3ff << AC97C_RECV_SLOTS_BIT)
-#  define AC97C_XMIT_SLOTS_BIT  3
+#  define AC97C_XMIT_SLOTS_BIT	3
 #  define AC97C_XMIT_SLOTS_MASK (0x3ff << AC97C_XMIT_SLOTS_BIT)
-#  define AC97C_SG              (1<<2)
-#  define AC97C_SYNC            (1<<1)
-#  define AC97C_RESET           (1<<0)
-#define AC97C_STATUS              0xB0000004
-#  define AC97C_XU              (1<<11)
-#  define AC97C_XO              (1<<10)
-#  define AC97C_RU              (1<<9)
-#  define AC97C_RO              (1<<8)
-#  define AC97C_READY           (1<<7)
-#  define AC97C_CP              (1<<6)
-#  define AC97C_TR              (1<<5)
-#  define AC97C_TE              (1<<4)
-#  define AC97C_TF              (1<<3)
-#  define AC97C_RR              (1<<2)
-#  define AC97C_RE              (1<<1)
-#  define AC97C_RF              (1<<0)
-#define AC97C_DATA                0xB0000008
-#define AC97C_CMD                 0xB000000C
-#  define AC97C_WD_BIT          16
-#  define AC97C_READ            (1<<7)
-#  define AC97C_INDEX_MASK      0x7f
-#define AC97C_CNTRL               0xB0000010
-#  define AC97C_RS              (1<<1)
-#  define AC97C_CE              (1<<0)
-
+#  define AC97C_SG		(1 << 2)
+#  define AC97C_SYNC		(1 << 1)
+#  define AC97C_RESET		(1 << 0)
+#define AC97C_STATUS		0xB0000004
+#  define AC97C_XU		(1 << 11)
+#  define AC97C_XO		(1 << 10)
+#  define AC97C_RU		(1 << 9)
+#  define AC97C_RO		(1 << 8)
+#  define AC97C_READY		(1 << 7)
+#  define AC97C_CP		(1 << 6)
+#  define AC97C_TR		(1 << 5)
+#  define AC97C_TE		(1 << 4)
+#  define AC97C_TF		(1 << 3)
+#  define AC97C_RR		(1 << 2)
+#  define AC97C_RE		(1 << 1)
+#  define AC97C_RF		(1 << 0)
+#define AC97C_DATA		0xB0000008
+#define AC97C_CMD		0xB000000C
+#  define AC97C_WD_BIT		16
+#  define AC97C_READ		(1 << 7)
+#  define AC97C_INDEX_MASK	0x7f
+#define AC97C_CNTRL		0xB0000010
+#  define AC97C_RS		(1 << 1)
+#  define AC97C_CE		(1 << 0)
 
 /* Secure Digital (SD) Controller */
 #define SD0_XMIT_FIFO	0xB0600000
@@ -1638,73 +1633,74 @@ enum soc_au1200_ints {
 
 #if defined(CONFIG_SOC_AU1500) || defined(CONFIG_SOC_AU1550)
 /* Au1500 PCI Controller */
-#define Au1500_CFG_BASE           0xB4005000 // virtual, kseg0 addr
-#define Au1500_PCI_CMEM           (Au1500_CFG_BASE + 0)
-#define Au1500_PCI_CFG            (Au1500_CFG_BASE + 4)
-#  define PCI_ERROR ((1<<22) | (1<<23) | (1<<24) | (1<<25) | (1<<26) | (1<<27))
-#define Au1500_PCI_B2BMASK_CCH    (Au1500_CFG_BASE + 8)
-#define Au1500_PCI_B2B0_VID       (Au1500_CFG_BASE + 0xC)
-#define Au1500_PCI_B2B1_ID        (Au1500_CFG_BASE + 0x10)
-#define Au1500_PCI_MWMASK_DEV     (Au1500_CFG_BASE + 0x14)
+#define Au1500_CFG_BASE 	0xB4005000	/* virtual, KSEG1 addr */
+#define Au1500_PCI_CMEM 	(Au1500_CFG_BASE + 0)
+#define Au1500_PCI_CFG		(Au1500_CFG_BASE + 4)
+#  define PCI_ERROR		((1 << 22) | (1 << 23) | (1 << 24) | \
+				 (1 << 25) | (1 << 26) | (1 << 27))
+#define Au1500_PCI_B2BMASK_CCH	(Au1500_CFG_BASE + 8)
+#define Au1500_PCI_B2B0_VID	(Au1500_CFG_BASE + 0xC)
+#define Au1500_PCI_B2B1_ID	(Au1500_CFG_BASE + 0x10)
+#define Au1500_PCI_MWMASK_DEV	(Au1500_CFG_BASE + 0x14)
 #define Au1500_PCI_MWBASE_REV_CCL (Au1500_CFG_BASE + 0x18)
-#define Au1500_PCI_ERR_ADDR       (Au1500_CFG_BASE + 0x1C)
-#define Au1500_PCI_SPEC_INTACK    (Au1500_CFG_BASE + 0x20)
-#define Au1500_PCI_ID             (Au1500_CFG_BASE + 0x100)
-#define Au1500_PCI_STATCMD        (Au1500_CFG_BASE + 0x104)
-#define Au1500_PCI_CLASSREV       (Au1500_CFG_BASE + 0x108)
-#define Au1500_PCI_HDRTYPE        (Au1500_CFG_BASE + 0x10C)
-#define Au1500_PCI_MBAR           (Au1500_CFG_BASE + 0x110)
+#define Au1500_PCI_ERR_ADDR	(Au1500_CFG_BASE + 0x1C)
+#define Au1500_PCI_SPEC_INTACK	(Au1500_CFG_BASE + 0x20)
+#define Au1500_PCI_ID		(Au1500_CFG_BASE + 0x100)
+#define Au1500_PCI_STATCMD	(Au1500_CFG_BASE + 0x104)
+#define Au1500_PCI_CLASSREV	(Au1500_CFG_BASE + 0x108)
+#define Au1500_PCI_HDRTYPE	(Au1500_CFG_BASE + 0x10C)
+#define Au1500_PCI_MBAR 	(Au1500_CFG_BASE + 0x110)
 
-#define Au1500_PCI_HDR            0xB4005100 // virtual, kseg0 addr
+#define Au1500_PCI_HDR		0xB4005100	/* virtual, KSEG1 addr */
 
-/* All of our structures, like pci resource, have 32 bit members.
+/*
+ * All of our structures, like PCI resource, have 32-bit members.
  * Drivers are expected to do an ioremap on the PCI MEM resource, but it's
- * hard to store 0x4 0000 0000 in a 32 bit type.  We require a small patch
+ * hard to store 0x4 0000 0000 in a 32-bit type.  We require a small patch
  * to __ioremap to check for addresses between (u32)Au1500_PCI_MEM_START and
- * (u32)Au1500_PCI_MEM_END and change those to the full 36 bit PCI MEM
- * addresses.  For PCI IO, it's simpler because we get to do the ioremap
+ * (u32)Au1500_PCI_MEM_END and change those to the full 36-bit PCI MEM
+ * addresses.  For PCI I/O, it's simpler because we get to do the ioremap
  * ourselves and then adjust the device's resources.
  */
-#define Au1500_EXT_CFG            0x600000000ULL
-#define Au1500_EXT_CFG_TYPE1      0x680000000ULL
-#define Au1500_PCI_IO_START       0x500000000ULL
-#define Au1500_PCI_IO_END         0x5000FFFFFULL
-#define Au1500_PCI_MEM_START      0x440000000ULL
-#define Au1500_PCI_MEM_END        0x44FFFFFFFULL
+#define Au1500_EXT_CFG		0x600000000ULL
+#define Au1500_EXT_CFG_TYPE1	0x680000000ULL
+#define Au1500_PCI_IO_START	0x500000000ULL
+#define Au1500_PCI_IO_END	0x5000FFFFFULL
+#define Au1500_PCI_MEM_START	0x440000000ULL
+#define Au1500_PCI_MEM_END	0x44FFFFFFFULL
 
 #define PCI_IO_START	0x00001000
 #define PCI_IO_END	0x000FFFFF
 #define PCI_MEM_START	0x40000000
 #define PCI_MEM_END	0x4FFFFFFF
 
-#define PCI_FIRST_DEVFN (0<<3)
-#define PCI_LAST_DEVFN  (19<<3)
+#define PCI_FIRST_DEVFN (0 << 3)
+#define PCI_LAST_DEVFN	(19 << 3)
 
-#define IOPORT_RESOURCE_START 0x00001000 /* skip legacy probing */
-#define IOPORT_RESOURCE_END   0xffffffff
-#define IOMEM_RESOURCE_START  0x10000000
-#define IOMEM_RESOURCE_END    0xffffffff
+#define IOPORT_RESOURCE_START	0x00001000	/* skip legacy probing */
+#define IOPORT_RESOURCE_END	0xffffffff
+#define IOMEM_RESOURCE_START	0x10000000
+#define IOMEM_RESOURCE_END	0xffffffff
 
 #else /* Au1000 and Au1100 and Au1200 */
 
-/* don't allow any legacy ports probing */
-#define IOPORT_RESOURCE_START 0x10000000
-#define IOPORT_RESOURCE_END   0xffffffff
-#define IOMEM_RESOURCE_START  0x10000000
-#define IOMEM_RESOURCE_END    0xffffffff
-
-#define PCI_IO_START    0
-#define PCI_IO_END      0
-#define PCI_MEM_START   0
-#define PCI_MEM_END     0
+/* Don't allow any legacy ports probing */
+#define IOPORT_RESOURCE_START	0x10000000
+#define IOPORT_RESOURCE_END	0xffffffff
+#define IOMEM_RESOURCE_START	0x10000000
+#define IOMEM_RESOURCE_END	0xffffffff
+
+#define PCI_IO_START	0
+#define PCI_IO_END	0
+#define PCI_MEM_START	0
+#define PCI_MEM_END	0
 #define PCI_FIRST_DEVFN 0
-#define PCI_LAST_DEVFN  0
+#define PCI_LAST_DEVFN	0
 
 #endif
 
 #ifndef _LANGUAGE_ASSEMBLY
-typedef volatile struct
-{
+typedef volatile struct {
 	/* 0x0000 */ u32 toytrim;
 	/* 0x0004 */ u32 toywrite;
 	/* 0x0008 */ u32 toymatch0;
@@ -1746,13 +1742,14 @@ typedef volatile struct
 	/* 0x010C */ u32 outputclr;
 	/* 0x0110 */ u32 pinstaterd;
 #define pininputen pinstaterd
-
 } AU1X00_SYS;
 
-static AU1X00_SYS* const sys  = (AU1X00_SYS *)SYS_BASE;
+static AU1X00_SYS * const sys = (AU1X00_SYS *)SYS_BASE;
 
 #endif
-/* Processor information base on prid.
+
+/*
+ * Processor information based on PRID.
  * Copied from PowerPC.
  */
 #ifndef _LANGUAGE_ASSEMBLY
@@ -1767,9 +1764,8 @@ struct cpu_spec {
 	unsigned char	cpu_pll_wo;	/* sys_cpupll reg. write-only */
 };
 
-extern struct cpu_spec		cpu_specs[];
-extern struct cpu_spec		*cur_cpu_spec[];
+extern struct cpu_spec	cpu_specs[];
+extern struct cpu_spec	*cur_cpu_spec[];
 #endif
 
 #endif
-
Index: linux-2.6/include/asm-mips/mach-au1x00/au1000_dma.h
===================================================================
--- linux-2.6.orig/include/asm-mips/mach-au1x00/au1000_dma.h
+++ linux-2.6/include/asm-mips/mach-au1x00/au1000_dma.h
@@ -1,11 +1,10 @@
 /*
  * BRIEF MODULE DESCRIPTION
- *	Defines for using and allocating dma channels on the Alchemy
- *      Au1000 mips processor.
+ *	Defines for using and allocating DMA channels on the Alchemy
+ *      Au1x00 MIPS processors.
  *
- * Copyright 2000 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *         	stevel@mvista.com or source@mvista.com
+ * Copyright 2000, 2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -31,7 +30,7 @@
 #ifndef __ASM_AU1000_DMA_H
 #define __ASM_AU1000_DMA_H
 
-#include <asm/io.h>		/* need byte IO */
+#include <linux/io.h>		/* need byte IO */
 #include <linux/spinlock.h>	/* And spinlocks */
 #include <linux/delay.h>
 #include <asm/system.h>
@@ -50,36 +49,36 @@
 #define DMA_DAH_MASK		(0x0f << 20)
 #define DMA_DID_BIT		16
 #define DMA_DID_MASK		(0x0f << DMA_DID_BIT)
-#define DMA_DS			(1<<15)
-#define DMA_BE			(1<<13)
-#define DMA_DR			(1<<12)
-#define DMA_TS8			(1<<11)
+#define DMA_DS			(1 << 15)
+#define DMA_BE			(1 << 13)
+#define DMA_DR			(1 << 12)
+#define DMA_TS8 		(1 << 11)
 #define DMA_DW_BIT		9
 #define DMA_DW_MASK		(0x03 << DMA_DW_BIT)
 #define DMA_DW8			(0 << DMA_DW_BIT)
 #define DMA_DW16		(1 << DMA_DW_BIT)
 #define DMA_DW32		(2 << DMA_DW_BIT)
-#define DMA_NC			(1<<8)
-#define DMA_IE			(1<<7)
-#define DMA_HALT		(1<<6)
-#define DMA_GO			(1<<5)
-#define DMA_AB			(1<<4)
-#define DMA_D1			(1<<3)
-#define DMA_BE1			(1<<2)
-#define DMA_D0			(1<<1)
-#define DMA_BE0			(1<<0)
-
-#define DMA_PERIPHERAL_ADDR       0x00000008
-#define DMA_BUFFER0_START         0x0000000C
-#define DMA_BUFFER1_START         0x00000014
-#define DMA_BUFFER0_COUNT         0x00000010
-#define DMA_BUFFER1_COUNT         0x00000018
-#define DMA_BAH_BIT 16
-#define DMA_BAH_MASK (0x0f << DMA_BAH_BIT)
-#define DMA_COUNT_BIT 0
-#define DMA_COUNT_MASK (0xffff << DMA_COUNT_BIT)
+#define DMA_NC			(1 << 8)
+#define DMA_IE			(1 << 7)
+#define DMA_HALT		(1 << 6)
+#define DMA_GO			(1 << 5)
+#define DMA_AB			(1 << 4)
+#define DMA_D1			(1 << 3)
+#define DMA_BE1 		(1 << 2)
+#define DMA_D0			(1 << 1)
+#define DMA_BE0 		(1 << 0)
+
+#define DMA_PERIPHERAL_ADDR	0x00000008
+#define DMA_BUFFER0_START	0x0000000C
+#define DMA_BUFFER1_START	0x00000014
+#define DMA_BUFFER0_COUNT	0x00000010
+#define DMA_BUFFER1_COUNT	0x00000018
+#define DMA_BAH_BIT	16
+#define DMA_BAH_MASK	(0x0f << DMA_BAH_BIT)
+#define DMA_COUNT_BIT	0
+#define DMA_COUNT_MASK	(0xffff << DMA_COUNT_BIT)
 
-/* DMA Device ID's follow */
+/* DMA Device IDs follow */
 enum {
 	DMA_ID_UART0_TX = 0,
 	DMA_ID_UART0_RX,
@@ -110,7 +109,8 @@ enum {
 };
 
 struct dma_chan {
-	int dev_id;		// this channel is allocated if >=0, free otherwise
+	int dev_id;		/* this channel is allocated if >= 0, */
+				/* free otherwise */
 	unsigned int io;
 	const char *dev_str;
 	int irq;
@@ -132,23 +132,23 @@ extern int au1000_dma_read_proc(char *bu
 extern void dump_au1000_dma_channel(unsigned int dmanr);
 extern spinlock_t au1000_dma_spin_lock;
 
-
-static __inline__ struct dma_chan *get_dma_chan(unsigned int dmanr)
+static inline struct dma_chan *get_dma_chan(unsigned int dmanr)
 {
-	if (dmanr >= NUM_AU1000_DMA_CHANNELS
-	    || au1000_dma_table[dmanr].dev_id < 0)
+	if (dmanr >= NUM_AU1000_DMA_CHANNELS ||
+	    au1000_dma_table[dmanr].dev_id < 0)
 		return NULL;
 	return &au1000_dma_table[dmanr];
 }
 
-static __inline__ unsigned long claim_dma_lock(void)
+static inline unsigned long claim_dma_lock(void)
 {
 	unsigned long flags;
+
 	spin_lock_irqsave(&au1000_dma_spin_lock, flags);
 	return flags;
 }
 
-static __inline__ void release_dma_lock(unsigned long flags)
+static inline void release_dma_lock(unsigned long flags)
 {
 	spin_unlock_irqrestore(&au1000_dma_spin_lock, flags);
 }
@@ -156,48 +156,53 @@ static __inline__ void release_dma_lock(
 /*
  * Set the DMA buffer enable bits in the mode register.
  */
-static __inline__ void enable_dma_buffer0(unsigned int dmanr)
+static inline void enable_dma_buffer0(unsigned int dmanr)
 {
 	struct dma_chan *chan = get_dma_chan(dmanr);
+
 	if (!chan)
 		return;
 	au_writel(DMA_BE0, chan->io + DMA_MODE_SET);
 }
-static __inline__ void enable_dma_buffer1(unsigned int dmanr)
+
+static inline void enable_dma_buffer1(unsigned int dmanr)
 {
 	struct dma_chan *chan = get_dma_chan(dmanr);
+
 	if (!chan)
 		return;
 	au_writel(DMA_BE1, chan->io + DMA_MODE_SET);
 }
-static __inline__ void enable_dma_buffers(unsigned int dmanr)
+static inline void enable_dma_buffers(unsigned int dmanr)
 {
 	struct dma_chan *chan = get_dma_chan(dmanr);
+
 	if (!chan)
 		return;
 	au_writel(DMA_BE0 | DMA_BE1, chan->io + DMA_MODE_SET);
 }
 
-static __inline__ void start_dma(unsigned int dmanr)
+static inline void start_dma(unsigned int dmanr)
 {
 	struct dma_chan *chan = get_dma_chan(dmanr);
+
 	if (!chan)
 		return;
-
 	au_writel(DMA_GO, chan->io + DMA_MODE_SET);
 }
 
 #define DMA_HALT_POLL 0x5000
 
-static __inline__ void halt_dma(unsigned int dmanr)
+static inline void halt_dma(unsigned int dmanr)
 {
 	struct dma_chan *chan = get_dma_chan(dmanr);
 	int i;
+
 	if (!chan)
 		return;
-
 	au_writel(DMA_GO, chan->io + DMA_MODE_CLEAR);
-	// poll the halt bit
+
+	/* Poll the halt bit */
 	for (i = 0; i < DMA_HALT_POLL; i++)
 		if (au_readl(chan->io + DMA_MODE_READ) & DMA_HALT)
 			break;
@@ -205,55 +210,57 @@ static __inline__ void halt_dma(unsigned
 		printk(KERN_INFO "halt_dma: HALT poll expired!\n");
 }
 
-
-static __inline__ void disable_dma(unsigned int dmanr)
+static inline void disable_dma(unsigned int dmanr)
 {
 	struct dma_chan *chan = get_dma_chan(dmanr);
+
 	if (!chan)
 		return;
 
 	halt_dma(dmanr);
 
-	// now we can disable the buffers
+	/* Now we can disable the buffers */
 	au_writel(~DMA_GO, chan->io + DMA_MODE_CLEAR);
 }
 
-static __inline__ int dma_halted(unsigned int dmanr)
+static inline int dma_halted(unsigned int dmanr)
 {
 	struct dma_chan *chan = get_dma_chan(dmanr);
+
 	if (!chan)
 		return 1;
 	return (au_readl(chan->io + DMA_MODE_READ) & DMA_HALT) ? 1 : 0;
 }
 
-/* initialize a DMA channel */
-static __inline__ void init_dma(unsigned int dmanr)
+/* Initialize a DMA channel. */
+static inline void init_dma(unsigned int dmanr)
 {
 	struct dma_chan *chan = get_dma_chan(dmanr);
 	u32 mode;
+
 	if (!chan)
 		return;
 
 	disable_dma(dmanr);
 
-	// set device FIFO address
-	au_writel(CPHYSADDR(chan->fifo_addr),
-		  chan->io + DMA_PERIPHERAL_ADDR);
+	/* Set device FIFO address */
+	au_writel(CPHYSADDR(chan->fifo_addr), chan->io + DMA_PERIPHERAL_ADDR);
 
 	mode = chan->mode | (chan->dev_id << DMA_DID_BIT);
 	if (chan->irq)
 		mode |= DMA_IE;
 
 	au_writel(~mode, chan->io + DMA_MODE_CLEAR);
-	au_writel(mode, chan->io + DMA_MODE_SET);
+	au_writel(mode,  chan->io + DMA_MODE_SET);
 }
 
 /*
- * set mode for a specific DMA channel
+ * Set mode for a specific DMA channel
  */
-static __inline__ void set_dma_mode(unsigned int dmanr, unsigned int mode)
+static inline void set_dma_mode(unsigned int dmanr, unsigned int mode)
 {
 	struct dma_chan *chan = get_dma_chan(dmanr);
+
 	if (!chan)
 		return;
 	/*
@@ -266,36 +273,37 @@ static __inline__ void set_dma_mode(unsi
 	chan->mode |= mode;
 }
 
-static __inline__ unsigned int get_dma_mode(unsigned int dmanr)
+static inline unsigned int get_dma_mode(unsigned int dmanr)
 {
 	struct dma_chan *chan = get_dma_chan(dmanr);
+
 	if (!chan)
 		return 0;
 	return chan->mode;
 }
 
-static __inline__ int get_dma_active_buffer(unsigned int dmanr)
+static inline int get_dma_active_buffer(unsigned int dmanr)
 {
 	struct dma_chan *chan = get_dma_chan(dmanr);
+
 	if (!chan)
 		return -1;
 	return (au_readl(chan->io + DMA_MODE_READ) & DMA_AB) ? 1 : 0;
 }
 
-
 /*
- * set the device FIFO address for a specific DMA channel - only
+ * Set the device FIFO address for a specific DMA channel - only
  * applicable to GPO4 and GPO5. All the other devices have fixed
  * FIFO addresses.
  */
-static __inline__ void set_dma_fifo_addr(unsigned int dmanr,
-					 unsigned int a)
+static inline void set_dma_fifo_addr(unsigned int dmanr, unsigned int a)
 {
 	struct dma_chan *chan = get_dma_chan(dmanr);
+
 	if (!chan)
 		return;
 
-	if (chan->mode & DMA_DS)	/* second bank of device ids */
+	if (chan->mode & DMA_DS)	/* second bank of device IDs */
 		return;
 
 	if (chan->dev_id != DMA_ID_GP04 && chan->dev_id != DMA_ID_GP05)
@@ -307,16 +315,19 @@ static __inline__ void set_dma_fifo_addr
 /*
  * Clear the DMA buffer done bits in the mode register.
  */
-static __inline__ void clear_dma_done0(unsigned int dmanr)
+static inline void clear_dma_done0(unsigned int dmanr)
 {
 	struct dma_chan *chan = get_dma_chan(dmanr);
+
 	if (!chan)
 		return;
 	au_writel(DMA_D0, chan->io + DMA_MODE_CLEAR);
 }
-static __inline__ void clear_dma_done1(unsigned int dmanr)
+
+static inline void clear_dma_done1(unsigned int dmanr)
 {
 	struct dma_chan *chan = get_dma_chan(dmanr);
+
 	if (!chan)
 		return;
 	au_writel(DMA_D1, chan->io + DMA_MODE_CLEAR);
@@ -325,16 +336,17 @@ static __inline__ void clear_dma_done1(u
 /*
  * This does nothing - not applicable to Au1000 DMA.
  */
-static __inline__ void set_dma_page(unsigned int dmanr, char pagenr)
+static inline void set_dma_page(unsigned int dmanr, char pagenr)
 {
 }
 
 /*
  * Set Buffer 0 transfer address for specific DMA channel.
  */
-static __inline__ void set_dma_addr0(unsigned int dmanr, unsigned int a)
+static inline void set_dma_addr0(unsigned int dmanr, unsigned int a)
 {
 	struct dma_chan *chan = get_dma_chan(dmanr);
+
 	if (!chan)
 		return;
 	au_writel(a, chan->io + DMA_BUFFER0_START);
@@ -343,9 +355,10 @@ static __inline__ void set_dma_addr0(uns
 /*
  * Set Buffer 1 transfer address for specific DMA channel.
  */
-static __inline__ void set_dma_addr1(unsigned int dmanr, unsigned int a)
+static inline void set_dma_addr1(unsigned int dmanr, unsigned int a)
 {
 	struct dma_chan *chan = get_dma_chan(dmanr);
+
 	if (!chan)
 		return;
 	au_writel(a, chan->io + DMA_BUFFER1_START);
@@ -355,10 +368,10 @@ static __inline__ void set_dma_addr1(uns
 /*
  * Set Buffer 0 transfer size (max 64k) for a specific DMA channel.
  */
-static __inline__ void set_dma_count0(unsigned int dmanr,
-				      unsigned int count)
+static inline void set_dma_count0(unsigned int dmanr, unsigned int count)
 {
 	struct dma_chan *chan = get_dma_chan(dmanr);
+
 	if (!chan)
 		return;
 	count &= DMA_COUNT_MASK;
@@ -368,10 +381,10 @@ static __inline__ void set_dma_count0(un
 /*
  * Set Buffer 1 transfer size (max 64k) for a specific DMA channel.
  */
-static __inline__ void set_dma_count1(unsigned int dmanr,
-				      unsigned int count)
+static inline void set_dma_count1(unsigned int dmanr, unsigned int count)
 {
 	struct dma_chan *chan = get_dma_chan(dmanr);
+
 	if (!chan)
 		return;
 	count &= DMA_COUNT_MASK;
@@ -381,10 +394,10 @@ static __inline__ void set_dma_count1(un
 /*
  * Set both buffer transfer sizes (max 64k) for a specific DMA channel.
  */
-static __inline__ void set_dma_count(unsigned int dmanr,
-				     unsigned int count)
+static inline void set_dma_count(unsigned int dmanr, unsigned int count)
 {
 	struct dma_chan *chan = get_dma_chan(dmanr);
+
 	if (!chan)
 		return;
 	count &= DMA_COUNT_MASK;
@@ -396,35 +409,36 @@ static __inline__ void set_dma_count(uns
  * Returns which buffer has its done bit set in the mode register.
  * Returns -1 if neither or both done bits set.
  */
-static __inline__ unsigned int get_dma_buffer_done(unsigned int dmanr)
+static inline unsigned int get_dma_buffer_done(unsigned int dmanr)
 {
 	struct dma_chan *chan = get_dma_chan(dmanr);
+
 	if (!chan)
 		return 0;
-
-    return au_readl(chan->io + DMA_MODE_READ) & (DMA_D0 | DMA_D1);
+	return au_readl(chan->io + DMA_MODE_READ) & (DMA_D0 | DMA_D1);
 }
 
 
 /*
  * Returns the DMA channel's Buffer Done IRQ number.
  */
-static __inline__ int get_dma_done_irq(unsigned int dmanr)
+static inline int get_dma_done_irq(unsigned int dmanr)
 {
 	struct dma_chan *chan = get_dma_chan(dmanr);
+
 	if (!chan)
 		return -1;
-
 	return chan->irq;
 }
 
 /*
  * Get DMA residue count. Returns the number of _bytes_ left to transfer.
  */
-static __inline__ int get_dma_residue(unsigned int dmanr)
+static inline int get_dma_residue(unsigned int dmanr)
 {
 	int curBufCntReg, count;
 	struct dma_chan *chan = get_dma_chan(dmanr);
+
 	if (!chan)
 		return 0;
 
@@ -442,4 +456,3 @@ static __inline__ int get_dma_residue(un
 }
 
 #endif /* __ASM_AU1000_DMA_H */
-
Index: linux-2.6/include/asm-mips/mach-au1x00/au1000_gpio.h
===================================================================
--- linux-2.6.orig/include/asm-mips/mach-au1x00/au1000_gpio.h
+++ linux-2.6/include/asm-mips/mach-au1x00/au1000_gpio.h
@@ -2,12 +2,12 @@
  * FILE NAME au1000_gpio.h
  *
  * BRIEF MODULE DESCRIPTION
- *	API to Alchemy Au1000 GPIO device.
+ *	API to Alchemy Au1xx0 GPIO device.
  *
  *  Author: MontaVista Software, Inc.  <source@mvista.com>
- *          Steve Longerbeam <stevel@mvista.com>
+ *          Steve Longerbeam
  *
- * Copyright 2001 MontaVista Software Inc.
+ * Copyright 2001, 2008 MontaVista Software Inc.
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -37,12 +37,12 @@
 
 #define AU1000GPIO_IOC_MAGIC 'A'
 
-#define AU1000GPIO_IN		_IOR (AU1000GPIO_IOC_MAGIC, 0, int)
-#define AU1000GPIO_SET		_IOW (AU1000GPIO_IOC_MAGIC, 1, int)
-#define AU1000GPIO_CLEAR	_IOW (AU1000GPIO_IOC_MAGIC, 2, int)
-#define AU1000GPIO_OUT		_IOW (AU1000GPIO_IOC_MAGIC, 3, int)
-#define AU1000GPIO_TRISTATE	_IOW (AU1000GPIO_IOC_MAGIC, 4, int)
-#define AU1000GPIO_AVAIL_MASK	_IOR (AU1000GPIO_IOC_MAGIC, 5, int)
+#define AU1000GPIO_IN		_IOR(AU1000GPIO_IOC_MAGIC, 0, int)
+#define AU1000GPIO_SET		_IOW(AU1000GPIO_IOC_MAGIC, 1, int)
+#define AU1000GPIO_CLEAR	_IOW(AU1000GPIO_IOC_MAGIC, 2, int)
+#define AU1000GPIO_OUT		_IOW(AU1000GPIO_IOC_MAGIC, 3, int)
+#define AU1000GPIO_TRISTATE	_IOW(AU1000GPIO_IOC_MAGIC, 4, int)
+#define AU1000GPIO_AVAIL_MASK	_IOR(AU1000GPIO_IOC_MAGIC, 5, int)
 
 #ifdef __KERNEL__
 extern u32 get_au1000_avail_gpio_mask(void);
Index: linux-2.6/include/asm-mips/mach-au1x00/au1550_spi.h
===================================================================
--- linux-2.6.orig/include/asm-mips/mach-au1x00/au1550_spi.h
+++ linux-2.6/include/asm-mips/mach-au1x00/au1550_spi.h
@@ -1,5 +1,5 @@
 /*
- * au1550_spi.h - au1550 psc spi controller driver - platform data struct
+ * au1550_spi.h - Au1550 PSC SPI controller driver - platform data structure
  */
 
 #ifndef _AU1550_SPI_H_
Index: linux-2.6/include/asm-mips/mach-au1x00/au1xxx.h
===================================================================
--- linux-2.6.orig/include/asm-mips/mach-au1x00/au1xxx.h
+++ linux-2.6/include/asm-mips/mach-au1x00/au1xxx.h
@@ -23,10 +23,10 @@
 #ifndef _AU1XXX_H_
 #define _AU1XXX_H_
 
-
 #include <asm/mach-au1x00/au1000.h>
 
-#if defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1100) || defined(CONFIG_MIPS_DB1500) || defined(CONFIG_MIPS_DB1550)
+#if defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1100) || \
+    defined(CONFIG_MIPS_DB1500) || defined(CONFIG_MIPS_DB1550)
 #include <asm/mach-db1x00/db1x00.h>
 
 #elif defined(CONFIG_MIPS_PB1550)
Index: linux-2.6/include/asm-mips/mach-au1x00/au1xxx_dbdma.h
===================================================================
--- linux-2.6.orig/include/asm-mips/mach-au1x00/au1xxx_dbdma.h
+++ linux-2.6/include/asm-mips/mach-au1x00/au1xxx_dbdma.h
@@ -28,17 +28,18 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-/* Specifics for the Au1xxx Descriptor-Based DMA Controllers, first
- * seen in the AU1550 part.
+/*
+ * Specifics for the Au1xxx Descriptor-Based DMA Controller,
+ * first seen in the AU1550 part.
  */
 #ifndef _AU1000_DBDMA_H_
 #define _AU1000_DBDMA_H_
 
-
 #ifndef _LANGUAGE_ASSEMBLY
 
-/* The DMA base addresses.
- * The Channels are every 256 bytes (0x0100) from the channel 0 base.
+/*
+ * The DMA base addresses.
+ * The channels are every 256 bytes (0x0100) from the channel 0 base.
  * Interrupt status/enable is bits 15:0 for channels 15 to zero.
  */
 #define DDMA_GLOBAL_BASE	0xb4003000
@@ -51,16 +52,14 @@ typedef volatile struct dbdma_global {
 	u32	ddma_inten;
 } dbdma_global_t;
 
-/* General Configuration.
-*/
+/* General Configuration. */
 #define DDMA_CONFIG_AF		(1 << 2)
 #define DDMA_CONFIG_AH		(1 << 1)
 #define DDMA_CONFIG_AL		(1 << 0)
 
 #define DDMA_THROTTLE_EN	(1 << 31)
 
-/* The structure of a DMA Channel.
-*/
+/* The structure of a DMA Channel. */
 typedef volatile struct au1xxx_dma_channel {
 	u32	ddma_cfg;	/* See below */
 	u32	ddma_desptr;	/* 32-byte aligned pointer to descriptor */
@@ -69,8 +68,7 @@ typedef volatile struct au1xxx_dma_chann
 	u32	ddma_irq;	/* If bit 0 set, interrupt pending */
 	u32	ddma_stat;	/* See below */
 	u32	ddma_bytecnt;	/* Byte count, valid only when chan idle */
-	/* Remainder, up to the 256 byte boundary, is reserved.
-	*/
+	/* Remainder, up to the 256 byte boundary, is reserved. */
 } au1x_dma_chan_t;
 
 #define DDMA_CFG_SED	(1 << 9)	/* source DMA level/edge detect */
@@ -84,7 +82,8 @@ typedef volatile struct au1xxx_dma_chann
 #define DDMA_CFG_DBE	(1 << 1)	/* Destination big endian */
 #define DDMA_CFG_EN	(1 << 0)	/* Channel enable */
 
-/* Always set when descriptor processing done, regardless of
+/*
+ * Always set when descriptor processing done, regardless of
  * interrupt enable state.  Reflected in global intstat, don't
  * clear this until global intstat is read/used.
  */
@@ -94,7 +93,8 @@ typedef volatile struct au1xxx_dma_chann
 #define DDMA_STAT_V	(1 << 1)	/* Descriptor valid */
 #define DDMA_STAT_H	(1 << 0)	/* Channel Halted */
 
-/* "Standard" DDMA Descriptor.
+/*
+ * "Standard" DDMA Descriptor.
  * Must be 32-byte aligned.
  */
 typedef volatile struct au1xxx_ddma_desc {
@@ -106,8 +106,9 @@ typedef volatile struct au1xxx_ddma_desc
 	u32	dscr_dest1;		/* See below */
 	u32	dscr_stat;		/* completion status */
 	u32	dscr_nxtptr;		/* Next descriptor pointer (mostly) */
-	/* First 32bytes are HW specific!!!
-	   Lets have some SW data following.. make sure its 32bytes
+	/*
+	 * First 32 bytes are HW specific!!!
+	 * Lets have some SW data following -- make sure it's 32 bytes.
 	 */
 	u32	sw_status;
 	u32 	sw_context;
@@ -130,10 +131,9 @@ typedef volatile struct au1xxx_ddma_desc
 #define DSCR_CMD0_CV		(0x1 << 2)	/* Clear Valid when done */
 #define DSCR_CMD0_ST_MASK	(0x3 << 0)	/* Status instruction */
 
-#define SW_STATUS_INUSE		(1<<0)
+#define SW_STATUS_INUSE 	(1 << 0)
 
-/* Command 0 device IDs.
-*/
+/* Command 0 device IDs. */
 #ifdef CONFIG_SOC_AU1550
 #define DSCR_CMD0_UART0_TX	0
 #define DSCR_CMD0_UART0_RX	1
@@ -198,16 +198,15 @@ typedef volatile struct au1xxx_ddma_desc
 #define DSCR_CMD0_THROTTLE	30
 #define DSCR_CMD0_ALWAYS	31
 #define DSCR_NDEV_IDS		32
-/* THis macro is used to find/create custom device types */
-#define DSCR_DEV2CUSTOM_ID(x, d)	(((((x)&0xFFFF)<<8)|0x32000000)|((d)&0xFF))
-#define DSCR_CUSTOM2DEV_ID(x)	((x)&0xFF)
-
+/* This macro is used to find/create custom device types */
+#define DSCR_DEV2CUSTOM_ID(x, d) (((((x) & 0xFFFF) << 8) | 0x32000000) | \
+				  ((d) & 0xFF))
+#define DSCR_CUSTOM2DEV_ID(x)	((x) & 0xFF)
 
 #define DSCR_CMD0_SID(x)	(((x) & 0x1f) << 25)
 #define DSCR_CMD0_DID(x)	(((x) & 0x1f) << 20)
 
-/* Source/Destination transfer width.
-*/
+/* Source/Destination transfer width. */
 #define DSCR_CMD0_BYTE		0
 #define DSCR_CMD0_HALFWORD	1
 #define DSCR_CMD0_WORD		2
@@ -215,16 +214,14 @@ typedef volatile struct au1xxx_ddma_desc
 #define DSCR_CMD0_SW(x)		(((x) & 0x3) << 18)
 #define DSCR_CMD0_DW(x)		(((x) & 0x3) << 16)
 
-/* DDMA Descriptor Type.
-*/
+/* DDMA Descriptor Type. */
 #define DSCR_CMD0_STANDARD	0
 #define DSCR_CMD0_LITERAL	1
 #define DSCR_CMD0_CMP_BRANCH	2
 
 #define DSCR_CMD0_DT(x)		(((x) & 0x3) << 13)
 
-/* Status Instruction.
-*/
+/* Status Instruction. */
 #define DSCR_CMD0_ST_NOCHANGE	0	/* Don't change */
 #define DSCR_CMD0_ST_CURRENT	1	/* Write current status */
 #define DSCR_CMD0_ST_CMD0	2	/* Write cmd0 with V cleared */
@@ -232,23 +229,20 @@ typedef volatile struct au1xxx_ddma_desc
 
 #define DSCR_CMD0_ST(x)		(((x) & 0x3) << 0)
 
-/* Descriptor Command 1
-*/
+/* Descriptor Command 1. */
 #define DSCR_CMD1_SUPTR_MASK	(0xf << 28)	/* upper 4 bits of src addr */
 #define DSCR_CMD1_DUPTR_MASK	(0xf << 24)	/* upper 4 bits of dest addr */
 #define DSCR_CMD1_FL_MASK	(0x3 << 22)	/* Flag bits */
 #define DSCR_CMD1_BC_MASK	(0x3fffff)	/* Byte count */
 
-/* Flag description.
-*/
+/* Flag description. */
 #define DSCR_CMD1_FL_MEM_STRIDE0	0
 #define DSCR_CMD1_FL_MEM_STRIDE1	1
 #define DSCR_CMD1_FL_MEM_STRIDE2	2
 
 #define DSCR_CMD1_FL(x)		(((x) & 0x3) << 22)
 
-/* Source1, 1-dimensional stride.
-*/
+/* Source1, 1-dimensional stride. */
 #define DSCR_SRC1_STS_MASK	(3 << 30)	/* Src xfer size */
 #define DSCR_SRC1_SAM_MASK	(3 << 28)	/* Src xfer movement */
 #define DSCR_SRC1_SB_MASK	(0x3fff << 14)	/* Block size */
@@ -256,8 +250,7 @@ typedef volatile struct au1xxx_ddma_desc
 #define DSCR_SRC1_SS_MASK	(0x3fff << 0)	/* Stride */
 #define DSCR_SRC1_SS(x)		(((x) & 0x3fff) << 0)
 
-/* Dest1, 1-dimensional stride.
-*/
+/* Dest1, 1-dimensional stride. */
 #define DSCR_DEST1_DTS_MASK	(3 << 30)	/* Dest xfer size */
 #define DSCR_DEST1_DAM_MASK	(3 << 28)	/* Dest xfer movement */
 #define DSCR_DEST1_DB_MASK	(0x3fff << 14)	/* Block size */
@@ -279,29 +272,27 @@ typedef volatile struct au1xxx_ddma_desc
 #define DSCR_SRC1_SAM(x)	(((x) & 3) << 28)
 #define DSCR_DEST1_DAM(x)	(((x) & 3) << 28)
 
-/* The next descriptor pointer.
-*/
+/* The next descriptor pointer. */
 #define DSCR_NXTPTR_MASK	(0x07ffffff)
 #define DSCR_NXTPTR(x)		((x) >> 5)
 #define DSCR_GET_NXTPTR(x)	((x) << 5)
 #define DSCR_NXTPTR_MS		(1 << 27)
 
-/* The number of DBDMA channels.
-*/
+/* The number of DBDMA channels. */
 #define NUM_DBDMA_CHANS	16
 
 /*
- * Ddma API definitions
+ * DDMA API definitions
  * FIXME: may not fit to this header file
  */
 typedef struct dbdma_device_table {
-	u32		dev_id;
-	u32		dev_flags;
-	u32		dev_tsize;
-	u32		dev_devwidth;
-	u32		dev_physaddr;		/* If FIFO */
-	u32		dev_intlevel;
-	u32		dev_intpolarity;
+	u32	dev_id;
+	u32	dev_flags;
+	u32	dev_tsize;
+	u32	dev_devwidth;
+	u32	dev_physaddr;		/* If FIFO */
+	u32	dev_intlevel;
+	u32	dev_intpolarity;
 } dbdev_tab_t;
 
 
@@ -316,44 +307,41 @@ typedef struct dbdma_chan_config {
 	au1x_ddma_desc_t	*chan_desc_base;
 	au1x_ddma_desc_t	*get_ptr, *put_ptr, *cur_ptr;
 	void			*chan_callparam;
-	void (*chan_callback)(int, void *);
+	void			(*chan_callback)(int, void *);
 } chan_tab_t;
 
 #define DEV_FLAGS_INUSE		(1 << 0)
 #define DEV_FLAGS_ANYUSE	(1 << 1)
 #define DEV_FLAGS_OUT		(1 << 2)
 #define DEV_FLAGS_IN		(1 << 3)
-#define DEV_FLAGS_BURSTABLE (1 << 4)
+#define DEV_FLAGS_BURSTABLE	(1 << 4)
 #define DEV_FLAGS_SYNC		(1 << 5)
-/* end Ddma API definitions */
+/* end DDMA API definitions */
 
-/* External functions for drivers to use.
-*/
-/* Use this to allocate a dbdma channel.  The device ids are one of the
- * DSCR_CMD0 devices IDs, which is usually redefined to a more
- * meaningful name.  The 'callback' is called during dma completion
+/*
+ * External functions for drivers to use.
+ * Use this to allocate a DBDMA channel.  The device IDs are one of
+ * the DSCR_CMD0 devices IDs, which is usually redefined to a more
+ * meaningful name.  The 'callback' is called during DMA completion
  * interrupt.
  */
 extern u32 au1xxx_dbdma_chan_alloc(u32 srcid, u32 destid,
-	void (*callback)(int, void *), void *callparam);
+				   void (*callback)(int, void *),
+				   void *callparam);
 
 #define DBDMA_MEM_CHAN	DSCR_CMD0_ALWAYS
 
-/* Set the device width of a in/out fifo.
-*/
+/* Set the device width of an in/out FIFO. */
 u32 au1xxx_dbdma_set_devwidth(u32 chanid, int bits);
 
-/* Allocate a ring of descriptors for dbdma.
-*/
+/* Allocate a ring of descriptors for DBDMA. */
 u32 au1xxx_dbdma_ring_alloc(u32 chanid, int entries);
 
-/* Put buffers on source/destination descriptors.
-*/
+/* Put buffers on source/destination descriptors. */
 u32 _au1xxx_dbdma_put_source(u32 chanid, void *buf, int nbytes, u32 flags);
 u32 _au1xxx_dbdma_put_dest(u32 chanid, void *buf, int nbytes, u32 flags);
 
-/* Get a buffer from the destination descriptor.
-*/
+/* Get a buffer from the destination descriptor. */
 u32 au1xxx_dbdma_get_dest(u32 chanid, void **buf, int *nbytes);
 
 void au1xxx_dbdma_stop(u32 chanid);
@@ -364,29 +352,34 @@ u32 au1xxx_get_dma_residue(u32 chanid);
 void au1xxx_dbdma_chan_free(u32 chanid);
 void au1xxx_dbdma_dump(u32 chanid);
 
-u32 au1xxx_dbdma_put_dscr(u32 chanid, au1x_ddma_desc_t *dscr );
+u32 au1xxx_dbdma_put_dscr(u32 chanid, au1x_ddma_desc_t *dscr);
 
-u32 au1xxx_ddma_add_device( dbdev_tab_t *dev );
-void * au1xxx_ddma_get_nextptr_virt(au1x_ddma_desc_t *dp);
+u32 au1xxx_ddma_add_device(dbdev_tab_t *dev);
+void *au1xxx_ddma_get_nextptr_virt(au1x_ddma_desc_t *dp);
 
 /*
- 	Some compatibilty macros --
-		Needed to make changes to API without breaking existing drivers
-*/
-#define	au1xxx_dbdma_put_source(chanid, buf, nbytes)_au1xxx_dbdma_put_source(chanid, buf, nbytes, DDMA_FLAGS_IE)
-#define	au1xxx_dbdma_put_source_flags(chanid, buf, nbytes, flags) _au1xxx_dbdma_put_source(chanid, buf, nbytes, flags)
-#define	put_source_flags(chanid, buf, nbytes, flags) au1xxx_dbdma_put_source_flags(chanid, buf, nbytes, flags)
-
-
-#define au1xxx_dbdma_put_dest(chanid, buf, nbytes) _au1xxx_dbdma_put_dest(chanid, buf, nbytes, DDMA_FLAGS_IE)
-#define	au1xxx_dbdma_put_dest_flags(chanid, buf, nbytes, flags) _au1xxx_dbdma_put_dest(chanid, buf, nbytes, flags)
-#define	put_dest_flags(chanid, buf, nbytes, flags) au1xxx_dbdma_put_dest_flags(chanid, buf, nbytes, flags)
+ * Some compatibilty macros -- needed to make changes to API
+ * without breaking existing drivers.
+ */
+#define au1xxx_dbdma_put_source(chanid, buf, nbytes)			\
+	_au1xxx_dbdma_put_source(chanid, buf, nbytes, DDMA_FLAGS_IE)
+#define au1xxx_dbdma_put_source_flags(chanid, buf, nbytes, flags)	\
+	_au1xxx_dbdma_put_source(chanid, buf, nbytes, flags)
+#define put_source_flags(chanid, buf, nbytes, flags)			\
+	au1xxx_dbdma_put_source_flags(chanid, buf, nbytes, flags)
+
+#define au1xxx_dbdma_put_dest(chanid, buf, nbytes)			\
+	_au1xxx_dbdma_put_dest(chanid, buf, nbytes, DDMA_FLAGS_IE)
+#define au1xxx_dbdma_put_dest_flags(chanid, buf, nbytes, flags) 	\
+	_au1xxx_dbdma_put_dest(chanid, buf, nbytes, flags)
+#define put_dest_flags(chanid, buf, nbytes, flags)			\
+	au1xxx_dbdma_put_dest_flags(chanid, buf, nbytes, flags)
 
 /*
  *	Flags for the put_source/put_dest functions.
  */
-#define DDMA_FLAGS_IE	(1<<0)
-#define DDMA_FLAGS_NOIE (1<<1)
+#define DDMA_FLAGS_IE	(1 << 0)
+#define DDMA_FLAGS_NOIE (1 << 1)
 
 #endif /* _LANGUAGE_ASSEMBLY */
 #endif /* _AU1000_DBDMA_H_ */
Index: linux-2.6/include/asm-mips/mach-au1x00/au1xxx_ide.h
===================================================================
--- linux-2.6.orig/include/asm-mips/mach-au1x00/au1xxx_ide.h
+++ linux-2.6/include/asm-mips/mach-au1x00/au1xxx_ide.h
@@ -31,167 +31,164 @@
  */
 
 #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
-        #define DMA_WAIT_TIMEOUT        100
-        #define NUM_DESCRIPTORS         PRD_ENTRIES
+#define DMA_WAIT_TIMEOUT	100
+#define NUM_DESCRIPTORS 	PRD_ENTRIES
 #else /* CONFIG_BLK_DEV_IDE_AU1XXX_PIO_DBDMA */
-        #define NUM_DESCRIPTORS         2
+#define NUM_DESCRIPTORS 	2
 #endif
 
 #ifndef AU1XXX_ATA_RQSIZE
-        #define AU1XXX_ATA_RQSIZE       128
+#define AU1XXX_ATA_RQSIZE	128
 #endif
 
 /* Disable Burstable-Support for DBDMA */
 #ifndef CONFIG_BLK_DEV_IDE_AU1XXX_BURSTABLE_ON
-        #define CONFIG_BLK_DEV_IDE_AU1XXX_BURSTABLE_ON  0
+#define CONFIG_BLK_DEV_IDE_AU1XXX_BURSTABLE_ON	0
 #endif
 
 #ifdef CONFIG_PM
 /*
-* This will enable the device to be powered up when write() or read()
-* is called. If this is not defined, the driver will return -EBUSY.
-*/
+ * This will enable the device to be powered up when write() or read()
+ * is called. If this is not defined, the driver will return -EBUSY.
+ */
 #define WAKE_ON_ACCESS 1
 
-typedef struct
-{
-        spinlock_t         lock;       /* Used to block on state transitions */
-        au1xxx_power_dev_t *dev;       /* Power Managers device structure */
-        unsigned	   stopped;    /* USed to signaling device is stopped */
+typedef struct {
+	spinlock_t		lock;	/* Used to block on state transitions */
+	au1xxx_power_dev_t	*dev;	/* Power Managers device structure */
+	unsigned		stopped; /* Used to signal device is stopped */
 } pm_state;
 #endif
 
-
-typedef struct
-{
-        u32                     tx_dev_id, rx_dev_id, target_dev_id;
-        u32                     tx_chan, rx_chan;
-        void                    *tx_desc_head, *rx_desc_head;
-        ide_hwif_t              *hwif;
+typedef struct {
+	u32			tx_dev_id, rx_dev_id, target_dev_id;
+	u32			tx_chan, rx_chan;
+	void			*tx_desc_head, *rx_desc_head;
+	ide_hwif_t		*hwif;
 #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
-        ide_drive_t             *drive;
-        struct dbdma_cmd        *dma_table_cpu;
-        dma_addr_t              dma_table_dma;
+	ide_drive_t		*drive;
+	struct dbdma_cmd	*dma_table_cpu;
+	dma_addr_t		dma_table_dma;
 #endif
 	int			irq;
 	u32			regbase;
 #ifdef CONFIG_PM
-        pm_state                pm;
+	pm_state		pm;
 #endif
 } _auide_hwif;
 
-/*******************************************************************************
-* PIO Mode timing calculation :                                                *
-*                                                                              *
-* Static Bus Spec   ATA Spec                                                   *
-*      Tcsoe      =   t1                                                       *
-*      Toecs      =   t9                                                       *
-*      Twcs       =   t9                                                       *
-*      Tcsh       =   t2i | t2                                                 *
-*      Tcsoff     =   t2i | t2                                                 *
-*      Twp        =   t2                                                       *
-*      Tcsw       =   t1                                                       *
-*      Tpm        =   0                                                        *
-*      Ta         =   t1+t2                                                    *
-*******************************************************************************/
-
-#define TCSOE_MASK            (0x07<<29)
-#define TOECS_MASK            (0x07<<26)
-#define TWCS_MASK             (0x07<<28)
-#define TCSH_MASK             (0x0F<<24)
-#define TCSOFF_MASK           (0x07<<20)
-#define TWP_MASK              (0x3F<<14)
-#define TCSW_MASK             (0x0F<<10)
-#define TPM_MASK              (0x0F<<6)
-#define TA_MASK               (0x3F<<0)
-#define TS_MASK               (1<<8)
+/******************************************************************************/
+/* PIO Mode timing calculation :					      */
+/*									      */
+/* Static Bus Spec   ATA Spec						      */
+/*	Tcsoe	   =	t1						      */
+/*	Toecs	   =	t9						      */
+/*	Twcs	   =	t9						      */
+/*	Tcsh	   =	t2i | t2					      */
+/*	Tcsoff	   =	t2i | t2					      */
+/*	Twp	   =	t2						      */
+/*	Tcsw	   =	t1						      */
+/*	Tpm	   =	0						      */
+/*	Ta	   =	t1+t2						      */
+/******************************************************************************/
+
+#define TCSOE_MASK		(0x07 << 29)
+#define TOECS_MASK		(0x07 << 26)
+#define TWCS_MASK		(0x07 << 28)
+#define TCSH_MASK		(0x0F << 24)
+#define TCSOFF_MASK		(0x07 << 20)
+#define TWP_MASK		(0x3F << 14)
+#define TCSW_MASK		(0x0F << 10)
+#define TPM_MASK		(0x0F << 6)
+#define TA_MASK 		(0x3F << 0)
+#define TS_MASK 		(1 << 8)
 
 /* Timing parameters PIO mode 0 */
-#define SBC_IDE_PIO0_TCSOE    (0x04<<29)
-#define SBC_IDE_PIO0_TOECS    (0x01<<26)
-#define SBC_IDE_PIO0_TWCS     (0x02<<28)
-#define SBC_IDE_PIO0_TCSH     (0x08<<24)
-#define SBC_IDE_PIO0_TCSOFF   (0x07<<20)
-#define SBC_IDE_PIO0_TWP      (0x10<<14)
-#define SBC_IDE_PIO0_TCSW     (0x04<<10)
-#define SBC_IDE_PIO0_TPM      (0x0<<6)
-#define SBC_IDE_PIO0_TA       (0x15<<0)
+#define SBC_IDE_PIO0_TCSOE	(0x04 << 29)
+#define SBC_IDE_PIO0_TOECS	(0x01 << 26)
+#define SBC_IDE_PIO0_TWCS	(0x02 << 28)
+#define SBC_IDE_PIO0_TCSH	(0x08 << 24)
+#define SBC_IDE_PIO0_TCSOFF	(0x07 << 20)
+#define SBC_IDE_PIO0_TWP	(0x10 << 14)
+#define SBC_IDE_PIO0_TCSW	(0x04 << 10)
+#define SBC_IDE_PIO0_TPM	(0x00 << 6)
+#define SBC_IDE_PIO0_TA 	(0x15 << 0)
 /* Timing parameters PIO mode 1 */
-#define SBC_IDE_PIO1_TCSOE    (0x03<<29)
-#define SBC_IDE_PIO1_TOECS    (0x01<<26)
-#define SBC_IDE_PIO1_TWCS     (0x01<<28)
-#define SBC_IDE_PIO1_TCSH     (0x06<<24)
-#define SBC_IDE_PIO1_TCSOFF   (0x06<<20)
-#define SBC_IDE_PIO1_TWP      (0x08<<14)
-#define SBC_IDE_PIO1_TCSW     (0x03<<10)
-#define SBC_IDE_PIO1_TPM      (0x00<<6)
-#define SBC_IDE_PIO1_TA       (0x0B<<0)
+#define SBC_IDE_PIO1_TCSOE	(0x03 << 29)
+#define SBC_IDE_PIO1_TOECS	(0x01 << 26)
+#define SBC_IDE_PIO1_TWCS	(0x01 << 28)
+#define SBC_IDE_PIO1_TCSH	(0x06 << 24)
+#define SBC_IDE_PIO1_TCSOFF	(0x06 << 20)
+#define SBC_IDE_PIO1_TWP	(0x08 << 14)
+#define SBC_IDE_PIO1_TCSW	(0x03 << 10)
+#define SBC_IDE_PIO1_TPM	(0x00 << 6)
+#define SBC_IDE_PIO1_TA 	(0x0B << 0)
 /* Timing parameters PIO mode 2 */
-#define SBC_IDE_PIO2_TCSOE    (0x05<<29)
-#define SBC_IDE_PIO2_TOECS    (0x01<<26)
-#define SBC_IDE_PIO2_TWCS     (0x01<<28)
-#define SBC_IDE_PIO2_TCSH     (0x07<<24)
-#define SBC_IDE_PIO2_TCSOFF   (0x07<<20)
-#define SBC_IDE_PIO2_TWP      (0x1F<<14)
-#define SBC_IDE_PIO2_TCSW     (0x05<<10)
-#define SBC_IDE_PIO2_TPM      (0x00<<6)
-#define SBC_IDE_PIO2_TA       (0x22<<0)
+#define SBC_IDE_PIO2_TCSOE	(0x05 << 29)
+#define SBC_IDE_PIO2_TOECS	(0x01 << 26)
+#define SBC_IDE_PIO2_TWCS	(0x01 << 28)
+#define SBC_IDE_PIO2_TCSH	(0x07 << 24)
+#define SBC_IDE_PIO2_TCSOFF	(0x07 << 20)
+#define SBC_IDE_PIO2_TWP	(0x1F << 14)
+#define SBC_IDE_PIO2_TCSW	(0x05 << 10)
+#define SBC_IDE_PIO2_TPM	(0x00 << 6)
+#define SBC_IDE_PIO2_TA 	(0x22 << 0)
 /* Timing parameters PIO mode 3 */
-#define SBC_IDE_PIO3_TCSOE    (0x05<<29)
-#define SBC_IDE_PIO3_TOECS    (0x01<<26)
-#define SBC_IDE_PIO3_TWCS     (0x01<<28)
-#define SBC_IDE_PIO3_TCSH     (0x0D<<24)
-#define SBC_IDE_PIO3_TCSOFF   (0x0D<<20)
-#define SBC_IDE_PIO3_TWP      (0x15<<14)
-#define SBC_IDE_PIO3_TCSW     (0x05<<10)
-#define SBC_IDE_PIO3_TPM      (0x00<<6)
-#define SBC_IDE_PIO3_TA       (0x1A<<0)
+#define SBC_IDE_PIO3_TCSOE	(0x05 << 29)
+#define SBC_IDE_PIO3_TOECS	(0x01 << 26)
+#define SBC_IDE_PIO3_TWCS	(0x01 << 28)
+#define SBC_IDE_PIO3_TCSH	(0x0D << 24)
+#define SBC_IDE_PIO3_TCSOFF	(0x0D << 20)
+#define SBC_IDE_PIO3_TWP	(0x15 << 14)
+#define SBC_IDE_PIO3_TCSW	(0x05 << 10)
+#define SBC_IDE_PIO3_TPM	(0x00 << 6)
+#define SBC_IDE_PIO3_TA 	(0x1A << 0)
 /* Timing parameters PIO mode 4 */
-#define SBC_IDE_PIO4_TCSOE    (0x04<<29)
-#define SBC_IDE_PIO4_TOECS    (0x01<<26)
-#define SBC_IDE_PIO4_TWCS     (0x01<<28)
-#define SBC_IDE_PIO4_TCSH     (0x04<<24)
-#define SBC_IDE_PIO4_TCSOFF   (0x04<<20)
-#define SBC_IDE_PIO4_TWP      (0x0D<<14)
-#define SBC_IDE_PIO4_TCSW     (0x03<<10)
-#define SBC_IDE_PIO4_TPM      (0x00<<6)
-#define SBC_IDE_PIO4_TA       (0x12<<0)
+#define SBC_IDE_PIO4_TCSOE	(0x04 << 29)
+#define SBC_IDE_PIO4_TOECS	(0x01 << 26)
+#define SBC_IDE_PIO4_TWCS	(0x01 << 28)
+#define SBC_IDE_PIO4_TCSH	(0x04 << 24)
+#define SBC_IDE_PIO4_TCSOFF	(0x04 << 20)
+#define SBC_IDE_PIO4_TWP	(0x0D << 14)
+#define SBC_IDE_PIO4_TCSW	(0x03 << 10)
+#define SBC_IDE_PIO4_TPM	(0x00 << 6)
+#define SBC_IDE_PIO4_TA 	(0x12 << 0)
 /* Timing parameters MDMA mode 0 */
-#define SBC_IDE_MDMA0_TCSOE   (0x03<<29)
-#define SBC_IDE_MDMA0_TOECS   (0x01<<26)
-#define SBC_IDE_MDMA0_TWCS    (0x01<<28)
-#define SBC_IDE_MDMA0_TCSH    (0x07<<24)
-#define SBC_IDE_MDMA0_TCSOFF  (0x07<<20)
-#define SBC_IDE_MDMA0_TWP     (0x0C<<14)
-#define SBC_IDE_MDMA0_TCSW    (0x03<<10)
-#define SBC_IDE_MDMA0_TPM     (0x00<<6)
-#define SBC_IDE_MDMA0_TA      (0x0F<<0)
+#define SBC_IDE_MDMA0_TCSOE	(0x03 << 29)
+#define SBC_IDE_MDMA0_TOECS	(0x01 << 26)
+#define SBC_IDE_MDMA0_TWCS	(0x01 << 28)
+#define SBC_IDE_MDMA0_TCSH	(0x07 << 24)
+#define SBC_IDE_MDMA0_TCSOFF	(0x07 << 20)
+#define SBC_IDE_MDMA0_TWP	(0x0C << 14)
+#define SBC_IDE_MDMA0_TCSW	(0x03 << 10)
+#define SBC_IDE_MDMA0_TPM	(0x00 << 6)
+#define SBC_IDE_MDMA0_TA	(0x0F << 0)
 /* Timing parameters MDMA mode 1 */
-#define SBC_IDE_MDMA1_TCSOE   (0x05<<29)
-#define SBC_IDE_MDMA1_TOECS   (0x01<<26)
-#define SBC_IDE_MDMA1_TWCS    (0x01<<28)
-#define SBC_IDE_MDMA1_TCSH    (0x05<<24)
-#define SBC_IDE_MDMA1_TCSOFF  (0x05<<20)
-#define SBC_IDE_MDMA1_TWP     (0x0F<<14)
-#define SBC_IDE_MDMA1_TCSW    (0x05<<10)
-#define SBC_IDE_MDMA1_TPM     (0x00<<6)
-#define SBC_IDE_MDMA1_TA      (0x15<<0)
+#define SBC_IDE_MDMA1_TCSOE	(0x05 << 29)
+#define SBC_IDE_MDMA1_TOECS	(0x01 << 26)
+#define SBC_IDE_MDMA1_TWCS	(0x01 << 28)
+#define SBC_IDE_MDMA1_TCSH	(0x05 << 24)
+#define SBC_IDE_MDMA1_TCSOFF	(0x05 << 20)
+#define SBC_IDE_MDMA1_TWP	(0x0F << 14)
+#define SBC_IDE_MDMA1_TCSW	(0x05 << 10)
+#define SBC_IDE_MDMA1_TPM	(0x00 << 6)
+#define SBC_IDE_MDMA1_TA	(0x15 << 0)
 /* Timing parameters MDMA mode 2 */
-#define SBC_IDE_MDMA2_TCSOE   (0x04<<29)
-#define SBC_IDE_MDMA2_TOECS   (0x01<<26)
-#define SBC_IDE_MDMA2_TWCS    (0x01<<28)
-#define SBC_IDE_MDMA2_TCSH    (0x04<<24)
-#define SBC_IDE_MDMA2_TCSOFF  (0x04<<20)
-#define SBC_IDE_MDMA2_TWP     (0x0D<<14)
-#define SBC_IDE_MDMA2_TCSW    (0x04<<10)
-#define SBC_IDE_MDMA2_TPM     (0x00<<6)
-#define SBC_IDE_MDMA2_TA      (0x12<<0)
+#define SBC_IDE_MDMA2_TCSOE	(0x04 << 29)
+#define SBC_IDE_MDMA2_TOECS	(0x01 << 26)
+#define SBC_IDE_MDMA2_TWCS	(0x01 << 28)
+#define SBC_IDE_MDMA2_TCSH	(0x04 << 24)
+#define SBC_IDE_MDMA2_TCSOFF	(0x04 << 20)
+#define SBC_IDE_MDMA2_TWP	(0x0D << 14)
+#define SBC_IDE_MDMA2_TCSW	(0x04 << 10)
+#define SBC_IDE_MDMA2_TPM	(0x00 << 6)
+#define SBC_IDE_MDMA2_TA	(0x12 << 0)
 
 #define SBC_IDE_TIMING(mode) \
-         SBC_IDE_##mode##_TWCS | \
-         SBC_IDE_##mode##_TCSH | \
-         SBC_IDE_##mode##_TCSOFF | \
-         SBC_IDE_##mode##_TWP | \
-         SBC_IDE_##mode##_TCSW | \
-         SBC_IDE_##mode##_TPM | \
-         SBC_IDE_##mode##_TA
+	(SBC_IDE_##mode##_TWCS | \
+	 SBC_IDE_##mode##_TCSH | \
+	 SBC_IDE_##mode##_TCSOFF | \
+	 SBC_IDE_##mode##_TWP | \
+	 SBC_IDE_##mode##_TCSW | \
+	 SBC_IDE_##mode##_TPM | \
+	 SBC_IDE_##mode##_TA)
Index: linux-2.6/include/asm-mips/mach-au1x00/au1xxx_psc.h
===================================================================
--- linux-2.6.orig/include/asm-mips/mach-au1x00/au1xxx_psc.h
+++ linux-2.6/include/asm-mips/mach-au1x00/au1xxx_psc.h
@@ -33,7 +33,6 @@
 #ifndef _AU1000_PSC_H_
 #define _AU1000_PSC_H_
 
-
 /* The PSC base addresses.  */
 #ifdef CONFIG_SOC_AU1550
 #define PSC0_BASE_ADDR		0xb1a00000
@@ -47,8 +46,8 @@
 #define PSC1_BASE_ADDR		0xb1b00000
 #endif
 
-/* The PSC select and control registers are common to
- * all protocols.
+/*
+ * The PSC select and control registers are common to all protocols.
  */
 #define PSC_SEL_OFFSET		0x00000000
 #define PSC_CTRL_OFFSET		0x00000004
@@ -59,18 +58,17 @@
 #define PSC_SEL_CLK_SERCLK	(2 << 4)
 
 #define PSC_SEL_PS_MASK		0x00000007
-#define PSC_SEL_PS_DISABLED	(0)
-#define PSC_SEL_PS_SPIMODE	(2)
-#define PSC_SEL_PS_I2SMODE	(3)
-#define PSC_SEL_PS_AC97MODE	(4)
-#define PSC_SEL_PS_SMBUSMODE	(5)
-
-#define PSC_CTRL_DISABLE	(0)
-#define PSC_CTRL_SUSPEND	(2)
-#define PSC_CTRL_ENABLE		(3)
+#define PSC_SEL_PS_DISABLED	0
+#define PSC_SEL_PS_SPIMODE	2
+#define PSC_SEL_PS_I2SMODE	3
+#define PSC_SEL_PS_AC97MODE	4
+#define PSC_SEL_PS_SMBUSMODE	5
+
+#define PSC_CTRL_DISABLE	0
+#define PSC_CTRL_SUSPEND	2
+#define PSC_CTRL_ENABLE 	3
 
-/* AC97 Registers.
-*/
+/* AC97 Registers. */
 #define PSC_AC97CFG_OFFSET	0x00000008
 #define PSC_AC97MSK_OFFSET	0x0000000c
 #define PSC_AC97PCR_OFFSET	0x00000010
@@ -95,8 +93,7 @@
 #define PSC_AC97GPO		(AC97_PSC_BASE + PSC_AC97GPO_OFFSET)
 #define PSC_AC97GPI		(AC97_PSC_BASE + PSC_AC97GPI_OFFSET)
 
-/* AC97 Config Register.
-*/
+/* AC97 Config Register. */
 #define PSC_AC97CFG_RT_MASK	(3 << 30)
 #define PSC_AC97CFG_RT_FIFO1	(0 << 30)
 #define PSC_AC97CFG_RT_FIFO2	(1 << 30)
@@ -118,20 +115,19 @@
 #define PSC_AC97CFG_RXSLOT_MASK	(0x3ff << 1)
 #define PSC_AC97CFG_GE_ENABLE	(1)
 
-/* Enable slots 3-12.
-*/
+/* Enable slots 3-12. */
 #define PSC_AC97CFG_TXSLOT_ENA(x)	(1 << (((x) - 3) + 11))
 #define PSC_AC97CFG_RXSLOT_ENA(x)	(1 << (((x) - 3) + 1))
 
-/* The word length equation is ((x) * 2) + 2, so choose 'x' appropriately.
+/*
+ * The word length equation is ((x) * 2) + 2, so choose 'x' appropriately.
  * The only sensible numbers are 7, 9, or possibly 11.  Nah, just do the
  * arithmetic in the macro.
  */
-#define PSC_AC97CFG_SET_LEN(x)	(((((x)-2)/2) & 0xf) << 21)
+#define PSC_AC97CFG_SET_LEN(x)	(((((x) - 2) / 2) & 0xf) << 21)
 #define PSC_AC97CFG_GET_LEN(x)	(((((x) >> 21) & 0xf) * 2) + 2)
 
-/* AC97 Mask Register.
-*/
+/* AC97 Mask Register. */
 #define PSC_AC97MSK_GR		(1 << 25)
 #define PSC_AC97MSK_CD		(1 << 24)
 #define PSC_AC97MSK_RR		(1 << 13)
@@ -148,8 +144,7 @@
 				 PSC_AC97MSK_TO | PSC_AC97MSK_TU | \
 				 PSC_AC97MSK_RD | PSC_AC97MSK_TD)
 
-/* AC97 Protocol Control Register.
-*/
+/* AC97 Protocol Control Register. */
 #define PSC_AC97PCR_RC		(1 << 6)
 #define PSC_AC97PCR_RP		(1 << 5)
 #define PSC_AC97PCR_RS		(1 << 4)
@@ -157,8 +152,7 @@
 #define PSC_AC97PCR_TP		(1 << 1)
 #define PSC_AC97PCR_TS		(1 << 0)
 
-/* AC97 Status register (read only).
-*/
+/* AC97 Status register (read only). */
 #define PSC_AC97STAT_CB		(1 << 26)
 #define PSC_AC97STAT_CP		(1 << 25)
 #define PSC_AC97STAT_CR		(1 << 24)
@@ -174,8 +168,7 @@
 #define PSC_AC97STAT_DR		(1 << 1)
 #define PSC_AC97STAT_SR		(1 << 0)
 
-/* AC97 Event Register.
-*/
+/* AC97 Event Register. */
 #define PSC_AC97EVNT_GR		(1 << 25)
 #define PSC_AC97EVNT_CD		(1 << 24)
 #define PSC_AC97EVNT_RR		(1 << 13)
@@ -187,22 +180,18 @@
 #define PSC_AC97EVNT_RD		(1 << 5)
 #define PSC_AC97EVNT_TD		(1 << 4)
 
-/* CODEC Command Register.
-*/
+/* CODEC Command Register. */
 #define PSC_AC97CDC_RD		(1 << 25)
 #define PSC_AC97CDC_ID_MASK	(3 << 23)
 #define PSC_AC97CDC_INDX_MASK	(0x7f << 16)
-#define PSC_AC97CDC_ID(x)	(((x) & 0x3) << 23)
+#define PSC_AC97CDC_ID(x)	(((x) & 0x03) << 23)
 #define PSC_AC97CDC_INDX(x)	(((x) & 0x7f) << 16)
 
-/* AC97 Reset Control Register.
-*/
+/* AC97 Reset Control Register. */
 #define PSC_AC97RST_RST		(1 << 1)
 #define PSC_AC97RST_SNC		(1 << 0)
 
-
-/* PSC in I2S Mode.
-*/
+/* PSC in I2S Mode. */
 typedef struct	psc_i2s {
 	u32	psc_sel;
 	u32	psc_ctrl;
@@ -215,8 +204,7 @@ typedef struct	psc_i2s {
 	u32	psc_i2sudf;
 } psc_i2s_t;
 
-/* I2S Config Register.
-*/
+/* I2S Config Register. */
 #define PSC_I2SCFG_RT_MASK	(3 << 30)
 #define PSC_I2SCFG_RT_FIFO1	(0 << 30)
 #define PSC_I2SCFG_RT_FIFO2	(1 << 30)
@@ -247,8 +235,7 @@ typedef struct	psc_i2s {
 #define PSC_I2SCFG_MLJ		(1 << 10)
 #define PSC_I2SCFG_XM		(1 << 9)
 
-/* The word length equation is simply LEN+1.
- */
+/* The word length equation is simply LEN+1. */
 #define PSC_I2SCFG_SET_LEN(x)	((((x) - 1) & 0x1f) << 4)
 #define PSC_I2SCFG_GET_LEN(x)	((((x) >> 4) & 0x1f) + 1)
 
@@ -256,8 +243,7 @@ typedef struct	psc_i2s {
 #define PSC_I2SCFG_MLF		(1 << 1)
 #define PSC_I2SCFG_MS		(1 << 0)
 
-/* I2S Mask Register.
-*/
+/* I2S Mask Register. */
 #define PSC_I2SMSK_RR		(1 << 13)
 #define PSC_I2SMSK_RO		(1 << 12)
 #define PSC_I2SMSK_RU		(1 << 11)
@@ -271,8 +257,7 @@ typedef struct	psc_i2s {
 				 PSC_I2SMSK_TO | PSC_I2SMSK_TU | \
 				 PSC_I2SMSK_RD | PSC_I2SMSK_TD)
 
-/* I2S Protocol Control Register.
-*/
+/* I2S Protocol Control Register. */
 #define PSC_I2SPCR_RC		(1 << 6)
 #define PSC_I2SPCR_RP		(1 << 5)
 #define PSC_I2SPCR_RS		(1 << 4)
@@ -280,8 +265,7 @@ typedef struct	psc_i2s {
 #define PSC_I2SPCR_TP		(1 << 1)
 #define PSC_I2SPCR_TS		(1 << 0)
 
-/* I2S Status register (read only).
-*/
+/* I2S Status register (read only). */
 #define PSC_I2SSTAT_RF		(1 << 13)
 #define PSC_I2SSTAT_RE		(1 << 12)
 #define PSC_I2SSTAT_RR		(1 << 11)
@@ -294,8 +278,7 @@ typedef struct	psc_i2s {
 #define PSC_I2SSTAT_DR		(1 << 1)
 #define PSC_I2SSTAT_SR		(1 << 0)
 
-/* I2S Event Register.
-*/
+/* I2S Event Register. */
 #define PSC_I2SEVNT_RR		(1 << 13)
 #define PSC_I2SEVNT_RO		(1 << 12)
 #define PSC_I2SEVNT_RU		(1 << 11)
@@ -305,8 +288,7 @@ typedef struct	psc_i2s {
 #define PSC_I2SEVNT_RD		(1 << 5)
 #define PSC_I2SEVNT_TD		(1 << 4)
 
-/* PSC in SPI Mode.
-*/
+/* PSC in SPI Mode. */
 typedef struct	psc_spi {
 	u32	psc_sel;
 	u32	psc_ctrl;
@@ -318,8 +300,7 @@ typedef struct	psc_spi {
 	u32	psc_spitxrx;
 } psc_spi_t;
 
-/* SPI Config Register.
-*/
+/* SPI Config Register. */
 #define PSC_SPICFG_RT_MASK	(3 << 30)
 #define PSC_SPICFG_RT_FIFO1	(0 << 30)
 #define PSC_SPICFG_RT_FIFO2	(1 << 30)
@@ -355,8 +336,7 @@ typedef struct	psc_spi {
 #define PSC_SPICFG_MLF		(1 << 1)
 #define PSC_SPICFG_MO		(1 << 0)
 
-/* SPI Mask Register.
-*/
+/* SPI Mask Register. */
 #define PSC_SPIMSK_MM		(1 << 16)
 #define PSC_SPIMSK_RR		(1 << 13)
 #define PSC_SPIMSK_RO		(1 << 12)
@@ -371,16 +351,14 @@ typedef struct	psc_spi {
 				 PSC_SPIMSK_TU | PSC_SPIMSK_SD | \
 				 PSC_SPIMSK_MD)
 
-/* SPI Protocol Control Register.
-*/
+/* SPI Protocol Control Register. */
 #define PSC_SPIPCR_RC		(1 << 6)
 #define PSC_SPIPCR_SP		(1 << 5)
 #define PSC_SPIPCR_SS		(1 << 4)
 #define PSC_SPIPCR_TC		(1 << 2)
 #define PSC_SPIPCR_MS		(1 << 0)
 
-/* SPI Status register (read only).
-*/
+/* SPI Status register (read only). */
 #define PSC_SPISTAT_RF		(1 << 13)
 #define PSC_SPISTAT_RE		(1 << 12)
 #define PSC_SPISTAT_RR		(1 << 11)
@@ -393,8 +371,7 @@ typedef struct	psc_spi {
 #define PSC_SPISTAT_DR		(1 << 1)
 #define PSC_SPISTAT_SR		(1 << 0)
 
-/* SPI Event Register.
-*/
+/* SPI Event Register. */
 #define PSC_SPIEVNT_MM		(1 << 16)
 #define PSC_SPIEVNT_RR		(1 << 13)
 #define PSC_SPIEVNT_RO		(1 << 12)
@@ -405,13 +382,11 @@ typedef struct	psc_spi {
 #define PSC_SPIEVNT_SD		(1 << 5)
 #define PSC_SPIEVNT_MD		(1 << 4)
 
-/* Transmit register control.
-*/
+/* Transmit register control. */
 #define PSC_SPITXRX_LC		(1 << 29)
 #define PSC_SPITXRX_SR		(1 << 28)
 
-/* PSC in SMBus (I2C) Mode.
-*/
+/* PSC in SMBus (I2C) Mode. */
 typedef struct	psc_smb {
 	u32	psc_sel;
 	u32	psc_ctrl;
@@ -424,8 +399,7 @@ typedef struct	psc_smb {
 	u32	psc_smbtmr;
 } psc_smb_t;
 
-/* SMBus Config Register.
-*/
+/* SMBus Config Register. */
 #define PSC_SMBCFG_RT_MASK	(3 << 30)
 #define PSC_SMBCFG_RT_FIFO1	(0 << 30)
 #define PSC_SMBCFG_RT_FIFO2	(1 << 30)
@@ -452,8 +426,7 @@ typedef struct	psc_smb {
 
 #define PSC_SMBCFG_SET_SLV(x)	(((x) & 0x7f) << 1)
 
-/* SMBus Mask Register.
-*/
+/* SMBus Mask Register. */
 #define PSC_SMBMSK_DN		(1 << 30)
 #define PSC_SMBMSK_AN		(1 << 29)
 #define PSC_SMBMSK_AL		(1 << 28)
@@ -471,13 +444,11 @@ typedef struct	psc_smb {
 				 PSC_SMBMSK_TU | PSC_SMBMSK_SD | \
 				 PSC_SMBMSK_MD)
 
-/* SMBus Protocol Control Register.
-*/
+/* SMBus Protocol Control Register. */
 #define PSC_SMBPCR_DC		(1 << 2)
 #define PSC_SMBPCR_MS		(1 << 0)
 
-/* SMBus Status register (read only).
-*/
+/* SMBus Status register (read only). */
 #define PSC_SMBSTAT_BB		(1 << 28)
 #define PSC_SMBSTAT_RF		(1 << 13)
 #define PSC_SMBSTAT_RE		(1 << 12)
@@ -491,8 +462,7 @@ typedef struct	psc_smb {
 #define PSC_SMBSTAT_DR		(1 << 1)
 #define PSC_SMBSTAT_SR		(1 << 0)
 
-/* SMBus Event Register.
-*/
+/* SMBus Event Register. */
 #define PSC_SMBEVNT_DN		(1 << 30)
 #define PSC_SMBEVNT_AN		(1 << 29)
 #define PSC_SMBEVNT_AL		(1 << 28)
@@ -510,15 +480,13 @@ typedef struct	psc_smb {
 				 PSC_SMBEVNT_TU | PSC_SMBEVNT_SD | \
 				 PSC_SMBEVNT_MD)
 
-/* Transmit register control.
-*/
+/* Transmit register control. */
 #define PSC_SMBTXRX_RSR		(1 << 28)
 #define PSC_SMBTXRX_STP		(1 << 29)
-#define PSC_SMBTXRX_DATAMASK	(0xff)
+#define PSC_SMBTXRX_DATAMASK	0xff
 
-/* SMBus protocol timers register.
-*/
-#define PSC_SMBTMR_SET_TH(x)	(((x) & 0x3) << 30)
+/* SMBus protocol timers register. */
+#define PSC_SMBTMR_SET_TH(x)	(((x) & 0x03) << 30)
 #define PSC_SMBTMR_SET_PS(x)	(((x) & 0x1f) << 25)
 #define PSC_SMBTMR_SET_PU(x)	(((x) & 0x1f) << 20)
 #define PSC_SMBTMR_SET_SH(x)	(((x) & 0x1f) << 15)
@@ -526,5 +494,4 @@ typedef struct	psc_smb {
 #define PSC_SMBTMR_SET_CL(x)	(((x) & 0x1f) << 5)
 #define PSC_SMBTMR_SET_CH(x)	(((x) & 0x1f) << 0)
 
-
 #endif /* _AU1000_PSC_H_ */
