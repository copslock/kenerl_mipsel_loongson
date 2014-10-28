Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 00:20:39 +0100 (CET)
Received: from mail-lb0-f173.google.com ([209.85.217.173]:65472 "EHLO
        mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011798AbaJ1XTDcFtuM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 00:19:03 +0100
Received: by mail-lb0-f173.google.com with SMTP id l4so1520888lbv.4
        for <multiple recipients>; Tue, 28 Oct 2014 16:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pOV5K/8iOzWgCxYe1T/dzANRQ+rRttjSsrWzb6RMqo8=;
        b=kllhkGNyP1uEAkZY3hC9Ge8ceJ4XbeeIwn0cuZ6ns9WDrarfQ2Tirx6V/yccCv+6QO
         89FnrdUBmle9OqG+hejfibsDmR4k+6PLCSJWD6nFc6vpbhxP5TDDdSAin4KYzbN0VR/o
         YK6lhJTHJfDGhOHQhmPEZE4zf1Du2cZ0s2a0CBN/QlUhXEnffeTXgldgMSCGwhHYu+yM
         5K9CZz9bMqEtkKbBWMR1cRiWFaeGwCHk38BE98YjaEdQmIRRhHEI6oTlCVEJQl47rK39
         0TPCVrcxwmyhBHNQKsSjsBGZWfzc+EgRijOViqVNw3Iff6tyRGXQYPywacTTGZ6dtdGX
         8k8Q==
X-Received: by 10.112.148.130 with SMTP id ts2mr7401032lbb.43.1414538337980;
        Tue, 28 Oct 2014 16:18:57 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id i6sm1173752laf.47.2014.10.28.16.18.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Oct 2014 16:18:57 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH v3 06/13] MIPS: ath25: add UART support
Date:   Wed, 29 Oct 2014 03:18:43 +0400
Message-Id: <1414538330-5548-7-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1414538330-5548-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1414538330-5548-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43657
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

Changes since v2:
  - add missed include

 arch/mips/ath25/ar2315.c  |  8 ++++++++
 arch/mips/ath25/ar2315.h  |  2 ++
 arch/mips/ath25/ar5312.c  |  8 ++++++++
 arch/mips/ath25/ar5312.h  |  2 ++
 arch/mips/ath25/devices.c | 30 ++++++++++++++++++++++++++++++
 arch/mips/ath25/devices.h |  2 ++
 6 files changed, 52 insertions(+)

diff --git a/arch/mips/ath25/ar2315.c b/arch/mips/ath25/ar2315.c
index d92aa91..d10eac4 100644
--- a/arch/mips/ath25/ar2315.c
+++ b/arch/mips/ath25/ar2315.c
@@ -267,3 +267,11 @@ void __init ar2315_plat_mem_setup(void)
 
 	_machine_restart = ar2315_restart;
 }
+
+void __init ar2315_arch_init(void)
+{
+	unsigned irq = irq_create_mapping(ar2315_misc_irq_domain,
+					  AR2315_MISC_IRQ_UART0);
+
+	ath25_serial_setup(AR2315_UART0_BASE, irq, ar2315_apb_frequency());
+}
diff --git a/arch/mips/ath25/ar2315.h b/arch/mips/ath25/ar2315.h
index da5b843..4af5f4c 100644
--- a/arch/mips/ath25/ar2315.h
+++ b/arch/mips/ath25/ar2315.h
@@ -6,12 +6,14 @@
 void ar2315_arch_init_irq(void);
 void ar2315_plat_time_init(void);
 void ar2315_plat_mem_setup(void);
+void ar2315_arch_init(void);
 
 #else
 
 static inline void ar2315_arch_init_irq(void) {}
 static inline void ar2315_plat_time_init(void) {}
 static inline void ar2315_plat_mem_setup(void) {}
+static inline void ar2315_arch_init(void) {}
 
 #endif
 
diff --git a/arch/mips/ath25/ar5312.c b/arch/mips/ath25/ar5312.c
index b99a02a..398d4fd 100644
--- a/arch/mips/ath25/ar5312.c
+++ b/arch/mips/ath25/ar5312.c
@@ -265,3 +265,11 @@ void __init ar5312_plat_mem_setup(void)
 
 	_machine_restart = ar5312_restart;
 }
+
+void __init ar5312_arch_init(void)
+{
+	unsigned irq = irq_create_mapping(ar5312_misc_irq_domain,
+					  AR5312_MISC_IRQ_UART0);
+
+	ath25_serial_setup(AR5312_UART0_BASE, irq, ar5312_sys_frequency());
+}
diff --git a/arch/mips/ath25/ar5312.h b/arch/mips/ath25/ar5312.h
index 254f04f..86dfc6d 100644
--- a/arch/mips/ath25/ar5312.h
+++ b/arch/mips/ath25/ar5312.h
@@ -6,12 +6,14 @@
 void ar5312_arch_init_irq(void);
 void ar5312_plat_time_init(void);
 void ar5312_plat_mem_setup(void);
+void ar5312_arch_init(void);
 
 #else
 
 static inline void ar5312_arch_init_irq(void) {}
 static inline void ar5312_plat_time_init(void) {}
 static inline void ar5312_plat_mem_setup(void) {}
+static inline void ar5312_arch_init(void) {}
 
 #endif
 
diff --git a/arch/mips/ath25/devices.c b/arch/mips/ath25/devices.c
index e30afbc..400419d 100644
--- a/arch/mips/ath25/devices.c
+++ b/arch/mips/ath25/devices.c
@@ -1,11 +1,41 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/serial_8250.h>
 #include <asm/bootinfo.h>
 
 #include "devices.h"
+#include "ar5312.h"
+#include "ar2315.h"
 
 const char *get_system_type(void)
 {
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
index 2985586..23b53cb 100644
--- a/arch/mips/ath25/devices.h
+++ b/arch/mips/ath25/devices.h
@@ -9,6 +9,8 @@
 
 extern void (*ath25_irq_dispatch)(void);
 
+void ath25_serial_setup(u32 mapbase, int irq, unsigned int uartclk);
+
 static inline bool is_ar2315(void)
 {
 	return (current_cpu_data.cputype == CPU_4KEC);
-- 
1.8.5.5
