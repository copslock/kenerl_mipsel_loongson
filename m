Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2004 16:57:08 +0000 (GMT)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:32710 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225383AbUA1Q5D>;
	Wed, 28 Jan 2004 16:57:03 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id BAA26670;
	Thu, 29 Jan 2004 01:56:25 +0900 (JST)
Received: 4UMDO00 id i0SGuPu01536; Thu, 29 Jan 2004 01:56:25 +0900 (JST)
Received: 4UMRO01 id i0SGuOd26091; Thu, 29 Jan 2004 01:56:24 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Thu, 29 Jan 2004 01:56:22 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.4] common parts of vr41xx
Message-Id: <20040129015622.63844b90.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

I made patch for common parts of vr41xx.
Please apply this patch to 2.4 CVS tree.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/Makefile linux/arch/mips/Makefile
--- linux-orig/arch/mips/Makefile	Sun Jan 11 10:17:13 2004
+++ linux/arch/mips/Makefile	Thu Jan 29 01:41:29 2004
@@ -518,13 +518,19 @@
 endif
 
 #
+# The common parts for NEC VR4100 series
+#
+ifdef CONFIG_VR41XX
+SUBDIRS		+= arch/mips/vr41xx/common
+CORE_FILES	+= arch/mips/vr41xx/common/vr41xx.o
+endif
+
+#
 # NEC Eagle/Hawk (VR4122/VR4131) board
 #
 ifdef CONFIG_NEC_EAGLE
-SUBDIRS		+= arch/mips/vr41xx/common \
-		   arch/mips/vr41xx/nec-eagle
-CORE_FILES	+= arch/mips/vr41xx/common/vr41xx.o \
-		   arch/mips/vr41xx/nec-eagle/eagle.o
+SUBDIRS		+= arch/mips/vr41xx/nec-eagle
+CORE_FILES	+= arch/mips/vr41xx/nec-eagle/eagle.o
 LOADADDR	:= 0x80000000
 endif
 
@@ -532,10 +538,8 @@
 # ZAO Networks Capcella (VR4131)
 #
 ifdef CONFIG_ZAO_CAPCELLA
-SUBDIRS		+= arch/mips/vr41xx/common \
-		   arch/mips/vr41xx/zao-capcella
-CORE_FILES	+= arch/mips/vr41xx/common/vr41xx.o \
-		   arch/mips/vr41xx/zao-capcella/capcella.o
+SUBDIRS		+= arch/mips/vr41xx/zao-capcella
+CORE_FILES	+= arch/mips/vr41xx/zao-capcella/capcella.o
 LOADADDR	:= 0x80000000
 endif
 
@@ -543,10 +547,8 @@
 # Victor MP-C303/304 (VR4122)
 #
 ifdef CONFIG_VICTOR_MPC30X
-SUBDIRS		+= arch/mips/vr41xx/common \
-		   arch/mips/vr41xx/victor-mpc30x
-CORE_FILES	+= arch/mips/vr41xx/common/vr41xx.o \
-		   arch/mips/vr41xx/victor-mpc30x/mpc30x.o
+SUBDIRS		+= arch/mips/vr41xx/victor-mpc30x
+CORE_FILES	+= arch/mips/vr41xx/victor-mpc30x/mpc30x.o
 LOADADDR	:= 0x80001000
 endif
 
@@ -554,10 +556,8 @@
 # IBM WorkPad z50 (VR4121)
 #
 ifdef CONFIG_IBM_WORKPAD
-SUBDIRS		+= arch/mips/vr41xx/common \
-		   arch/mips/vr41xx/ibm-workpad
-CORE_FILES	+= arch/mips/vr41xx/common/vr41xx.o \
-		   arch/mips/vr41xx/ibm-workpad/workpad.o
+SUBDIRS		+= arch/mips/vr41xx/ibm-workpad
+CORE_FILES	+= arch/mips/vr41xx/ibm-workpad/workpad.o
 LOADADDR	+= 0x80004000
 endif
 
@@ -565,10 +565,8 @@
 # CASIO CASSIPEIA E-55/65 (VR4111)
 #
 ifdef CONFIG_CASIO_E55
