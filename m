Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Nov 2009 18:34:14 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:44470 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1494047AbZKSReH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Nov 2009 18:34:07 +0100
Received: by pwi15 with SMTP id 15so1593489pwi.24
        for <multiple recipients>; Thu, 19 Nov 2009 09:34:01 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=XW+RX8s2BQFbvDC5lOZTKpr0cbdmOoput8W+n77DGgA=;
        b=H4ajrMsvJieSwoIii2m9j7kPRct5iZFPoohY/fbaY2aq1K7U4tG2aO8cQIQGw7zyME
         UG0IDAXoSu+fGKw+vuG+sop2b6psMHV60J3o+5IILC+uceOaGXoGKQIx0uvmZU4MkVBB
         bZ4ynDRqYkaRb4oPwh3owEjTlJ2Aq6chIuLgI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NLVOgeUKiyM4tC7+HRs49EOS9SABkeOfnPe14Hcn+L/h1T0BSrAnaJKHoUrSGu5rQ1
         GCvE6ODKuZ4K1Ql+BTYA1d2GESgKgEEyXfRGc184RQeKVAOOoXG6hnTI6uBFQcWS/AuX
         Llv2cfCDVBlJvOZ3ObwN5dORlNZQkMGSRJhzc=
Received: by 10.115.114.9 with SMTP id r9mr292478wam.19.1258652041109;
        Thu, 19 Nov 2009 09:34:01 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm458353pzk.14.2009.11.19.09.33.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 09:34:00 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com,
	huhb@lemote.com, liujl@lemote.com, huangw@lemote.com,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 2/5] [loongson] yeeloong2f: add basic ec operations
Date:	Fri, 20 Nov 2009 01:33:48 +0800
Message-Id: <a99b4812e3e2ac13eb707718ca61f88fce3516b9.1258651050.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1258651050.git.wuzhangjin@gmail.com>
References: <cover.1258651050.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

YeeLoong2F has a kb3310b Embedded Controller. This patch add the basic
EC operations for future relative drivers or board support.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/lemote-2f/Makefile     |    2 +-
 arch/mips/loongson/lemote-2f/ec_kb3310b.c |  132 +++++++++++++++++++++++++++++
 arch/mips/loongson/lemote-2f/ec_kb3310b.h |   47 ++++++++++
 3 files changed, 180 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/loongson/lemote-2f/ec_kb3310b.c
 create mode 100644 arch/mips/loongson/lemote-2f/ec_kb3310b.h

diff --git a/arch/mips/loongson/lemote-2f/Makefile b/arch/mips/loongson/lemote-2f/Makefile
index ad9e287..81a97d0 100644
--- a/arch/mips/loongson/lemote-2f/Makefile
+++ b/arch/mips/loongson/lemote-2f/Makefile
@@ -2,7 +2,7 @@
 # Makefile for lemote loongson2f family machines
 #
 
-obj-y += irq.o reset.o
+obj-y += irq.o reset.o ec_kb3310b.o
 
 #
 # Suspend Support
