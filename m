Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2005 15:35:08 +0100 (BST)
Received: from mo01.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:50902 "EHLO
	mo01.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225329AbVGVOep>;
	Fri, 22 Jul 2005 15:34:45 +0100
Received: MO(mo01)id j6MEakIZ020111; Fri, 22 Jul 2005 23:36:46 +0900 (JST)
Received: MDO(mdo01) id j6MEajBL022059; Fri, 22 Jul 2005 23:36:45 +0900 (JST)
Received: from stratos (h009.p499.iij4u.or.jp [210.149.243.9])
	by mbox.iij4u.or.jp (4U-MR/mbox00) id j6MEai5h012241
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Fri, 22 Jul 2005 23:36:45 +0900 (JST)
Date:	Fri, 22 Jul 2005 23:36:44 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6] vr41xx: update system type
Message-Id: <20050722233644.0269a853.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

I decided to use common system type on vr41xx. 
Please apply this patch.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/Makefile a/arch/mips/Makefile
--- a-orig/arch/mips/Makefile	2005-07-15 07:53:47.000000000 +0900
+++ a/arch/mips/Makefile	2005-07-22 23:15:41.000000000 +0900
@@ -534,13 +534,11 @@
 #
 # ZAO Networks Capcella (VR4131)
 #
-core-$(CONFIG_ZAO_CAPCELLA)	+= arch/mips/vr41xx/zao-capcella/
 load-$(CONFIG_ZAO_CAPCELLA)	+= 0xffffffff80000000
 
 #
 # Victor MP-C303/304 (VR4122)
 #
-core-$(CONFIG_VICTOR_MPC30X)	+= arch/mips/vr41xx/victor-mpc30x/
 load-$(CONFIG_VICTOR_MPC30X)	+= 0xffffffff80001000
 
 #
@@ -558,13 +556,11 @@
 #
 # TANBAC TB0226 Mbase (VR4131)
 #
-core-$(CONFIG_TANBAC_TB0226)	+= arch/mips/vr41xx/tanbac-tb0226/
 load-$(CONFIG_TANBAC_TB0226)	+= 0xffffffff80000000
 
 #
 # TANBAC TB0229 VR4131DIMM (VR4131)
 #
-core-$(CONFIG_TANBAC_TB0229)	+= arch/mips/vr41xx/tanbac-tb0229/
 load-$(CONFIG_TANBAC_TB0229)	+= 0xffffffff80000000
 
 #
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/casio-e55/setup.c a/arch/mips/vr41xx/casio-e55/setup.c
--- a-orig/arch/mips/vr41xx/casio-e55/setup.c	2005-05-23 20:14:28.000000000 +0900
+++ a/arch/mips/vr41xx/casio-e55/setup.c	2005-07-22 23:15:41.000000000 +0900
@@ -23,11 +23,6 @@
 #include <asm/io.h>
 #include <asm/vr41xx/e55.h>
 