-SUBDIRS		+= arch/mips/vr41xx/common \
-		   arch/mips/vr41xx/casio-e55
-CORE_FILES	+= arch/mips/vr41xx/common/vr41xx.o \
-		   arch/mips/vr41xx/casio-e55/e55.o
+SUBDIRS		+= arch/mips/vr41xx/casio-e55
+CORE_FILES	+= arch/mips/vr41xx/casio-e55/e55.o
 LOADADDR	+= 0x80004000
 endif
 
@@ -576,10 +574,8 @@
 # TANBAC TB0226 Mbase (VR4131)
 #
 ifdef CONFIG_TANBAC_TB0226
-SUBDIRS		+= arch/mips/vr41xx/common \
-		   arch/mips/vr41xx/tanbac-tb0226
-CORE_FILES	+= arch/mips/vr41xx/common/vr41xx.o \
-		   arch/mips/vr41xx/tanbac-tb0226/tb0226.o
+SUBDIRS		+= arch/mips/vr41xx/tanbac-tb0226
+CORE_FILES	+= arch/mips/vr41xx/tanbac-tb0226/tb0226.o
 LOADADDR	:= 0x80000000
 endif
 
@@ -587,10 +583,8 @@
 # TANBAC TB0229 (VR4131DIMM)
 #
 ifdef CONFIG_TANBAC_TB0229
-SUBDIRS		+= arch/mips/vr41xx/common \
-		   arch/mips/vr41xx/tanbac-tb0229
-CORE_FILES	+= arch/mips/vr41xx/common/vr41xx.o \
-		   arch/mips/vr41xx/tanbac-tb0229/tb0229.o
+SUBDIRS		+= arch/mips/vr41xx/tanbac-tb0229
+CORE_FILES	+= arch/mips/vr41xx/tanbac-tb0229/tb0229.o
 LOADADDR	:= 0x80000000
 endif
 
diff -urN -X dontdiff linux-orig/arch/mips/config-shared.in linux/arch/mips/config-shared.in
--- linux-orig/arch/mips/config-shared.in	Fri Jan 16 01:18:59 2004
+++ linux/arch/mips/config-shared.in	Thu Jan 29 01:41:29 2004
@@ -249,9 +249,7 @@
    define_bool CONFIG_OLD_TIME_C y
 fi
 if [ "$CONFIG_CASIO_E55" = "y" ]; then
-   define_bool CONFIG_IRQ_CPU y
-   define_bool CONFIG_NEW_TIME_C y
-   define_bool CONFIG_NONCOHERENT_IO y
+   define_bool CONFIG_VR41XX y
    define_bool CONFIG_ISA y
    define_bool CONFIG_DUMMY_KEYB y
    define_bool CONFIG_SCSI n
@@ -439,9 +437,7 @@
    #not yet define_bool CONFIG_PCI_AUTO y
 fi
 if [ "$CONFIG_IBM_WORKPAD" = "y" ]; then
-   define_bool CONFIG_IRQ_CPU y
-   define_bool CONFIG_NEW_TIME_C y
-   define_bool CONFIG_NONCOHERENT_IO y
+   define_bool CONFIG_VR41XX y
    define_bool CONFIG_ISA y
    define_bool CONFIG_SCSI n
 fi
@@ -595,9 +591,7 @@
    define_bool CONFIG_SCSI n
 fi
 if [ "$CONFIG_NEC_EAGLE" = "y" ]; then
-   define_bool CONFIG_IRQ_CPU y
-   define_bool CONFIG_NEW_TIME_C y
-   define_bool CONFIG_NONCOHERENT_IO y
+   define_bool CONFIG_VR41XX y
    define_bool CONFIG_PCI y
    define_bool CONFIG_NEW_PCI y
    define_bool CONFIG_PCI_AUTO y
@@ -650,9 +644,7 @@
    define_bool CONFIG_PCI y
 fi
 if [ "$CONFIG_TANBAC_TB0226" = "y" ]; then
-   define_bool CONFIG_IRQ_CPU y
-   define_bool CONFIG_NEW_TIME_C y
-   define_bool CONFIG_NONCOHERENT_IO y
+   define_bool CONFIG_VR41XX y
    define_bool CONFIG_PCI y
    define_bool CONFIG_NEW_PCI y
    define_bool CONFIG_PCI_AUTO y
@@ -660,9 +652,7 @@
    define_bool CONFIG_SERIAL_MANY_PORTS y
 fi
 if [ "$CONFIG_TANBAC_TB0229" = "y" ]; then
