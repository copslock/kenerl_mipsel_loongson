Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Dec 2016 15:59:36 +0100 (CET)
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32935 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993120AbcLDO733H0Vr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 4 Dec 2016 15:59:29 +0100
Received: by mail-pg0-f66.google.com with SMTP id 3so13552198pgd.0;
        Sun, 04 Dec 2016 06:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=o7kP9c7CXDpKrxmaLeMuchdr7ORAnSEAFttEZuD09jc=;
        b=RJR0x1sejcd9Oq5J11+8dfN0+rZDVdJA+O5ENIICr2I8ixmsRPhN/nI1pSlf6P+YcH
         2EkDH1vUfN8lyuNb2npIKwzOTKFJaxtIG9JmmRkv/QdKU+IOHnYdfl7l807D9nNhTCs1
         NFjUiQH9uS5/srW8lJTZ3EaYlByTQVzG0F7kz8CVPQghJ0aoAEah8JlY0t6yIb38vjY+
         7GsRhV7JO4SNvP2v/7BZkBfBDVyenlxf31nwucI5yrpX1NnqkdS26Gy4EZsSyxbfBVAh
         zkfMPyfNgvKQ5kKZtbX2Mv4Yzfkd2b+KOiaRp56UjyzEok9kewWocy3AdWnCxAkThB1x
         2vUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=o7kP9c7CXDpKrxmaLeMuchdr7ORAnSEAFttEZuD09jc=;
        b=b1nWwL7Ek6hMP28qcwy1Q/dx4K7BKN6qo9f4LxkoFLADwov+WSzvcgHmGR7X+wWkps
         E0dXByH7OKWbmXkyJi87xxemo+eGLBm7wU6gHb50c2IdtlsEIYVh8Nz+d4PXCA1MNK4E
         M/cVnySESY48kPudrCVrkPWfOEH6q73+5ctx+8Wc9jgEdqDFDME8XZ6PrBKdGG8MGXv3
         kxpeyNz2XZXBrTg14kxXj6vhM4wf1GyMh7FgGn3DyN2fh2R8RAsI1pqyWbKpiox4nl4u
         H5+q1XDzfMEFp6C8PbjVip4QHhf5zPvIji1/i4lnVxHed6Cp94j6u//gimr2sfH4KeZS
         A45g==
X-Gm-Message-State: AKaTC02antx+Q5PCONzm0pNrOVzVkHjFAbWbUm7fqWbUTXEaw5wmJGXgdMC2cJdp57eFiA==
X-Received: by 10.84.209.173 with SMTP id y42mr113587004plh.94.1480863561365;
        Sun, 04 Dec 2016 06:59:21 -0800 (PST)
Received: from ubuntu (ec2-52-77-214-225.ap-southeast-1.compute.amazonaws.com. [52.77.214.225])
        by smtp.gmail.com with ESMTPSA id w17sm20962735pgm.18.2016.12.04.06.57.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 04 Dec 2016 06:59:20 -0800 (PST)
Date:   Sun, 4 Dec 2016 22:57:03 +0800
From:   Yang Ling <gnaygnil@gmail.com>
To:     keguang.zhang@gmail.com, ralf@linux-mips.org
Cc:     gnaygnil@gmail.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2.3 1/3] MIPS: loongson1: Remove several redundant
 RTC-related macros
Message-ID: <20161204145703.GA29649@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gnaygnil@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnaygnil@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Move the RTC-related macros to regs-rtc.h.

Signed-off-by: Yang Ling <gnaygnil@gmail.com>

---
V2.3:
  Remove the wide character.
V2.1~2.2:
  No change.
V2.0:
  Add the header file regs-rtc.h in loongson1.h.
---
 arch/mips/include/asm/mach-loongson32/loongson1.h |  7 +++---
 arch/mips/include/asm/mach-loongson32/regs-rtc.h  | 23 +++++++++++++++++++
 arch/mips/loongson32/common/platform.c            | 27 +++++++++--------------
 3 files changed, 38 insertions(+), 19 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson32/regs-rtc.h

