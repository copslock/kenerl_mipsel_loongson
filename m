Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Dec 2002 09:34:38 +0100 (CET)
Received: from mx2.mips.com ([206.31.31.227]:28609 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S8225201AbSLKIei>;
	Wed, 11 Dec 2002 09:34:38 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gBB8KQNf028853;
	Wed, 11 Dec 2002 00:20:54 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA21275;
	Wed, 11 Dec 2002 00:20:28 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gBB8KSb20283;
	Wed, 11 Dec 2002 09:20:28 +0100 (MET)
Message-ID: <3DF6F54C.64858797@mips.com>
Date: Wed, 11 Dec 2002 09:20:28 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Malta board patch
Content-Type: multipart/mixed;
 boundary="------------93A4B8413635DC7FA812BDF8"
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------93A4B8413635DC7FA812BDF8
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

I have attached a patch, with some minor changes for the Malta board.

/Carsten

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------93A4B8413635DC7FA812BDF8
Content-Type: text/plain; charset=iso-8859-15;
 name="malta.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="malta.patch"

Index: arch/mips/mips-boards/generic/memory.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mips-boards/generic/memory.c,v
retrieving revision 1.6.2.1
diff -u -r1.6.2.1 memory.c
--- arch/mips/mips-boards/generic/memory.c	5 Aug 2002 23:53:34 -0000	1.6.2.1
+++ arch/mips/mips-boards/generic/memory.c	11 Dec 2002 08:11:56 -0000
@@ -168,7 +168,7 @@
 			      + boot_mem_map.map[i].size) {
 			ClearPageReserved(virt_to_page(__va(addr)));
 			set_page_count(virt_to_page(__va(addr)), 1);
-			free_page(__va(addr));
+			free_page((unsigned long)__va(addr));
 			addr += PAGE_SIZE;
 			freed += PAGE_SIZE;
 		}
Index: arch/mips/mips-boards/generic/pci.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mips-boards/generic/pci.c,v
retrieving revision 1.5.2.4
diff -u -r1.5.2.4 pci.c
--- arch/mips/mips-boards/generic/pci.c	28 Sep 2002 18:28:44 -0000	1.5.2.4
+++ arch/mips/mips-boards/generic/pci.c	11 Dec 2002 08:11:56 -0000
@@ -405,6 +405,12 @@
 			".set\treorder");
 
 		irq = *(volatile u32 *)(KSEG1ADDR(BONITO_PCICFG_BASE));
+		__asm__ __volatile__(
+			".set\tnoreorder\n\t"
+			".set\tnoat\n\t"
+			"sync\n\t"
+			".set\tat\n\t"
+			".set\treorder");
 		irq &= 0xff;
 		BONITO_PCIMAP_CFG = 0;
 		break;
Index: arch/mips/mips-boards/malta/malta_int.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mips-boards/malta/malta_int.c,v
retrieving revision 1.8.2.6
diff -u -r1.8.2.6 malta_int.c
--- arch/mips/mips-boards/malta/malta_int.c	5 Aug 2002 23:53:34 -0000	1.8.2.6
+++ arch/mips/mips-boards/malta/malta_int.c	11 Dec 2002 08:11:57 -0000
@@ -91,6 +91,9 @@
 {
         unsigned int data,datahi;
 
+	/* Mask out corehi interrupt. */
+	clear_c0_status(IE_IRQ3);
+
         printk("CoreHI interrupt, shouldn't happen, so we die here!!!\n");
         printk("epc   : %08lx\nStatus: %08lx\nCause : %08lx\nbadVaddr : %08lx\n"
 , regs->cp0_epc, regs->cp0_status, regs->cp0_cause, regs->cp0_badvaddr);
@@ -125,7 +128,6 @@
 
         /* We die here*/
         die("CoreHi interrupt", regs);
-        while (1) ;
 }
 
 void __init init_IRQ(void)
