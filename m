Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jul 2005 16:15:23 +0100 (BST)
Received: from mo00.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:12738 "EHLO
	mo00.iij4u.or.jp") by linux-mips.org with ESMTP id <S8226727AbVGOPPH>;
	Fri, 15 Jul 2005 16:15:07 +0100
Received: MO(mo00)id j6FFGOjJ015281; Sat, 16 Jul 2005 00:16:24 +0900 (JST)
Received: MDO(mdo00) id j6FFGN5T010835; Sat, 16 Jul 2005 00:16:24 +0900 (JST)
Received: from stratos (h086.p498.iij4u.or.jp [210.149.242.86])
	by mbox.iij4u.or.jp (4U-MR/mbox00) id j6FFGM4Z002435
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Sat, 16 Jul 2005 00:16:23 +0900 (JST)
Date:	Sat, 16 Jul 2005 00:16:21 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	ppopov@linux-mips.org
Cc:	yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-Id: <20050716001621.6d9d607a.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20050714174806Z8226711-3678+3079@linux-mips.org>
References: <20050714174806Z8226711-3678+3079@linux-mips.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Pete,

On Thu, 14 Jul 2005 18:48:00 +0100
ppopov@linux-mips.org wrote:

> 
> Log message:
> 	Philips PNX8550 support: MIPS32-like core with 2 Trimedias on it.

I think the following include path is better.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/philips/pnx8550/common/gdb_hook.c a/arch/mips/philips/pnx8550/common/gdb_hook.c
--- a-orig/arch/mips/philips/pnx8550/common/gdb_hook.c	2005-07-15 02:47:58.000000000 +0900
+++ a/arch/mips/philips/pnx8550/common/gdb_hook.c	2005-07-15 23:44:03.361056952 +0900
@@ -31,7 +31,7 @@
 #include <asm/serial.h>
 #include <asm/io.h>
 
