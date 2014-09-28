Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Sep 2014 20:32:54 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:36722 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010012AbaI1SbPNswgi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Sep 2014 20:31:15 +0200
Received: by mail-lb0-f177.google.com with SMTP id w7so21230lbi.36
        for <multiple recipients>; Sun, 28 Sep 2014 11:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5NuIkTSQw4Wgs7HUP6gozMLDySVye6binwUFkiJaUWk=;
        b=0iFvWHQf4jkiWTkThgmt+yKVCrbbvpEENCG7b21S4BwkXtYnp2uYTqoEPyp3b3W6i5
         nvsvg5GwJusCraf5uaL/LfzOwMSJ1qy/Bq2PciXP1IqMSh6HeeRCU/oPBAXNlP/EW16/
         i/qhWTJBqof++hJrl12dGnoVTwnvISWL2mBLqPceqISm8hLw9ZZOdxiYzWs1KFvGmGpd
         mMEAG9EVz7ED+WiwWiMcexnmvzyF4GDx3iTJD9fDt1XTdOWV7lxhRBLIQfsw1S3PphS/
         UB1LVaLDU/CNf2DwwgAAecNUwvVniqPt79ObDuLSDx1g/cDsjHg0hJRoI6Bp/j2lwsNg
         9qcw==
X-Received: by 10.152.43.201 with SMTP id y9mr34995692lal.54.1411929069852;
        Sun, 28 Sep 2014 11:31:09 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id je9sm581674lbc.3.2014.09.28.11.31.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Sep 2014 11:31:09 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH 06/16] MIPS: ar231x: add UART support
Date:   Sun, 28 Sep 2014 22:33:05 +0400
Message-Id: <1411929195-23775-7-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42857
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

 arch/mips/ar231x/ar2315.c  |  9 +++++++++
 arch/mips/ar231x/ar2315.h  |  2 ++
 arch/mips/ar231x/ar5312.c  |  9 +++++++++
 arch/mips/ar231x/ar5312.h  |  2 ++
 arch/mips/ar231x/devices.c | 25 +++++++++++++++++++++++++
 arch/mips/ar231x/devices.h |  2 ++
 6 files changed, 49 insertions(+)

diff --git a/arch/mips/ar231x/ar2315.c b/arch/mips/ar231x/ar2315.c
index 320893a..3d21a25a 100644
--- a/arch/mips/ar231x/ar2315.c
+++ b/arch/mips/ar231x/ar2315.c
@@ -245,3 +245,12 @@ void __init ar2315_prom_init(void)
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
 
+void __init ar2315_arch_init(void)
+{
+	if (!is_2315())
+		return;
+
+	ar231x_serial_setup(AR2315_UART0, ar2315_misc_irq_base +
+			    AR2315_MISC_IRQ_UART0, ar2315_apb_frequency());
+}
+
diff --git a/arch/mips/ar231x/ar2315.h b/arch/mips/ar231x/ar2315.h
index 2a57858..9af22db 100644
--- a/arch/mips/ar231x/ar2315.h
+++ b/arch/mips/ar231x/ar2315.h
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
 
diff --git a/arch/mips/ar231x/ar5312.c b/arch/mips/ar231x/ar5312.c
index 3f81d33..138d7e1 100644
--- a/arch/mips/ar231x/ar5312.c
+++ b/arch/mips/ar231x/ar5312.c
@@ -247,3 +247,12 @@ void __init ar5312_prom_init(void)
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
 
+void __init ar5312_arch_init(void)
+{
+	if (!is_5312())
+		return;
+
+	ar231x_serial_setup(AR5312_UART0, ar5312_misc_irq_base +
+			    AR5312_MISC_IRQ_UART0, ar5312_sys_frequency());
+}
+
diff --git a/arch/mips/ar231x/ar5312.h b/arch/mips/ar231x/ar5312.h
index b60ad38..d04a33d 100644
--- a/arch/mips/ar231x/ar5312.h
+++ b/arch/mips/ar231x/ar5312.h
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
 
diff --git a/arch/mips/ar231x/devices.c b/arch/mips/ar231x/devices.c
index f71a643..85caae4 100644
--- a/arch/mips/ar231x/devices.c
+++ b/arch/mips/ar231x/devices.c
@@ -1,5 +1,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/serial_8250.h>
 #include <asm/bootinfo.h>
 
 #include "devices.h"
@@ -18,3 +19,27 @@ const char *get_system_type(void)
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
+static int __init ar231x_arch_init(void)
+{
+	ar5312_arch_init();
+	ar2315_arch_init();
+	return 0;
+}
+
+arch_initcall(ar231x_arch_init);
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
1.8.5.5