-const char *get_system_type(void)
-{
-	return "CASIO CASSIOPEIA E-11/15/55/65";
-}
-
 static int __init casio_e55_setup(void)
 {
 	set_io_port_base(IO_PORT_BASE);
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/Makefile a/arch/mips/vr41xx/common/Makefile
--- a-orig/arch/mips/vr41xx/common/Makefile	2005-07-16 04:16:55.000000000 +0900
+++ a/arch/mips/vr41xx/common/Makefile	2005-07-22 23:15:41.000000000 +0900
@@ -2,7 +2,7 @@
 # Makefile for common code of the NEC VR4100 series.
 #
 
-obj-y				+= bcu.o cmu.o icu.o init.o int-handler.o irq.o pmu.o
+obj-y				+= bcu.o cmu.o icu.o init.o int-handler.o irq.o pmu.o type.o
 obj-$(CONFIG_VRC4173)		+= vrc4173.o
 
 EXTRA_AFLAGS := $(CFLAGS)
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/type.c a/arch/mips/vr41xx/common/type.c
--- a-orig/arch/mips/vr41xx/common/type.c	1970-01-01 09:00:00.000000000 +0900
+++ a/arch/mips/vr41xx/common/type.c	2005-07-22 23:15:41.000000000 +0900
@@ -0,0 +1,24 @@
+/*
+ *  type.c, System type for NEC VR4100 series.
+ *
+ *  Copyright (C) 2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+const char *get_system_type(void)
+{
+	return "NEC VR4100 series";
+}
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/ibm-workpad/setup.c a/arch/mips/vr41xx/ibm-workpad/setup.c
--- a-orig/arch/mips/vr41xx/ibm-workpad/setup.c	2005-05-23 20:14:28.000000000 +0900
+++ a/arch/mips/vr41xx/ibm-workpad/setup.c	2005-07-22 23:15:41.000000000 +0900
@@ -23,11 +23,6 @@
 #include <asm/io.h>
 #include <asm/vr41xx/workpad.h>
 
-const char *get_system_type(void)
-{
-	return "IBM WorkPad z50";
-}
-
 static int __init ibm_workpad_setup(void)
 {
 	set_io_port_base(IO_PORT_BASE);
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/nec-cmbvr4133/init.c a/arch/mips/vr41xx/nec-cmbvr4133/init.c
--- a-orig/arch/mips/vr41xx/nec-cmbvr4133/init.c	2005-07-10 22:23:55.000000000 +0900
+++ a/arch/mips/vr41xx/nec-cmbvr4133/init.c	2005-07-22 23:15:41.000000000 +0900
@@ -16,11 +16,6 @@
  * Manish Lachwani (mlachwani@mvista.com)
  */
 #include <linux/config.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-
-#include <asm/bootinfo.h>
 
 #ifdef CONFIG_ROCKHOPPER
 #include <asm/io.h>
@@ -28,14 +23,7 @@
 
 #define PCICONFDREG	0xaf000c14
 #define PCICONFAREG	0xaf000c18
-#endif
-
-const char *get_system_type(void)
-{
-	return "NEC CMB-VR4133";
-}
 
-#ifdef CONFIG_ROCKHOPPER
 void disable_pcnet(void)
 {
 	u32 data;
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/tanbac-tb0226/Makefile a/arch/mips/vr41xx/tanbac-tb0226/Makefile
--- a-orig/arch/mips/vr41xx/tanbac-tb0226/Makefile	2004-02-25 11:15:37.000000000 +0900
+++ a/arch/mips/vr41xx/tanbac-tb0226/Makefile	1970-01-01 09:00:00.000000000 +0900
@@ -1,5 +0,0 @@
-#
-# Makefile for the TANBAC TB0226 specific parts of the kernel
-#
-
-obj-y			+= setup.o
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/tanbac-tb0226/setup.c a/arch/mips/vr41xx/tanbac-tb0226/setup.c
--- a-orig/arch/mips/vr41xx/tanbac-tb0226/setup.c	2005-05-20 00:26:29.000000000 +0900
+++ a/arch/mips/vr41xx/tanbac-tb0226/setup.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,24 +0,0 @@
-/*
- *  setup.c, Setup for the TANBAC TB0226.
- *
- *  Copyright (C) 2002-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-const char *get_system_type(void)
-{
-	return "TANBAC TB0226";
-}
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/tanbac-tb0229/Makefile a/arch/mips/vr41xx/tanbac-tb0229/Makefile
--- a-orig/arch/mips/vr41xx/tanbac-tb0229/Makefile	2005-05-20 00:41:01.000000000 +0900
+++ a/arch/mips/vr41xx/tanbac-tb0229/Makefile	1970-01-01 09:00:00.000000000 +0900
@@ -1,5 +0,0 @@
-#
-# Makefile for the TANBAC TB0229(VR4131DIMM) specific parts of the kernel
-#
-
-obj-y				:= setup.o
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/tanbac-tb0229/setup.c a/arch/mips/vr41xx/tanbac-tb0229/setup.c
--- a-orig/arch/mips/vr41xx/tanbac-tb0229/setup.c	2005-05-20 00:26:29.000000000 +0900
+++ a/arch/mips/vr41xx/tanbac-tb0229/setup.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,27 +0,0 @@
-/*
- *  setup.c, Setup for the TANBAC TB0229 (VR4131DIMM)
- *
- *  Copyright (C) 2002-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- *
- *  Modified for TANBAC TB0229:
- *  Copyright (C) 2003  Megasolution Inc.  <matsu@megasolution.jp>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-const char *get_system_type(void)
-{
-	return "TANBAC TB0229";
-}
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/victor-mpc30x/Makefile a/arch/mips/vr41xx/victor-mpc30x/Makefile
--- a-orig/arch/mips/vr41xx/victor-mpc30x/Makefile	2004-02-25 11:15:37.000000000 +0900
+++ a/arch/mips/vr41xx/victor-mpc30x/Makefile	1970-01-01 09:00:00.000000000 +0900
@@ -1,5 +0,0 @@
-#
-# Makefile for the Victor MP-C303/304 specific parts of the kernel
-#
-
-obj-y			+= setup.o
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/victor-mpc30x/setup.c a/arch/mips/vr41xx/victor-mpc30x/setup.c
--- a-orig/arch/mips/vr41xx/victor-mpc30x/setup.c	2005-05-20 00:26:29.000000000 +0900
+++ a/arch/mips/vr41xx/victor-mpc30x/setup.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,24 +0,0 @@
-/*
- *  setup.c, Setup for the Victor MP-C303/304.
- *
- *  Copyright (C) 2002-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-const char *get_system_type(void)
-{
-	return "Victor MP-C303/304";
-}
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/zao-capcella/Makefile a/arch/mips/vr41xx/zao-capcella/Makefile
--- a-orig/arch/mips/vr41xx/zao-capcella/Makefile	2004-02-25 11:15:37.000000000 +0900
+++ a/arch/mips/vr41xx/zao-capcella/Makefile	1970-01-01 09:00:00.000000000 +0900
@@ -1,5 +0,0 @@
-#
-# Makefile for the ZAO Networks Capcella  specific parts of the kernel
-#
-
-obj-y			+= setup.o
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/zao-capcella/setup.c a/arch/mips/vr41xx/zao-capcella/setup.c
--- a-orig/arch/mips/vr41xx/zao-capcella/setup.c	2005-05-20 00:26:29.000000000 +0900
+++ a/arch/mips/vr41xx/zao-capcella/setup.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,24 +0,0 @@
-/*
- *  setup.c, Setup for the ZAO Networks Capcella.
- *
- *  Copyright (C) 2002-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-const char *get_system_type(void)
-{
-	return "ZAO Networks Capcella";
-}
