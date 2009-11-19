Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Nov 2009 18:34:39 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:44816 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1494056AbZKSRea (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Nov 2009 18:34:30 +0100
Received: by pzk35 with SMTP id 35so1798279pzk.22
        for <multiple recipients>; Thu, 19 Nov 2009 09:34:22 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=anKCmY4i2eqAGqanAU2twL+Xls966xwMlNw8i3koGRM=;
        b=cgloO7hsOvb2HvzbJUpupWTS1TSKZBqyoma1QMix9luobvMUHq2Qcrw5yJtWFPOWMk
         kawWyzM3k1dvXi/fvDfTqMvRg35JOz34ZFDJ/nTHs0HWbjlnD/QA5HOEDOcmBI+SY1LT
         qwqdrBpWXONMBr6CfZh0VhKisRYcq88cusDOE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ICoPPLojWVs6nCx4mt/S/wG18wJAY6hpWBEa/h9ltZGJUaMrBtZ0qZKEg/15BqqJlY
         0PmoQW2WsgR3zmJduVRg3fS9w2fENfNAJdu0VSy/s22gNy/fnCGsLY7pYbwU4B7IPb34
         x/rRsaISq7AYBh0meou0gwHI5FyXwYij32R0g=
Received: by 10.115.37.37 with SMTP id p37mr294548waj.11.1258652062394;
        Thu, 19 Nov 2009 09:34:22 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm464703pxi.6.2009.11.19.09.34.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 09:34:22 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com,
	huhb@lemote.com, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 3/5] [loongson] yeeloong2f: add LID open event as the wakeup event
Date:	Fri, 20 Nov 2009 01:34:12 +0800
Message-Id: <af75e5960ec423f3f2f56eeb35523f95a7ea8cad.1258651050.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1258651050.git.wuzhangjin@gmail.com>
References: <cover.1258651050.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Yeeloong2F netbook has an embedded controller(kb3310b) to manage the LID
action. when the LID is closed/opened, a relative SCI interrupt take
place, and the relative event is saved to a relative EC register.

This patch make the LID open action can wake up the processor from wait
mode if it in the suspend mode.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/mach-loongson/loongson.h |    1 +
 arch/mips/loongson/lemote-2f/irq.c             |    4 +-
 arch/mips/loongson/lemote-2f/pm.c              |   72 ++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index daf7041..71ce760 100644
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
index 8090d05..7202177 100644
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
@@ -52,6 +55,9 @@ static int i8042_enable_kbd_port(void)
 /*
  * The i8042 is connnected to i8259A
  */
+#define PIC_CASCADE_IR 2	/* cascade irq num of i8259A */
+
+/* i8042 is connnectted to i8259A */
 void setup_wakeup_events(void)
 {
 	int irq_mask;
@@ -65,9 +71,75 @@ void setup_wakeup_events(void)
 
 		/* enable keyboard port */
 		i8042_enable_kbd_port();
+
+		/* wakeup cpu via sci with relative lid openning event */
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
+	printk(KERN_INFO "irq = %d\n", irq);
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
+				/* if we call it directly here, the WARNING
+				 * will happen at line 98 of
+				 * kerenl/time/timekeeping.c (getnstimeofday)
+				 * via "WARN_ON(timekeeping_suspended);" because,
+				 * currently, we are in the suspend status
+				 */
+				if (initialized == 0) {
+					/* init the rfkill work task */
+					INIT_DELAYED_WORK(&lid_task, yeeloong_lid_update_task);
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
