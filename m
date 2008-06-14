Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Jun 2008 02:32:48 +0100 (BST)
Received: from jehova.dsm.dk ([80.199.102.117]:37256 "EHLO jehova.dsm.dk")
	by ftp.linux-mips.org with ESMTP id S20037362AbYFNBco (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 14 Jun 2008 02:32:44 +0100
Received: (qmail 29538 invoked by uid 1000); 14 Jun 2008 01:32:42 -0000
Date:	Sat, 14 Jun 2008 02:32:42 +0100 (BST)
From:	Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To:	ralf@linux-mips.org
cc:	linux-mips@linux-mips.org
Subject: [PATCH] 2.6.25.6 bring Lasat back from the dead
Message-ID: <Pine.LNX.4.40.0806140224580.29138-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <th@jehova.dsm.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas@horsten.com
Precedence: bulk
X-list: linux-mips

After the common MIPS CPU interrupt controller (for irq0-7) was
introduced the Lasat boards didn't get their interrupts right, so
nothing worked. The old routines need to be offset by the new 8
hardware interrupts common to all MIPS CPU's.

Signed-off-by: Thomas Horsten <thomas@horsten.com>

diff -u -r linux-2.6.25.6/arch/mips/lasat/image/Makefile linux-2.6.25.6-th/arch/mips/lasat/image/Makefile
--- linux-2.6.25.6/arch/mips/lasat/image/Makefile	2008-06-11 10:39:29.000000000 +0100
+++ linux-2.6.25.6-th/arch/mips/lasat/image/Makefile	2008-06-12 18:35:45.000000000 +0100
@@ -24,7 +24,7 @@
 		-D TIMESTAMP=$(shell date +%s)

 $(obj)/head.o: $(obj)/head.S $(KERNEL_IMAGE)
-	$(CC) -fno-pic $(HEAD_DEFINES) $(LINUXINCLUDE) -c -o $@ $<
+	$(CC) -EL -fno-pic $(HEAD_DEFINES) $(LINUXINCLUDE) -c -o $@ $<

 OBJECTS = head.o kImage.o

@@ -35,14 +35,14 @@
 	$(MKLASATIMG) -o $@ -k $^ -m $(MKLASATIMG_ARCH)

 $(obj)/rom.bin: $(obj)/rom
-	$(OBJCOPY) -O binary -S $^ $@
+	$(OBJCOPY) -O binary -S $^ $@

 # Rule to make the bootloader
 $(obj)/rom: $(addprefix $(obj)/,$(OBJECTS))
 	$(LD) $(LDFLAGS) $(LDSCRIPT) -o $@ $^

 $(obj)/%.o: $(obj)/%.gz
-	$(LD) -r -o $@ -b binary $<
+	$(LD) -EL -r -o $@ -b binary $<

 $(obj)/%.gz: $(obj)/%.bin
 	gzip -cf -9 $< > $@
diff -u -r linux-2.6.25.6/arch/mips/lasat/interrupt.c linux-2.6.25.6-th/arch/mips/lasat/interrupt.c
--- linux-2.6.25.6/arch/mips/lasat/interrupt.c	2008-06-11 10:39:29.000000000 +0100
+++ linux-2.6.25.6-th/arch/mips/lasat/interrupt.c	2008-06-12 23:45:51.000000000 +0100
@@ -34,11 +34,13 @@

 void disable_lasat_irq(unsigned int irq_nr)
 {
+	irq_nr -= LASAT_IRQ_BASE;
 	*lasat_int_mask &= ~(1 << irq_nr) << lasat_int_mask_shift;
 }

 void enable_lasat_irq(unsigned int irq_nr)
 {
+	irq_nr -= LASAT_IRQ_BASE;
 	*lasat_int_mask |= (1 << irq_nr) << lasat_int_mask_shift;
 }

diff -u -r linux-2.6.25.6/include/asm-mips/lasat/serial.h linux-2.6.25.6-th/include/asm-mips/lasat/serial.h
--- linux-2.6.25.6/include/asm-mips/lasat/serial.h	2008-06-11 10:39:29.000000000 +0100
+++ linux-2.6.25.6-th/include/asm-mips/lasat/serial.h	2008-06-13 00:09:29.000000000 +0100
@@ -4,10 +4,10 @@
 #define LASAT_BASE_BAUD_100 		(7372800 / 16)
 #define LASAT_UART_REGS_BASE_100	0x1c8b0000
 #define LASAT_UART_REGS_SHIFT_100	2
-#define LASATINT_UART_100		8
+#define LASATINT_UART_100		16

 /* * LASAT 200 boards serial configuration */
 #define LASAT_BASE_BAUD_200		(100000000 / 16 / 12)
 #define LASAT_UART_REGS_BASE_200	(Vrc5074_PHYS_BASE + 0x0300)
 #define LASAT_UART_REGS_SHIFT_200	3
-#define LASATINT_UART_200		13
+#define LASATINT_UART_200		21
