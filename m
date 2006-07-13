Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jul 2006 09:35:05 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:22596 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133571AbWGMId2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 13 Jul 2006 09:33:28 +0100
Received: by mo.po.2iij.net (mo30) id k6D8XQSc013158; Thu, 13 Jul 2006 17:33:26 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox30) id k6D8XOTQ055077
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 13 Jul 2006 17:33:24 +0900 (JST)
Date:	Thu, 13 Jul 2006 17:33:24 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] vr41xx: updated e55 setup function
Message-Id: <20060713173324.5499df36.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has updated the CASIO E55 setup function.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/vr41xx/casio-e55/setup.c mips/arch/mips/vr41xx/casio-e55/setup.c
--- mips-orig/arch/mips/vr41xx/casio-e55/setup.c	2006-07-12 12:13:07.314097500 +0900
+++ mips/arch/mips/vr41xx/casio-e55/setup.c	2006-07-12 15:31:40.894635500 +0900
@@ -1,7 +1,7 @@
 /*
  *  setup.c, Setup for the CASIO CASSIOPEIA E-11/15/55/65.
  *
- *  Copyright (C) 2002-2005  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *  Copyright (C) 2002-2006  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -21,13 +21,18 @@
 #include <linux/ioport.h>
 
 #include <asm/io.h>
-#include <asm/vr41xx/e55.h>
+
+#define E55_ISA_IO_BASE		0x1400c000
+#define E55_ISA_IO_SIZE		0x03ff4000
+#define E55_ISA_IO_START	0
+#define E55_ISA_IO_END		(E55_ISA_IO_SIZE - 1)
+#define E55_IO_PORT_BASE	KSEG1ADDR(E55_ISA_IO_BASE)
 
 static int __init casio_e55_setup(void)
 {
-	set_io_port_base(IO_PORT_BASE);
-	ioport_resource.start = IO_PORT_RESOURCE_START;
-	ioport_resource.end = IO_PORT_RESOURCE_END;
+	set_io_port_base(E55_IO_PORT_BASE);
+	ioport_resource.start = E55_ISA_IO_START;
+	ioport_resource.end = E55_ISA_IO_END;
 
 	return 0;
 }
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/vr41xx/e55.h mips/include/asm-mips/vr41xx/e55.h
--- mips-orig/include/asm-mips/vr41xx/e55.h	2006-07-12 12:13:12.654431250 +0900
+++ mips/include/asm-mips/vr41xx/e55.h	1970-01-01 09:00:00.000000000 +0900
@@ -1,43 +0,0 @@
-/*
- *  e55.h, Include file for CASIO CASSIOPEIA E-10/15/55/65.
- *
- *  Copyright (C) 2002-2004  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
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
-#ifndef __CASIO_E55_H
-#define __CASIO_E55_H
-
-#include <asm/addrspace.h>
-#include <asm/vr41xx/vr41xx.h>
-
-/*
- * Board specific address mapping
- */
-#define VR41XX_ISA_MEM_BASE		0x10000000
-#define VR41XX_ISA_MEM_SIZE		0x04000000
-
-/* VR41XX_ISA_IO_BASE includes offset from real base. */
-#define VR41XX_ISA_IO_BASE		0x1400c000
-#define VR41XX_ISA_IO_SIZE		0x03ff4000
-
-#define ISA_BUS_IO_BASE			0
-#define ISA_BUS_IO_SIZE			VR41XX_ISA_IO_SIZE
-
-#define IO_PORT_BASE			KSEG1ADDR(VR41XX_ISA_IO_BASE)
-#define IO_PORT_RESOURCE_START		ISA_BUS_IO_BASE
-#define IO_PORT_RESOURCE_END		(ISA_BUS_IO_BASE + ISA_BUS_IO_SIZE - 1)
-
-#endif /* __CASIO_E55_H */
