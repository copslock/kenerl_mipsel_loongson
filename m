Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Dec 2003 09:03:57 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:21915 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225794AbTLWJDy>;
	Tue, 23 Dec 2003 09:03:54 +0000
Received: from teasel.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id hBN93oQF010980;
	Tue, 23 Dec 2003 10:03:50 +0100 (MET)
Received: (from dimitri@localhost)
	by teasel.sonytel.be (8.9.3+Sun/8.9.3) id KAA05325;
	Tue, 23 Dec 2003 10:03:51 +0100 (MET)
Date: Tue, 23 Dec 2003 10:03:51 +0100
From: Dimitri Torfs <dimitri@sonycom.com>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: [PATCH 2.6] use struct uart_port for early_serial_setup()
Message-ID: <20031223090351.GA5300@sonycom.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <dimitri@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3824
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dimitri@sonycom.com
Precedence: bulk
X-list: linux-mips



--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

  I think early_serial_setup() should be called with struct uart_port* instead
  of struct serial_struct*. Patch for the Vr41xx series.

  Dimitri

-- 
Dimitri Torfs             |  NSCE 
dimitri.torfs@sonycom.com |  Sint Stevens Woluwestraat 55
tel: +32 2 2908451        |  1130 Brussel
fax: +32 2 7262686        |  Belgium


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

Index: arch/mips/vr41xx/common/serial.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/vr41xx/common/serial.c,v
retrieving revision 1.4
diff -u -r1.4 serial.c
--- arch/mips/vr41xx/common/serial.c	31 Oct 2003 01:49:07 -0000	1.4
+++ arch/mips/vr41xx/common/serial.c	23 Dec 2003 08:51:07 -0000
@@ -41,7 +41,9 @@
  */
 #include <linux/init.h>
 #include <linux/types.h>
+#include <linux/tty.h>
 #include <linux/serial.h>
+#include <linux/serial_core.h>
 
 #include <asm/addrspace.h>
 #include <asm/cpu.h>
@@ -116,59 +118,62 @@
 
 void __init vr41xx_siu_init(int interface, int module)
 {
-	struct serial_struct s;
+#ifdef CONFIG_SERIAL_8250
+	struct uart_port p;
 
 	vr41xx_siu_ifselect(interface, module);
 
-	memset(&s, 0, sizeof(s));
+	memset(&p, 0, sizeof(p));
 
-	s.line = vr41xx_serial_ports;
-	s.baud_base = SIU_BASE_BAUD;
-	s.irq = SIU_IRQ;
-	s.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
+	p.line = vr41xx_serial_ports;
+	p.uartclk = SIU_BASE_BAUD * 16;
+	p.irq = SIU_IRQ;
+	p.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
 	switch (current_cpu_data.cputype) {
 	case CPU_VR4111:
 	case CPU_VR4121:
-		s.iomem_base = (unsigned char *)VR4111_SIURB;
+		p.membase = (unsigned char *)VR4111_SIURB;
 		break;
 	case CPU_VR4122:
 	case CPU_VR4131:
 	case CPU_VR4133:
-		s.iomem_base = (unsigned char *)VR4122_SIURB;
+		p.membase = (unsigned char *)VR4122_SIURB;
 		break;
 	default:
 		panic("Unexpected CPU of NEC VR4100 series");
 		break;
 	}
-	s.iomem_reg_shift = 0;
-	s.io_type = SERIAL_IO_MEM;
-	if (early_serial_setup(&s) != 0)
+	p.regshift = 0;
+	p.iotype = UPIO_MEM;
+	if (early_serial_setup(&p) != 0)
 		printk(KERN_ERR "SIU setup failed!\n");
 
 	vr41xx_clock_supply(SIU_CLOCK);
 
 	vr41xx_serial_ports++;
+#endif
 }
 
 void __init vr41xx_dsiu_init(void)
 {
-	struct serial_struct s;
+#ifdef CONFIG_SERIAL_8250
+	struct uart_port p;
 
 	if (current_cpu_data.cputype != CPU_VR4122 &&
 	    current_cpu_data.cputype != CPU_VR4131 &&
 	    current_cpu_data.cputype != CPU_VR4133)
 		return;
 
-	memset(&s, 0, sizeof(s));
+	memset(&p, 0, sizeof(p));
 
-	s.line = vr41xx_serial_ports;
-	s.baud_base = DSIU_BASE_BAUD;
-	s.irq = DSIU_IRQ;
-	s.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
-	s.iomem_base = (unsigned char *)DSIURB;
-	s.iomem_reg_shift = 0;
-	s.io_type = SERIAL_IO_MEM;
-	if (early_serial_setup(&s) != 0)
+	p.line = vr41xx_serial_ports;
+	p.uartclk = DSIU_BASE_BAUD * 16;
+	p.irq = DSIU_IRQ;
+	p.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
+	p.membase = (unsigned char *)DSIURB;
+	p.regshift = 0;
+	p.iotype = UPIO_MEM;
+	if (early_serial_setup(&p) != 0)
 		printk(KERN_ERR "DSIU setup failed!\n");
 
 	vr41xx_clock_supply(DSIU_CLOCK);
@@ -176,4 +181,5 @@
 	writew(INTDSIU, MDSIUINTREG);
 
 	vr41xx_serial_ports++;
+#endif
 }

--jI8keyz6grp/JLjh--