-   define_bool CONFIG_IRQ_CPU y
-   define_bool CONFIG_NEW_TIME_C y
-   define_bool CONFIG_NONCOHERENT_IO y
+   define_bool CONFIG_VR41XX y
    define_bool CONFIG_PCI y
    define_bool CONFIG_NEW_PCI y
    define_bool CONFIG_PCI_AUTO y
@@ -691,9 +681,7 @@
    define_bool CONFIG_NONCOHERENT_IO y
 fi
 if [ "$CONFIG_VICTOR_MPC30X" = "y" ]; then
-   define_bool CONFIG_IRQ_CPU y
-   define_bool CONFIG_NEW_TIME_C y
-   define_bool CONFIG_NONCOHERENT_IO y
+   define_bool CONFIG_VR41XX y
    define_bool CONFIG_PCI y
    define_bool CONFIG_NEW_PCI y
    define_bool CONFIG_PCI_AUTO y
@@ -701,9 +689,7 @@
    define_bool CONFIG_SCSI n
 fi
 if [ "$CONFIG_ZAO_CAPCELLA" = "y" ]; then
-   define_bool CONFIG_IRQ_CPU y
-   define_bool CONFIG_NEW_TIME_C y
-   define_bool CONFIG_NONCOHERENT_IO y
+   define_bool CONFIG_VR41XX y
    define_bool CONFIG_PCI y
    define_bool CONFIG_NEW_PCI y
    define_bool CONFIG_PCI_AUTO y
@@ -711,6 +697,11 @@
    define_bool CONFIG_SCSI n
 fi
 
+if [ "$CONFIG_VR41XX" = "y" ]; then
+   define_bool CONFIG_IRQ_CPU y
+   define_bool CONFIG_NEW_TIME_C y
+   define_bool CONFIG_NONCOHERENT_IO y
+fi
 if [ "$CONFIG_MIPS_AU1000" != "y" ]; then
    define_bool CONFIG_MIPS_AU1000 n
 fi
diff -urN -X dontdiff linux-orig/arch/mips/kernel/setup.c linux/arch/mips/kernel/setup.c
--- linux-orig/arch/mips/kernel/setup.c	Thu Dec 18 23:48:47 2003
+++ linux/arch/mips/kernel/setup.c	Thu Jan 29 01:41:29 2004
@@ -482,18 +482,13 @@
 	void momenco_jaguar_atx_setup(void);
 	void nino_setup(void);
 	void nec_osprey_setup(void);
-	void nec_eagle_setup(void);
-	void zao_capcella_setup(void);
-	void victor_mpc30x_setup(void);
-	void ibm_workpad_setup(void);
-	void casio_e55_setup(void);
-	void tanbac_tb0226_setup(void);
 	void jmr3927_setup(void);
 	void tx4927_setup(void);
  	void it8172_setup(void);
 	void swarm_setup(void);
 	void hp_setup(void);
 	void au1x00_setup(void);
+	void vr41xx_platform_setup(void);
 	void frame_info_init(void);
 
 	frame_info_init();
@@ -598,39 +593,9 @@
 			nec_osprey_setup();
 			break;
 #endif
-#ifdef CONFIG_NEC_EAGLE
-		case MACH_NEC_EAGLE:
-			nec_eagle_setup();
-			break;
-#endif
-#ifdef CONFIG_ZAO_CAPCELLA
-		case MACH_ZAO_CAPCELLA:
-			zao_capcella_setup();
-			break;
-#endif
-#ifdef CONFIG_VICTOR_MPC30X
-		case MACH_VICTOR_MPC30X:
-			victor_mpc30x_setup();
-			break;
-#endif
-#ifdef CONFIG_IBM_WORKPAD
-		case MACH_IBM_WORKPAD:
-			ibm_workpad_setup();
-			break;
-#endif
-#ifdef CONFIG_CASIO_E55
-		case MACH_CASIO_E55:
-			casio_e55_setup();
-			break;
-#endif
-#ifdef CONFIG_TANBAC_TB0226
-		case MACH_TANBAC_TB0226:
-			tanbac_tb0226_setup();
-			break;
-#endif
-#ifdef CONFIG_TANBAC_TB0229
-		case MACH_TANBAC_TB0229:
-			tanbac_tb0229_setup();
+#ifdef CONFIG_VR41XX 
+		case MACH_TYPE_NEC_VR41XX:
+			vr41xx_platform_setup();
 			break;
 #endif
 		}
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/casio-e55/init.c linux/arch/mips/vr41xx/casio-e55/init.c
--- linux-orig/arch/mips/vr41xx/casio-e55/init.c	Tue Apr 15 01:31:39 2003
+++ linux/arch/mips/vr41xx/casio-e55/init.c	Thu Jan 29 01:41:29 2004
@@ -5,8 +5,7 @@
  * BRIEF MODULE DESCRIPTION
  *	Initialisation code for the CASIO CASSIOPEIA E-55/65.
  *
