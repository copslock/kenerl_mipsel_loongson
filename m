Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 05:57:16 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:14277 "EHLO lemote.com")
	by ftp.linux-mips.org with ESMTP id S20031508AbZDIE4b (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Apr 2009 05:56:31 +0100
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id 7100D3412F;
	Thu,  9 Apr 2009 12:53:32 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4IEB5qETnWGV; Thu,  9 Apr 2009 12:53:26 +0800 (CST)
Received: from [127.0.0.1] (unknown [222.92.8.142])
	by lemote.com (Postfix) with ESMTP id 2C85534129;
	Thu,  9 Apr 2009 12:53:26 +0800 (CST)
Message-ID: <49DD7FF3.20505@lemote.com>
Date:	Thu, 09 Apr 2009 12:56:19 +0800
From:	yanhua <yanh@lemote.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	=?GB2312?B?xe3Bwb31?= <penglj@lemote.com>,
	"zhangfx@lemote.com" <zhangfx@lemote.com>
Subject: [PATCH 5/14] lemote: CS5536 MFGPT as system clock source support
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-Path: <yanh@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22290
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanh@lemote.com
Precedence: bulk
X-list: linux-mips

The cpu count timer should not be used if oprofile and cpufreq are to be
supported. Instead the CS5536' mfgpt is a proper timer alternative
---
arch/mips/lemote/lm2f/Kconfig | 15 +++++++++++----
arch/mips/lemote/lm2f/common/Makefile | 2 +-
arch/mips/lemote/lm2f/common/mfgpt.c | 4 ++--
arch/mips/lemote/lm2f/fuloong/setup.c | 2 +-
arch/mips/lemote/lm2f/yeeloong/setup.c | 2 +-
5 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/mips/lemote/lm2f/Kconfig b/arch/mips/lemote/lm2f/Kconfig
index 25fb9c0..bdf34e5 100644
--- a/arch/mips/lemote/lm2f/Kconfig
+++ b/arch/mips/lemote/lm2f/Kconfig
@@ -6,8 +6,8 @@ choice
config LEMOTE_FULOONG2F
bool "Lemote Fuloong mini-PC"
select ARCH_SPARSEMEM_ENABLE
- select CEVT_R4K
- select CSRC_R4K
+ select CEVT_R4K if ! CS5536_MFGPT
+ select CSRC_R4K if ! CS5536_MFGPT
select SYS_HAS_CPU_LOONGSON2
select DMA_NONCOHERENT
select BOOT_ELF32
@@ -31,8 +31,8 @@ config LEMOTE_FULOONG2F
config LEMOTE_YEELOONG2F
bool "Lemote Yeloong2F mini Notebook"
select ARCH_SPARSEMEM_ENABLE
- select CEVT_R4K
- select CSRC_R4K
+ select CEVT_R4K if ! CS5536_MFGPT
+ select CSRC_R4K if ! CS5536_MFGPT
select SYS_HAS_CPU_LOONGSON2
select DMA_NONCOHERENT
select BOOT_ELF32
@@ -62,6 +62,13 @@ config CS5536
bool
select CS5536_RTC_BUG

+config CS5536_MFGPT
+ bool "Using cs5536's MFGPT as system clock"
+ depends on CS5536
+ help
+ This is needed if cpufreq and oprofile should be enabled in
+ Loongson2(F) machines
+
config LEMOTE_NAS
bool "Lemote NAS machine"
depends on LEMOTE_FULOONG2F
diff --git a/arch/mips/lemote/lm2f/common/Makefile
b/arch/mips/lemote/lm2f/common/Makefile
index d13d2e8..765874a 100644
--- a/arch/mips/lemote/lm2f/common/Makefile
+++ b/arch/mips/lemote/lm2f/common/Makefile
@@ -5,5 +5,5 @@
# Makefile for the loongson2f CPUS, generic files
#

-obj-y += mem.o mipsdha.o pci.o mem.o plat.o
+obj-y += mem.o mipsdha.o pci.o mem.o plat.o mfgpt.o
obj-$(CONFIG_CS5536) += cs5536_vsm.o
diff --git a/arch/mips/lemote/lm2f/common/mfgpt.c
b/arch/mips/lemote/lm2f/common/mfgpt.c
index e62a7fd..2179b86 100644
--- a/arch/mips/lemote/lm2f/common/mfgpt.c
+++ b/arch/mips/lemote/lm2f/common/mfgpt.c
@@ -147,7 +147,7 @@ void __init setup_mfgpt_timer(void)
struct clock_event_device *cd = &mfgpt_clockevent;
unsigned int cpu = smp_processor_id();

- cd->cpumask = cpumask_of_cpu(cpu);
+ cd->cpumask = cpumask_of(cpu);
clockevent_set_clock(cd, MFGFT_TICK_RATE);
cd->max_delta_ns = clockevent_delta2ns(0xFFFF, cd);
cd->min_delta_ns = clockevent_delta2ns(0xF, cd);
@@ -218,5 +218,5 @@ int __init init_mfgpt_clocksource(void)
clocksource_mfgpt.mult = clocksource_hz2mult(MFGFT_TICK_RATE, 22);
return clocksource_register(&clocksource_mfgpt);
}
-/* Too late for kernel calc delay */
+/* too late to calc delay */
//arch_initcall(init_mfgpt_clocksource);
diff --git a/arch/mips/lemote/lm2f/fuloong/setup.c
b/arch/mips/lemote/lm2f/fuloong/setup.c
index e0c393e..e6590f4 100644
--- a/arch/mips/lemote/lm2f/fuloong/setup.c
+++ b/arch/mips/lemote/lm2f/fuloong/setup.c
@@ -60,7 +60,7 @@ void __init plat_time_init(void)
/* setup mips r4k timer */
mips_hpt_frequency = cpu_clock_freq / 2;

-#ifdef CONFIG_LS2F_CPU_FREQ
+#ifdef CONFIG_CS5536_MFGPT
init_mfgpt_clocksource();
#endif
}
diff --git a/arch/mips/lemote/lm2f/yeeloong/setup.c
b/arch/mips/lemote/lm2f/yeeloong/setup.c
index 33c422c..815a42a 100644
--- a/arch/mips/lemote/lm2f/yeeloong/setup.c
+++ b/arch/mips/lemote/lm2f/yeeloong/setup.c
@@ -60,7 +60,7 @@ void __init plat_time_init(void)
/* setup mips r4k timer */
mips_hpt_frequency = cpu_clock_freq / 2;

-#ifdef CONFIG_LS2F_CPU_FREQ
+#ifdef CONFIG_CS5536_MFGPT
init_mfgpt_clocksource();
#endif
}
-- 
1.5.6.5
