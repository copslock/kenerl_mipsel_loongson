Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Nov 2004 15:15:11 +0000 (GMT)
Received: from mo01.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:33762 "EHLO
	mo01.iij4u.or.jp") by linux-mips.org with ESMTP id <S8224902AbUKQPPF>;
	Wed, 17 Nov 2004 15:15:05 +0000
Received: MO(mo01)id iAHFF10F027114; Thu, 18 Nov 2004 00:15:01 +0900 (JST)
Received: MDO(mdo01) id iAHFF1EH002743; Thu, 18 Nov 2004 00:15:01 +0900 (JST)
Received: 4UMRO01 id iAHFF0Ta023773; Thu, 18 Nov 2004 00:15:00 +0900 (JST)
	from stratos (localhost [127.0.0.1]) (authenticated)
Date: Thu, 18 Nov 2004 00:14:58 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] Add cpu_wait() for NEC VR41xx
Message-Id: <20041118001458.25f845ce.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch had added cpu_wait() for NEC VR41xx.
Please apply this patch to v2.6 CVS tree.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff b-orig/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
--- b-orig/arch/mips/kernel/cpu-probe.c	Sun Oct 31 21:49:07 2004
+++ b/arch/mips/kernel/cpu-probe.c	Wed Nov 17 22:51:36 2004
@@ -85,11 +85,9 @@
 	case CPU_R3081:
 	case CPU_R3081E:
 		cpu_wait = r3081_wait;
-		printk(" available.\n");
 		break;
 	case CPU_TX3927:
 		cpu_wait = r39xx_wait;
-		printk(" available.\n");
 		break;
 	case CPU_R4200:
 /*	case CPU_R4300: */
@@ -110,7 +108,6 @@
 	case CPU_24K:
 	case CPU_25KF:
 		cpu_wait = r4k_wait;
-		printk(" available.\n");
 		break;
 #ifdef CONFIG_PM
 	case CPU_AU1000:
@@ -118,17 +115,19 @@
 	case CPU_AU1500:
 		if (au1k_wait_ptr != NULL) {
 			cpu_wait = au1k_wait_ptr;
-			printk(" available.\n");
 		}
 		else {
-			printk(" unavailable.\n");
 		}
 		break;
 #endif
 	default:
-		printk(" unavailable.\n");
 		break;
 	}
+
+	if (cpu_wait)
+		printk(" available.\n");
+	else
+		printk(" unavailable.\n");
 }
 
 void __init check_bugs32(void)
diff -urN -X dontdiff b-orig/arch/mips/vr41xx/common/pmu.c b/arch/mips/vr41xx/common/pmu.c
--- b-orig/arch/mips/vr41xx/common/pmu.c	Thu May 27 02:11:11 2004
+++ b/arch/mips/vr41xx/common/pmu.c	Wed Nov 17 22:58:09 2004
@@ -22,6 +22,7 @@
 #include <linux/types.h>
 
 #include <asm/cpu.h>
+#include <asm/cpu-features.h>
 #include <asm/io.h>
 #include <asm/reboot.h>
 #include <asm/system.h>
@@ -29,6 +30,17 @@
 #define PMUCNT2REG	KSEG1ADDR(0x0f0000c6)
  #define SOFTRST	0x0010
 
+static void vr41xx_cpu_wait(void)
+{
+	__asm__ __volatile__(
+		".set\tmips3\n\t"
+		"standby\n\t"
+		"nop\n\t"
+		"nop\n\t"
+		"nop\n\t"
+		".set\tmips0");
+}
+
 static inline void software_reset(void)
 {
 	uint16_t val;
@@ -70,6 +82,8 @@
 
 static int __init vr41xx_pmu_init(void)
 {
+	cpu_wait = vr41xx_cpu_wait;
+
 	_machine_restart = vr41xx_restart;
 	_machine_halt = vr41xx_halt;
 	_machine_power_off = vr41xx_power_off;
diff -urN -X dontdiff b-orig/include/asm-mips/cpu-features.h b/include/asm-mips/cpu-features.h
--- b-orig/include/asm-mips/cpu-features.h	Tue Aug 17 21:07:18 2004
+++ b/include/asm-mips/cpu-features.h	Wed Nov 17 22:57:04 2004
@@ -124,4 +124,6 @@
 #define cpu_scache_line_size()	current_cpu_data.scache.linesz
 #endif
 
+extern void (*cpu_wait)(void);
+
 #endif /* __ASM_CPU_FEATURES_H */
