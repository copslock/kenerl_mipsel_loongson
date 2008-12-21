Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Dec 2008 08:27:29 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:45246 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S22774246AbYLUI03 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 21 Dec 2008 08:26:29 +0000
Received: (qmail 3950 invoked from network); 21 Dec 2008 09:24:57 +0100
Received: from scarran.roarinelk.net (HELO localhost.localdomain) (192.168.0.242)
  by 192.168.0.1 with SMTP; 21 Dec 2008 09:24:57 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 03/14] Alchemy: move commandline mangling out of common code
Date:	Sun, 21 Dec 2008 09:26:16 +0100
Message-Id: <e6862a9acc480a4f00d0b7ae738e8a355a7e4810.1229846412.git.mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <80cf5c7a0db39a7230bae7766264acbfc68d200e.1229846412.git.mano@roarinelk.homelinux.net>
References: <cover.1229846410.git.mano@roarinelk.homelinux.net>
 <caebb02f97491d8e5830438e1a746b0e02fa2c7c.1229846411.git.mano@roarinelk.homelinux.net>
 <80cf5c7a0db39a7230bae7766264acbfc68d200e.1229846412.git.mano@roarinelk.homelinux.net>
In-Reply-To: <cover.1229846410.git.mano@roarinelk.homelinux.net>
References: <cover.1229846410.git.mano@roarinelk.homelinux.net>
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21637
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Not every alchemy-based board might want these options forced on it,
and most of this stuff seems to be intended for devboard code anyway.
Remove commandline mangling code out of common chip code and instead
add relevant sections to all in-tree boards to not change existing
behaviour.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/alchemy/common/setup.c                 |   34 ++-------------------
 arch/mips/alchemy/devboards/db1x00/board_setup.c |   28 ++++++++++++++++++
 arch/mips/alchemy/devboards/pb1000/board_setup.c |   10 ++++++
 arch/mips/alchemy/devboards/pb1100/board_setup.c |   27 +++++++++++++++++
 arch/mips/alchemy/devboards/pb1200/board_setup.c |   24 ++++++++-------
 arch/mips/alchemy/devboards/pb1500/board_setup.c |   18 +++++++++++
 arch/mips/alchemy/devboards/pb1550/board_setup.c |   12 ++++++++
 arch/mips/alchemy/mtx-1/board_setup.c            |   12 ++++++++
 arch/mips/alchemy/xxs1500/board_setup.c          |   12 ++++++++
 9 files changed, 136 insertions(+), 41 deletions(-)

diff --git a/arch/mips/alchemy/common/setup.c b/arch/mips/alchemy/common/setup.c
index 1ac6b06..9889ec3 100644
--- a/arch/mips/alchemy/common/setup.c
+++ b/arch/mips/alchemy/common/setup.c
@@ -35,7 +35,6 @@
 #include <asm/time.h>
 
 #include <au1000.h>
-#include <prom.h>
 
 extern void __init board_setup(void);
 extern void au1000_restart(char *);