diff --git a/arch/mips/loongson/lemote-2f/ec_kb3310b.c b/arch/mips/loongson/lemote-2f/ec_kb3310b.c
new file mode 100644
index 0000000..1ca38a8
--- /dev/null
+++ b/arch/mips/loongson/lemote-2f/ec_kb3310b.c
@@ -0,0 +1,132 @@
+/*
+ * EC(Embedded Controller) KB3310B basic support for YeeLoong2F netbook
+ *
+ *  Copyright (C) 2008 Lemote Inc.
+ *  Author: liujl <liujl@lemote.com>, 2008-04-20
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/delay.h>
+
+#include "ec_kb3310b.h"
+
+/* this spinlock is dedicated for ec_read & ec_write function */
+DEFINE_SPINLOCK(index_access_lock);
+/* this spinlock is dedicated for 62&66 ports access */
+DEFINE_SPINLOCK(port_access_lock);
+
+/* read a byte from EC registers throught index-io */
+unsigned char ec_read(unsigned short addr)
+{
+	unsigned char value;
+	unsigned long flags;
+
+	spin_lock_irqsave(&index_access_lock, flags);
+	outb((addr & 0xff00) >> 8, EC_IO_PORT_HIGH);
+	outb((addr & 0x00ff), EC_IO_PORT_LOW);
+	value = inb(EC_IO_PORT_DATA);
+	spin_unlock_irqrestore(&index_access_lock, flags);
+
+	return value;
+}
+EXPORT_SYMBOL_GPL(ec_read);
+
+/* write a byte to EC registers throught index-io */
+void ec_write(unsigned short addr, unsigned char val)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&index_access_lock, flags);
+	outb((addr & 0xff00) >> 8, EC_IO_PORT_HIGH);
+	outb((addr & 0x00ff), EC_IO_PORT_LOW);
+	outb(val, EC_IO_PORT_DATA);
+	/*  flush the write action */
+	inb(EC_IO_PORT_DATA);
+	spin_unlock_irqrestore(&index_access_lock, flags);
+
+	return;
+}
+EXPORT_SYMBOL_GPL(ec_write);
+
+/*
+ * this function is used for ec command writing and corresponding status query
+ */
+int ec_query_seq(unsigned char cmd)
+{
+	int timeout;
+	unsigned char status;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&port_access_lock, flags);
+
+	/* make chip goto reset mode */
+	udelay(EC_REG_DELAY);
+	outb(cmd, EC_CMD_PORT);
+	udelay(EC_REG_DELAY);
+
+	/* check if the command is received by ec */
+	timeout = EC_CMD_TIMEOUT;
+	status = inb(EC_STS_PORT);
+	while (timeout-- && (status & (1 << 1))) {
+		status = inb(EC_STS_PORT);
+		udelay(EC_REG_DELAY);
+	}
+
+	if (timeout <= 0) {
+		printk(KERN_ERR "%s: deadable error : timeout...\n", __func__);
+		ret = -EINVAL;
+	} else
+		printk(KERN_INFO
+			   "(%x/%d)ec issued command %d status : 0x%x\n",
+			   timeout, EC_CMD_TIMEOUT - timeout, cmd, status);
+
+	spin_unlock_irqrestore(&port_access_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ec_query_seq);
+
+/*
+ * using query command to ec to get the proper event number
+ */
+int ec_query_event_num(void)
+{
+	return ec_query_seq(CMD_GET_EVENT_NUM);
+}
+EXPORT_SYMBOL(ec_query_event_num);
+
+/*
+ * get event number from ec
+ *
+ * NOTE : this routine must follow the query_event_num function in the
+ * interrupt
+ */
+int ec_get_event_num(void)
+{
+	int timeout = 100;
+	unsigned char value;
+	unsigned char status;
+
+	udelay(EC_REG_DELAY);
+	status = inb(EC_STS_PORT);
+	udelay(EC_REG_DELAY);
+	while (timeout-- && !(status & (1 << 0))) {
+		status = inb(EC_STS_PORT);
+		udelay(EC_REG_DELAY);
+	}
+	if (timeout <= 0) {
+		printk(KERN_INFO "%s: get event number timeout.\n", __func__);
+		return -EINVAL;
+	}
+	value = inb(EC_DAT_PORT);
+	udelay(EC_REG_DELAY);
+
+	return value;
+}
+EXPORT_SYMBOL(ec_get_event_num);
diff --git a/arch/mips/loongson/lemote-2f/ec_kb3310b.h b/arch/mips/loongson/lemote-2f/ec_kb3310b.h
new file mode 100644
index 0000000..4d29953
--- /dev/null
+++ b/arch/mips/loongson/lemote-2f/ec_kb3310b.h
@@ -0,0 +1,47 @@
+/*
+ * EC(Embedded Controller) KB3310B header file
+ *
+ *  Copyright (C) 2008 Lemote Inc. & Insititute of Computing Technology
+ *  Author: liujl <liujl@lemote.com>, 2008-03-14
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef _EC_KB3310B_H
+#define _EC_KB3310B_H
+
+extern unsigned char ec_read(unsigned short addr);
+extern void ec_write(unsigned short addr, unsigned char val);
+extern int ec_query_seq(unsigned char cmd);
+extern int ec_query_event_num(void);
+extern int ec_get_event_num(void);
+
+/*
+ * The following registers are determined by the EC index configuration.
+ * 1, fill the PORT_HIGH as EC register high part.
+ * 2, fill the PORT_LOW as EC register low part.
+ * 3, fill the PORT_DATA as EC register write data or get the data from it.
+ */
+#define	EC_IO_PORT_HIGH	0x0381
+#define	EC_IO_PORT_LOW	0x0382
+#define	EC_IO_PORT_DATA	0x0383
+
+/* ec delay time 500us for register and status access */
+#define	EC_REG_DELAY	500	/* unit : us */
+#define	EC_CMD_TIMEOUT		0x1000
+
+/* EC access port for sci communication */
+#define	EC_CMD_PORT		0x66
+#define	EC_STS_PORT		0x66
+#define	EC_DAT_PORT		0x62
+#define	CMD_INIT_IDLE_MODE	0xdd
+#define	CMD_EXIT_IDLE_MODE	0xdf
+#define	CMD_INIT_RESET_MODE	0xd8
+#define	CMD_REBOOT_SYSTEM	0x8c
+#define	CMD_GET_EVENT_NUM	0x84
+#define	CMD_PROGRAM_PIECE	0xda
+
+#endif /* !_EC_KB3310B_H */
-- 
1.6.2.1
