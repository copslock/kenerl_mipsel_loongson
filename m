Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Sep 2002 23:01:55 +0200 (CEST)
Received: from cassidy.nuernberg.linuxtag.net ([212.204.83.80]:8973 "EHLO
	cassidy.nuernberg.linuxtag.net") by linux-mips.org with ESMTP
	id <S1122960AbSIJVBy>; Tue, 10 Sep 2002 23:01:54 +0200
Received: by cassidy.nuernberg.linuxtag.net (Postfix, from userid 1006)
	id 9790EEC280; Tue, 10 Sep 2002 23:05:17 +0200 (CEST)
Received: from hydra.linuxtag.uni-kl.de (VPN-Hydra [192.168.0.1])
	by cassidy.nuernberg.linuxtag.net (Postfix) with ESMTP id A9816EC0F6
	for <linux-mips@linux-mips.org>; Tue, 10 Sep 2002 23:05:14 +0200 (CEST)
Received: by hydra.linuxtag.uni-kl.de (Postfix, from userid 1034)
	id 35D691DD5; Tue, 10 Sep 2002 23:01:40 +0200 (CEST)
Received: from cassidy.nuernberg.linuxtag.net (unknown [192.168.200.1])
	by hydra.linuxtag.uni-kl.de (Postfix) with ESMTP id 8A4A51D37
	for <merker@linuxtag.org>; Tue, 10 Sep 2002 21:00:49 +0000 (UTC)
Received: by cassidy.nuernberg.linuxtag.net (Postfix, from userid 1006)
	id AEF93EC280; Tue, 10 Sep 2002 23:04:23 +0200 (CEST)
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by cassidy.nuernberg.linuxtag.net (Postfix) with ESMTP id AEAC4EC0F6
	for <merker@linuxtag.org>; Tue, 10 Sep 2002 23:04:20 +0200 (CEST)
Received: from excalibur.cologne.de (p508510F9.dip.t-dialin.net [80.133.16.249])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id XAA04022
	for <merker@linuxtag.org>; Tue, 10 Sep 2002 23:00:47 +0200 (MET DST)
Resent-From: karsten@excalibur.cologne.de
Received: from karsten by excalibur.cologne.de with local (Exim 3.35 #1 (Debian))
	id 17osCd-0001jp-00
	for <merker@linuxtag.org>; Tue, 10 Sep 2002 23:05:43 +0200
Date: Tue, 10 Sep 2002 22:48:41 +0200
From: Karsten Merker <karsten@excalibur.cologne.de>
To: linux-mips@linux-mips.org
Cc: p2@mind.be
Subject: Cobalt NASRaq patches
Message-ID: <20020910204841.GA6525@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@linux-mips.org, p2@mind.be
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
Resent-Date: Tue, 10 Sep 2002 23:05:42 +0200
Resent-To: merker@linuxtag.org
Resent-Message-Id: <E17osCd-0001jp-00@excalibur.cologne.de>
Resent-From: merker@linuxtag.org
Resent-Date: Tue, 10 Sep 2002 23:01:40 +0200
Resent-To: linux-mips@linux-mips.org
Return-Path: <merker@linuxtag.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karsten@excalibur.cologne.de
Precedence: bulk
X-list: linux-mips


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hallo everybody,

Peter de Schrijver and I have been working on the support for the Cobalt
NASRaq. The results are several patches, of which the first three are IMHO
ready for inclusion into oss cvs (patches are short and self-explaining and
should not have any side effects). These are:

- cobalt-2.4-20020908-2-galileo.diff
  Small change in the code fragment distinguishing between "old" and
  "new" galileo chipsets). The old code did not take into account that
  there are systems with newer chip revisions than 0x10.

- cobalt-2.4-20020908-2-rootdev.diff
  Allow setting the root device through a config option. The firmware
  of the MIPS-based Cobalt systems does not allow to pass commandline
  parameters to the kernel, so the root device has to be compiled in.

- cobalt-2.4-20020908-2-serial.diff
  The NASRaq has an ST16C650 serial controller, which has some differences
  in the register set in comparison to the standard 16C550 which need to
  be handled.

Besides these, the tulip driver needs some patches, too. These are not yet
ready for inclusion into cvs and will be submitted later.

Ralf, Maciej, could you please apply the appended patches?

Regards,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cobalt-2.4-20020908-2-galileo.diff"

diff -Nur linux-mips-cvs/arch/mips/cobalt/pci.c linux-cobalt/arch/mips/cobalt/pci.c
--- linux-mips-cvs/arch/mips/cobalt/pci.c	Thu Aug 15 09:56:41 2002
+++ linux-cobalt/arch/mips/cobalt/pci.c	Sun Sep  8 22:25:16 2002
@@ -8,6 +8,9 @@
  * Copyright (C) 1995, 1996, 1997 by Ralf Baechle
  * Copyright (C) 2001 by Liam Davies (ldavies@agile.tv)
  *
+ * 2002/09/08 changed qube_raq_galileo_fixup to handle newer Galileo revisions
+ *            Peter de Schrijver <p2@mind.be>,
+ *            Karsten Merker <merker@debian.org>
  */
 
 #include <linux/config.h>
@@ -20,6 +23,8 @@
 #include <asm/pci.h>
 #include <asm/io.h>
 
+#undef DEBUG
+
 #ifdef CONFIG_PCI
 
 int cobalt_board_id;
@@ -204,6 +209,10 @@
 {
 	unsigned short galileo_id;
 
+#ifdef DEBUG
+	printk("pci.c: qube_raq_galileo_fixup: pci vendor id: %04x, pci device id: %04x\n",dev->vendor,dev->device);
+#endif
+
 	/* Fix PCI latency-timer and cache-line-size values in Galileo
 	 * host bridge.
 	 */
@@ -219,7 +228,17 @@
 	 */
 	pci_read_config_word(dev, PCI_REVISION_ID, &galileo_id);
 	galileo_id &= 0xff;     /* mask off class info */
-	if (galileo_id == 0x10) {
+
+	/* Originally the code checked only for existence of revision
+	 * 0x10 (new Galileo) or 0x01/0x02 (old Galileo). At least in
+	 * the NASRAQ there is a revision 0x11, which should probably
+	 * be handled as new Galileo too, so we now check for
+	 * galileo_id >= 0x10 instead of galileo_id == 0x10.
+	 *            Peter de Schrijver <p2@mind.be>,
+	 *            Karsten Merker <merker@debian.org>, 2002/09/08
+	 */
+
+	if (galileo_id >= 0x10) {
 		/* New Galileo, assumes PCI stop line to VIA is connected. */
 		*((volatile unsigned int *)0xb4000c04) = 0x00004020;
 	} else if (galileo_id == 0x1 || galileo_id == 0x2) {

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cobalt-2.4-20020908-2-rootdev.diff"

diff -Nur linux-mips-cvs/Documentation/Configure.help linux-cobalt/Documentation/Configure.help
--- linux-mips-cvs/Documentation/Configure.help	Thu Jun 27 00:34:59 2002
+++ linux-cobalt/Documentation/Configure.help	Sun Sep  8 22:55:06 2002
@@ -2336,6 +2336,15 @@
   behaviour is platform-dependent, but normally the flash frequency is
   a hyperbolic function of the 5-minute load average.
 
+Root device for the MIPS-based Cobalt systems
+CONFIG_COBALT_MIPS_ROOTDEVICE
+ The firmware of the MIPS-based Cobalt systems does not allow to 
+ specify a kernel command line, so it has to be compiled into the 
+ kernel. This includes the root device to use, so you have to change
+ this option and recompile the kernel to use another root partition.
+ Please note that this option is overridden by CONFIG_ROOT_NFS,
+ which implies a "root=/dev/nfs rw".
+
 Networking support
 CONFIG_NET
   Unless you really know what you are doing, you should say Y here.
diff -Nur linux-mips-cvs/arch/mips/cobalt/setup.c linux-cobalt/arch/mips/cobalt/setup.c
--- linux-mips-cvs/arch/mips/cobalt/setup.c	Thu Aug 15 10:03:21 2002
+++ linux-cobalt/arch/mips/cobalt/setup.c	Sun Sep  8 22:40:44 2002
@@ -8,6 +8,14 @@
  * Copyright (C) 1996, 1997 by Ralf Baechle
  * Copyright (C) 2001 by Liam Davies (ldavies@agile.tv)
  *
+ * 2002/09/08 added CONFIG_COBALT_MIPS_ROOTDEVICE option
+ *            The Cobalt firmware does not allow to specify a kernel command
+ *            line, so it has to be compiled into the kernel. Made the
+ *            root device a config option so one does not always have to
+ *            modify the sources to boot from another partition.
+ *            Peter de Schrijver <p2@mind.be>,
+ *            Karsten Merker <merker@debian.org>
+ *            
  */
 
 #include <linux/config.h>
@@ -34,6 +42,9 @@
 extern struct rtc_ops std_rtc_ops;
 extern struct ide_ops std_ide_ops;
 
+#ifndef CONFIG_COBALT_MIPS_ROOTDEVICE
+#define CONFIG_COBALT_MIPS_ROOTDEVICE "/dev/hda1"
+#endif
 
 char arcs_cmdline[CL_SIZE] = {
  "console=ttyS0,115200 "
@@ -41,9 +52,9 @@
  "ip=on "
 #endif
 #ifdef CONFIG_ROOT_NFS
- "root=/dev/nfs "
+ "root=/dev/nfs rw "
 #else
- "root=/dev/hda1 "
+ "root=" CONFIG_COBALT_MIPS_ROOTDEVICE
 #endif
  };
 
diff -Nur linux-mips-cvs/arch/mips/config-shared.in linux-cobalt/arch/mips/config-shared.in
--- linux-mips-cvs/arch/mips/config-shared.in	Tue Sep  3 01:34:10 2002
+++ linux-cobalt/arch/mips/config-shared.in	Sun Sep  8 22:42:57 2002
@@ -584,6 +584,10 @@
    bool '    ISA bus support' CONFIG_ISA
 fi
 
+if [ "$CONFIG_MIPS_COBALT" = "y" ]; then
+   string 'Cobalt systems root device' CONFIG_COBALT_MIPS_ROOTDEVICE "/dev/hda1"
+fi
+
 bool 'Networking support' CONFIG_NET
 
 if [ "$CONFIG_PCI" != "y" ]; then

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cobalt-2.4-20020908-2-serial.diff"

diff -Nur linux-mips-cvs/drivers/char/serial.c linux-cobalt/drivers/char/serial.c
--- linux-mips-cvs/drivers/char/serial.c	Wed Jul 24 15:51:48 2002
+++ linux-cobalt/drivers/char/serial.c	Sun Sep  8 23:35:08 2002
@@ -68,6 +68,14 @@
  *        Kevin D. Kissell, kevink@mips.com and Carsten Langgaard,
  *        carstenl@mips.com
  *        Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
+ *
+ * 2002/09/08 fixed handling of the ST16C650 UART
+ *        The ST16C650, which is used in the Cobalt NASRAQ, differs
+ *        from the "normal" 16C550 regarding the FIFO handling and needs
+ *        special treatment (e.g. FIFO trigger level bits are defined 
+ *        differently than for the 16C550).
+ *        Peter de Schrijver <p2@mind.be>, Karsten Merker <merker@debian.org>
+ *        
  */
 
 static char *serial_version = "5.05c";
@@ -307,8 +315,15 @@
 	{ "16550A", 16, UART_CLEAR_FIFO | UART_USE_FIFO }, 
 	{ "cirrus", 1, 0 }, 	/* usurped by cyclades.c */
 	{ "ST16650", 1, UART_CLEAR_FIFO | UART_STARTECH }, 
-	{ "ST16650V2", 32, UART_CLEAR_FIFO | UART_USE_FIFO |
-		  UART_STARTECH }, 
+	{ "ST16650V2", 16, UART_CLEAR_FIFO | UART_USE_FIFO |
+		  UART_STARTECH }, /* Although the datasheet indicates a 32byte
+				      Tx FIFO size, the lowest possible trigger
+				      level is 8 bytes, which effectively should
+ 				      give us a 24 byte guaranteed FIFO. But
+				      testing has indicated this doesn't work,
+				      although it's unclear why.
+				      Limiting the Tx FIFO size to 16bytes does
+				      work. */
 	{ "TI16750", 64, UART_CLEAR_FIFO | UART_USE_FIFO},
 	{ "Startech", 1, 0},	/* usurped by cyclades.c */
 	{ "16C950/954", 128, UART_CLEAR_FIFO | UART_USE_FIFO},
@@ -1753,6 +1768,10 @@
 		else if (info->state->type == PORT_RSA)
 			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_14;
 #endif
+		else if (info->state->type == PORT_16650V2) {
+			fcr = UART_FCR_ENABLE_FIFO | UART_FCR6_R_TRIGGER_8
+			      | UART_FCR6_T_TRIGGER_8;
+		}	
 		else
 			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_8;
 	}

--vtzGhvizbBRQ85DL--
