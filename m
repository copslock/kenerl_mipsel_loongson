Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Feb 2003 13:36:33 +0000 (GMT)
Received: from grey.subnet.at ([IPv6:::ffff:193.170.141.20]:5903 "EHLO
	grey.subnet.at") by linux-mips.org with ESMTP id <S8225200AbTBNNgc>;
	Fri, 14 Feb 2003 13:36:32 +0000
Received: from localhost ([193.170.141.10]) by grey.subnet.at ; Fri, 14 Feb 2003 14:36:21 +0100
From: Bruno Randolf <br1@4g-systems.de>
To: linux-mips@linux-mips.org
Subject: [patch] au1x00 power management
Date: Fri, 14 Feb 2003 14:36:12 +0100
User-Agent: KMail/1.5
Organization: 4G Mobile Systeme
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_MDPT+XYfYb0o1xz"
Message-Id: <200302141436.12593.br1@4g-systems.de>
X-Rcpt-To: <linux-mips@linux-mips.org>
Return-Path: <br1@4g-systems.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: br1@4g-systems.de
Precedence: bulk
X-list: linux-mips


--Boundary-00=_MDPT+XYfYb0o1xz
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hello!

this is a trivial patch which enables the experimental power management on 
au1x00. while it does not add anything substantial it makes it working again 
by resolving some naming issues - resulting in about 50% less power 
consumption on my machine.

regards,
bruno


--Boundary-00=_MDPT+XYfYb0o1xz
Content-Type: text/x-diff;
  charset="us-ascii";
  name="au1000_power.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="au1000_power.diff"

--- linux-mips-2_4-cvs-clean/arch/mips/au1000/common/power.c	Wed Dec 11 07:12:29 2002
+++ linux-mips-2_4/arch/mips/au1000/common/power.c	Fri Feb 14 12:17:53 2003
@@ -52,10 +52,10 @@
 extern void au1k_wait(void);
 static void calibrate_delay(void);
 
-extern void set_au1000_speed(unsigned int new_freq);
-extern unsigned int get_au1000_speed(void);
-extern unsigned long get_au1000_uart_baud_base(void);
-extern void set_au1000_uart_baud_base(unsigned long new_baud_base);
+extern void set_au1x00_speed(unsigned int new_freq);
+extern unsigned int get_au1x00_speed(void);
+extern unsigned long get_au1x00_uart_baud_base(void);
+extern void set_au1x00_uart_baud_base(unsigned long new_baud_base);
 extern unsigned long save_local_and_disable(int controller);
 extern void restore_local_and_enable(int controller, unsigned long mask);
 extern void local_enable_irq(unsigned int irq_nr);
@@ -188,13 +188,13 @@
 			return -EFAULT;
 		}
 
-		old_baud_base = get_au1000_uart_baud_base();
-		old_cpu_freq = get_au1000_speed();
-
+		old_baud_base = get_au1x00_uart_baud_base();
+		old_cpu_freq = get_au1x00_speed();
+		
 		new_cpu_freq = pll * 12 * 1000000;
-		new_baud_base = (new_cpu_freq / 4) / 16;
-		set_au1000_speed(new_cpu_freq);
-		set_au1000_uart_baud_base(new_baud_base);
+		new_baud_base = (new_cpu_freq / 4) / 16;	
+		set_au1x00_speed(new_cpu_freq);
+		set_au1x00_uart_baud_base(new_baud_base);
 
 		old_refresh = au_readl(MEM_SDREFCFG) & 0x1ffffff;
 		new_refresh =
@@ -325,9 +325,11 @@
 	}
 }
 
+/*
 void au1k_wait(void)
 {
 	__asm__("nop\n\t" "nop\n\t");
 }
+*/
 
 #endif				/* CONFIG_PM */
--- linux-mips-2_4-cvs-clean/arch/mips/config-shared.in Fri Feb 14 12:12:25 2003
+++ linux-mips-2_4/arch/mips/config-shared.in   Fri Feb 14 12:46:14 2003
@@ -823,7 +823,9 @@

 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC

-dep_bool 'Power Management support (EXPERIMENTAL)' CONFIG_PM $CONFIG_EXPERIMENTAL $CONFIG_MIPS_AU1000
+if [ "$CONFIG_CPU_AU1X00" = "y" ] ; then
+   dep_bool 'Power Management support (EXPERIMENTAL)' CONFIG_PM $CONFIG_EXPERIMENTAL
+fi
 endmenu

 source drivers/mtd/Config.in

--Boundary-00=_MDPT+XYfYb0o1xz--
