Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2012 10:14:05 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:53092 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903396Ab2FOIMv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2012 10:12:51 +0200
Received: by dadm1 with SMTP id m1so3729829dad.36
        for <multiple recipients>; Fri, 15 Jun 2012 01:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=RrNcsFKxQCs3734YgLByWyQWf5b/c7r388SmWUN5kLA=;
        b=HUn92F7oBJnR9ETojRcxqe/hT5hjyiZOtbJMlj/oZ6/34LBimRZZQKAwMTVGrmsSK3
         iUQ8yonZS8dUlhTaR5HjgxJxw0KXcD8iBiUXnrgprAMzWTSPWO3eNZU2KrH5MP4gfdzZ
         VzSKUmhHjBd0hq5xF7AYf4eYKkYS+CO8zdcxMeenQ/IT2XrZ0S+WzIjGEX8A3pX3WKXm
         irSiXGcylAqlvFCaqJVKX0gzLJRqL74PK9iLquQU6L5gksUgFAe43L5sRNFpsV4kE/+i
         OBXsNUVPaISl+89rh94JVB3+lG2XfRgJez33h4aYnFFWFAX/8v8DZqAuU77VTJ7giPZK
         PuRg==
Received: by 10.68.197.198 with SMTP id iw6mr16981442pbc.36.1339747964716;
        Fri, 15 Jun 2012 01:12:44 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id nh8sm12437247pbc.60.2012.06.15.01.12.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jun 2012 01:12:43 -0700 (PDT)
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH 07/14] MIPS: Loongson 3: Add serial port support.
Date:   Fri, 15 Jun 2012 16:09:54 +0800
Message-Id: <1339747801-28691-8-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
X-archive-position: 33645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
---
 arch/mips/include/asm/mach-loongson/loongson.h |    3 ++
 arch/mips/loongson/common/serial.c             |   27 ++++++++++++++++++++++++
 arch/mips/loongson/common/uart_base.c          |    5 ++++
 3 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index fe7d9a6..16d0924 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -125,6 +125,9 @@ static inline void do_perfcnt_IRQ(void)
 #define LOONGSON_PCICONFIGBASE	0x00
 #define LOONGSON_REGBASE	0x100
 
+/* Loongson-3A cpu uart */
+#define LOONGSON_UART_BASE 0x1fe001e0
+
 /* PCI Configuration Registers */
 
 #define LOONGSON_PCI_REG(x)	LOONGSON_REG(LOONGSON_PCICONFIGBASE + (x))
diff --git a/arch/mips/loongson/common/serial.c b/arch/mips/loongson/common/serial.c
index 7580873..6bfe9dd 100644
--- a/arch/mips/loongson/common/serial.c
+++ b/arch/mips/loongson/common/serial.c
@@ -47,6 +47,33 @@ static struct plat_serial8250_port uart8250_data[][2] = {
 	[MACH_DEXXON_GDIUM2F10]         {PORT_M(3), {} },
 	[MACH_LEMOTE_NAS]               {PORT_M(3), {} },
 	[MACH_LEMOTE_LL2F]              {PORT(3), {} },
+	[MACH_LEMOTE_A1004]             {
+						{
+							.irq		= MIPS_CPU_IRQ_BASE + 2,
+							.uartclk	= 33177600,
+							.iotype		= UPIO_MEM,
+							.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+						},
+						{}
+					},
+	[MACH_LEMOTE_A1101]             {
+						{
+							.irq		= MIPS_CPU_IRQ_BASE + 2,
+							.uartclk	= 25000000,
+							.iotype		= UPIO_MEM,
+							.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+						},
+						{}
+					},
+	[MACH_LEMOTE_A1205]             {
+						{
+							.irq		= MIPS_CPU_IRQ_BASE + 2,
+							.uartclk	= 25000000,
+							.iotype		= UPIO_MEM,
+							.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+						},
+						{}
+					},
 	[MACH_LOONGSON_END]             {},
 };
 
diff --git a/arch/mips/loongson/common/uart_base.c b/arch/mips/loongson/common/uart_base.c
index d69ea54..ca86c07 100644
--- a/arch/mips/loongson/common/uart_base.c
+++ b/arch/mips/loongson/common/uart_base.c
@@ -30,6 +30,11 @@ void prom_init_loongson_uart_base(void)
 	case MACH_LEMOTE_LL2F:
 		loongson_uart_base = LOONGSON_PCIIO_BASE + 0x2f8;
 		break;
+	case MACH_LEMOTE_A1004:
+	case MACH_LEMOTE_A1101:
+	case MACH_LEMOTE_A1205:
+		loongson_uart_base = LOONGSON_UART_BASE;
+		break;
 	case MACH_LEMOTE_ML2F7:
 	case MACH_LEMOTE_YL2F89:
 	case MACH_DEXXON_GDIUM2F10:
-- 
1.7.7.3
