Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 06:55:13 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:55015 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903774Ab2FZEu5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 06:50:57 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SjNbV-0002zj-CN; Mon, 25 Jun 2012 23:42:17 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 25/33] MIPS: PNX83xx, PNX8550: Cleanup files effected by firmware changes.
Date:   Mon, 25 Jun 2012 23:41:40 -0500
Message-Id: <1340685708-14408-26-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1340685708-14408-1-git-send-email-sjhill@mips.com>
References: <1340685708-14408-1-git-send-email-sjhill@mips.com>
X-archive-position: 33831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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

From: "Steven J. Hill" <sjhill@mips.com>

Make headers consistent across the files and make changes based on
running the checkpatch script.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/pnx833x/common/setup.c     |   32 ++++++------------
 arch/mips/pnx833x/stb22x/board.c     |   43 +++++++++----------------
 arch/mips/pnx8550/common/setup.c     |   59 ++++++++++++++++------------------
 arch/mips/pnx8550/jbs/init.c         |   36 ++++-----------------
 arch/mips/pnx8550/stb810/prom_init.c |   23 ++++---------
 5 files changed, 66 insertions(+), 127 deletions(-)

diff --git a/arch/mips/pnx833x/common/setup.c b/arch/mips/pnx833x/common/setup.c
index 3ea4926..5b56f23 100644
--- a/arch/mips/pnx833x/common/setup.c
+++ b/arch/mips/pnx833x/common/setup.c
@@ -1,33 +1,21 @@
 /*
- *  setup.c: Setup PNX833X Soc.
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
- *  Copyright 2008 NXP Semiconductors
- *	  Chris Steel <chris.steel@nxp.com>
- *    Daniel Laird <daniel.j.laird@nxp.com>
+ * Setup PNX833X SOC. Based on software written by
+ * Nikita Youshchenko <yoush@debian.org> from PNX8550 code.
  *
- *  Based on software written by:
- *      Nikita Youshchenko <yoush@debian.org>, based on PNX8550 code.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ * Copyright 2008 NXP Semiconductors
+ * Authors: Chris Steel <chris.steel@nxp.com>
+ *          Daniel Laird <daniel.j.laird@nxp.com>
  */
 #include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
 #include <linux/io.h>
 #include <linux/pci.h>
+
 #include <asm/reboot.h>
+
 #include <pnx833x.h>
 #include <gpio.h>
 
diff --git a/arch/mips/pnx833x/stb22x/board.c b/arch/mips/pnx833x/stb22x/board.c
index cdf1a3b..e4c6422 100644
--- a/arch/mips/pnx833x/stb22x/board.c
+++ b/arch/mips/pnx833x/stb22x/board.c
@@ -1,31 +1,20 @@
 /*
- *  board.c: STB225 board support.
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
- *  Copyright 2008 NXP Semiconductors
- *	  Chris Steel <chris.steel@nxp.com>
- *    Daniel Laird <daniel.j.laird@nxp.com>
+ * STB225 board support based on software written by
+ * Nikita Youshchenko <yoush@debian.org> from PNX8550 code.
  *
- *  Based on software written by:
- *      Nikita Youshchenko <yoush@debian.org>, based on PNX8550 code.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ * Copyright 2008 NXP Semiconductors
+ * Authors: Chris Steel <chris.steel@nxp.com>
+ *	    Daniel Laird <daniel.j.laird@nxp.com>
  */
 #include <linux/init.h>
-#include <linux/mm.h>
+#include <linux/bootmem.h>
+
 #include <asm/fw/fw.h>
-#include <pnx833x.h>
+
 #include <gpio.h>
 
 /* endianess twiddlers */
@@ -94,9 +83,6 @@ void __init pnx833x_board_setup(void)
 	PNX833X_MIU_SEL0_TIMING = 0x50003081;
 	PNX833X_MIU_SEL1_TIMING = 0x50003081;
 
-	/* Setup GPIO 00 for use as MIU CS1 (CS0 is not multiplexed, so does not need this) */
-	pnx833x_gpio_select_function_alt(0);
-
 	/* Setup GPIO 04 to input NAND read/busy signal */
 	pnx833x_gpio_select_function_io(4);
 	pnx833x_gpio_select_input(4);
@@ -115,8 +101,11 @@ void __init pnx833x_board_setup(void)
 	PNX833X_MIU_SEL1 = 1;
 	PNX833X_MIU_SEL0_TIMING = 0x6A08D082;
 	PNX833X_MIU_SEL1_TIMING = 0x6A08D082;
+#endif
 
-	/* Setup GPIO 00 for use as MIU CS1 (CS0 is not multiplexed, so does not need this) */
+	/*
+	 * Setup GPIO 00 for use as MIU CS1 (CS0 is not multiplexed,
+	 * so does not need this)
+	 */
 	pnx833x_gpio_select_function_alt(0);
-#endif
 }
