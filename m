Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 01:05:28 +0200 (CEST)
Received: from mail-la0-f46.google.com ([209.85.215.46]:35458 "EHLO
        mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012106AbaJUXDrS-0YZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 01:03:47 +0200
Received: by mail-la0-f46.google.com with SMTP id gi9so1916252lab.5
        for <multiple recipients>; Tue, 21 Oct 2014 16:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cXsiU7JMahVc3xG31Gj0KB6FjTICO0OMvAI/IlzCYtc=;
        b=uXgwfGqbvvIcMTK38jwt0h+HuYHmN2E7qAbGpWjECcWigDHI1wdVu/D1vD4lWnAqc+
         dZ4V3MMsLKB/I1bkp1u3t2ykuEVsej7VU/o5t6RrwrxNxtOEMre/t5BfNgSV/CnRIEoS
         HQVitnnY6QGPZBddT/BXG4J8l2pA2vLqmk9ZHfsaClQfkEHU5TkVni8HukTuaokbF6hr
         nzq1kATA+S+j8JLqoEnuoXmnhe3mfFw0n5b8MdalVdsSyOPSPU7SOJr3Fb33NZq5h7C0
         LBMTow11jd+HQRhXPRG4aieo0GSJKQ+n78joVgehizDmMq/Ai8bQp0/FZxGPjOuWpFvg
         328A==
X-Received: by 10.152.10.143 with SMTP id i15mr38179588lab.5.1413932621910;
        Tue, 21 Oct 2014 16:03:41 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id lk5sm5077133lac.45.2014.10.21.16.03.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 16:03:40 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH v2 06/13] MIPS: ath25: add UART support
Date:   Wed, 22 Oct 2014 03:03:44 +0400
Message-Id: <1413932631-12866-7-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1413932631-12866-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1413932631-12866-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43453
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

Changes since RFC:
  - register UART during arch initialization

Changes since v1:
  - rename MIPS machine ar231x -> ath25

 arch/mips/ath25/ar2315.c  |  6 ++++++
 arch/mips/ath25/ar2315.h  |  2 ++
 arch/mips/ath25/ar5312.c  |  6 ++++++
 arch/mips/ath25/ar5312.h  |  2 ++
 arch/mips/ath25/devices.c | 28 ++++++++++++++++++++++++++++
 arch/mips/ath25/devices.h |  2 ++
 6 files changed, 46 insertions(+)

diff --git a/arch/mips/ath25/ar2315.c b/arch/mips/ath25/ar2315.c
index e1a338b..897f538 100644
--- a/arch/mips/ath25/ar2315.c
+++ b/arch/mips/ath25/ar2315.c
@@ -233,3 +233,9 @@ void __init ar2315_prom_init(void)
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
 
+void __init ar2315_arch_init(void)
+{
+	ath25_serial_setup(AR2315_UART0, ar2315_misc_irq_base +
+			   AR2315_MISC_IRQ_UART0, ar2315_apb_frequency());
+}
+
diff --git a/arch/mips/ath25/ar2315.h b/arch/mips/ath25/ar2315.h
index 2a57858..9af22db 100644
--- a/arch/mips/ath25/ar2315.h
+++ b/arch/mips/ath25/ar2315.h
@@ -7,6 +7,7 @@ void ar2315_arch_init_irq(void);
 void ar2315_plat_time_init(void);
 void ar2315_plat_mem_setup(void);
 void ar2315_prom_init(void);
+void ar2315_arch_init(void);
 
 #else
 
@@ -14,6 +15,7 @@ static inline void ar2315_arch_init_irq(void) {}
 static inline void ar2315_plat_time_init(void) {}
 static inline void ar2315_plat_mem_setup(void) {}
 static inline void ar2315_prom_init(void) {}
+static inline void ar2315_arch_init(void) {}
 
 #endif
 
diff --git a/arch/mips/ath25/ar5312.c b/arch/mips/ath25/ar5312.c
index e9c7f71..ad36aab 100644
--- a/arch/mips/ath25/ar5312.c
+++ b/arch/mips/ath25/ar5312.c
@@ -235,3 +235,9 @@ void __init ar5312_prom_init(void)
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
 
+void __init ar5312_arch_init(void)
+{
+	ath25_serial_setup(AR5312_UART0, ar5312_misc_irq_base +
+			   AR5312_MISC_IRQ_UART0, ar5312_sys_frequency());
+}
+
diff --git a/arch/mips/ath25/ar5312.h b/arch/mips/ath25/ar5312.h
index b60ad38..d04a33d 100644
--- a/arch/mips/ath25/ar5312.h
+++ b/arch/mips/ath25/ar5312.h
@@ -7,6 +7,7 @@ void ar5312_arch_init_irq(void);
 void ar5312_plat_time_init(void);
 void ar5312_plat_mem_setup(void);
 void ar5312_prom_init(void);
+void ar5312_arch_init(void);
 
 #else
 
@@ -14,6 +15,7 @@ static inline void ar5312_arch_init_irq(void) {}
 static inline void ar5312_plat_time_init(void) {}
 static inline void ar5312_plat_mem_setup(void) {}
 static inline void ar5312_prom_init(void) {}
+static inline void ar5312_arch_init(void) {}
 
 #endif
 
diff --git a/arch/mips/ath25/devices.c b/arch/mips/ath25/devices.c
index e30afbc..0416cd2 100644
--- a/arch/mips/ath25/devices.c
+++ b/arch/mips/ath25/devices.c
@@ -1,5 +1,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/serial_8250.h>
 #include <asm/bootinfo.h>
 
 #include "devices.h"
@@ -9,3 +10,30 @@ const char *get_system_type(void)
 	return "Atheros (unknown)";
 }
 
+void __init ath25_serial_setup(u32 mapbase, int irq, unsigned int uartclk)
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
+static int __init ath25_arch_init(void)
+{
+	if (is_ar5312())
+		ar5312_arch_init();
+	else
+		ar2315_arch_init();
+
+	return 0;
+}
+
+arch_initcall(ath25_arch_init);
diff --git a/arch/mips/ath25/devices.h b/arch/mips/ath25/devices.h
index bbf2988..54fafd3 100644
--- a/arch/mips/ath25/devices.h
+++ b/arch/mips/ath25/devices.h
@@ -5,6 +5,8 @@
 
 extern void (*ath25_irq_dispatch)(void);
 
+void ath25_serial_setup(u32 mapbase, int irq, unsigned int uartclk);
+
 static inline bool is_ar2315(void)
 {
 	return (current_cpu_data.cputype == CPU_4KEC);
-- 
1.8.5.5
