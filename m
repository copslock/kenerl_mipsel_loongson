Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Oct 2009 08:19:58 +0200 (CEST)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:35523 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493054AbZJPGSF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 16 Oct 2009 08:18:05 +0200
Received: by pzk32 with SMTP id 32so1795126pzk.21
        for <multiple recipients>; Thu, 15 Oct 2009 23:17:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=Om0akuLIZqUOkk021/AKD6AhzRE7QLkq7dpxw9JdDDk=;
        b=n7u4beLzI5Xhbfo0aJlupbhBkaIMxpYaesdJFVNvf0NiGCfJI/RXFT7osltgSSduoG
         azP6C76Nf+fWK5Y7EjsjGQZqAxJ8ERzzBxxlesuWaLIcAeDvZ9TDmEk1lQ/B7aWl8nvr
         DL3YQ/2GwiI7KJoz9Yg4YHUd/UbE7p/sN0T5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=w5YmRcmClnt/g3WTej6KbACjrOt02zQHntfZLmd62flFC+3uuFEWbGrIE0h2gghdpq
         4eT3o8YHRezRLAfm2d8ohdnMN6zZDRP8Gbc6pqO7wZImNRxoLD1klQPjx8ChxOhFmrcX
         BRlchV6AqM0UOXPQVLAbcQaTvOjOC/oNs1s8o=
Received: by 10.114.237.19 with SMTP id k19mr1232102wah.69.1255673874684;
        Thu, 15 Oct 2009 23:17:54 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm591698pzk.3.2009.10.15.23.17.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Oct 2009 23:17:52 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, yanh@lemote.com,
	huhb@lemote.com, Zhang Le <r0bertz@gentoo.org>, zhangfx@lemote.com,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 4/7] [loongosn] add a new serial port debug function
Date:	Fri, 16 Oct 2009 14:17:17 +0800
Message-Id: <fa536e7b25f41bf1ed1a1e203de389bb970e8174.1255673756.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <d771bbf1f97c456c8e845adfe2c0c05065f68d39.1255673756.git.wuzhangjin@gmail.com>
References: <cover.1255672832.git.wuzhangjin@gmail.com>
 <83f0ebe8e34e5da49d0cb3487a7ef53f4edd69af.1255673756.git.wuzhangjin@gmail.com>
 <c709487f102bcd028fd637f5692ff42d94c55b33.1255673756.git.wuzhangjin@gmail.com>
 <d771bbf1f97c456c8e845adfe2c0c05065f68d39.1255673756.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1255673756.git.wuzhangjin@gmail.com>
References: <cover.1255673756.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

There is an existing serial port debug function: prom_putchar(), but it
can only print one char, herein add a new prom_printf(), which works
like printk, but print to serial port, which is very important to kernel
debugging.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/mach-loongson/dbg.h |   17 ++++++++++++++
 arch/mips/loongson/common/Makefile        |    2 +-
 arch/mips/loongson/common/dbg.c           |   34 +++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson/dbg.h
 create mode 100644 arch/mips/loongson/common/dbg.c

diff --git a/arch/mips/include/asm/mach-loongson/dbg.h b/arch/mips/include/asm/mach-loongson/dbg.h
new file mode 100644
index 0000000..c676f8e
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson/dbg.h
@@ -0,0 +1,17 @@
+/*
+ * Copyright (C) 2009 Lemote Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef _ASM_MACH_LOONGSON_DBG_H_
+#define _ASM_MACH_LOONGSON_DBG_H_
+
+/* serial port print support */
+extern void prom_putchar(char c);
+extern void prom_printf(char *fmt, ...);
+
+#endif /* _ASM_MACH_LOONGSON_DBG_H_ */
diff --git a/arch/mips/loongson/common/Makefile b/arch/mips/loongson/common/Makefile
index 656b3cc..adbe85c 100644
--- a/arch/mips/loongson/common/Makefile
+++ b/arch/mips/loongson/common/Makefile
@@ -8,4 +8,4 @@ obj-y += setup.o init.o cmdline.o env.o time.o reset.o irq.o \
 #
 # Early printk support
 #
-obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
+obj-$(CONFIG_EARLY_PRINTK) += early_printk.o dbg.o
diff --git a/arch/mips/loongson/common/dbg.c b/arch/mips/loongson/common/dbg.c
new file mode 100644
index 0000000..214f295
--- /dev/null
+++ b/arch/mips/loongson/common/dbg.c
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) 2009 Lemote Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <dbg.h>
+#include <loongson.h>
+
+#define PROM_PRINTF_BUF_LEN 1024
+
+void prom_printf(char *fmt, ...)
+{
+	static char buf[PROM_PRINTF_BUF_LEN];
+	va_list args;
+	char *ptr;
+
+
+	va_start(args, fmt);
+	vscnprintf(buf, sizeof(buf), fmt, args);
+
+	ptr = buf;
+
+	while (*ptr != 0) {
+		if (*ptr == '\n')
+			prom_putchar('\r');
+
+		prom_putchar(*ptr++);
+	}
+	va_end(args);
+}
-- 
1.6.2.1