- * Copyright 2002 Yoichi Yuasa
- *                yuasa@hh.iij4u.or.jp
+ * Copyright (C) 2002-2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License as published by the
@@ -41,7 +40,7 @@
 	}
 
 	mips_machgroup = MACH_GROUP_NEC_VR41XX;
-	mips_machtype = MACH_CASIO_E55;
+	mips_machtype = MACH_TYPE_NEC_VR41XX;
 }
 
 void __init prom_free_prom_memory (void)
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/casio-e55/setup.c linux/arch/mips/vr41xx/casio-e55/setup.c
--- linux-orig/arch/mips/vr41xx/casio-e55/setup.c	Fri Oct 31 11:28:40 2003
+++ linux/arch/mips/vr41xx/casio-e55/setup.c	Thu Jan 29 01:41:29 2004
@@ -1,17 +1,21 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/casio-e55/setup.c
+ *  setup.c, Setup for the CASIO CASSIOPEIA E-11/15/55/65.
  *
- * BRIEF MODULE DESCRIPTION
- *	Setup for the CASIO CASSIOPEIA E-11/15/55/65.
+ *  Copyright (C) 2002-2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
- * Copyright 2002 Yoichi Yuasa
- *                yuasa@hh.iij4u.or.jp
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
  *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/config.h>
 #include <linux/init.h>
@@ -28,7 +32,7 @@
 extern void * __rd_start, * __rd_end;
 #endif
 
-void __init casio_e55_setup(void)
+void __init vr41xx_platform_setup(void)
 {
 	set_io_port_base(IO_PORT_BASE);
 	ioport_resource.start = IO_PORT_RESOURCE_START;
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/ibm-workpad/init.c linux/arch/mips/vr41xx/ibm-workpad/init.c
--- linux-orig/arch/mips/vr41xx/ibm-workpad/init.c	Tue Apr 15 01:31:39 2003
+++ linux/arch/mips/vr41xx/ibm-workpad/init.c	Thu Jan 29 01:41:29 2004
@@ -5,8 +5,7 @@
  * BRIEF MODULE DESCRIPTION
  *	Initialisation code for the IBM WorkPad z50.
  *
- * Copyright 2002 Yoichi Yuasa
- *                yuasa@hh.iij4u.or.jp
+ * Copyright (C) 2002-2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License as published by the
@@ -41,7 +40,7 @@
 	}
 
 	mips_machgroup = MACH_GROUP_NEC_VR41XX;
-	mips_machtype = MACH_IBM_WORKPAD;
+	mips_machtype = MACH_TYPE_NEC_VR41XX;
 }
 
 void __init prom_free_prom_memory (void)
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/ibm-workpad/setup.c linux/arch/mips/vr41xx/ibm-workpad/setup.c
--- linux-orig/arch/mips/vr41xx/ibm-workpad/setup.c	Fri Oct 31 11:28:41 2003
+++ linux/arch/mips/vr41xx/ibm-workpad/setup.c	Thu Jan 29 01:41:29 2004
@@ -1,17 +1,21 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/workpad/setup.c
+ *  setup.c, Setup for the IBM WorkPad z50.
  *
- * BRIEF MODULE DESCRIPTION
- *	Setup for the IBM WorkPad z50.
+ *  Copyright (C) 2002-2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
- * Copyright 2002 Yoichi Yuasa
- *                yuasa@hh.iij4u.or.jp
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
  *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/config.h>
 #include <linux/init.h>
@@ -28,7 +32,7 @@
 extern void * __rd_start, * __rd_end;
 #endif
 
