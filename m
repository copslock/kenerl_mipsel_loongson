Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Apr 2008 21:01:02 +0100 (BST)
Received: from p549F61CF.dip.t-dialin.net ([84.159.97.207]:51393 "EHLO
	p549F61CF.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20021373AbYDMUA7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 13 Apr 2008 21:00:59 +0100
Received: from rtsoft3.corbina.net ([85.21.88.6]:16155 "EHLO
	buildserver.ru.mvista.com") by lappi.linux-mips.net with ESMTP
	id S1786810AbYDKQzb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 Apr 2008 18:55:31 +0200
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id E9EA68810; Fri, 11 Apr 2008 21:55:25 +0500 (SAMST)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH] Alchemy: kill useless #include's and extern'sv (take 2)
Date:	Fri, 11 Apr 2008 20:54:43 +0400
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200804112054.44078.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Go thru the Alchemy code and hunt down every unneeded #include and extern
(some of which refer to already long dead functions).

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Last time I overlooked arch/mips/au1000/mtx-1/platform.c, so please update the
queued patch...

 arch/mips/au1000/common/cputable.c     |    5 +----
 arch/mips/au1000/common/dbdma.c        |    6 ------
 arch/mips/au1000/common/dbg_io.c       |    1 -
 arch/mips/au1000/common/dma.c          |    5 +----
 arch/mips/au1000/common/gpio.c         |    5 -----
 arch/mips/au1000/common/irq.c          |    1 -
 arch/mips/au1000/common/pci.c          |    2 +-
 arch/mips/au1000/common/platform.c     |    4 +---
 arch/mips/au1000/common/power.c        |    9 +--------
 arch/mips/au1000/common/prom.c         |    2 +-
 arch/mips/au1000/common/puts.c         |    1 -
 arch/mips/au1000/common/reset.c        |    8 +-------
 arch/mips/au1000/common/setup.c        |   11 +----------
 arch/mips/au1000/common/sleeper.S      |    2 +-
 arch/mips/au1000/common/time.c         |    8 --------
 arch/mips/au1000/db1x00/board_setup.c  |   15 ++-------------
 arch/mips/au1000/db1x00/init.c         |    5 -----
 arch/mips/au1000/db1x00/irqmap.c       |   21 ++-------------------
 arch/mips/au1000/mtx-1/board_setup.c   |   14 ++------------
 arch/mips/au1000/mtx-1/init.c          |    6 +-----
 arch/mips/au1000/mtx-1/irqmap.c        |   19 +------------------
 arch/mips/au1000/mtx-1/platform.c      |    1 -
 arch/mips/au1000/pb1000/board_setup.c  |   11 +----------
 arch/mips/au1000/pb1000/init.c         |    6 +-----
 arch/mips/au1000/pb1000/irqmap.c       |   18 +-----------------
 arch/mips/au1000/pb1100/board_setup.c  |   11 +----------
 arch/mips/au1000/pb1100/init.c         |    6 +-----
 arch/mips/au1000/pb1100/irqmap.c       |   19 +------------------
 arch/mips/au1000/pb1200/board_setup.c  |   17 +----------------
 arch/mips/au1000/pb1200/init.c         |    6 +-----
 arch/mips/au1000/pb1200/irqmap.c       |   20 ++------------------
 arch/mips/au1000/pb1500/board_setup.c  |   11 +----------
 arch/mips/au1000/pb1500/init.c         |    6 +-----
 arch/mips/au1000/pb1500/irqmap.c       |   19 +------------------
 arch/mips/au1000/pb1550/board_setup.c  |   15 ++-------------
 arch/mips/au1000/pb1550/init.c         |    6 +-----
 arch/mips/au1000/pb1550/irqmap.c       |   19 +------------------
 arch/mips/au1000/xxs1500/board_setup.c |   11 +----------
 arch/mips/au1000/xxs1500/init.c        |    6 +-----
 arch/mips/au1000/xxs1500/irqmap.c      |   19 +------------------
 arch/mips/pci/fixup-au1000.c           |    5 +----
 41 files changed, 38 insertions(+), 344 deletions(-)

Index: linux-2.6/arch/mips/au1000/common/cputable.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/cputable.c
+++ linux-2.6/arch/mips/au1000/common/cputable.c
@@ -11,10 +11,7 @@
  *  as published by the Free Software Foundation; either version
  *  2 of the License, or (at your option) any later version.
  */
-#include <linux/string.h>
-#include <linux/sched.h>
-#include <linux/threads.h>
-#include <linux/init.h>
+
 #include <asm/mach-au1x00/au1000.h>
 
 struct cpu_spec* cur_cpu_spec[NR_CPUS];
Index: linux-2.6/arch/mips/au1000/common/dbdma.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/dbdma.c
+++ linux-2.6/arch/mips/au1000/common/dbdma.c
@@ -31,18 +31,12 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
-#include <linux/string.h>
-#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
-#include <asm/system.h>
-
 
 #if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
 
Index: linux-2.6/arch/mips/au1000/common/dbg_io.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/dbg_io.c
+++ linux-2.6/arch/mips/au1000/common/dbg_io.c
@@ -1,5 +1,4 @@
 
-#include <asm/io.h>
 #include <asm/mach-au1x00/au1000.h>
 
 #ifdef CONFIG_KGDB
Index: linux-2.6/arch/mips/au1000/common/dma.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/dma.c
+++ linux-2.6/arch/mips/au1000/common/dma.c
@@ -33,12 +33,9 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
-#include <linux/sched.h>
 #include <linux/spinlock.h>
-#include <linux/string.h>
-#include <linux/delay.h>
 #include <linux/interrupt.h>
-#include <asm/system.h>
+
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1000_dma.h>
 
Index: linux-2.6/arch/mips/au1000/common/gpio.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/gpio.c
+++ linux-2.6/arch/mips/au1000/common/gpio.c
@@ -27,13 +27,8 @@
  * 	others have a second one : GPIO2
  */
 
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/types.h>
 #include <linux/module.h>
 
-#include <asm/addrspace.h>
-
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/gpio.h>
 
Index: linux-2.6/arch/mips/au1000/common/irq.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/irq.c
+++ linux-2.6/arch/mips/au1000/common/irq.c
@@ -26,7 +26,6 @@
  */
 #include <linux/bitops.h>
 #include <linux/init.h>
-#include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 
Index: linux-2.6/arch/mips/au1000/common/pci.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/pci.c
+++ linux-2.6/arch/mips/au1000/common/pci.c
@@ -30,7 +30,7 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
-#include <linux/types.h>
+
 #include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
Index: linux-2.6/arch/mips/au1000/common/platform.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/platform.c
+++ linux-2.6/arch/mips/au1000/common/platform.c
@@ -7,11 +7,9 @@
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-#include <linux/device.h>
+
 #include <linux/platform_device.h>
-#include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/resource.h>
 
 #include <asm/mach-au1x00/au1xxx.h>
 
Index: linux-2.6/arch/mips/au1000/common/power.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/power.c
+++ linux-2.6/arch/mips/au1000/common/power.c
@@ -29,17 +29,14 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
+
 #include <linux/init.h>
 #include <linux/pm.h>
 #include <linux/pm_legacy.h>
-#include <linux/slab.h>
 #include <linux/sysctl.h>
 #include <linux/jiffies.h>
 
-#include <asm/string.h>
 #include <asm/uaccess.h>
-#include <asm/io.h>
-#include <asm/system.h>
 #include <asm/cacheflush.h>
 #include <asm/mach-au1x00/au1000.h>
 
@@ -54,10 +51,6 @@
 
 static void au1000_calibrate_delay(void);
 
-extern void set_au1x00_speed(unsigned int new_freq);
-extern unsigned int get_au1x00_speed(void);
-extern unsigned long get_au1x00_uart_baud_base(void);
-extern void set_au1x00_uart_baud_base(unsigned long new_baud_base);
 extern unsigned long save_local_and_disable(int controller);
 extern void restore_local_and_enable(int controller, unsigned long mask);
 extern void local_enable_irq(unsigned int irq_nr);
Index: linux-2.6/arch/mips/au1000/common/prom.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/prom.c
+++ linux-2.6/arch/mips/au1000/common/prom.c
@@ -33,8 +33,8 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
+
 #include <linux/module.h>
-#include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/string.h>
 
Index: linux-2.6/arch/mips/au1000/common/puts.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/puts.c
+++ linux-2.6/arch/mips/au1000/common/puts.c
@@ -28,7 +28,6 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/types.h>
 #include <asm/mach-au1x00/au1000.h>
 
 #define SERIAL_BASE   UART_BASE
Index: linux-2.6/arch/mips/au1000/common/reset.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/reset.c
+++ linux-2.6/arch/mips/au1000/common/reset.c
@@ -27,13 +27,7 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <asm/io.h>
-#include <asm/pgtable.h>
-#include <asm/processor.h>
-#include <asm/reboot.h>
-#include <asm/system.h>
+
 #include <asm/mach-au1x00/au1000.h>
 
 extern int au_sleep(void);
Index: linux-2.6/arch/mips/au1000/common/setup.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/setup.c
+++ linux-2.6/arch/mips/au1000/common/setup.c
@@ -25,21 +25,14 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
+
 #include <linux/init.h>
-#include <linux/sched.h>
 #include <linux/ioport.h>
-#include <linux/mm.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/pm.h>
 
-#include <asm/cpu.h>
-#include <asm/bootinfo.h>
-#include <asm/irq.h>
 #include <asm/mipsregs.h>
 #include <asm/reboot.h>
-#include <asm/pgtable.h>
 #include <asm/time.h>
 
 #include <au1000.h>
@@ -49,8 +42,6 @@ extern void __init board_setup(void);
 extern void au1000_restart(char *);
 extern void au1000_halt(void);
 extern void au1000_power_off(void);
-extern void au1x_time_init(void);
-extern void au1x_timer_setup(struct irqaction *irq);
 extern void set_cpuspec(void);
 
 void __init plat_mem_setup(void)
Index: linux-2.6/arch/mips/au1000/common/sleeper.S
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/sleeper.S
+++ linux-2.6/arch/mips/au1000/common/sleeper.S
@@ -9,9 +9,9 @@
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
  */
+
 #include <asm/asm.h>
 #include <asm/mipsregs.h>
-#include <asm/addrspace.h>
 #include <asm/regdef.h>
 #include <asm/stackframe.h>
 
Index: linux-2.6/arch/mips/au1000/common/time.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/time.c
+++ linux-2.6/arch/mips/au1000/common/time.c
@@ -34,20 +34,12 @@
 
 #include <linux/types.h>
 #include <linux/init.h>
-#include <linux/kernel_stat.h>
-#include <linux/sched.h>
 #include <linux/spinlock.h>
-#include <linux/hardirq.h>
 
-#include <asm/compiler.h>
 #include <asm/mipsregs.h>
 #include <asm/time.h>
-#include <asm/div64.h>
 #include <asm/mach-au1x00/au1000.h>
 
-#include <linux/mc146818rtc.h>
-#include <linux/timex.h>
-
 static int no_au1xxx_32khz;
 extern int allow_au1k_wait; /* default off for CP0 Counter */
 
Index: linux-2.6/arch/mips/au1000/db1x00/board_setup.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/db1x00/board_setup.c
+++ linux-2.6/arch/mips/au1000/db1x00/board_setup.c
@@ -27,20 +27,9 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
+
 #include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/ioport.h>
-#include <linux/mm.h>
-#include <linux/console.h>
-#include <linux/mc146818rtc.h>
-#include <linux/delay.h>
-
-#include <asm/cpu.h>
-#include <asm/bootinfo.h>
-#include <asm/irq.h>
-#include <asm/mipsregs.h>
-#include <asm/reboot.h>
-#include <asm/pgtable.h>
+
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-db1x00/db1x00.h>
 
Index: linux-2.6/arch/mips/au1000/db1x00/init.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/db1x00/init.c
+++ linux-2.6/arch/mips/au1000/db1x00/init.c
@@ -28,13 +28,8 @@
  */
 
 #include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/bootmem.h>
-#include <linux/string.h>
 #include <linux/kernel.h>
 
-#include <asm/addrspace.h>
 #include <asm/bootinfo.h>
 
 #include <prom.h>
Index: linux-2.6/arch/mips/au1000/db1x00/irqmap.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/db1x00/irqmap.c
+++ linux-2.6/arch/mips/au1000/db1x00/irqmap.c
@@ -25,26 +25,9 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
-#include <linux/errno.h>
+
 #include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/kernel_stat.h>
-#include <linux/module.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/timex.h>
-#include <linux/slab.h>
-#include <linux/random.h>
-#include <linux/delay.h>
-#include <linux/bitops.h>
-
-#include <asm/bootinfo.h>
-#include <asm/io.h>
-#include <asm/mipsregs.h>
-#include <asm/system.h>
+
 #include <asm/mach-au1x00/au1000.h>
 
 #ifdef CONFIG_MIPS_DB1500
Index: linux-2.6/arch/mips/au1000/mtx-1/board_setup.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/mtx-1/board_setup.c
+++ linux-2.6/arch/mips/au1000/mtx-1/board_setup.c
@@ -28,19 +28,9 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
+
 #include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/ioport.h>
-#include <linux/mm.h>
-#include <linux/console.h>
-#include <linux/delay.h>
-
-#include <asm/cpu.h>
-#include <asm/bootinfo.h>
-#include <asm/irq.h>
-#include <asm/mipsregs.h>
-#include <asm/reboot.h>
-#include <asm/pgtable.h>
+
 #include <asm/mach-au1x00/au1000.h>
 
 extern int (*board_pci_idsel)(unsigned int devsel, int assert);
Index: linux-2.6/arch/mips/au1000/mtx-1/init.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/mtx-1/init.c
+++ linux-2.6/arch/mips/au1000/mtx-1/init.c
@@ -28,14 +28,10 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
-#include <linux/string.h>
+
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/bootmem.h>
 
-#include <asm/addrspace.h>
 #include <asm/bootinfo.h>
 
 #include <prom.h>
Index: linux-2.6/arch/mips/au1000/mtx-1/irqmap.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/mtx-1/irqmap.c
+++ linux-2.6/arch/mips/au1000/mtx-1/irqmap.c
@@ -25,26 +25,9 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
-#include <linux/errno.h>
+
 #include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/kernel_stat.h>
-#include <linux/module.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/timex.h>
-#include <linux/slab.h>
-#include <linux/random.h>
-#include <linux/delay.h>
-#include <linux/bitops.h>
 
-#include <asm/bootinfo.h>
-#include <asm/io.h>
-#include <asm/mipsregs.h>
-#include <asm/system.h>
 #include <asm/mach-au1x00/au1000.h>
 
 char irq_tab_alchemy[][5] __initdata = {
Index: linux-2.6/arch/mips/au1000/pb1000/board_setup.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1000/board_setup.c
+++ linux-2.6/arch/mips/au1000/pb1000/board_setup.c
@@ -23,19 +23,10 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
+
 #include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/ioport.h>
-#include <linux/mm.h>
-#include <linux/console.h>
 #include <linux/delay.h>
 
-#include <asm/cpu.h>
-#include <asm/bootinfo.h>
-#include <asm/irq.h>
-#include <asm/mipsregs.h>
-#include <asm/reboot.h>
-#include <asm/pgtable.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1000.h>
 
Index: linux-2.6/arch/mips/au1000/pb1000/init.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1000/init.c
+++ linux-2.6/arch/mips/au1000/pb1000/init.c
@@ -26,14 +26,10 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
+
 #include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/bootmem.h>
-#include <linux/string.h>
 #include <linux/kernel.h>
 
-#include <asm/addrspace.h>
 #include <asm/bootinfo.h>
 
 #include <prom.h>
Index: linux-2.6/arch/mips/au1000/pb1000/irqmap.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1000/irqmap.c
+++ linux-2.6/arch/mips/au1000/pb1000/irqmap.c
@@ -25,26 +25,10 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
-#include <linux/errno.h>
+
 #include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/kernel_stat.h>
-#include <linux/module.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/types.h>
 #include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/timex.h>
-#include <linux/slab.h>
-#include <linux/random.h>
-#include <linux/delay.h>
-#include <linux/bitops.h>
 
-#include <asm/bootinfo.h>
-#include <asm/io.h>
-#include <asm/mipsregs.h>
-#include <asm/system.h>
 #include <asm/mach-au1x00/au1000.h>
 
 struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
Index: linux-2.6/arch/mips/au1000/pb1100/board_setup.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1100/board_setup.c
+++ linux-2.6/arch/mips/au1000/pb1100/board_setup.c
@@ -23,19 +23,10 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
+
 #include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/ioport.h>
-#include <linux/mm.h>
-#include <linux/console.h>
 #include <linux/delay.h>
 
-#include <asm/cpu.h>
-#include <asm/bootinfo.h>
-#include <asm/irq.h>
-#include <asm/mipsregs.h>
-#include <asm/reboot.h>
-#include <asm/pgtable.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1100.h>
 
Index: linux-2.6/arch/mips/au1000/pb1100/init.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1100/init.c
+++ linux-2.6/arch/mips/au1000/pb1100/init.c
@@ -27,14 +27,10 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
+
 #include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/bootmem.h>
-#include <linux/string.h>
 #include <linux/kernel.h>
 
-#include <asm/addrspace.h>
 #include <asm/bootinfo.h>
 
 #include <prom.h>
Index: linux-2.6/arch/mips/au1000/pb1100/irqmap.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1100/irqmap.c
+++ linux-2.6/arch/mips/au1000/pb1100/irqmap.c
@@ -25,26 +25,9 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
-#include <linux/errno.h>
+
 #include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/kernel_stat.h>
-#include <linux/module.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/timex.h>
-#include <linux/slab.h>
-#include <linux/random.h>
-#include <linux/delay.h>
-#include <linux/bitops.h>
 
-#include <asm/bootinfo.h>
-#include <asm/io.h>
-#include <asm/mipsregs.h>
-#include <asm/system.h>
 #include <asm/mach-au1x00/au1000.h>
 
 struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
Index: linux-2.6/arch/mips/au1000/pb1200/board_setup.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1200/board_setup.c
+++ linux-2.6/arch/mips/au1000/pb1200/board_setup.c
@@ -23,24 +23,9 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
+
 #include <linux/init.h>
 #include <linux/sched.h>
-#include <linux/ioport.h>
-#include <linux/mm.h>
-#include <linux/console.h>
-#include <linux/mc146818rtc.h>
-#include <linux/delay.h>
-
-#if defined(CONFIG_BLK_DEV_IDE_AU1XXX)
-#include <linux/ide.h>
-#endif
-
-#include <asm/cpu.h>
-#include <asm/bootinfo.h>
-#include <asm/irq.h>
-#include <asm/mipsregs.h>
-#include <asm/reboot.h>
-#include <asm/pgtable.h>
 
 #include <au1000.h>
 #include <au1xxx_dbdma.h>
Index: linux-2.6/arch/mips/au1000/pb1200/init.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1200/init.c
+++ linux-2.6/arch/mips/au1000/pb1200/init.c
@@ -27,14 +27,10 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
+
 #include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/bootmem.h>
-#include <linux/string.h>
 #include <linux/kernel.h>
 
-#include <asm/addrspace.h>
 #include <asm/bootinfo.h>
 
 #include <prom.h>
Index: linux-2.6/arch/mips/au1000/pb1200/irqmap.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1200/irqmap.c
+++ linux-2.6/arch/mips/au1000/pb1200/irqmap.c
@@ -22,26 +22,10 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
-#include <linux/errno.h>
+
 #include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/kernel_stat.h>
-#include <linux/module.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/types.h>
 #include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/timex.h>
-#include <linux/slab.h>
-#include <linux/random.h>
-#include <linux/delay.h>
-#include <linux/bitops.h>
-
-#include <asm/bootinfo.h>
-#include <asm/io.h>
-#include <asm/mipsregs.h>
-#include <asm/system.h>
+
 #include <asm/mach-au1x00/au1000.h>
 
 #ifdef CONFIG_MIPS_PB1200
Index: linux-2.6/arch/mips/au1000/pb1500/board_setup.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1500/board_setup.c
+++ linux-2.6/arch/mips/au1000/pb1500/board_setup.c
@@ -23,19 +23,10 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
+
 #include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/ioport.h>
-#include <linux/mm.h>
-#include <linux/console.h>
 #include <linux/delay.h>
 
-#include <asm/cpu.h>
-#include <asm/bootinfo.h>
-#include <asm/irq.h>
-#include <asm/mipsregs.h>
-#include <asm/reboot.h>
-#include <asm/pgtable.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1500.h>
 
Index: linux-2.6/arch/mips/au1000/pb1500/init.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1500/init.c
+++ linux-2.6/arch/mips/au1000/pb1500/init.c
@@ -27,14 +27,10 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
+
 #include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/bootmem.h>
-#include <linux/string.h>
 #include <linux/kernel.h>
 
-#include <asm/addrspace.h>
 #include <asm/bootinfo.h>
 
 #include <prom.h>
Index: linux-2.6/arch/mips/au1000/pb1500/irqmap.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1500/irqmap.c
+++ linux-2.6/arch/mips/au1000/pb1500/irqmap.c
@@ -25,26 +25,9 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
-#include <linux/errno.h>
+
 #include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/kernel_stat.h>
-#include <linux/module.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/timex.h>
-#include <linux/slab.h>
-#include <linux/random.h>
-#include <linux/delay.h>
-#include <linux/bitops.h>
 
-#include <asm/bootinfo.h>
-#include <asm/io.h>
-#include <asm/mipsregs.h>
-#include <asm/system.h>
 #include <asm/mach-au1x00/au1000.h>
 
 char irq_tab_alchemy[][5] __initdata = {
Index: linux-2.6/arch/mips/au1000/pb1550/board_setup.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1550/board_setup.c
+++ linux-2.6/arch/mips/au1000/pb1550/board_setup.c
@@ -27,20 +27,9 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
+
 #include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/ioport.h>
-#include <linux/mm.h>
-#include <linux/console.h>
-#include <linux/mc146818rtc.h>
-#include <linux/delay.h>
-
-#include <asm/cpu.h>
-#include <asm/bootinfo.h>
-#include <asm/irq.h>
-#include <asm/mipsregs.h>
-#include <asm/reboot.h>
-#include <asm/pgtable.h>
+
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-pb1x00/pb1550.h>
 
Index: linux-2.6/arch/mips/au1000/pb1550/init.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1550/init.c
+++ linux-2.6/arch/mips/au1000/pb1550/init.c
@@ -27,14 +27,10 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
+
 #include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/bootmem.h>
-#include <linux/string.h>
 #include <linux/kernel.h>
 
-#include <asm/addrspace.h>
 #include <asm/bootinfo.h>
 
 #include <prom.h>
Index: linux-2.6/arch/mips/au1000/pb1550/irqmap.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/pb1550/irqmap.c
+++ linux-2.6/arch/mips/au1000/pb1550/irqmap.c
@@ -25,26 +25,9 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
-#include <linux/errno.h>
+
 #include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/kernel_stat.h>
-#include <linux/module.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/timex.h>
-#include <linux/slab.h>
-#include <linux/random.h>
-#include <linux/delay.h>
-#include <linux/bitops.h>
 
-#include <asm/bootinfo.h>
-#include <asm/io.h>
-#include <asm/mipsregs.h>
-#include <asm/system.h>
 #include <asm/mach-au1x00/au1000.h>
 
 char irq_tab_alchemy[][5] __initdata = {
Index: linux-2.6/arch/mips/au1000/xxs1500/board_setup.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/xxs1500/board_setup.c
+++ linux-2.6/arch/mips/au1000/xxs1500/board_setup.c
@@ -23,19 +23,10 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
+
 #include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/ioport.h>
-#include <linux/mm.h>
-#include <linux/console.h>
 #include <linux/delay.h>
 
-#include <asm/cpu.h>
-#include <asm/bootinfo.h>
-#include <asm/irq.h>
-#include <asm/mipsregs.h>
-#include <asm/reboot.h>
-#include <asm/pgtable.h>
 #include <asm/mach-au1x00/au1000.h>
 
 void board_reset(void)
Index: linux-2.6/arch/mips/au1000/xxs1500/init.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/xxs1500/init.c
+++ linux-2.6/arch/mips/au1000/xxs1500/init.c
@@ -26,14 +26,10 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
+
 #include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/bootmem.h>
-#include <linux/string.h>
 #include <linux/kernel.h>
 
-#include <asm/addrspace.h>
 #include <asm/bootinfo.h>
 
 #include <prom.h>
Index: linux-2.6/arch/mips/au1000/xxs1500/irqmap.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/xxs1500/irqmap.c
+++ linux-2.6/arch/mips/au1000/xxs1500/irqmap.c
@@ -25,26 +25,9 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
-#include <linux/errno.h>
+
 #include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/kernel_stat.h>
-#include <linux/module.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/timex.h>
-#include <linux/slab.h>
-#include <linux/random.h>
-#include <linux/delay.h>
-#include <linux/bitops.h>
 
-#include <asm/bootinfo.h>
-#include <asm/io.h>
-#include <asm/mipsregs.h>
-#include <asm/system.h>
 #include <asm/mach-au1x00/au1000.h>
 
 struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
Index: linux-2.6/arch/mips/pci/fixup-au1000.c
===================================================================
--- linux-2.6.orig/arch/mips/pci/fixup-au1000.c
+++ linux-2.6/arch/mips/pci/fixup-au1000.c
@@ -26,13 +26,10 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
-#include <linux/types.h>
+
 #include <linux/pci.h>
-#include <linux/kernel.h>
 #include <linux/init.h>
 
-#include <asm/mach-au1x00/au1000.h>
-
 extern char irq_tab_alchemy[][5];
 
 int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
Index: linux-2.6/arch/mips/au1000/mtx-1/platform.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/mtx-1/platform.c
+++ linux-2.6/arch/mips/au1000/mtx-1/platform.c
@@ -19,7 +19,6 @@
  */
 
 #include <linux/init.h>
-#include <linux/types.h>
 #include <linux/platform_device.h>
 #include <linux/leds.h>
 #include <linux/gpio_keys.h>
