Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Nov 2002 15:53:01 +0100 (CET)
Received: from r-hh.iij4u.or.jp ([210.130.0.72]:9203 "EHLO r-hh.iij4u.or.jp")
	by linux-mips.org with ESMTP id <S1122109AbSKCOxA>;
	Sun, 3 Nov 2002 15:53:00 +0100
Received: from stratos (h197.p500.iij4u.or.jp [210.149.244.197])
	by r-hh.iij4u.or.jp (8.11.6+IIJ/8.11.6) with SMTP id gA3EqmQ19069;
	Sun, 3 Nov 2002 23:52:48 +0900 (JST)
Date: Sun, 3 Nov 2002 23:52:24 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: ralf@linux-mips.org
Cc: yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: fixed the problem about build of vr41xx on linux-2.5.45
Message-Id: <20021103235224.2d7a4814.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Sun__3_Nov_2002_23:52:24_+0900_08824850"
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 553
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--Multipart_Sun__3_Nov_2002_23:52:24_+0900_08824850
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello Ralf,

I fixed the problem about build of vr41xx on linux-2.5.45.
Here is a patch.

Please apply this patch.

Thanks,

Yoichi
--Multipart_Sun__3_Nov_2002_23:52:24_+0900_08824850
Content-Type: text/plain;
 name="vr41xx-2.4.45.diff"
Content-Disposition: attachment;
 filename="vr41xx-2.4.45.diff"
Content-Transfer-Encoding: 7bit

diff -aruN linux.orig/arch/mips/Kconfig-shared linux/arch/mips/Kconfig-shared
--- linux.orig/arch/mips/Kconfig-shared	Sun Nov  3 20:42:38 2002
+++ linux/arch/mips/Kconfig-shared	Sun Nov  3 22:45:44 2002
@@ -508,7 +508,7 @@
 
 config SERIAL
 	tristate
-	depends on NEC_OSPREY || IBM_WORKPAD || CASIO_E55
+	depends on ZAO_CAPCELLA || NEC_EAGLE || NEC_OSPREY || VICTOR_MPC30X || IBM_WORKPAD || CASIO_E55
 	default y
 	---help---
 	  This selects whether you want to include the driver for the standard
@@ -553,9 +553,9 @@
 	depends on MIPS_PB1500 || MIPS_PB1100 || MIPS_PB1000
 	default y
 
-config CONFIG_VR41XX_COMMON
+config VR41XX_COMMON
 	bool
-	depends on CONFIG_NEC_EAGLE || CONFIG_ZAO_CAPCELLA || CONFIG_VICTOR_MPC30X || CONFIG_IBM_WORKPAD || CONFIG_CASIO_E55
+	depends on NEC_EAGLE || ZAO_CAPCELLA || VICTOR_MPC30X || IBM_WORKPAD || CASIO_E55
 	default y
 
 config CONFIG_DDB5XXX_COMMON
diff -aruN linux.orig/arch/mips/defconfig-workpad linux/arch/mips/defconfig-workpad
--- linux.orig/arch/mips/defconfig-workpad	Sun Nov  3 20:43:06 2002
+++ linux/arch/mips/defconfig-workpad	Sun Nov  3 23:36:58 2002
@@ -22,7 +22,7 @@
 # Loadable module support
 #
 CONFIG_MODULES=y
-CONFIG_MODVERSIONS=y
+# CONFIG_MODVERSIONS is not set
 CONFIG_KMOD=y
 
 #
@@ -72,6 +72,7 @@
 CONFIG_SERIAL=y
 CONFIG_SERIAL_MANY_PORTS=y
 CONFIG_DUMMY_KEYB=y
+CONFIG_VR41XX_COMMON=y
 # CONFIG_FB is not set
 
 #
diff -aruN linux.orig/drivers/ide/mips/Makefile linux/drivers/ide/mips/Makefile
--- linux.orig/drivers/ide/mips/Makefile	Fri Nov  1 05:59:35 2002
+++ linux/drivers/ide/mips/Makefile	Sun Nov  3 23:04:04 2002
@@ -1,6 +1,4 @@
 
-O_TARGET := idedriver-mips.o
-
 obj-y		:=
 obj-m		:=
 
diff -aruN linux.orig/include/asm-mips/ide.h linux/include/asm-mips/ide.h
--- linux.orig/include/asm-mips/ide.h	Thu Oct 31 22:50:01 2002
+++ linux/include/asm-mips/ide.h	Sun Nov  3 22:33:12 2002
@@ -202,8 +202,6 @@
 
 #else /* defined(CONFIG_SWAP_IO_SPACE) && defined(__MIPSEB__)  */
 
-#define ide_fix_driveid(id)		do {} while (0)
-
 #endif
 
 #define ide_release_lock(lock)		do {} while (0)
diff -aruN linux.orig/include/asm-mips/system.h linux/include/asm-mips/system.h
--- linux.orig/include/asm-mips/system.h	Sun Nov  3 01:23:55 2002
+++ linux/include/asm-mips/system.h	Sun Nov  3 22:18:07 2002
@@ -319,11 +319,10 @@
 #else
 	unsigned long flags, retval;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	retval = *m;
 	*m = val;
-	restore_flags(flags);	/* implies memory barrier  */
+	local_irq_restore(flags);	/* implies memory barrier  */
 	return retval;
 #endif /* Processor-dependent optimization */
 }

--Multipart_Sun__3_Nov_2002_23:52:24_+0900_08824850--