-void __init ibm_workpad_setup(void)
+void __init vr41xx_platform_setup(void)
 {
 	set_io_port_base(IO_PORT_BASE);
 	ioport_resource.start = IO_PORT_RESOURCE_START;
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/nec-eagle/init.c linux/arch/mips/vr41xx/nec-eagle/init.c
--- linux-orig/arch/mips/vr41xx/nec-eagle/init.c	Tue Apr 15 01:31:39 2003
+++ linux/arch/mips/vr41xx/nec-eagle/init.c	Thu Jan 29 01:41:29 2004
@@ -66,7 +66,7 @@
 	}
 
 	mips_machgroup = MACH_GROUP_NEC_VR41XX;
-	mips_machtype = MACH_NEC_EAGLE;
+	mips_machtype = MACH_TYPE_NEC_VR41XX;
 }
 
 void __init prom_free_prom_memory (void)
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/nec-eagle/setup.c linux/arch/mips/vr41xx/nec-eagle/setup.c
--- linux-orig/arch/mips/vr41xx/nec-eagle/setup.c	Fri Oct 31 11:28:41 2003
+++ linux/arch/mips/vr41xx/nec-eagle/setup.c	Thu Jan 29 01:41:29 2004
@@ -107,7 +107,7 @@
 };
 #endif
 
-void __init nec_eagle_setup(void)
+void __init vr41xx_platform_setup(void)
 {
 	set_io_port_base(IO_PORT_BASE);
 	ioport_resource.start = IO_PORT_RESOURCE_START;
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0226/init.c linux/arch/mips/vr41xx/tanbac-tb0226/init.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0226/init.c	Sat Jan 10 19:38:55 2004
+++ linux/arch/mips/vr41xx/tanbac-tb0226/init.c	Thu Jan 29 01:41:29 2004
@@ -5,8 +5,7 @@
  * BRIEF MODULE DESCRIPTION
  *	Initialisation code for the TANBAC TB0226.
  *
- * Copyright 2002,2003 Yoichi Yuasa
- *                yuasa@hh.iij4u.or.jp
+ * Copyright (C) 2002-2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License as published by the
@@ -44,7 +43,7 @@
 	}
 
 	mips_machgroup = MACH_GROUP_NEC_VR41XX;
-	mips_machtype = MACH_TANBAC_TB0226;
+	mips_machtype = MACH_TYPE_NEC_VR41XX;
 }
 
 void __init prom_free_prom_memory (void)
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0226/setup.c linux/arch/mips/vr41xx/tanbac-tb0226/setup.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0226/setup.c	Fri Oct 31 11:28:41 2003
+++ linux/arch/mips/vr41xx/tanbac-tb0226/setup.c	Thu Jan 29 01:41:29 2004
@@ -1,17 +1,21 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/tanbac-tb0226/setup.c
+ *  setup.c, Setup for the TANBAC TB0226.
  *
- * BRIEF MODULE DESCRIPTION
- *	Setup for the TANBAC TB0226.
+ *  Copyright (C) 2002-2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
- * Copyright 2002,2003 Yoichi Yuasa
- *                yuasa@hh.iij4u.or.jp
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
  *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/config.h>
 #include <linux/init.h>
@@ -75,7 +79,7 @@
 };
 #endif
 
-void __init tanbac_tb0226_setup(void)
+void __init vr41xx_platform_setup(void)
 {
 	set_io_port_base(IO_PORT_BASE);
 	ioport_resource.start = IO_PORT_RESOURCE_START;
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0229/init.c linux/arch/mips/vr41xx/tanbac-tb0229/init.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0229/init.c	Sat Jan 10 19:38:55 2004
+++ linux/arch/mips/vr41xx/tanbac-tb0229/init.c	Thu Jan 29 01:41:29 2004
@@ -5,8 +5,7 @@
  * BRIEF MODULE DESCRIPTION
  *	Initialisation code for the TANBAC TB0229(VR4131DIMM)
  *
- * Copyright 2002,2003 Yoichi Yuasa
- *                yuasa@hh.iij4u.or.jp
+ * Copyright (C) 2002-2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  * Modified for TANBAC TB0229:
  * Copyright 2003 Megasolution Inc.
@@ -49,7 +48,7 @@
 	}
 
 	mips_machgroup = MACH_GROUP_NEC_VR41XX;
