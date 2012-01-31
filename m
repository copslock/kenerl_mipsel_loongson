Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 18:22:44 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:57815 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904035Ab2AaRTb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jan 2012 18:19:31 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id BADAA44848A;
        Tue, 31 Jan 2012 18:19:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7bQ3S6AnhIeE; Tue, 31 Jan 2012 18:19:30 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 3299F448957;
        Tue, 31 Jan 2012 18:19:30 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 6/6] MIPS: loongson: use IS_ENABLED()
Date:   Tue, 31 Jan 2012 18:19:08 +0100
Message-Id: <1328030348-21967-7-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1328030348-21967-1-git-send-email-florian@openwrt.org>
References: <1328030348-21967-1-git-send-email-florian@openwrt.org>
X-archive-position: 32374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/include/asm/mach-loongson/loongson.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index 1e29b9d..06367c3 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -14,6 +14,7 @@
 #include <linux/io.h>
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <linux/kconfig.h>
 
 /* loongson internal northbridge initialization */
 extern void bonito_irq_init(void);
@@ -66,7 +67,7 @@ extern int mach_i8259_irq(void);
 #include <linux/interrupt.h>
 static inline void do_perfcnt_IRQ(void)
 {
-#if defined(CONFIG_OPROFILE) || defined(CONFIG_OPROFILE_MODULE)
+#if IS_ENABLED(CONFIG_OPROFILE)
 	do_IRQ(LOONGSON2_PERFCNT_IRQ);
 #endif
 }
-- 
1.7.5.4
