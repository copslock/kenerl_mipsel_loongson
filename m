Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Sep 2003 17:10:57 +0100 (BST)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:28396 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225310AbTICQKZ>;
	Wed, 3 Sep 2003 17:10:25 +0100
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id BAA10883;
	Thu, 4 Sep 2003 01:10:21 +0900 (JST)
Received: 4UMDO01 id h83GALQ22510; Thu, 4 Sep 2003 01:10:21 +0900 (JST)
Received: 4UMRO01 id h83GAKH05760; Thu, 4 Sep 2003 01:10:21 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Thu, 4 Sep 2003 01:10:19 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: ralf@linux-mips.org
Cc: yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: [patch] NEC VRC4173 CARDU
Message-Id: <20030904011019.5c6fe5a0.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Thu__4_Sep_2003_01:10:19_+0900_08623c98"
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--Multipart_Thu__4_Sep_2003_01:10:19_+0900_08623c98
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello Ralf,

I made a patch for NEC VRC4173 CARDU(PCMCIA Controller).
This patch can be prevented from probing the already used slot.

Please apply this patch.

Yoichi

--Multipart_Thu__4_Sep_2003_01:10:19_+0900_08623c98
Content-Type: text/plain;
 name="vrc4173_cardu-v24.diff"
Content-Disposition: attachment;
 filename="vrc4173_cardu-v24.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/drivers/pcmcia/vrc4173_cardu.c linux/drivers/pcmcia/vrc4173_cardu.c
--- linux.orig/drivers/pcmcia/vrc4173_cardu.c	Fri Apr 11 11:08:50 2003
+++ linux/drivers/pcmcia/vrc4173_cardu.c	Wed Sep  3 19:47:00 2003
@@ -6,7 +6,7 @@
  * 	NEC VRC4173 CARDU driver for Socket Services
  *	(This device doesn't support CardBus. it is supporting only 16bit PC Card.)
  *
- * Copyright 2002 Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ * Copyright 2002,2003 Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License as published by the
@@ -520,6 +520,9 @@
 
 	slot = vrc4173_cardu_slots++;
 	socket = &cardu_sockets[slot];
+	if (socket->noprobe != 0)
+		return -EBUSY;
+
 	sprintf(socket->name, "NEC VRC4173 CARDU%1d", slot+1);
 
 	if ((err = pci_enable_device(dev)) < 0)
@@ -564,6 +567,36 @@
 
 	return 0;
 }
+
+static int __devinit vrc4173_cardu_setup(char *options)
+{
+	if (options == NULL || *options == '\0')
+		return 0;
+
+	if (strncmp(options, "cardu1:", 7) == 0) {
+		options += 7;
+		if (*options != '\0') {
+			if (strncmp(options, "noprobe", 7) == 0) {
+				cardu_sockets[CARDU1].noprobe = 1;
+				options += 7;
+			}
+
+			if (*options != ',')
+				return 0;
+		} else
+			return 0;
+	}
+
+	if (strncmp(options, "cardu2:", 7) == 0) {
+		options += 7;
+		if ((*options != '\0') && (strncmp(options, "noprobe", 7) == 0))
+			cardu_sockets[CARDU2].noprobe = 1;
+	}
+
+	return 0;
+}
+
+__setup("vrc4173_cardu=", vrc4173_cardu_setup);
 
 static struct pci_device_id vrc4173_cardu_id_table[] __devinitdata = {
 	{	.vendor		= PCI_VENDOR_ID_NEC,
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/drivers/pcmcia/vrc4173_cardu.h linux/drivers/pcmcia/vrc4173_cardu.h
--- linux.orig/drivers/pcmcia/vrc4173_cardu.h	Fri Apr 11 11:08:50 2003
+++ linux/drivers/pcmcia/vrc4173_cardu.h	Wed Sep  3 19:47:05 2003
@@ -35,6 +35,8 @@
 #include <pcmcia/ss.h>
 
 #define CARDU_MAX_SOCKETS	2
+#define CARDU1			0
+#define CARDU2			1
 
 /*
  * PCI Configuration Registers
@@ -229,6 +231,7 @@
  #define VPP_CNT_0V		0x00000000
 
 typedef struct vrc4173_socket {
+	int noprobe;
 	struct pci_dev *dev;
 	void *base;
 	void (*handler)(void *, unsigned int);

--Multipart_Thu__4_Sep_2003_01:10:19_+0900_08623c98
Content-Type: text/plain;
 name="vrc4173_cardu-v26.diff"
Content-Disposition: attachment;
 filename="vrc4173_cardu-v26.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/drivers/pcmcia/vrc4173_cardu.c linux/drivers/pcmcia/vrc4173_cardu.c
--- linux.orig/drivers/pcmcia/vrc4173_cardu.c	Fri Apr 11 11:09:21 2003
+++ linux/drivers/pcmcia/vrc4173_cardu.c	Thu Sep  4 00:51:29 2003
@@ -6,7 +6,7 @@
  * 	NEC VRC4173 CARDU driver for Socket Services
  *	(This device doesn't support CardBus. it is supporting only 16bit PC Card.)
  *
- * Copyright 2002 Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ * Copyright 2002,2003 Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License as published by the
@@ -519,6 +519,9 @@
 
 	slot = vrc4173_cardu_slots++;
 	socket = &cardu_sockets[slot];
+	if (socket->noprobe != 0)
+		return -EBUSY;
+
 	sprintf(socket->name, "NEC VRC4173 CARDU%1d", slot+1);
 
 	if ((err = pci_enable_device(dev)) < 0)
@@ -563,6 +566,36 @@
 
 	return 0;
 }
+
+static int __devinit vrc4173_cardu_setup(char *options)
+{
+	if (options == NULL || *options == '\0')
+		return 0;
+
+	if (strncmp(options, "cardu1:", 7) == 0) {
+		options += 7;
+		if (*options != '\0') {
+			if (strncmp(options, "noprobe", 7) == 0) {
+				cardu_sockets[CARDU1].noprobe = 1;
+				options += 7;
+			}
+
+			if (*options != ',')
+				return 0;
+		} else
+			return 0;
+	}
+
+	if (strncmp(options, "cardu2:", 7) == 0) {
+		options += 7;
+		if ((*options != '\0') && (strncmp(options, "noprobe", 7) == 0))
+			cardu_sockets[CARDU2].noprobe = 1;
+	}
+
+	return 0;
+}
+
+__setup("vrc4173_cardu=", vrc4173_cardu_setup);
 
 static struct pci_device_id vrc4173_cardu_id_table[] __devinitdata = {
 	{	.vendor		= PCI_VENDOR_ID_NEC,
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/drivers/pcmcia/vrc4173_cardu.h linux/drivers/pcmcia/vrc4173_cardu.h
--- linux.orig/drivers/pcmcia/vrc4173_cardu.h	Fri Apr 11 11:09:21 2003
+++ linux/drivers/pcmcia/vrc4173_cardu.h	Thu Sep  4 00:51:29 2003
@@ -35,6 +35,8 @@
 #include <pcmcia/ss.h>
 
 #define CARDU_MAX_SOCKETS	2
+#define CARDU1			0
+#define CARDU2			1
 
 /*
  * PCI Configuration Registers
@@ -229,6 +231,7 @@
  #define VPP_CNT_0V		0x00000000
 
 typedef struct vrc4173_socket {
+	int noprobe;
 	struct pci_dev *dev;
 	void *base;
 	void (*handler)(void *, unsigned int);

--Multipart_Thu__4_Sep_2003_01:10:19_+0900_08623c98--
