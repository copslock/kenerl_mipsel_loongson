Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Nov 2002 12:50:15 +0100 (CET)
Received: from r-hh.iij4u.or.jp ([210.130.0.72]:48611 "EHLO r-hh.iij4u.or.jp")
	by linux-mips.org with ESMTP id <S1122109AbSKDLuO>;
	Mon, 4 Nov 2002 12:50:14 +0100
Received: from stratos (h197.p500.iij4u.or.jp [210.149.244.197])
	by r-hh.iij4u.or.jp (8.11.6+IIJ/8.11.6) with SMTP id gA4BnuQ25402;
	Mon, 4 Nov 2002 20:49:56 +0900 (JST)
Date: Mon, 4 Nov 2002 20:49:29 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: Re: fixed the problem about build of vr41xx on linux-2.5.45
Message-Id: <20021104204929.558ddff2.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20021103183650.A23232@bacchus.dhis.org>
References: <20021103235224.2d7a4814.yuasa@hh.iij4u.or.jp>
	<20021103183650.A23232@bacchus.dhis.org>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Mon__4_Nov_2002_20:49:29_+0900_082566c0"
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--Multipart_Mon__4_Nov_2002_20:49:29_+0900_082566c0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello Ralf,

On Sun, 3 Nov 2002 18:36:50 +0100
Ralf Baechle <ralf@uni-koblenz.de> wrote:

> On Sun, Nov 03, 2002 at 11:52:24PM +0900, Yoichi Yuasa wrote:
> 
> > Hello Ralf,
> > 
> > I fixed the problem about build of vr41xx on linux-2.5.45.
> > Here is a patch.
> 
> I applied the patch although quite heavily modified.  Here the bad bits:
> 
> >  config SERIAL
> >  	tristate
> > -	depends on NEC_OSPREY || IBM_WORKPAD || CASIO_E55
> > +	depends on ZAO_CAPCELLA || NEC_EAGLE || NEC_OSPREY || VICTOR_MPC30X || IBM_WORKPAD || CASIO_E55
> >  	default y
> >  	---help---
> >  	  This selects whether you want to include the driver for the standard
> 
> This misses the problem.  There is no more CONFIG_SERIAL option and as such
> I removed all CONFIG_SERIAL* stuff entirely.

I made a patch for vr41xx about this problem.
Please apply a patch.

Thanks,

Yoichi

--Multipart_Mon__4_Nov_2002_20:49:29_+0900_082566c0
Content-Type: text/plain;
 name="vr41xx-serial.diff"
Content-Disposition: attachment;
 filename="vr41xx-serial.diff"
Content-Transfer-Encoding: 7bit

diff -aruN linux.orig/arch/mips/vr41xx/casio-e55/setup.c linux/arch/mips/vr41xx/casio-e55/setup.c
--- linux.orig/arch/mips/vr41xx/casio-e55/setup.c	Tue Oct 29 09:56:59 2002
+++ linux/arch/mips/vr41xx/casio-e55/setup.c	Mon Nov  4 15:05:00 2002
@@ -68,5 +68,7 @@
 
 	vr41xx_cmu_init(0);
 
+#ifdef CONFIG_SERIAL_8250
 	vr41xx_siu_init(SIU_RS232C, 0);
+#endif
 }
diff -aruN linux.orig/arch/mips/vr41xx/common/Makefile linux/arch/mips/vr41xx/common/Makefile
--- linux.orig/arch/mips/vr41xx/common/Makefile	Fri Nov  1 11:32:25 2002
+++ linux/arch/mips/vr41xx/common/Makefile	Mon Nov  4 15:01:14 2002
@@ -5,7 +5,7 @@
 obj-y		:= bcu.o cmu.o giu.o icu.o int-handler.o reset.o
 
 obj-$(CONFIG_PCI)		+= pciu.o
-obj-$(CONFIG_SERIAL)		+= serial.o
+obj-$(CONFIG_SERIAL_8250)	+= serial.o
 obj-$(CONFIG_VR41XX_TIME_C)	+= time.o
 
 EXTRA_AFLAGS := $(CFLAGS)
diff -aruN linux.orig/arch/mips/vr41xx/ibm-workpad/setup.c linux/arch/mips/vr41xx/ibm-workpad/setup.c
--- linux.orig/arch/mips/vr41xx/ibm-workpad/setup.c	Tue Oct 29 09:56:59 2002
+++ linux/arch/mips/vr41xx/ibm-workpad/setup.c	Mon Nov  4 15:10:05 2002
@@ -68,5 +68,7 @@
 
 	vr41xx_cmu_init(0);
 
+#ifdef CONFIG_SERIAL_8250
 	vr41xx_siu_init(SIU_RS232C, 0);
+#endif
 }
diff -aruN linux.orig/arch/mips/vr41xx/nec-eagle/setup.c linux/arch/mips/vr41xx/nec-eagle/setup.c
--- linux.orig/arch/mips/vr41xx/nec-eagle/setup.c	Tue Oct 29 09:56:59 2002
+++ linux/arch/mips/vr41xx/nec-eagle/setup.c	Mon Nov  4 15:10:46 2002
@@ -146,8 +146,10 @@
 
 	vr41xx_cmu_init(0);
 
+#ifdef CONFIG_SERIAL_8250
 	vr41xx_dsiu_init();
 	vr41xx_siu_init(SIU_RS232C, 0);
+#endif
 
 #ifdef CONFIG_PCI
 	vr41xx_pciu_init(&pci_address_map);
diff -aruN linux.orig/arch/mips/vr41xx/victor-mpc30x/setup.c linux/arch/mips/vr41xx/victor-mpc30x/setup.c
--- linux.orig/arch/mips/vr41xx/victor-mpc30x/setup.c	Tue Oct 29 09:56:59 2002
+++ linux/arch/mips/vr41xx/victor-mpc30x/setup.c	Mon Nov  4 15:11:14 2002
@@ -116,7 +116,9 @@
 
 	vr41xx_cmu_init(0);
 
+#ifdef CONFIG_SERIAL_8250
 	vr41xx_siu_init(SIU_RS232C, 0);
+#endif
 
 #ifdef CONFIG_PCI
 	vr41xx_pciu_init(&pci_address_map);
diff -aruN linux.orig/arch/mips/vr41xx/zao-capcella/setup.c linux/arch/mips/vr41xx/zao-capcella/setup.c
--- linux.orig/arch/mips/vr41xx/zao-capcella/setup.c	Tue Oct 29 09:56:59 2002
+++ linux/arch/mips/vr41xx/zao-capcella/setup.c	Mon Nov  4 15:11:52 2002
@@ -116,8 +116,10 @@
 
 	vr41xx_cmu_init(0x0102);
 
+#ifdef CONFIG_SERIAL_8250
 	vr41xx_siu_init(SIU_RS232C, 0);
 	vr41xx_dsiu_init();
+#endif
 
 #ifdef CONFIG_PCI
 	vr41xx_pciu_init(&pci_address_map);

--Multipart_Mon__4_Nov_2002_20:49:29_+0900_082566c0--
