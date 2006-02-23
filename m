Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2006 15:40:12 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:56640 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S8133754AbWBWPiN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Feb 2006 15:38:13 +0000
Received: from 192.168.1.104 ([10.150.0.9])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id k1NFjEt16556
	for <linux-mips@linux-mips.org>; Thu, 23 Feb 2006 19:45:14 +0400
Subject: NEC VR5701 support
From:	Sergey Podstavin <spodstavin@ru.mvista.com>
Reply-To: spodstavin@ru.mvista.com
To:	linux-mips <linux-mips@linux-mips.org>
Content-Type: multipart/mixed; boundary="=-00L1rH500cG3JDghjOz8"
Organization: MontaVista
Date:	Thu, 23 Feb 2006 18:45:15 +0300
Message-Id: <1140709515.5741.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Return-Path: <spodstavin@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10624
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: spodstavin@ru.mvista.com
Precedence: bulk
X-list: linux-mips


--=-00L1rH500cG3JDghjOz8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-00L1rH500cG3JDghjOz8
Content-Disposition: attachment; filename=pro_mips_nec_vr5701_usb_fix.patch
Content-Type: text/x-patch; name=pro_mips_nec_vr5701_usb_fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Source: MontaVista Software, Inc. Igor Goryachev <igoryachev@ru.mvista.com>
MR: 15905
Type: Defect Fix
Disposition: needs submitting to linuxmips-embedded mailing list
Signed-off-by: Igor Goryachev <igoryachev@ru.mvista.com>
Description:
    Fixes USB host behaviour on NEC vr5701.

Index: linux-2.6.10/arch/mips/vr5701/tcube/setup.c
===================================================================
--- linux-2.6.10.orig/arch/mips/vr5701/tcube/setup.c
+++ linux-2.6.10/arch/mips/vr5701/tcube/setup.c
@@ -136,11 +136,11 @@ static void __init tcube_board_init(void
 	/* setup GPIO */
 	ddb_out32(GIU_DIR0, 0xf7ebffdf);
 	ddb_out32(GIU_DIR1, 0x000007fa);
-	ddb_out32(GIU_FUNCSEL0, 0xf1c1ffff);
+	ddb_out32(GIU_FUNCSEL0, 0xf1c07fff);
 	ddb_out32(GIU_FUNCSEL1, 0x000007f0);
 	chk_init_5701_reg(GIU_DIR0, 0xf7ebffdf);
 	chk_init_5701_reg(GIU_DIR1, 0x000007fa);
-	chk_init_5701_reg(GIU_FUNCSEL0, 0xf1c1ffff);
+	chk_init_5701_reg(GIU_FUNCSEL0, 0xf1c07fff);
 	chk_init_5701_reg(GIU_FUNCSEL1, 0x000007f0);
 
 	/* enable USB input buffers */
Index: linux-2.6.10/include/linux/lsppatchlevel.h
===================================================================
--- linux-2.6.10.orig/include/linux/lsppatchlevel.h
+++ linux-2.6.10/include/linux/lsppatchlevel.h
@@ -6,4 +6,4 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
-#define LSP_PATCH_LEVEL "8"
+#define LSP_PATCH_LEVEL "9"
Index: linux-2.6.10/mvl_patches/pro-0009.c
===================================================================
--- /dev/null
+++ linux-2.6.10/mvl_patches/pro-0009.c
@@ -0,0 +1,16 @@
+/*
+ * Author: MontaVista Software, Inc. <source@mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/init.h>
+#include <linux/mvl_patch.h>
+
+static __init int regpatch(void)
+{
+        return mvl_register_patch(9);
+}
+module_init(regpatch);

--=-00L1rH500cG3JDghjOz8--
