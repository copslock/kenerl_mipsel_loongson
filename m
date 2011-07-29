Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jul 2011 10:37:59 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:38491 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491017Ab1G2Ih1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Jul 2011 10:37:27 +0200
Received: by fxd20 with SMTP id 20so2661831fxd.36
        for <multiple recipients>; Fri, 29 Jul 2011 01:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8N/PxHIJ/dEQz2I0JCEo/p7oWUwLh/LVJxGc6C5gRIs=;
        b=GyjD5lk7kwltg1Cr4mDXXU3727nDTYDo6a/Qw1DOYMZB/MUkL3gwzwxS4hXi/CMPld
         6Luh5sz6fefL5cBHprNgsWKQ3G1+an/o2gbV5mGLuDIqwafn/hylG52ENlbzuqoIQlbr
         2nYGknUxd+0iRMuC8N6b/fnt+gZHsRTl7uTXE=
Received: by 10.223.161.74 with SMTP id q10mr1437123fax.117.1311928641609;
        Fri, 29 Jul 2011 01:37:21 -0700 (PDT)
Received: from localhost.localdomain (178-191-3-196.adsl.highway.telekom.at [178.191.3.196])
        by mx.google.com with ESMTPS id q5sm955747fah.30.2011.07.29.01.37.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Jul 2011 01:37:20 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [RFC PATCH 1/2] MIPS: add option to get rid of plat_irq_dispatch
Date:   Fri, 29 Jul 2011 10:37:15 +0200
Message-Id: <1311928636-18854-2-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1311928636-18854-1-git-send-email-manuel.lauss@googlemail.com>
References: <1311928636-18854-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 30764
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21490

On MIPS, platforms need to implement their own dispatcher, which
is a globally visible function (bad).  For the traditional 8 MIPS
interrupts an irq_chip already exists and is registered on most
platforms.  This patch allows platforms to selectively get rid of
the plat_irq_dispatch function and instead register their custom
IRQ controllers as chained handlers for one or more of the MIPS
interrupts.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/Kconfig          |    3 +++
 arch/mips/kernel/genex.S   |    4 ++++
 arch/mips/kernel/irq_cpu.c |    7 +++++++
 3 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 177cdaf..43d9d7f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -955,6 +955,9 @@ config SYNC_R4K
 config MIPS_MACHINE
 	def_bool n
 
+config MIPS_NO_PLAT_IRQ_DISPATCH
+	def_bool n
+
 config NO_IOPORT
 	def_bool n
 
diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 8882e57..d8bdb65 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -202,7 +202,11 @@ NESTED(handle_int, PT_SIZE, sp)
 	LONG_L	s0, TI_REGS($28)
 	LONG_S	sp, TI_REGS($28)
 	PTR_LA	ra, ret_from_irq
+#ifdef CONFIG_MIPS_NO_PLAT_IRQ_DISPATCH
+	j	mips_irq_dispatch
+#else
 	j	plat_irq_dispatch
+#endif
 	END(handle_int)
 
 	__INIT
diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
index 191eb52..73f1dd4 100644
--- a/arch/mips/kernel/irq_cpu.c
+++ b/arch/mips/kernel/irq_cpu.c
@@ -37,6 +37,13 @@
 #include <asm/mipsmtregs.h>
 #include <asm/system.h>
 
+/* I wish I could inline this function directly into genex.S' handle_int */
+void mips_irq_dispatch(void)
+{
+	unsigned long c = (read_c0_cause() & read_c0_status()) >> 8;
+	do_IRQ(MIPS_CPU_IRQ_BASE + __ffs(c & 0xff));
+}
+
 static inline void unmask_mips_irq(struct irq_data *d)
 {
 	set_c0_status(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
-- 
1.7.6
