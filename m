Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2008 22:52:14 +0000 (GMT)
Received: from mo31.po.2iij.NET ([210.128.50.54]:8727 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S28640958AbYCRWwM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 18 Mar 2008 22:52:12 +0000
Received: by mo.po.2iij.net (mo31) id m2IMpm89043647; Wed, 19 Mar 2008 07:51:48 +0900 (JST)
Received: from localhost (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox303) id m2IMphMF024820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Mar 2008 07:51:43 +0900
Message-Id: <200803182251.m2IMphMF024820@po-mbox303.hop.2iij.net>
Date:	Wed, 19 Mar 2008 07:51:01 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2/2] add  VR41xx SIU setup for serial console
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Add VR41xx SIU setup for serial console.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/vr41xx/common/init.c linux/arch/mips/vr41xx/common/init.c
--- linux-orig/arch/mips/vr41xx/common/init.c	2008-03-12 17:03:15.200969168 +0900
+++ linux/arch/mips/vr41xx/common/init.c	2008-03-12 17:03:38.574609820 +0900
@@ -1,7 +1,7 @@
 /*
  *  init.c, Common initialization routines for NEC VR4100 series.
  *
- *  Copyright (C) 2003-2005  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *  Copyright (C) 2003-2008  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -53,6 +53,8 @@ void __init plat_time_init(void)
 void __init plat_mem_setup(void)
 {
 	iomem_resource_init();
+
+	vr41xx_siu_setup();
 }
 
 void __init prom_init(void)
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/vr41xx/common/siu.c linux/arch/mips/vr41xx/common/siu.c
--- linux-orig/arch/mips/vr41xx/common/siu.c	2008-03-12 17:03:15.200969168 +0900
+++ linux/arch/mips/vr41xx/common/siu.c	2008-03-12 17:05:49.337802432 +0900
@@ -1,7 +1,7 @@
 /*
  *  NEC VR4100 series SIU platform device.
  *
- *  Copyright (C) 2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *  Copyright (C) 2007-2008  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -118,3 +118,37 @@ err_free_device:
 	return retval;
 }
 device_initcall(vr41xx_siu_add);
+
+void __init vr41xx_siu_setup(void)
+{
+	struct uart_port port;
+	struct resource *res;
+	unsigned int *type;
+	int i;
+
+	switch (current_cpu_type()) {
+	case CPU_VR4111:
+	case CPU_VR4121:
+		type = siu_type1_ports;
+		res = siu_type1_resource;
+		break;
+	case CPU_VR4122:
+	case CPU_VR4131:
+	case CPU_VR4133:
+		type = siu_type2_ports;
+		res = siu_type2_resource;
+		break;
+	default:
+		return;
+	}
+
+	for (i = 0; i < SIU_PORTS_MAX; i++) {
+		port.line = i;
+		port.type = type[i];
+		if (port.type == PORT_UNKNOWN)
+			break;
+		port.mapbase = res[i].start;
+		port.membase = (unsigned char __iomem *)KSEG1ADDR(res[i].start);
+		vr41xx_siu_early_setup(&port);
+	}
+}
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/include/asm-mips/vr41xx/vr41xx.h linux/include/asm-mips/vr41xx/vr41xx.h
--- linux-orig/include/asm-mips/vr41xx/vr41xx.h	2008-03-12 17:04:01.248560582 +0900
+++ linux/include/asm-mips/vr41xx/vr41xx.h	2008-03-12 17:03:38.730540709 +0900
@@ -7,7 +7,7 @@
  * Copyright (C) 2001, 2002 Paul Mundt
  * Copyright (C) 2002 MontaVista Software, Inc.
  * Copyright (C) 2002 TimeSys Corp.
- * Copyright (C) 2003-2005 Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ * Copyright (C) 2003-2008 Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -143,4 +143,10 @@ extern void vr41xx_disable_csiint(uint16
 extern void vr41xx_enable_bcuint(void);
 extern void vr41xx_disable_bcuint(void);
 
+#ifdef CONFIG_SERIAL_VR41XX_CONSOLE
+extern void vr41xx_siu_setup(void);
+#else
+static inline void vr41xx_siu_setup(void) {}
+#endif
+
 #endif /* __NEC_VR41XX_H */
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/include/asm-mips/vr41xx/siu.h linux/include/asm-mips/vr41xx/siu.h
--- linux-orig/include/asm-mips/vr41xx/siu.h	2008-03-12 17:04:01.248560582 +0900
+++ linux/include/asm-mips/vr41xx/siu.h	2008-03-12 17:03:38.730540709 +0900
@@ -1,7 +1,7 @@
 /*
  *  Include file for NEC VR4100 series Serial Interface Unit.
  *
- *  Copyright (C) 2005  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *  Copyright (C) 2005-2008  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -49,4 +49,10 @@ typedef enum {
 
 extern void vr41xx_select_irda_module(irda_module_t module, irda_speed_t speed);
 
+#ifdef CONFIG_SERIAL_VR41XX_CONSOLE
+extern void vr41xx_siu_early_setup(struct uart_port *port);
+#else
+static inline void vr41xx_siu_early_setup(struct uart_port *port) {}
+#endif
+
 #endif /* __NEC_VR41XX_SIU_H */
