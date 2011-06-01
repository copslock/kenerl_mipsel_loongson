Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jun 2011 21:50:00 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:47094 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491854Ab1FATrh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Jun 2011 21:47:37 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p51Jlbl8010158;
        Wed, 1 Jun 2011 20:47:37 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p51JlbEB010157;
        Wed, 1 Jun 2011 20:47:37 +0100
Message-Id: <20110601180610.832810002@duck.linux-mips.net>
User-Agent: quilt/0.48-1
Date:   Wed, 01 Jun 2011 19:05:07 +0100
From:   ralf@linux-mips.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org
Subject: [patch 11/14] i8253: Consolidate definitions of PIT_LATCH
References: <20110601180456.801265664@duck.linux-mips.net>
Content-Disposition: inline; filename=i8253-sort-out-pit_latch-definitions.patch
X-archive-position: 30185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1187

x86 defines PIT_LATCH as LATCH which in <linux/timex.h> is defined as
((CLOCK_TICK_RATE + HZ/2) / HZ) and <asm/timex.h> again defines
CLOCK_TICK_RATE as PIT_TICK_RATE.

MIPS defines PIT_LATCH as LATCH which in <linux/timex.h> is defined as
((CLOCK_TICK_RATE + HZ/2) / HZ) and <asm/timex.h> again defines
CLOCK_TICK_RATE as 1193182.

ARM defines PITCH_LATCH as ((PIT_TICK_RATE + HZ / 2) / HZ) - and that's
the sanest thing and equivalent to above definitions so use that as the
new definition in <linux/i8253.h>.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
To: linux-kernel@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mips@linux-mips.org

 arch/arm/include/asm/i8253.h  |    2 --
 arch/mips/include/asm/i8253.h |    2 --
 arch/x86/include/asm/i8253.h  |    2 --
 include/linux/i8253.h         |    4 ++++
 4 files changed, 4 insertions(+), 6 deletions(-)

Index: linux-mips/arch/arm/include/asm/i8253.h
===================================================================
--- linux-mips.orig/arch/arm/include/asm/i8253.h
+++ linux-mips/arch/arm/include/asm/i8253.h
@@ -1,6 +1,4 @@
 #ifndef __ASMARM_I8253_H
 #define __ASMARM_I8253_H
 
-#define PIT_LATCH	((PIT_TICK_RATE + HZ / 2) / HZ)
-
 #endif
Index: linux-mips/arch/mips/include/asm/i8253.h
===================================================================
--- linux-mips.orig/arch/mips/include/asm/i8253.h
+++ linux-mips/arch/mips/include/asm/i8253.h
@@ -5,8 +5,6 @@
 #ifndef __ASM_I8253_H
 #define __ASM_I8253_H
 
-#define PIT_LATCH		LATCH
-
 extern void setup_pit_timer(void);
 
 #endif /* __ASM_I8253_H */
Index: linux-mips/arch/x86/include/asm/i8253.h
===================================================================
--- linux-mips.orig/arch/x86/include/asm/i8253.h
+++ linux-mips/arch/x86/include/asm/i8253.h
@@ -1,8 +1,6 @@
 #ifndef _ASM_X86_I8253_H
 #define _ASM_X86_I8253_H
 
-#define PIT_LATCH	LATCH
-
 extern void setup_pit_timer(void);
 
 #endif /* _ASM_X86_I8253_H */
Index: linux-mips/include/linux/i8253.h
===================================================================
--- linux-mips.orig/include/linux/i8253.h
+++ linux-mips/include/linux/i8253.h
@@ -9,7 +9,9 @@
 #ifndef __LINUX_I8253_H
 #define __LINUX_I8253_H
 
+#include <linux/param.h>
 #include <linux/spinlock.h>
+#include <linux/timex.h>
 #include <asm/i8253.h>
 
 /* i8253A PIT registers */
@@ -17,6 +19,8 @@
 #define PIT_CH0		0x40
 #define PIT_CH2		0x42
 
+#define PIT_LATCH	((PIT_TICK_RATE + HZ/2) / HZ)
+
 #define inb_pit         inb_p
 #define outb_pit        outb_p
 