-#include <asm/mach-pnx8550/uart.h>
+#include <uart.h>
 
 static struct serial_state rs_table[RS_TABLE_SIZE] = {
 	SERIAL_PORT_DFNS	/* Defined in serial.h */
diff -urN -X dontdiff a-orig/arch/mips/philips/pnx8550/common/int.c a/arch/mips/philips/pnx8550/common/int.c
--- a-orig/arch/mips/philips/pnx8550/common/int.c	2005-07-15 02:47:58.000000000 +0900
+++ a/arch/mips/philips/pnx8550/common/int.c	2005-07-15 23:44:32.008701848 +0900
@@ -35,8 +35,8 @@
 
 #include <asm/io.h>
 #include <asm/gdb-stub.h>
-#include <asm/mach-pnx8550/int.h>
-#include <asm/mach-pnx8550/uart.h>
+#include <int.h>
+#include <uart.h>
 
 extern asmlinkage void cp0_irqdispatch(void);
 
diff -urN -X dontdiff a-orig/arch/mips/philips/pnx8550/common/pci.c a/arch/mips/philips/pnx8550/common/pci.c
--- a-orig/arch/mips/philips/pnx8550/common/pci.c	2005-07-15 02:47:58.000000000 +0900
+++ a/arch/mips/philips/pnx8550/common/pci.c	2005-07-15 23:44:52.444595120 +0900
@@ -24,9 +24,9 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 
-#include <asm/mach-pnx8550/pci.h>
-#include <asm/mach-pnx8550/glb.h>
-#include <asm/mach-pnx8550/nand.h>
+#include <pci.h>
+#include <glb.h>
+#include <nand.h>
 
 static struct resource pci_io_resource = {
 	"pci IO space",
diff -urN -X dontdiff a-orig/arch/mips/philips/pnx8550/common/platform.c a/arch/mips/philips/pnx8550/common/platform.c
--- a-orig/arch/mips/philips/pnx8550/common/platform.c	2005-07-15 02:47:58.000000000 +0900
+++ a/arch/mips/philips/pnx8550/common/platform.c	2005-07-15 23:45:16.826888448 +0900
@@ -17,9 +17,9 @@
 #include <linux/init.h>
 #include <linux/resource.h>
 
-#include <asm/mach-pnx8550/int.h>
-#include <asm/mach-pnx8550/usb.h>
-#include <asm/mach-pnx8550/uart.h>
+#include <int.h>
+#include <usb.h>
+#include <uart.h>
 
 static struct resource pnx8550_usb_ohci_resources[] = {
 	[0] = {
diff -urN -X dontdiff a-orig/arch/mips/philips/pnx8550/common/proc.c a/arch/mips/philips/pnx8550/common/proc.c
--- a-orig/arch/mips/philips/pnx8550/common/proc.c	2005-07-15 02:47:58.000000000 +0900
+++ a/arch/mips/philips/pnx8550/common/proc.c	2005-07-15 23:45:33.076418144 +0900
@@ -24,8 +24,8 @@
 
 #include <asm/io.h>
 #include <asm/gdb-stub.h>
-#include <asm/mach-pnx8550/int.h>
-#include <asm/mach-pnx8550/uart.h>
+#include <int.h>
+#include <uart.h>
 
 
 static int pnx8550_timers_read (char* page, char** start, off_t offset, int count, int* eof, void* data)
diff -urN -X dontdiff a-orig/arch/mips/philips/pnx8550/common/prom.c a/arch/mips/philips/pnx8550/common/prom.c
--- a-orig/arch/mips/philips/pnx8550/common/prom.c	2005-07-15 02:47:58.000000000 +0900
+++ a/arch/mips/philips/pnx8550/common/prom.c	2005-07-15 23:45:44.729646584 +0900
@@ -15,7 +15,7 @@
 #include <linux/string.h>
 
 #include <asm/bootinfo.h>
-#include <asm/mach-pnx8550/uart.h>
+#include <uart.h>
 
 /* #define DEBUG_CMDLINE */
 
diff -urN -X dontdiff a-orig/arch/mips/philips/pnx8550/common/reset.c a/arch/mips/philips/pnx8550/common/reset.c
--- a-orig/arch/mips/philips/pnx8550/common/reset.c	2005-07-15 02:47:58.000000000 +0900
+++ a/arch/mips/philips/pnx8550/common/reset.c	2005-07-15 23:45:55.884950720 +0900
@@ -23,7 +23,7 @@
 #include <linux/config.h>
 #include <linux/slab.h>
 #include <asm/reboot.h>
-#include <asm/mach-pnx8550/glb.h>
+#include <glb.h>
 
 void pnx8550_machine_restart(char *command)
 {
diff -urN -X dontdiff a-orig/arch/mips/philips/pnx8550/common/setup.c a/arch/mips/philips/pnx8550/common/setup.c
--- a-orig/arch/mips/philips/pnx8550/common/setup.c	2005-07-15 02:47:58.000000000 +0900
+++ a/arch/mips/philips/pnx8550/common/setup.c	2005-07-15 23:43:38.693806944 +0900
@@ -33,11 +33,11 @@
 #include <asm/pgtable.h>
 #include <asm/time.h>
 
-#include <asm/mach-pnx8550/glb.h>
-#include <asm/mach-pnx8550/int.h>
-#include <asm/mach-pnx8550/pci.h>
-#include <asm/mach-pnx8550/uart.h>
-#include <asm/mach-pnx8550/nand.h>
+#include <glb.h>
+#include <int.h>
+#include <pci.h>
+#include <uart.h>
+#include <nand.h>
 
 extern void prom_printf(char *fmt, ...);
 
diff -urN -X dontdiff a-orig/arch/mips/philips/pnx8550/common/time.c a/arch/mips/philips/pnx8550/common/time.c
--- a-orig/arch/mips/philips/pnx8550/common/time.c	2005-07-15 02:47:58.000000000 +0900
+++ a/arch/mips/philips/pnx8550/common/time.c	2005-07-15 23:46:11.606560672 +0900
@@ -31,8 +31,8 @@
 #include <asm/div64.h>
 #include <asm/debug.h>
 
-#include <asm/mach-pnx8550/int.h>
-#include <asm/mach-pnx8550/cm.h>
+#include <int.h>
+#include <cm.h>
 
 extern unsigned int mips_hpt_frequency;
 
diff -urN -X dontdiff a-orig/arch/mips/philips/pnx8550/jbs/board_setup.c a/arch/mips/philips/pnx8550/jbs/board_setup.c
--- a-orig/arch/mips/philips/pnx8550/jbs/board_setup.c	2005-07-15 02:47:59.000000000 +0900
+++ a/arch/mips/philips/pnx8550/jbs/board_setup.c	2005-07-15 23:46:28.102052976 +0900
@@ -39,7 +39,7 @@
 #include <asm/reboot.h>
 #include <asm/pgtable.h>
 
-#include <asm/mach-pnx8550/glb.h>
+#include <glb.h>
 
 /* CP0 hazard avoidance. */
 #define BARRIER __asm__ __volatile__(".set noreorder\n\t" \
diff -urN -X dontdiff a-orig/arch/mips/philips/pnx8550/jbs/irqmap.c a/arch/mips/philips/pnx8550/jbs/irqmap.c
--- a-orig/arch/mips/philips/pnx8550/jbs/irqmap.c	2005-07-15 02:47:59.000000000 +0900
+++ a/arch/mips/philips/pnx8550/jbs/irqmap.c	2005-07-15 23:46:38.463477800 +0900
@@ -26,7 +26,7 @@
  */
 
 #include <linux/init.h>
-#include <asm/mach-pnx8550/int.h>
+#include <int.h>
 
 char irq_tab_jbs[][5] __initdata = {
  [8] =	{ -1, PNX8550_INT_PCI_INTA, 0xff, 0xff, 0xff},
