Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Nov 2009 12:07:06 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:58514 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492296AbZKULFq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 21 Nov 2009 12:05:46 +0100
Received: by pwi15 with SMTP id 15so2655204pwi.24
        for <multiple recipients>; Sat, 21 Nov 2009 03:05:39 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=S7xxLvAv8Kq2wEN1S4rv/xu9twaNLiIdRYpBmlhHPco=;
        b=dcfmz2wU/oOjFpCRUa+aX7rzR41qhIqiiYW90eSxPe7junckhkh0v9FnLhO2BxVZID
         Y31f3r9X56RtkpSD3pSPLheDIIoTIQhYBwc7BygSccCPBmNYpMNhZ+wqCxr66+sBulzB
         DcFCYQcHLFy2Ik4nYUzUyJ1tg/d+xduiaY8mg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bPeVDbO2wIxghM1Xa1hwet7WpiqCwTKVCLElH5YS1hra0m2dASfWsyxAtDubOjggaN
         LHHSvGoFp8941ojLZZ/qQjr8VsbY1REJuqi5k88lpUngqpfoE9ECFJYGm8egMysukiBq
         ccVzidv4ZaaUloeIBgxisSUnfJSWUVVol8kAA=
Received: by 10.115.100.20 with SMTP id c20mr3575694wam.160.1258801539766;
        Sat, 21 Nov 2009 03:05:39 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm1508374pxi.4.2009.11.21.03.05.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Nov 2009 03:05:39 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v1 2/4] [loongson] yeeloong2f: add basic ec operations
Date:	Sat, 21 Nov 2009 19:05:23 +0800
Message-Id: <be09037e3ccaae045f2832f8428d5aa098cc7480.1258800842.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cd8541a74bab41734a44dfedcbc63688d165e35e.1258800842.git.wuzhangjin@gmail.com>
References: <cover.1258800842.git.wuzhangjin@gmail.com>
 <cd8541a74bab41734a44dfedcbc63688d165e35e.1258800842.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1258800842.git.wuzhangjin@gmail.com>
References: <cover.1258800842.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25016
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
index 5add7b2..4d84b27 100644
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
index 0000000..a7ce275
--- /dev/null
+++ b/arch/mips/loongson/lemote-2f/ec_kb3310b.h
@@ -0,0 +1,47 @@
+/*
+ * EC(Embedded Controller) KB3310B header file
+ *
+ *  Copyright (C) 2008 Lemote Inc.
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
+#define	EC_CMD_TIMEOUT	0x1000
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
