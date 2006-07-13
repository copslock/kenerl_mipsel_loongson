Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jul 2006 09:35:58 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:18955 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133572AbWGMIdh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 13 Jul 2006 09:33:37 +0100
Received: by mo.po.2iij.net (mo31) id k6D8XZT4077358; Thu, 13 Jul 2006 17:33:35 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox33) id k6D8XX3l062971
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 13 Jul 2006 17:33:33 +0900 (JST)
Date:	Thu, 13 Jul 2006 17:33:33 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] vr41xx: updated workpad setup function
Message-Id: <20060713173333.2eddfd7d.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has updated the IBM WorkPad setup function.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/vr41xx/ibm-workpad/setup.c mips/arch/mips/vr41xx/ibm-workpad/setup.c
--- mips-orig/arch/mips/vr41xx/ibm-workpad/setup.c	2006-07-12 12:13:07.318097750 +0900
+++ mips/arch/mips/vr41xx/ibm-workpad/setup.c	2006-07-12 15:40:51.761062500 +0900
@@ -1,7 +1,7 @@
 /*
  *  setup.c, Setup for the IBM WorkPad z50.
  *
- *  Copyright (C) 2002-2005  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *  Copyright (C) 2002-2006  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -21,13 +21,18 @@
 #include <linux/ioport.h>
 
 #include <asm/io.h>
-#include <asm/vr41xx/workpad.h>
+
+#define WORKPAD_ISA_IO_BASE	0x15000000
+#define WORKPAD_ISA_IO_SIZE	0x03000000
+#define WORKPAD_ISA_IO_START	0
+#define WORKPAD_ISA_IO_END	(WORKPAD_ISA_IO_SIZE - 1)
+#define WORKPAD_IO_PORT_BASE	KSEG1ADDR(WORKPAD_ISA_IO_BASE)
 
 static int __init ibm_workpad_setup(void)
 {
-	set_io_port_base(IO_PORT_BASE);
-	ioport_resource.start = IO_PORT_RESOURCE_START;
-	ioport_resource.end = IO_PORT_RESOURCE_END;
+	set_io_port_base(WORKPAD_IO_PORT_BASE);
+	ioport_resource.start = WORKPAD_ISA_IO_START;
+	ioport_resource.end = WORKPAD_ISA_IO_END;
 
 	return 0;
 }
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/vr41xx/workpad.h mips/include/asm-mips/vr41xx/workpad.h
--- mips-orig/include/asm-mips/vr41xx/workpad.h	2006-07-12 12:13:12.654431250 +0900
+++ mips/include/asm-mips/vr41xx/workpad.h	1970-01-01 09:00:00.000000000 +0900
@@ -1,43 +0,0 @@
-/*
- *  workpad.h, Include file for IBM WorkPad z50.
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
-#ifndef __IBM_WORKPAD_H
-#define __IBM_WORKPAD_H
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
-#define VR41XX_ISA_IO_BASE		0x15000000
-#define VR41XX_ISA_IO_SIZE		0x03000000
-
-#define ISA_BUS_IO_BASE			0
-#define ISA_BUS_IO_SIZE			VR41XX_ISA_IO_SIZE
-
-#define IO_PORT_BASE			KSEG1ADDR(VR41XX_ISA_IO_BASE)
-#define IO_PORT_RESOURCE_START		ISA_BUS_IO_BASE
-#define IO_PORT_RESOURCE_END		(ISA_BUS_IO_BASE + ISA_BUS_IO_SIZE - 1)
-
-#endif /* __IBM_WORKPAD_H */
