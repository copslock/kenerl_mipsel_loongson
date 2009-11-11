Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 07:58:12 +0100 (CET)
Received: from mail-px0-f176.google.com ([209.85.216.176]:34555 "EHLO
	mail-px0-f176.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492369AbZKKG54 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 07:57:56 +0100
Received: by pxi6 with SMTP id 6so885021pxi.0
        for <multiple recipients>; Tue, 10 Nov 2009 22:57:49 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=bzgjiRcaUOBC5/3rusN2ecm8D45s7YezWr5ZLLgC+ro=;
        b=VdyEn3cPhxmi2OhpFQ5bGeGqaXf9Iqrhv+gYRR5PBjEFTnxGQGcctx4ew3GwPCd1lo
         1vRCMSqszxmGMmVMehAgfzD5i2K4HzPHlVB45o83gdY352h+4MlntHEFlljy2aAGcHFR
         sPFpaRspQ/OPUaBNSetTJvGP37Q9qvngX13pg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=s7Rmui53f9UXGXf3K4DlPQLd6aU94bEKC+2YiRddLhqQQnDfn85kHwL9O9wXqJKSbI
         01RB6Gvt3rV/94qsLdQouVHxcWAVeZyEPuaIg1y1of5xmrrCX3r1pPSVvFNN4TwGuElq
         5tpB7jLw6j3pKylGeSLH7oNTNBMr4yDmS47nU=
Received: by 10.115.26.7 with SMTP id d7mr2479558waj.12.1257922669474;
        Tue, 10 Nov 2009 22:57:49 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm879133pxi.7.2009.11.10.22.57.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 22:57:48 -0800 (PST)
Subject: [PATCH -queue 2/2] [loongson] yeeloong2f: add board specific
 suspend support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, yanh@lemote.com, huhb@lemote.com,
	Wu Zhangjin <wuzhangjin@gmail.com>,
	LenBrown <len.brown@intel.com>, PavelMachek <pavel@ucw.cz>,
	"RafaelJ.Wysocki" <rjw@sisk.pl>, linux-pm@lists.linux-foundation.or
In-Reply-To: <1368943cd7de052a825f8b23ec730b8546278d1e.1257922151.git.wuzhangjin@gmail.com>
References: <cover.1257920162.git.wuzhangjin@gmail.com>
	 <1368943cd7de052a825f8b23ec730b8546278d1e.1257922151.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1257922151.git.wuzhangjin@gmail.com>
References: <cover.1257922151.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Wed, 11 Nov 2009 14:57:41 +0800
Message-ID: <1257922661.2922.98.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

(Add CC to Rafael J. Wysocki, Len Brown and Pavel Machek)

Lemote loongson2f family machines need an external interrupt to wake up
the system from the suspend mode.

For the new Fuloong2f and LingLoong2f, they add a button to send the
interrupt to the cpu directly, so, there is no need to setup an
interrupt for them.

But for YeeLoong2f and Mengloong2f, there is no hardware change, So, we
setup the keyboard interrupt as the wakeup interrupt, this patch does
it!

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/lemote-2f/Makefile |    6 +++
 arch/mips/loongson/lemote-2f/pm.c     |   70 +++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/loongson/lemote-2f/pm.c

diff --git a/arch/mips/loongson/lemote-2f/Makefile b/arch/mips/loongson/lemote-2f/Makefile
index da543b1..5add7b2 100644
--- a/arch/mips/loongson/lemote-2f/Makefile
+++ b/arch/mips/loongson/lemote-2f/Makefile
@@ -3,3 +3,9 @@
 #
 
 obj-y += irq.o reset.o
+
+#
+# Suspend Support
+#
+
+obj-$(CONFIG_LOONGSON_SUSPEND) += pm.o
diff --git a/arch/mips/loongson/lemote-2f/pm.c b/arch/mips/loongson/lemote-2f/pm.c
new file mode 100644
index 0000000..771f32d
--- /dev/null
+++ b/arch/mips/loongson/lemote-2f/pm.c
@@ -0,0 +1,70 @@
+/*
+ *  Lemote loongson2f family machines' specific suspend support
+ *
+ *  Copyright (C) 2009 Lemote Inc.
+ *  Author: Wu Zhangjin <wuzj@lemote.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/suspend.h>
+#include <linux/interrupt.h>
+#include <linux/pm.h>
+#include <linux/i8042.h>
+
+#include <asm/i8259.h>
+#include <asm/mipsregs.h>
+#include <asm/bootinfo.h>
+
+#include <loongson.h>
+
+#define I8042_KBD_IRQ		1
+#define I8042_CTR_KBDINT	0x01
+#define I8042_CTR_KBDDIS	0x10
+
+static unsigned char i8042_ctr;
+
+static int i8042_enable_kbd_port(void)
+{
+	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_RCTR)) {
+		printk(KERN_ERR "i8042.c: Can't read CTR while enabling i8042 kbd port.\n");
+		return -EIO;
+	}
+
+	i8042_ctr &= ~I8042_CTR_KBDDIS;
+	i8042_ctr |= I8042_CTR_KBDINT;
+
+	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
+		i8042_ctr &= ~I8042_CTR_KBDINT;
+		i8042_ctr |= I8042_CTR_KBDDIS;
+		printk(KERN_ERR "i8042.c: Failed to enable KBD port.\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/* i8042 is connnectted to i8259A */
+void setup_wakeup_events(void)
+{
+	int irq_mask;
+
+	printk(KERN_INFO "setup wakeup interrupts\n");
+
+	switch (mips_machtype) {
+	case MACH_LEMOTE_ML2F7:
+	case MACH_LEMOTE_YL2F89:
+		/* open the keyboard irq in i8259A */
+		outb((0xff & ~(1 << I8042_KBD_IRQ)), PIC_MASTER_IMR);
+		irq_mask = inb(PIC_MASTER_IMR);
+
+		/* enable keyboard port */
+		i8042_enable_kbd_port();
+		break;
+	default:
+		break;
+	}
+}
-- 
1.6.2.1