-	mips_machtype = MACH_TANBAC_TB0229;
+	mips_machtype = MACH_TYPE_NEC_VR41XX;
 }
 
 void __init prom_free_prom_memory (void)
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0229/setup.c linux/arch/mips/vr41xx/tanbac-tb0229/setup.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0229/setup.c	Fri Oct 31 11:28:41 2003
+++ linux/arch/mips/vr41xx/tanbac-tb0229/setup.c	Thu Jan 29 01:41:29 2004
@@ -1,21 +1,24 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/tanbac-tb0229/setup.c
+ *  setup.c, Setup for the TANBAC TB0229 (VR4131DIMM)
  *
- * BRIEF MODULE DESCRIPTION
- *	Setup for the TANBAC TB0229 (VR4131DIMM)
+ *  Copyright (C) 2002-2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
- * Copyright 2002,2003 Yoichi Yuasa
- *                yuasa@hh.iij4u.or.jp
+ *  Modified for TANBAC TB0229:
+ *  Copyright (C) 2003  Megasolution Inc. <matsu@megasolution.jp>
  *
- * Modified for TANBAC TB0229:
- * Copyright 2003 Megasolution Inc.
- *                matsu@megasolution.jp
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
  *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/config.h>
 #include <linux/blk.h>
@@ -87,7 +90,7 @@
 };
 #endif
 
-void __init tanbac_tb0229_setup(void)
+void __init vr41xx_platform_setup(void)
 {
 	set_io_port_base(IO_PORT_BASE);
 	ioport_resource.start = IO_PORT_RESOURCE_START;
@@ -123,4 +126,3 @@
 	vr41xx_pciu_init(&pci_address_map);
 #endif
 }
-
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/victor-mpc30x/init.c linux/arch/mips/vr41xx/victor-mpc30x/init.c
--- linux-orig/arch/mips/vr41xx/victor-mpc30x/init.c	Tue Apr 15 01:31:39 2003
+++ linux/arch/mips/vr41xx/victor-mpc30x/init.c	Thu Jan 29 01:41:29 2004
@@ -5,8 +5,7 @@
  * BRIEF MODULE DESCRIPTION
  *	Initialisation code for the Victor MP-C303/304.
  *
- * Copyright 2002 Yoichi Yuasa
- *                yuasa@hh.iij4u.or.jp
+ * Copyright (C) 2002-2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License as published by the
@@ -44,7 +43,7 @@
 	}
 
 	mips_machgroup = MACH_GROUP_NEC_VR41XX;
-	mips_machtype = MACH_VICTOR_MPC30X;
+	mips_machtype = MACH_TYPE_NEC_VR41XX;
 
 	add_memory_region(0, 32 << 20, BOOT_MEM_RAM);
 }
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/victor-mpc30x/setup.c linux/arch/mips/vr41xx/victor-mpc30x/setup.c
--- linux-orig/arch/mips/vr41xx/victor-mpc30x/setup.c	Fri Oct 31 11:28:41 2003
+++ linux/arch/mips/vr41xx/victor-mpc30x/setup.c	Thu Jan 29 01:41:29 2004
@@ -1,17 +1,21 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/victor-mpc30x/setup.c
+ *  setup.c, Setup for the Victor MP-C303/304.
  *
- * BRIEF MODULE DESCRIPTION
- *	Setup for the Victor MP-C303/304.
+ *  Copyright (C) 2002-2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
- * Copyright 2002 Yoichi Yuasa
- *                yuasa@hh.iij4u.or.jp
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
  *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/config.h>
 #include <linux/init.h>
@@ -76,7 +80,7 @@
 };
 #endif
 
-void __init victor_mpc30x_setup(void)
+void __init vr41xx_platform_setup(void)
 {
 	set_io_port_base(IO_PORT_BASE);
 	ioport_resource.start = IO_PORT_RESOURCE_START;
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/zao-capcella/init.c linux/arch/mips/vr41xx/zao-capcella/init.c
--- linux-orig/arch/mips/vr41xx/zao-capcella/init.c	Sat Jan 10 19:38:55 2004
+++ linux/arch/mips/vr41xx/zao-capcella/init.c	Thu Jan 29 01:41:29 2004
@@ -5,8 +5,7 @@
  * BRIEF MODULE DESCRIPTION
  *	Initialisation code for the ZAO Networks Capcella.
  *
- * Copyright 2002 Yoichi Yuasa
- *                yuasa@hh.iij4u.or.jp
+ * Copyright (C) 2002-2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License as published by the
@@ -44,7 +43,7 @@
 	}
 
 	mips_machgroup = MACH_GROUP_NEC_VR41XX;
