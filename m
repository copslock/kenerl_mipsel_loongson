Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jun 2011 21:49:12 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:47080 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491852Ab1FATrf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Jun 2011 21:47:35 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p51JlVXp010116;
        Wed, 1 Jun 2011 20:47:31 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p51JlUpY010114;
        Wed, 1 Jun 2011 20:47:30 +0100
Message-Id: <20110601180610.134151920@duck.linux-mips.net>
User-Agent: quilt/0.48-1
Date:   Wed, 01 Jun 2011 19:04:58 +0100
From:   ralf@linux-mips.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org
Subject: [patch 02/14] i8253: Unify all kernel declarations of i8253_lock in <linux/i8253.h>.
References: <20110601180456.801265664@duck.linux-mips.net>
Content-Disposition: inline; filename=i8253-move-common-declarations-to-new-header.patch
X-archive-position: 30183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1177

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
To: linux-kernel@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mips@linux-mips.org

 arch/arm/include/asm/i8253.h  |    9 ---------
 arch/mips/include/asm/i8253.h |   12 ------------
 arch/x86/include/asm/i8253.h  |   10 ----------
 include/linux/i8253.h         |   14 ++++++++++++++
 4 files changed, 14 insertions(+), 31 deletions(-)

Index: linux-mips/include/linux/i8253.h
===================================================================
--- linux-mips.orig/include/linux/i8253.h
+++ linux-mips/include/linux/i8253.h
@@ -2,10 +2,24 @@
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
+ *
+ *  Machine specific IO port address definition for generic.
+ *  Written by Osamu Tomita <tomita@cinet.co.jp>
  */
 #ifndef __LINUX_I8253_H
 #define __LINUX_I8253_H
 
+#include <linux/spinlock.h>
 #include <asm/i8253.h>
 
+/* i8253A PIT registers */
+#define PIT_MODE	0x43
+#define PIT_CH0		0x40
+#define PIT_CH2		0x42
+
+#define inb_pit         inb_p
+#define outb_pit        outb_p
+
+extern raw_spinlock_t i8253_lock;
+
 #endif /* __LINUX_I8253_H */
Index: linux-mips/arch/arm/include/asm/i8253.h
===================================================================
--- linux-mips.orig/arch/arm/include/asm/i8253.h
+++ linux-mips/arch/arm/include/asm/i8253.h
@@ -1,15 +1,6 @@
 #ifndef __ASMARM_I8253_H
 #define __ASMARM_I8253_H
 
-/* i8253A PIT registers */
-#define PIT_MODE	0x43
-#define PIT_CH0		0x40
-
 #define PIT_LATCH	((PIT_TICK_RATE + HZ / 2) / HZ)
 
-extern raw_spinlock_t i8253_lock;
-
-#define outb_pit	outb_p
-#define inb_pit		inb_p
-
 #endif
Index: linux-mips/arch/mips/include/asm/i8253.h
===================================================================
--- linux-mips.orig/arch/mips/include/asm/i8253.h
+++ linux-mips/arch/mips/include/asm/i8253.h
@@ -5,20 +5,8 @@
 #ifndef __ASM_I8253_H
 #define __ASM_I8253_H
 
-#include <linux/spinlock.h>
-
-/* i8253A PIT registers */
-#define PIT_MODE		0x43
-#define PIT_CH0			0x40
-#define PIT_CH2			0x42
-
 #define PIT_LATCH		LATCH
 
-extern raw_spinlock_t i8253_lock;
-
 extern void setup_pit_timer(void);
 
-#define inb_pit inb_p
-#define outb_pit outb_p
-
 #endif /* __ASM_I8253_H */
Index: linux-mips/arch/x86/include/asm/i8253.h
===================================================================
--- linux-mips.orig/arch/x86/include/asm/i8253.h
+++ linux-mips/arch/x86/include/asm/i8253.h
@@ -1,20 +1,10 @@
 #ifndef _ASM_X86_I8253_H
 #define _ASM_X86_I8253_H
 
-/* i8253A PIT registers */
-#define PIT_MODE		0x43
-#define PIT_CH0			0x40
-#define PIT_CH2			0x42
-
 #define PIT_LATCH	LATCH
 
-extern raw_spinlock_t i8253_lock;
-
 extern struct clock_event_device *global_clock_event;
 
 extern void setup_pit_timer(void);
 
-#define inb_pit		inb_p
-#define outb_pit	outb_p
-
 #endif /* _ASM_X86_I8253_H */
