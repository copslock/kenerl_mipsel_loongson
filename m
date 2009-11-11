Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 07:53:54 +0100 (CET)
Received: from mail-px0-f176.google.com ([209.85.216.176]:48030 "EHLO
	mail-px0-f176.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492369AbZKKGxG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 07:53:06 +0100
Received: by pxi6 with SMTP id 6so882884pxi.0
        for <multiple recipients>; Tue, 10 Nov 2009 22:52:59 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=exE4x/VVy40jLOO9O7gkpuGhA7UnriqyXbxgdxLjtTs=;
        b=RWBpruagxf8uZ5MRoPAxTT4ronmPMcAa3FbdJLfwKr6G+g9TLDfnGSAfKe5dI4omFJ
         B2HLny7C+ybk4vUYlKef/lGFP+WzxVWeL/tT74oKJToRH6HIQeszM7/k1jU9IkYI0rLn
         5GVzm1VzC8GRvFVFtCJlYtNYgE/GgEfTB/Q0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MBoEmn4kLUAOq4oEciiGNuv9cU3QcjO4RccNT+MxOu5wUeAknkTZwrXoFKCnPye1JB
         pzzfDgMO8xr7TUOwBogP/pa+VdQsVolgIYi8SNr86p0IAHtLye7D0ZKhPv88Jb+p4ZKb
         L3tBWCumNt/BVZpQaAi0P36cU+JrJYIKo5mRU=
Received: by 10.115.38.40 with SMTP id q40mr2409264waj.95.1257922378988;
        Tue, 10 Nov 2009 22:52:58 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm819777pzk.2.2009.11.10.22.52.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 22:52:58 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, yanh@lemote.com, huhb@lemote.com,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 2/2] [loongson] yeeloong2f: add board specific suspend support
Date:	Wed, 11 Nov 2009 14:52:37 +0800
Message-Id: <839e40163a9833381d7d4a85ea07820496229701.1257922151.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <1368943cd7de052a825f8b23ec730b8546278d1e.1257922151.git.wuzhangjin@gmail.com>
References: <cover.1257920162.git.wuzhangjin@gmail.com>
 <1368943cd7de052a825f8b23ec730b8546278d1e.1257922151.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1257922151.git.wuzhangjin@gmail.com>
References: <cover.1257922151.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

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
