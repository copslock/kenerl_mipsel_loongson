Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jun 2011 21:47:52 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:47038 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491847Ab1FATrZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Jun 2011 21:47:25 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p51JlWj1010125;
        Wed, 1 Jun 2011 20:47:32 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p51JlWJL010124;
        Wed, 1 Jun 2011 20:47:32 +0100
Message-Id: <20110601180610.295501825@duck.linux-mips.net>
User-Agent: quilt/0.48-1
Date:   Wed, 01 Jun 2011 19:05:00 +0100
From:   ralf@linux-mips.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     linux-mips@linux-mips.org
Subject: [patch 04/14] i8253: Make MIPS use the shared i8253_lock.
References: <20110601180456.801265664@duck.linux-mips.net>
Content-Disposition: inline; filename=i8253-move-mips-to-shared-lock.patch
X-archive-position: 30180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1160

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org

 arch/mips/Kconfig        |    1 +
 arch/mips/kernel/i8253.c |    3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

Index: linux-mips/arch/mips/Kconfig
===================================================================
--- linux-mips.orig/arch/mips/Kconfig
+++ linux-mips/arch/mips/Kconfig
@@ -2388,6 +2388,7 @@ config MMU
 config I8253
 	bool
 	select CLKSRC_I8253
+	select I8253_LOCK
 	select MIPS_EXTERNAL_TIMER
 
 config ZONE_DMA32
Index: linux-mips/arch/mips/kernel/i8253.c
===================================================================
--- linux-mips.orig/arch/mips/kernel/i8253.c
+++ linux-mips/arch/mips/kernel/i8253.c
@@ -16,9 +16,6 @@
 #include <asm/io.h>
 #include <asm/time.h>
 
-DEFINE_RAW_SPINLOCK(i8253_lock);
-EXPORT_SYMBOL(i8253_lock);
-
 /*
  * Initialize the PIT timer.
  *