Index: include/asm-mips/mips-boards/malta.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/mips-boards/malta.h,v
retrieving revision 1.1.4.2
diff -u -r1.1.4.2 malta.h
--- include/asm-mips/mips-boards/malta.h	5 Aug 2002 23:53:38 -0000	1.1.4.2
+++ include/asm-mips/mips-boards/malta.h	11 Dec 2002 08:12:17 -0000
@@ -32,9 +32,23 @@
  * Malta I/O ports base address for the Galileo GT64120 and Algorithmics
  * Bonito system controllers.
  */
-#define MALTA_GT_PORT_BASE      (KSEG1ADDR(0x18000000))
+#define MALTA_GT_PORT_BASE      get_gt_port_base(GT_PCI0IOLD_OFS)
 #define MALTA_BONITO_PORT_BASE  (KSEG1ADDR(0x1fd00000))
-#define MALTA_MSC_PORT_BASE     (KSEG1ADDR(0x18000000))
+#define MALTA_MSC_PORT_BASE     get_msc_port_base(MSC01_PCI_SC2PIOBASL)
+
+static inline unsigned long get_gt_port_base(unsigned long reg)
+{
+	unsigned long addr;
+	GT_READ(reg, addr);
+	return KSEG1ADDR((addr & 0xffff) << 21);
+}
+
+static inline unsigned long get_msc_port_base(unsigned long reg)
+{
+	unsigned long addr;
+	MSC_READ(reg, addr);
+	return KSEG1ADDR(addr);
+}
 
 /*
  * Malta RTC-device indirect register access.
@@ -58,5 +72,7 @@
 #define SMSC_CONFIG_ACTIVATE_ENABLE   1
 
 #define SMSC_WRITE(x,a)     outb(x,a)
+
+#define MALTA_JMPRS_REG		(KSEG1ADDR(0x1f000210))
 
 #endif /* !(_MIPS_MALTA_H) */
Index: include/asm-mips64/mips-boards/malta.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips64/mips-boards/malta.h,v
retrieving revision 1.1.2.2
diff -u -r1.1.2.2 malta.h
--- include/asm-mips64/mips-boards/malta.h	5 Aug 2002 23:53:39 -0000	1.1.2.2
+++ include/asm-mips64/mips-boards/malta.h	11 Dec 2002 08:12:18 -0000
@@ -32,9 +32,23 @@
  * Malta I/O ports base address for the Galileo GT64120 and Algorithmics
  * Bonito system controllers.
  */
-#define MALTA_GT_PORT_BASE      (KSEG1ADDR(0x18000000))
+#define MALTA_GT_PORT_BASE      get_gt_port_base(GT_PCI0IOLD_OFS)
 #define MALTA_BONITO_PORT_BASE  (KSEG1ADDR(0x1fd00000))
-#define MALTA_MSC_PORT_BASE     (KSEG1ADDR(0x18000000))
+#define MALTA_MSC_PORT_BASE     get_msc_port_base(MSC01_PCI_SC2PIOBASL)
+
+static inline unsigned long get_gt_port_base(unsigned long reg)
+{
+	unsigned long addr;
+	GT_READ(reg, addr);
+	return KSEG1ADDR((addr & 0xffff) << 21);
+}
+
+static inline unsigned long get_msc_port_base(unsigned long reg)
+{
+	unsigned long addr;
+	MSC_READ(reg, addr);
+	return KSEG1ADDR(addr);
+}
 
 /*
  * Malta RTC-device indirect register access.
@@ -58,5 +72,7 @@
 #define SMSC_CONFIG_ACTIVATE_ENABLE   1
 
 #define SMSC_WRITE(x,a)     outb(x,a)
+
+#define MALTA_JMPRS_REG		(KSEG1ADDR(0x1f000210))
 
 #endif /* !(_MIPS_MALTA_H) */

--------------93A4B8413635DC7FA812BDF8--
