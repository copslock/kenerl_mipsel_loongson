Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Sep 2016 12:02:13 +0200 (CEST)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34900 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991940AbcI0KCHFXQmv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Sep 2016 12:02:07 +0200
Received: by mail-pa0-f68.google.com with SMTP id j3so515424paj.2;
        Tue, 27 Sep 2016 03:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=mvL2/nEOInYwCciHXOtvT52Tr05ZVVqoU3w5ozFy9G4=;
        b=bfIMIhF7goxCOvbFsz3BWmXG0AeAKK59O9Qjt83qai+QBDngVPLGBrEmGoTjnJNNAR
         vRQYU1klVCHk7JD8bIGVtR6NaCUrvfylu1eC+x1uus4h8BQSjpVATooHYKdMLuyzmJ19
         0BJAyav2eKQh8NNCpZjj7kjTM93bIvQv7P0buqcSYWXUe0/JxfE9fchR/xnjujIJE6JP
         lbhsGKpznoTFnUHDmoA8WHIVSKVgwNFA/tz9qtMBId9WHwtIys0X698Dzqu3O1RDrqVK
         xvPlY6gPB1kD8dHheVeQigipYNEFw8ghQswpgeglXvFk/0UnDz9cx66ks1sojYgouG/C
         jc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=mvL2/nEOInYwCciHXOtvT52Tr05ZVVqoU3w5ozFy9G4=;
        b=JhfnOdWvIwfPLK01vT8Za7cndHTOdjiy+5WYrTffH+rNFHke3ML0Lc+hwoDCJp8JOu
         jg4JaGyCANzl5BjZ7MkgxCoYMOY8b2dHyb2i22MLOw281sOmIKsdcx3W+QazvXm2hKsE
         qbsMdAKJsOULnr/mA5VmnzPzX/8qMLJgIPLM72mCtb0E5d0hvP0CUIYIGKrWX69oH6jj
         dHgPVgYiYnrGqI9HXL+WmZZabn3f1ra8c+SEt1xye3n6vniIkElb341JcJBJcWVcC9br
         Fn4zZaEeAnPylcuwrFAe35ZXuxc4OcmeoF36dHtsRFfnr6Wtyw/78J/crDpdMurQw5Uq
         5klw==
X-Gm-Message-State: AA6/9RlNZyunUaqEpqvMf93wSbWqPnTAgVwn4nH7oT+mZRguqjS4W4n/j/SESQ5j6uwHUA==
X-Received: by 10.66.173.145 with SMTP id bk17mr6718192pac.8.1474970519407;
        Tue, 27 Sep 2016 03:01:59 -0700 (PDT)
Received: from ly-pc (ec2-52-77-214-225.ap-southeast-1.compute.amazonaws.com. [52.77.214.225])
        by smtp.gmail.com with ESMTPSA id o123sm3474448pfg.78.2016.09.27.03.01.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Sep 2016 03:01:58 -0700 (PDT)
Date:   Tue, 27 Sep 2016 18:01:44 +0800
From:   Yang Ling <gnaygnil@gmail.com>
To:     keguang.zhang@gmail.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        gnaygnil@gmail.com
Subject: [PATCH] MIPS: loongson32: Remove several RTC-related macros
Message-ID: <20160927100130.GA23768@ly-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gnaygnil@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55268
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

Add regs-rtc.h to replace the macros of redundancy.

Signed-off-by: Yang Ling <gnaygnil@gmail.com>
---
 arch/mips/include/asm/mach-loongson32/regs-rtc.h | 23 +++++++++++++++++++++++
 arch/mips/loongson32/common/platform.c           | 23 ++++++++++-------------
 2 files changed, 33 insertions(+), 13 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson32/regs-rtc.h

diff --git a/arch/mips/include/asm/mach-loongson32/regs-rtc.h b/arch/mips/include/asm/mach-loongson32/regs-rtc.h
new file mode 100644
index 0000000..1fe724b
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson32/regs-rtc.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (c) 2016 Yang Ling <gnaygnil@gmail.com>
+ *
+ * Loongson 1 RTC timer Register Definitions.
+ *
+ * This program is free software; you can redistribute	it and/or modify it
+ * under  the terms of	the GNU General	 Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
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
index beff085..193a84d 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -22,10 +22,7 @@
 #include <cpufreq.h>
 #include <dma.h>
 #include <nand.h>
-
-#define LS1X_RTC_CTRL	((void __iomem *)KSEG1ADDR(LS1X_RTC_BASE + 0x40))
-#define RTC_EXTCLK_OK	(BIT(5) | BIT(8))
-#define RTC_EXTCLK_EN	BIT(8)
+#include <regs-rtc.h>
 
 /* 8250/16550 compatible UART */
 #define LS1X_UART(_id)						\
@@ -70,15 +67,6 @@ void __init ls1x_serial_set_uartclk(struct platform_device *pdev)
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
@@ -357,6 +345,15 @@ struct platform_device ls1x_ehci_pdev = {
 };
 
 /* Real Time Clock */
+void __init ls1x_rtc_set_extclk(struct platform_device *pdev)
+{
+	u32 val;
+
+	val = __raw_readl(LS1X_RTC_CTRL);
+	if (!(val & RTC_EXTCLK_OK))
+		__raw_writel(val | RTC_EXTCLK_EN, LS1X_RTC_CTRL);
+}
+
 struct platform_device ls1x_rtc_pdev = {
 	.name		= "ls1x-rtc",
 	.id		= -1,
-- 
1.9.1