diff --git a/arch/mips/pnx8550/common/setup.c b/arch/mips/pnx8550/common/setup.c
index b8ae54c..bbb1799 100644
--- a/arch/mips/pnx8550/common/setup.c
+++ b/arch/mips/pnx8550/common/setup.c
@@ -1,45 +1,22 @@
 /*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
- * 2.6 port, Embedded Alley Solutions, Inc
+ * Setup based on Per Hallsmark, per.hallsmark@mvista.com
  *
- *  Based on Per Hallsmark, per.hallsmark@mvista.com
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ * Copyright 2005 Embedded Alley Solutions, Inc <source@embeddedalley.com>
  */
 #include <linux/init.h>
-#include <linux/sched.h>
 #include <linux/ioport.h>
-#include <linux/irq.h>
-#include <linux/mm.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
 #include <linux/serial_pnx8xxx.h>
-#include <linux/pm.h>
 
-#include <asm/cpu.h>
-#include <asm/irq.h>
-#include <asm/mipsregs.h>
 #include <asm/reboot.h>
 #include <asm/fw/fw.h>
-#include <asm/pgtable.h>
-#include <asm/time.h>
 
 #include <glb.h>
-#include <int.h>
 #include <pci.h>
 #include <uart.h>
-#include <nand.h>
 
 extern void __init board_setup(void);
 extern void pnx8550_machine_restart(char *);
@@ -89,16 +66,34 @@ unsigned long get_system_mem_size(void)
 
 int pnx8550_console_port = -1;
 
+/* used by early printk */
+void prom_putchar(char c)
+{
+	if (pnx8550_console_port != -1) {
+		/* Wait until FIFO not full */
+		while (((ip3106_fifo(UART_BASE, pnx8550_console_port) &
+			PNX8XXX_UART_FIFO_TXFIFO) >> 16) >= 16)
+			;
+
+		/* Send one char */
+		ip3106_fifo(UART_BASE, pnx8550_console_port) = c;
+	}
+}
+
+void __init prom_free_prom_memory(void)
+{
+}
+
 void __init plat_mem_setup(void)
 {
 	int i;
-	char* argptr;
+	char *argptr;
 
 	board_setup();  /* board specific setup */
 
-        _machine_restart = pnx8550_machine_restart;
-        _machine_halt = pnx8550_machine_halt;
-        pm_power_off = pnx8550_machine_halt;
+	_machine_restart = pnx8550_machine_restart;
+	_machine_halt = pnx8550_machine_halt;
+	pm_power_off = pnx8550_machine_halt;
 
 	/* Clear the Global 2 Register, PCI Inta Output Enable Registers
 	   Bit 1:Enable DAC Powerdown
diff --git a/arch/mips/pnx8550/jbs/init.c b/arch/mips/pnx8550/jbs/init.c
index e682446..15f071d 100644
--- a/arch/mips/pnx8550/jbs/init.c
+++ b/arch/mips/pnx8550/jbs/init.c
@@ -1,37 +1,14 @@
 /*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
- *  Copyright 2005 Embedded Alley Solutions, Inc
- *  source@embeddedalley.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
+ * Copyright 2005 Embedded Alley Solutions, Inc <source@embeddedalley.com>
  */
-
 #include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
 #include <linux/bootmem.h>
-#include <asm/addrspace.h>
+
 #include <asm/fw/fw.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
 
 const char *get_system_type(void)
 {
@@ -44,7 +21,6 @@ void __init prom_init(void)
 
 	fw_init_cmdline();
 
-	//memsize = 0x02800000; /* Trimedia uses memory above */
-	memsize = 0x08000000; /* Trimedia uses memory above */
+	memsize = 0x08000000;	/* Trimedia uses memory above */
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
diff --git a/arch/mips/pnx8550/stb810/prom_init.c b/arch/mips/pnx8550/stb810/prom_init.c
index cb1b052..3beefc2 100644
--- a/arch/mips/pnx8550/stb810/prom_init.c
+++ b/arch/mips/pnx8550/stb810/prom_init.c
@@ -1,25 +1,16 @@
 /*
- *  STB810 specific prom routines
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
- *  Author: MontaVista Software, Inc.
- *          source@mvista.com
+ * STB810 specific prom routines.
  *
- *  Copyright 2005 MontaVista Software Inc.
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
+ * Copyright 2005 MontaVista Software Inc. <source@mvista.com>
  */
-
 #include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
 #include <linux/bootmem.h>
-#include <asm/addrspace.h>
+
 #include <asm/fw/fw.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
 
 const char *get_system_type(void)
 {
@@ -32,6 +23,6 @@ void __init prom_init(void)
 
 	fw_init_cmdline();
 
-	memsize = 0x08000000; /* Trimedia uses memory above */
+	memsize = 0x08000000;	/* Trimedia uses memory above */
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
-- 
1.7.10.3
