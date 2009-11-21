Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Nov 2009 12:07:31 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:36862 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492324AbZKULFt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 21 Nov 2009 12:05:49 +0100
Received: by pwi15 with SMTP id 15so2655220pwi.24
        for <multiple recipients>; Sat, 21 Nov 2009 03:05:42 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=I/NaTMZwCLdnB7rpiR+WJPtVcyGfUHAWmlB8PvoCXGg=;
        b=DVLVXba/qzfdvgsmvBQLnZJYXSmKmyG40CJlR294EjpZ4b1Yi02j8yr5SuVv12prU0
         s4i2HCFy9/joanVs1e2ER3VZdanWbe9aXECSvvqpgxNsIPCoLLCy/tKv+RT+box4YClH
         YECGUzshBIBZQUafCEUI5p0QgzZ86HxRBUS7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fmqNyqUkN5VJeCTT+Ih8T7cb51dWR0uLbm9c3nbpginzglx3MinMzVTgT+N8gRdxKP
         TvsF+5kB5T1GbX3QCcFjbLli7ZItNFabYMx+ZavhtjI/m+9U76aajzn38TTYdZt0XRku
         IA7ho8O2Y2JsRouJdVdWqUz0zssoHHDRpZpLo=
Received: by 10.115.103.17 with SMTP id f17mr3545790wam.166.1258801542224;
        Sat, 21 Nov 2009 03:05:42 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm1508374pxi.4.2009.11.21.03.05.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Nov 2009 03:05:41 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v1 3/4] [loongson] yeeloong2f: add LID open event as the wakeup event
Date:	Sat, 21 Nov 2009 19:05:24 +0800
Message-Id: <b983b517f93e13dda9d76c3d1719999b0593b9d3.1258800842.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <be09037e3ccaae045f2832f8428d5aa098cc7480.1258800842.git.wuzhangjin@gmail.com>
References: <cover.1258800842.git.wuzhangjin@gmail.com>
 <cd8541a74bab41734a44dfedcbc63688d165e35e.1258800842.git.wuzhangjin@gmail.com>
 <be09037e3ccaae045f2832f8428d5aa098cc7480.1258800842.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1258800842.git.wuzhangjin@gmail.com>
References: <cover.1258800842.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Yeeloong2F netbook has an embedded controller(kb3310b) to manage the LID
action. when the LID is closed/opened, a SCI interrupt is sent out and
the corresponding event is saved to an EC register for later query.

This patch allow the LID open action to wake up the processor from wait
mode if it is in the suspend mode.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/mach-loongson/loongson.h |    1 +
 arch/mips/loongson/lemote-2f/irq.c             |    4 +-
 arch/mips/loongson/lemote-2f/pm.c              |   71 +++++++++++++++++++++++-
 3 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index a7fa66e..06c28f3 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -41,6 +41,7 @@ extern void __init bonito_irq_init(void);
 extern void __init set_irq_trigger_mode(void);
 extern void __init mach_init_irq(void);
 extern void mach_irq_dispatch(unsigned int pending);
+extern int mach_i8259_irq(void);
 
 /* We need this in some places... */
 #define delay()	({		\
diff --git a/arch/mips/loongson/lemote-2f/irq.c b/arch/mips/loongson/lemote-2f/irq.c
index 50e7bb6..77d32f9 100644
--- a/arch/mips/loongson/lemote-2f/irq.c
+++ b/arch/mips/loongson/lemote-2f/irq.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/interrupt.h>
+#include <linux/module.h>
 
 #include <asm/irq_cpu.h>
 #include <asm/i8259.h>
@@ -30,7 +31,7 @@
  * The generic i8259_irq() make the kernel hang on booting.  Since we cannot
  * get the irq via the IRR directly, we access the ISR instead.
  */
-static inline int mach_i8259_irq(void)
+int mach_i8259_irq(void)
 {
 	int irq, isr;
 
@@ -60,6 +61,7 @@ static inline int mach_i8259_irq(void)
 
 	return irq;
 }
+EXPORT_SYMBOL(mach_i8259_irq);
 
 static void i8259_irqdispatch(void)
 {
diff --git a/arch/mips/loongson/lemote-2f/pm.c b/arch/mips/loongson/lemote-2f/pm.c
index 8090d05..3072583 100644
--- a/arch/mips/loongson/lemote-2f/pm.c
+++ b/arch/mips/loongson/lemote-2f/pm.c
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/pm.h>
 #include <linux/i8042.h>
+#include <linux/module.h>
 
 #include <asm/i8259.h>
 #include <asm/mipsregs.h>
@@ -21,6 +22,8 @@
 
 #include <loongson.h>
 
+#include "ec_kb3310b.h"
+
 #define I8042_KBD_IRQ		1
 #define I8042_CTR_KBDINT	0x01
 #define I8042_CTR_KBDDIS	0x10
@@ -49,9 +52,6 @@ static int i8042_enable_kbd_port(void)
 	return 0;
 }
 
-/*
- * The i8042 is connnected to i8259A
- */
 void setup_wakeup_events(void)
 {
 	int irq_mask;
@@ -65,9 +65,74 @@ void setup_wakeup_events(void)
 
 		/* enable keyboard port */
 		i8042_enable_kbd_port();
+
+		/* wakeup cpu via SCI with relative lid openning event */
+		outb(irq_mask & ~(1 << PIC_CASCADE_IR), PIC_MASTER_IMR);
+		inb(PIC_MASTER_IMR);
+		outb(0xff & ~(1 << (SCI_IRQ_NUM - 8)), PIC_SLAVE_IMR);
+		inb(PIC_SLAVE_IMR);
+
 		break;
 
 	default:
 		break;
 	}
 }
+
+static struct delayed_work lid_task;
+static int initialized;
+/* yeeloong_report_lid_status will be implemented in yeeloong_laptop.c */
+sci_handler yeeloong_report_lid_status;
+EXPORT_SYMBOL(yeeloong_report_lid_status);
+static void yeeloong_lid_update_task(struct work_struct *work)
+{
+	if (yeeloong_report_lid_status)
+		yeeloong_report_lid_status(BIT_LID_DETECT_ON);
+}
+
+int wakeup_loongson(void)
+{
+	int irq;
+
+	/* query the interrupt number */
+	irq = mach_i8259_irq();
+	if (irq < 0)
+		return 0;
+
+	printk(KERN_INFO "%s: irq = %d\n", __func__, irq);
+
+	if (irq == I8042_KBD_IRQ)
+		return 1;
+	else if (irq == SCI_IRQ_NUM) {
+		int ret, sci_event;
+		/* query the event number */
+		ret = ec_query_seq(CMD_GET_EVENT_NUM);
+		if (ret < 0)
+			return 0;
+		sci_event = ec_get_event_num();
+		if (sci_event < 0)
+			return 0;
+		if (sci_event == EVENT_LID) {
+			int lid_status;
+			/* check the LID status */
+			lid_status = ec_read(REG_LID_DETECT);
+			/* wakeup cpu when people open the LID */
+			if (lid_status == BIT_LID_DETECT_ON) {
+				/* If we call it directly here, the WARNING
+				 * will be sent out by getnstimeofday
+				 * via "WARN_ON(timekeeping_suspended);"
+				 * because we can not schedule in suspend mode.
+				 */
+				if (initialized == 0) {
+					INIT_DELAYED_WORK(&lid_task,
+						yeeloong_lid_update_task);
+					initialized = 1;
+				}
+				schedule_delayed_work(&lid_task, 1);
+				return 1;
+			}
+		}
+	}
+
+	return 0;
+}
-- 
1.6.2.1
