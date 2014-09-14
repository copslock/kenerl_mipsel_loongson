Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Sep 2014 21:33:34 +0200 (CEST)
Received: from mail-lb0-f173.google.com ([209.85.217.173]:47447 "EHLO
        mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008891AbaINTbzeuEHe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 14 Sep 2014 21:31:55 +0200
Received: by mail-lb0-f173.google.com with SMTP id w7so3406194lbi.18
        for <multiple recipients>; Sun, 14 Sep 2014 12:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9R3Hladz4qD7K01y3w4YvGoJs5sVwgailHj1BiJJyVc=;
        b=G+oDDHh7zPHdHsCJpJgMlXOzOQG51ixAi0d4X+GGaC7TjzRd/S9KlNOP5/m9p3E/1F
         dNDgrPvzB/0+ebMi9ACRJBSnzIE2udpUeXYnMpu9m91H/CZxQ5Rlemxs3E2oWzr1tALM
         CKEnPHQy71B6VHYvW94t5xr/pC5gOmTfsr58dpOm03ToKlHXzuf3i9/e5Z06XpwqqKCI
         nZJ0aRjDS6TzpTKuhJakSWLFhyVfGyluQlacm0r/Yj3Ou0CXJSqOFkvmvWr5WxNXn1JC
         fy/LB7EACgV1g3q+Kr5JI9ucNDmTLUHXAt+8ajpWrmsEFZYhc9N3W+bfIiKYTqaXSgAI
         CKEg==
X-Received: by 10.152.28.74 with SMTP id z10mr24006126lag.10.1410723110217;
        Sun, 14 Sep 2014 12:31:50 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id y5sm3339621laa.20.2014.09.14.12.31.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Sep 2014 12:31:49 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [RFC 06/18] MIPS: ar231x: add UART support
Date:   Sun, 14 Sep 2014 23:33:21 +0400
Message-Id: <1410723213-22440-7-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 arch/mips/ar231x/ar2315.c  |  4 ++++
 arch/mips/ar231x/ar5312.c  |  4 ++++
 arch/mips/ar231x/devices.c | 17 +++++++++++++++++
 arch/mips/ar231x/devices.h |  2 ++
 4 files changed, 27 insertions(+)

diff --git a/arch/mips/ar231x/ar2315.c b/arch/mips/ar231x/ar2315.c
index e64aa16..94bab76 100644
--- a/arch/mips/ar231x/ar2315.c
+++ b/arch/mips/ar231x/ar2315.c
@@ -53,6 +53,8 @@ static void ar2315_misc_irq_handler(unsigned irq, struct irq_desc *desc)
 		generic_handle_irq(AR2315_MISC_IRQ_TIMER);
 	else if (pending & AR2315_ISR_AHB)
 		generic_handle_irq(AR2315_MISC_IRQ_AHB);
+	else if (pending & AR2315_ISR_UART0)
+		generic_handle_irq(AR2315_MISC_IRQ_UART0);
 	else
 		spurious_interrupt();
 }
@@ -207,6 +209,8 @@ void __init ar2315_plat_mem_setup(void)
 	ar231x_write_reg(AR2315_WDC, AR2315_WDC_IGNORE_EXPIRATION);
 
 	_machine_restart = ar2315_restart;
+	ar231x_serial_setup(AR2315_UART0, AR2315_MISC_IRQ_UART0,
+			    ar2315_apb_frequency());
 }
 
 void __init ar2315_prom_init(void)
diff --git a/arch/mips/ar231x/ar5312.c b/arch/mips/ar231x/ar5312.c
index c3abb13..35f7c71 100644
--- a/arch/mips/ar231x/ar5312.c
+++ b/arch/mips/ar231x/ar5312.c
@@ -55,6 +55,8 @@ static void ar5312_misc_irq_handler(unsigned irq, struct irq_desc *desc)
 		(void)ar231x_read_reg(AR5312_TIMER);
 	} else if (pending & AR5312_ISR_AHBPROC)
 		generic_handle_irq(AR5312_MISC_IRQ_AHB_PROC);
+	else if ((pending & AR5312_ISR_UART0))
+		generic_handle_irq(AR5312_MISC_IRQ_UART0);
 	else if (pending & AR5312_ISR_WD)
 		generic_handle_irq(AR5312_MISC_IRQ_WATCHDOG);
 	else
@@ -211,6 +213,8 @@ void __init ar5312_plat_mem_setup(void)
 	ar231x_write_reg(AR5312_WD_CTRL, AR5312_WD_CTRL_IGNORE_EXPIRATION);
 
 	_machine_restart = ar5312_restart;
+	ar231x_serial_setup(AR5312_UART0, AR5312_MISC_IRQ_UART0,
+			    ar5312_sys_frequency());
 }
 
 void __init ar5312_prom_init(void)
diff --git a/arch/mips/ar231x/devices.c b/arch/mips/ar231x/devices.c
index f71a643..3d650bb 100644
--- a/arch/mips/ar231x/devices.c
+++ b/arch/mips/ar231x/devices.c
@@ -1,5 +1,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/serial_8250.h>
 #include <asm/bootinfo.h>
 
 #include "devices.h"
@@ -18,3 +19,19 @@ const char *get_system_type(void)
 	return devtype_strings[ar231x_devtype];
 }
 
+void __init ar231x_serial_setup(u32 mapbase, int irq, unsigned int uartclk)
+{
+	struct uart_port s;
+
+	memset(&s, 0, sizeof(s));
+
+	s.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP;
+	s.iotype = UPIO_MEM32;
+	s.irq = irq;
+	s.regshift = 2;
+	s.mapbase = mapbase;
+	s.uartclk = uartclk;
+
+	early_serial_setup(&s);
+}
+
diff --git a/arch/mips/ar231x/devices.h b/arch/mips/ar231x/devices.h
index 82fa6fb..9f83150 100644
--- a/arch/mips/ar231x/devices.h
+++ b/arch/mips/ar231x/devices.h
@@ -10,6 +10,8 @@ enum {
 extern int ar231x_devtype;
 extern void (*ar231x_irq_dispatch)(void);
 
+void ar231x_serial_setup(u32 mapbase, int irq, unsigned int uartclk);
+
 static inline bool is_2315(void)
 {
 	return (current_cpu_data.cputype == CPU_4KEC);
-- 
1.8.1.5