-	mips_machtype = MACH_ZAO_CAPCELLA;
+	mips_machtype = MACH_TYPE_NEC_VR41XX;
 }
 
 void __init prom_free_prom_memory (void)
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/zao-capcella/setup.c linux/arch/mips/vr41xx/zao-capcella/setup.c
--- linux-orig/arch/mips/vr41xx/zao-capcella/setup.c	Fri Oct 31 11:28:41 2003
+++ linux/arch/mips/vr41xx/zao-capcella/setup.c	Thu Jan 29 01:41:29 2004
@@ -1,17 +1,21 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/zao-capcella/setup.c
+ *  setup.c, Setup for the ZAO Networks Capcella.
  *
- * BRIEF MODULE DESCRIPTION
- *	Setup for the ZAO Networks Capcella.
+ *  Copyright (C) 2002-2003  Yoichi Yuasa <yuasa@hh.iij4u.orjp>
  *
- * Copyright 2002 Yoichi Yuasa
- *                yuasa@hh.iij4u.or.jp
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
  *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/config.h>
 #include <linux/init.h>
@@ -76,7 +80,7 @@
 };
 #endif
 
-void __init zao_capcella_setup(void)
+void __init vr41xx_platform_setup(void)
 {
 	set_io_port_base(IO_PORT_BASE);
 	ioport_resource.start = IO_PORT_RESOURCE_START;
diff -urN -X dontdiff linux-orig/include/asm-mips/bootinfo.h linux/include/asm-mips/bootinfo.h
--- linux-orig/include/asm-mips/bootinfo.h	Sun Jan 11 10:17:47 2004
+++ linux/include/asm-mips/bootinfo.h	Thu Jan 29 01:41:29 2004
@@ -185,13 +185,7 @@
  * Valid machtype for group NEC_VR41XX
  */
 #define MACH_NEC_OSPREY		0	/* Osprey eval board */
-#define MACH_NEC_EAGLE		1	/* NEC Eagle/Hawk board */
-#define MACH_ZAO_CAPCELLA	2	/* ZAO Networks Capcella */
-#define MACH_VICTOR_MPC30X	3	/* Victor MP-C303/304 */
-#define MACH_IBM_WORKPAD	4	/* IBM WorkPad z50 */
-#define MACH_CASIO_E55		5	/* CASIO CASSIOPEIA E-10/15/55/65 */
-#define MACH_TANBAC_TB0226	6	/* TANBAC TB0226 (MBASE) */
-#define MACH_TANBAC_TB0229	7	/* TANBAC TB0229 (VR4131DIMM) */
+#define MACH_TYPE_NEC_VR41XX	1	/* NEC VR4100 series based boards/gadgets */
 
 /*
  * Valid machtype for group TITAN
diff -urN -X dontdiff linux-orig/include/asm-mips64/bootinfo.h linux/include/asm-mips64/bootinfo.h
--- linux-orig/include/asm-mips64/bootinfo.h	Sun Jan 11 10:17:50 2004
+++ linux/include/asm-mips64/bootinfo.h	Thu Jan 29 01:43:08 2004
@@ -184,13 +184,7 @@
  * Valid machtype for group NEC_VR41XX
  */
 #define MACH_NEC_OSPREY		0	/* Osprey eval board */
-#define MACH_NEC_EAGLE		1	/* NEC Eagle/Hawk board */
-#define MACH_ZAO_CAPCELLA	2	/* ZAO Networks Capcella */
-#define MACH_VICTOR_MPC30X	3	/* Victor MP-C303/304 */
-#define MACH_IBM_WORKPAD	4	/* IBM WorkPad z50 */
-#define MACH_CASIO_E55		5	/* CASIO CASSIOPEIA E-10/15/55/65 */
-#define MACH_TANBAC_TB0226	6	/* TANBAC TB0226 (MBASE) */
-#define MACH_TANBAC_TB0229	7	/* TANBAC TB0229 (VR4131DIMM) */
+#define MACH_TYPE_NEC_VR41XX	1	/* NEC VR4100 series based boards/gadgets */
 
 /*
  * Valid machtype for group TITAN