@@ -46,12 +45,15 @@ extern void set_cpuspec(void);
 void __init plat_mem_setup(void)
 {
 	struct	cpu_spec *sp;
-	char *argptr;
 	unsigned long prid, cpufreq, bclk;
 
 	set_cpuspec();
 	sp = cur_cpu_spec[0];
 
+	_machine_restart = au1000_restart;
+	_machine_halt = au1000_halt;
+	pm_power_off = au1000_power_off;
+
 	board_setup();  /* board specific setup */
 
 	prid = read_c0_prid();
@@ -79,34 +81,6 @@ void __init plat_mem_setup(void)
 		/* Clear to obtain best system bus performance */
 		clear_c0_config(1 << 19); /* Clear Config[OD] */
 
-	argptr = prom_getcmdline();
-
-#ifdef CONFIG_SERIAL_8250_CONSOLE
-	argptr = strstr(argptr, "console=");
-	if (argptr == NULL) {
-		argptr = prom_getcmdline();
-		strcat(argptr, " console=ttyS0,115200");
-	}
-#endif
-
-#ifdef CONFIG_FB_AU1100
-	argptr = strstr(argptr, "video=");
-	if (argptr == NULL) {
-		argptr = prom_getcmdline();
-		/* default panel */
-		/*strcat(argptr, " video=au1100fb:panel:Sharp_320x240_16");*/
-	}
-#endif
-
-#if defined(CONFIG_SOUND_AU1X00) && !defined(CONFIG_SOC_AU1000)
-	/* au1000 does not support vra, au1500 and au1100 do */
-	strcat(argptr, " au1000_audio=vra");
-	argptr = prom_getcmdline();
-#endif
-	_machine_restart = au1000_restart;
-	_machine_halt = au1000_halt;
-	pm_power_off = au1000_power_off;
-
 	/* IO/MEM resources. */
 	set_io_port_base(0);
 	ioport_resource.start = IOPORT_RESOURCE_START;
diff --git a/arch/mips/alchemy/devboards/db1x00/board_setup.c b/arch/mips/alchemy/devboards/db1x00/board_setup.c
index 427f799..a75ffbf 100644
--- a/arch/mips/alchemy/devboards/db1x00/board_setup.c
+++ b/arch/mips/alchemy/devboards/db1x00/board_setup.c
@@ -32,6 +32,9 @@
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-db1x00/db1x00.h>
 
+#include <prom.h>
+
+
 static BCSR * const bcsr = (BCSR *)BCSR_KSEG1_ADDR;
 
 const char *get_system_type(void)
@@ -52,6 +55,31 @@ void board_reset(void)
 void __init board_setup(void)
 {
 	u32 pin_func = 0;
+	char *argptr;
+
+	argptr = prom_getcmdline();
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+	argptr = strstr(argptr, "console=");
+	if (argptr == NULL) {
+		argptr = prom_getcmdline();
+		strcat(argptr, " console=ttyS0,115200");
+	}
+#endif
+
+#ifdef CONFIG_FB_AU1100
+	argptr = strstr(argptr, "video=");
+	if (argptr == NULL) {
+		argptr = prom_getcmdline();
+		/* default panel */
+		/*strcat(argptr, " video=au1100fb:panel:Sharp_320x240_16");*/
+	}
+#endif
+
+#if defined(CONFIG_SOUND_AU1X00) && !defined(CONFIG_SOC_AU1000)
+	/* au1000 does not support vra, au1500 and au1100 do */
+	strcat(argptr, " au1000_audio=vra");
+	argptr = prom_getcmdline();
+#endif
 
 	/* Not valid for Au1550 */
 #if defined(CONFIG_IRDA) && \
diff --git a/arch/mips/alchemy/devboards/pb1000/board_setup.c b/arch/mips/alchemy/devboards/pb1000/board_setup.c
index b75e487..889c8fd 100644
--- a/arch/mips/alchemy/devboards/pb1000/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1000/board_setup.c
@@ -28,6 +28,7 @@
 #include <linux/interrupt.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1000.h>
+#include <prom.h>
 
 
 struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
@@ -52,6 +53,15 @@ void __init board_setup(void)
 	u32 sys_freqctrl, sys_clksrc;
 	u32 prid = read_c0_prid();
 
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+	char *argptr = prom_getcmdline();
+	argptr = strstr(argptr, "console=");
+	if (argptr == NULL) {
+		argptr = prom_getcmdline();
+		strcat(argptr, " console=ttyS0,115200");
+	}
+#endif
+
 	/* Set AUX clock to 12 MHz * 8 = 96 MHz */
 	au_writel(8, SYS_AUXPLL);
 	au_writel(0, SYS_PINSTATERD);
diff --git a/arch/mips/alchemy/devboards/pb1100/board_setup.c b/arch/mips/alchemy/devboards/pb1100/board_setup.c
index 9daab7e..fbd211e 100644
--- a/arch/mips/alchemy/devboards/pb1100/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1100/board_setup.c
@@ -29,6 +29,8 @@
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1100.h>
 
+#include <prom.h>
+
 
 struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
 	{ AU1000_GPIO_9,  INTC_INT_LOW_LEVEL, 0 }, /* PCMCIA Card Fully_Inserted# */
@@ -54,6 +56,31 @@ void board_reset(void)
 void __init board_setup(void)
 {
 	volatile void __iomem *base = (volatile void __iomem *)0xac000000UL;
+	char *argptr;
+
+	argptr = prom_getcmdline();
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+	argptr = strstr(argptr, "console=");
+	if (argptr == NULL) {
+		argptr = prom_getcmdline();
+		strcat(argptr, " console=ttyS0,115200");
+	}
+#endif
+
+#ifdef CONFIG_FB_AU1100
+	argptr = strstr(argptr, "video=");
+	if (argptr == NULL) {
+		argptr = prom_getcmdline();
+		/* default panel */
+		/*strcat(argptr, " video=au1100fb:panel:Sharp_320x240_16");*/
+	}
+#endif
+
+#if defined(CONFIG_SOUND_AU1X00) && !defined(CONFIG_SOC_AU1000)
+	/* au1000 does not support vra, au1500 and au1100 do */
+	strcat(argptr, " au1000_audio=vra");
+	argptr = prom_getcmdline();
+#endif
 
 	/* Set AUX clock to 12 MHz * 8 = 96 MHz */
 	au_writel(8, SYS_AUXPLL);
diff --git a/arch/mips/alchemy/devboards/pb1200/board_setup.c b/arch/mips/alchemy/devboards/pb1200/board_setup.c
index 8f03dc8..b5585e4 100644
--- a/arch/mips/alchemy/devboards/pb1200/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1200/board_setup.c
@@ -46,7 +46,19 @@ void board_reset(void)
 
 void __init board_setup(void)
 {
-	char *argptr = NULL;
+	char *argptr;
+
+	argptr = prom_getcmdline();
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+	argptr = strstr(argptr, "console=");
+	if (argptr == NULL) {
+		argptr = prom_getcmdline();
+		strcat(argptr, " console=ttyS0,115200");
+	}
+#endif
+#ifdef CONFIG_FB_AU1200
+	strcat(argptr, " video=au1200fb:panel:bs");
+#endif
 
 #if 0
 	{
@@ -104,16 +116,6 @@ void __init board_setup(void)
 	}
 #endif
 
-#ifdef CONFIG_FB_AU1200
-	argptr = prom_getcmdline();
-#ifdef CONFIG_MIPS_PB1200
-	strcat(argptr, " video=au1200fb:panel:bs");
-#endif
-#ifdef CONFIG_MIPS_DB1200
-	strcat(argptr, " video=au1200fb:panel:bs");
-#endif
-#endif
-
 	/*
 	 * The Pb1200 development board uses external MUX for PSC0 to
 	 * support SMB/SPI. bcsr->resets bit 12: 0=SMB 1=SPI
diff --git a/arch/mips/alchemy/devboards/pb1500/board_setup.c b/arch/mips/alchemy/devboards/pb1500/board_setup.c
index 47173f1..dcb36a6 100644
--- a/arch/mips/alchemy/devboards/pb1500/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1500/board_setup.c
@@ -29,6 +29,8 @@
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1500.h>
 
+#include <prom.h>
+
 
 char irq_tab_alchemy[][5] __initdata = {
 	[12] = { -1, INTA, INTX, INTX, INTX },   /* IDSEL 12 - HPT370	*/
@@ -61,6 +63,22 @@ void __init board_setup(void)
 {
 	u32 pin_func;
 	u32 sys_freqctrl, sys_clksrc;
+	char *argptr;
+
+	argptr = prom_getcmdline();
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+	argptr = strstr(argptr, "console=");
+	if (argptr == NULL) {
+		argptr = prom_getcmdline();
+		strcat(argptr, " console=ttyS0,115200");
+	}
+#endif
+
+#if defined(CONFIG_SOUND_AU1X00) && !defined(CONFIG_SOC_AU1000)
+	/* au1000 does not support vra, au1500 and au1100 do */
+	strcat(argptr, " au1000_audio=vra");
+	argptr = prom_getcmdline();
+#endif
 
 	sys_clksrc = sys_freqctrl = pin_func = 0;
 	/* Set AUX clock to 12 MHz * 8 = 96 MHz */
diff --git a/arch/mips/alchemy/devboards/pb1550/board_setup.c b/arch/mips/alchemy/devboards/pb1550/board_setup.c
index 25a9190..f462652 100644
--- a/arch/mips/alchemy/devboards/pb1550/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1550/board_setup.c
@@ -32,6 +32,8 @@
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1550.h>
 
+#include <prom.h>
+
 
 char irq_tab_alchemy[][5] __initdata = {
 	[12] = { -1, INTB, INTC, INTD, INTA }, /* IDSEL 12 - PCI slot 2 (left)  */
@@ -61,6 +63,16 @@ void __init board_setup(void)
 {
 	u32 pin_func;
 
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+	char *argptr;
+	argptr = prom_getcmdline();
+	argptr = strstr(argptr, "console=");
+	if (argptr == NULL) {
+		argptr = prom_getcmdline();
+		strcat(argptr, " console=ttyS0,115200");
+	}
+#endif
+
 	/*
 	 * Enable PSC1 SYNC for AC'97.  Normaly done in audio driver,
 	 * but it is board specific code, so put it here.
diff --git a/arch/mips/alchemy/mtx-1/board_setup.c b/arch/mips/alchemy/mtx-1/board_setup.c
index 3f80791..8ed1ae1 100644
--- a/arch/mips/alchemy/mtx-1/board_setup.c
+++ b/arch/mips/alchemy/mtx-1/board_setup.c
@@ -32,6 +32,8 @@
 
 #include <asm/mach-au1x00/au1000.h>
 
+#include <prom.h>
+
 extern int (*board_pci_idsel)(unsigned int devsel, int assert);
 int mtx1_pci_idsel(unsigned int devsel, int assert);
 
@@ -43,6 +45,16 @@ void board_reset(void)
 
 void __init board_setup(void)
 {
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+	char *argptr;
+	argptr = prom_getcmdline();
+	argptr = strstr(argptr, "console=");
+	if (argptr == NULL) {
+		argptr = prom_getcmdline();
+		strcat(argptr, " console=ttyS0,115200");
+	}
+#endif
+
 #if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
 	/* Enable USB power switch */
 	au_writel(au_readl(GPIO2_DIR) | 0x10, GPIO2_DIR);
diff --git a/arch/mips/alchemy/xxs1500/board_setup.c b/arch/mips/alchemy/xxs1500/board_setup.c
index 4c587ac..a2634fa 100644
--- a/arch/mips/alchemy/xxs1500/board_setup.c
+++ b/arch/mips/alchemy/xxs1500/board_setup.c
@@ -28,6 +28,8 @@
 
 #include <asm/mach-au1x00/au1000.h>
 
+#include <prom.h>
+
 void board_reset(void)
 {
 	/* Hit BCSR.SYSTEM_CONTROL[SW_RST] */
@@ -38,6 +40,16 @@ void __init board_setup(void)
 {
 	u32 pin_func;
 
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+	char *argptr;
+	argptr = prom_getcmdline();
+	argptr = strstr(argptr, "console=");
+	if (argptr == NULL) {
+		argptr = prom_getcmdline();
+		strcat(argptr, " console=ttyS0,115200");
+	}
+#endif
+
 	/* Set multiple use pins (UART3/GPIO) to UART (it's used as UART too) */
 	pin_func  = au_readl(SYS_PINFUNC) & ~SYS_PF_UR3;
 	pin_func |= SYS_PF_UR3;
-- 
1.6.0.4
