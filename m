Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jul 2006 09:36:44 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:58437 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133565AbWGMIeB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 13 Jul 2006 09:34:01 +0100
Received: by mo.po.2iij.net (mo32) id k6D8XvPU049591; Thu, 13 Jul 2006 17:33:57 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox31) id k6D8Xuu0008549
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 13 Jul 2006 17:33:57 +0900 (JST)
Date:	Thu, 13 Jul 2006 17:33:56 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] vr41xx: added #indef __KERNEL__/#endif to vr41xx header
 files
Message-Id: <20060713173356.72ab52f1.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has added #ifdef __KERNEL__/#endif to vr41xx header files.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/vr41xx/giu.h mips/include/asm-mips/vr41xx/giu.h
--- mips-orig/include/asm-mips/vr41xx/giu.h	2006-07-12 12:13:12.654431250 +0900
+++ mips/include/asm-mips/vr41xx/giu.h	2006-07-12 15:59:14.834000250 +0900
@@ -20,6 +20,8 @@
 #ifndef __NEC_VR41XX_GIU_H
 #define __NEC_VR41XX_GIU_H
 
+#ifdef __KERNEL__
+
 typedef enum {
 	IRQ_TRIGGER_LEVEL,
 	IRQ_TRIGGER_EDGE,
@@ -66,4 +68,6 @@ typedef enum {
 
 extern int vr41xx_gpio_pullupdown(unsigned int pin, gpio_pull_t pull);
 
+#endif /* __KERNEL__ */
+
 #endif /* __NEC_VR41XX_GIU_H */
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/vr41xx/pci.h mips/include/asm-mips/vr41xx/pci.h
--- mips-orig/include/asm-mips/vr41xx/pci.h	2006-07-12 12:13:12.654431250 +0900
+++ mips/include/asm-mips/vr41xx/pci.h	2006-07-12 15:59:14.834000250 +0900
@@ -20,6 +20,8 @@
 #ifndef __NEC_VR41XX_PCI_H
 #define __NEC_VR41XX_PCI_H
 
+#ifdef __KERNEL__
+
 #define PCI_MASTER_ADDRESS_MASK	0x7fffffffU
 
 struct pci_master_address_conversion {
@@ -87,4 +89,6 @@ struct pci_controller_unit_setup {
 
 extern void vr41xx_pciu_setup(struct pci_controller_unit_setup *setup);
 
+#endif /* __KERNEL__ */
+
 #endif /* __NEC_VR41XX_PCI_H */
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/vr41xx/siu.h mips/include/asm-mips/vr41xx/siu.h
--- mips-orig/include/asm-mips/vr41xx/siu.h	2006-07-12 12:13:12.654431250 +0900
+++ mips/include/asm-mips/vr41xx/siu.h	2006-07-12 15:59:14.838000500 +0900
@@ -20,6 +20,8 @@
 #ifndef __NEC_VR41XX_SIU_H
 #define __NEC_VR41XX_SIU_H
 
+#ifdef __KERNEL__
+
 typedef enum {
 	SIU_INTERFACE_RS232C,
 	SIU_INTERFACE_IRDA,
@@ -47,4 +49,6 @@ typedef enum {
 
 extern void vr41xx_select_irda_module(irda_module_t module, irda_speed_t speed);
 
+#endif /* __KERNEL__ */
+
 #endif /* __NEC_VR41XX_SIU_H */
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/vr41xx/vr41xx.h mips/include/asm-mips/vr41xx/vr41xx.h
--- mips-orig/include/asm-mips/vr41xx/vr41xx.h	2006-07-12 13:51:13.821981250 +0900
+++ mips/include/asm-mips/vr41xx/vr41xx.h	2006-07-12 15:59:14.838000500 +0900
@@ -42,6 +42,8 @@
 /* VR4133 0x00000c84- */
 #define PRID_VR4133		0x00000c84
 
+#ifdef __KERNEL__
+
 /*
  * Bus Control Uint
  */
@@ -143,4 +145,6 @@ extern void vr41xx_disable_csiint(uint16
 extern void vr41xx_enable_bcuint(void);
 extern void vr41xx_disable_bcuint(void);
 
+#endif /* __KERNEL__ */
+
 #endif /* __NEC_VR41XX_H */