diff --git a/arch/mips/include/asm/mach-loongson32/loongson1.h b/arch/mips/include/asm/mach-loongson32/loongson1.h
index 3584c40..30bffcd 100644
--- a/arch/mips/include/asm/mach-loongson32/loongson1.h
+++ b/arch/mips/include/asm/mach-loongson32/loongson1.h
@@ -3,9 +3,9 @@
  *
  * Register mappings for Loongson 1
  *
- * This program is free software; you can redistribute	it and/or modify it
- * under  the terms of	the GNU General	 Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
  * option) any later version.
  */
 
@@ -52,6 +52,7 @@
 #include <regs-clk.h>
 #include <regs-mux.h>
 #include <regs-pwm.h>
+#include <regs-rtc.h>
 #include <regs-wdt.h>
 
 #endif /* __ASM_MACH_LOONGSON32_LOONGSON1_H */
diff --git a/arch/mips/include/asm/mach-loongson32/regs-rtc.h b/arch/mips/include/asm/mach-loongson32/regs-rtc.h
new file mode 100644
index 0000000..e67fda2
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson32/regs-rtc.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (c) 2016 Yang Ling <gnaygnil@gmail.com>
+ *
+ * Loongson 1 RTC timer Register Definitions.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __ASM_MACH_LOONGSON32_REGS_RTC_H
+#define __ASM_MACH_LOONGSON32_REGS_RTC_H
+
+#define LS1X_RTC_REG(x) \
+		((void __iomem *)KSEG1ADDR(LS1X_RTC_BASE + (x)))
+
+#define LS1X_RTC_CTRL	LS1X_RTC_REG(0x40)
+
+#define RTC_EXTCLK_OK	(BIT(5) | BIT(8))
+#define RTC_EXTCLK_EN	BIT(8)
+
+#endif /* __ASM_MACH_LOONGSON32_REGS_RTC_H */
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index beff085..18c2959 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -1,9 +1,9 @@
 /*
  * Copyright (c) 2011-2016 Zhang, Keguang <keguang.zhang@gmail.com>
  *
- * This program is free software; you can redistribute	it and/or modify it
- * under  the terms of	the GNU General	 Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
  * option) any later version.
  */
 
@@ -23,10 +23,6 @@
 #include <dma.h>
 #include <nand.h>
 
-#define LS1X_RTC_CTRL	((void __iomem *)KSEG1ADDR(LS1X_RTC_BASE + 0x40))
-#define RTC_EXTCLK_OK	(BIT(5) | BIT(8))
-#define RTC_EXTCLK_EN	BIT(8)
-
 /* 8250/16550 compatible UART */
 #define LS1X_UART(_id)						\
 	{							\
@@ -70,15 +66,6 @@ void __init ls1x_serial_set_uartclk(struct platform_device *pdev)
 		p->uartclk = clk_get_rate(clk);
 }
 
-void __init ls1x_rtc_set_extclk(struct platform_device *pdev)
-{
-	u32 val;
-
-	val = __raw_readl(LS1X_RTC_CTRL);
-	if (!(val & RTC_EXTCLK_OK))
-		__raw_writel(val | RTC_EXTCLK_EN, LS1X_RTC_CTRL);
-}
-
 /* CPUFreq */
 static struct plat_ls1x_cpufreq ls1x_cpufreq_pdata = {
 	.clk_name	= "cpu_clk",
@@ -357,6 +344,14 @@ struct platform_device ls1x_ehci_pdev = {
 };
 
 /* Real Time Clock */
+void __init ls1x_rtc_set_extclk(struct platform_device *pdev)
+{
+	u32 val = __raw_readl(LS1X_RTC_CTRL);
+
+	if (!(val & RTC_EXTCLK_OK))
+		__raw_writel(val | RTC_EXTCLK_EN, LS1X_RTC_CTRL);
+}
+
 struct platform_device ls1x_rtc_pdev = {
 	.name		= "ls1x-rtc",
 	.id		= -1,
-- 
1.9.1
