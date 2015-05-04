Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 May 2015 11:20:54 +0200 (CEST)
Received: from smtpbgbr1.qq.com ([54.207.19.206]:33315 "EHLO smtpbgbr1.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011129AbbEDJU03Ivn9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 May 2015 11:20:26 +0200
X-QQ-mid: bizesmtp3t1430731184t287t090
Received: from localhost.localdomain (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Mon, 04 May 2015 17:19:43 +0800 (CST)
X-QQ-SSF: 01100000002000F0FJ52000A0000000
X-QQ-FEAT: tZ7SKDDlSpHXqbBuCKSoeofCxglBmU4Dm0YRaZKEflhHXzsEIT7hdc3SG/qo4
        8JoHDZwk5kasea4Y3u5MG89YyUKFbZ6fKxOjiIdj7sHBqFstxaaTF4JddtBnhfdMrwBgRCt
        YtpdSjmYKENAtNMMAE0tbIq6hDOnXGvAPebcdJ8LScIIXIAQu3E/1AplKWyzBkmAJP7Svge
        w3WdW1wWBlV2ziXEgLjGbBL/wUHypJags6RTuoUYE6Q==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 1/4] MIPS: Loongson: Naming style cleanup and rework
Date:   Mon,  4 May 2015 17:19:08 +0800
Message-Id: <1430731151-4808-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1430731151-4808-1-git-send-email-chenhc@lemote.com>
References: <1430731151-4808-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Currently, code of Loongson-2/3 is under loongson directory and code of
Loongson-1 is under loongson1 directory. Besides, there are Kconfig
options such as MACH_LOONGSON and MACH_LOONGSON1. This naming style is
very ugly and confusing. Since Loongson-2/3 are both 64-bit general-
purpose CPU while Loongson-1 is 32-bit SoC, we rename both file names
and Kconfig symbols from loongson/loongson1 to loongson64/loongson32.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/Kbuild.platforms                         |    4 +-
 arch/mips/Kconfig                                  |   34 ++++++++++---------
 arch/mips/boot/compressed/uart-16550.c             |    2 +-
 arch/mips/configs/fuloong2e_defconfig              |    2 +-
 arch/mips/configs/lemote2f_defconfig               |    2 +-
 arch/mips/configs/loongson3_defconfig              |    2 +-
 arch/mips/configs/ls1b_defconfig                   |    2 +-
 arch/mips/include/asm/mach-loongson/workarounds.h  |    7 ----
 .../{mach-loongson1 => mach-loongson32}/cpufreq.h  |    6 ++--
 .../asm/{mach-loongson1 => mach-loongson32}/irq.h  |    6 ++--
 .../loongson1.h                                    |    6 ++--
 .../{mach-loongson1 => mach-loongson32}/platform.h |    6 ++--
 .../asm/{mach-loongson1 => mach-loongson32}/prom.h |    6 ++--
 .../{mach-loongson1 => mach-loongson32}/regs-clk.h |    6 ++--
 .../{mach-loongson1 => mach-loongson32}/regs-mux.h |    6 ++--
 .../{mach-loongson1 => mach-loongson32}/regs-pwm.h |    6 ++--
 .../{mach-loongson1 => mach-loongson32}/regs-wdt.h |    6 ++--
 .../boot_param.h                                   |    4 +-
 .../cpu-feature-overrides.h                        |    6 ++--
 .../cs5536/cs5536.h                                |    0
 .../cs5536/cs5536_mfgpt.h                          |    0
 .../cs5536/cs5536_pci.h                            |    0
 .../cs5536/cs5536_vsm.h                            |    0
 .../dma-coherence.h                                |    6 ++--
 .../asm/{mach-loongson => mach-loongson64}/gpio.h  |    0
 .../asm/{mach-loongson => mach-loongson64}/irq.h   |    6 ++--
 .../kernel-entry-init.h                            |    6 ++--
 .../{mach-loongson => mach-loongson64}/loongson.h  |    6 ++--
 .../loongson_hwmon.h                               |    0
 .../{mach-loongson => mach-loongson64}/machine.h   |    6 ++--
 .../mc146818rtc.h                                  |    6 ++--
 .../asm/{mach-loongson => mach-loongson64}/mem.h   |    6 ++--
 .../{mach-loongson => mach-loongson64}/mmzone.h    |    0
 .../asm/{mach-loongson => mach-loongson64}/pci.h   |    6 ++--
 .../{mach-loongson => mach-loongson64}/spaces.h    |    4 +-
 .../{mach-loongson => mach-loongson64}/topology.h  |    0
 .../mips/include/asm/mach-loongson64/workarounds.h |    7 ++++
 arch/mips/{loongson1 => loongson32}/Kconfig        |    4 +-
 arch/mips/{loongson1 => loongson32}/Makefile       |    2 +-
 arch/mips/{loongson1 => loongson32}/Platform       |    4 +-
 .../mips/{loongson1 => loongson32}/common/Makefile |    0
 arch/mips/{loongson1 => loongson32}/common/irq.c   |    0
 .../{loongson1 => loongson32}/common/platform.c    |    0
 arch/mips/{loongson1 => loongson32}/common/prom.c  |    0
 arch/mips/{loongson1 => loongson32}/common/reset.c |    0
 arch/mips/{loongson1 => loongson32}/common/setup.c |    0
 arch/mips/{loongson1 => loongson32}/common/time.c  |    0
 arch/mips/{loongson1 => loongson32}/ls1b/Makefile  |    0
 arch/mips/{loongson1 => loongson32}/ls1b/board.c   |    0
 arch/mips/{loongson => loongson64}/Kconfig         |    4 +-
 arch/mips/{loongson => loongson64}/Makefile        |    2 +-
 arch/mips/{loongson => loongson64}/Platform        |    4 +-
 arch/mips/{loongson => loongson64}/common/Makefile |    0
 .../{loongson => loongson64}/common/bonito-irq.c   |    0
 .../mips/{loongson => loongson64}/common/cmdline.c |    0
 .../common/cs5536/Makefile                         |    0
 .../common/cs5536/cs5536_acc.c                     |    0
 .../common/cs5536/cs5536_ehci.c                    |    0
 .../common/cs5536/cs5536_ide.c                     |    0
 .../common/cs5536/cs5536_isa.c                     |    0
 .../common/cs5536/cs5536_mfgpt.c                   |    0
 .../common/cs5536/cs5536_ohci.c                    |    0
 .../common/cs5536/cs5536_pci.c                     |    0
 .../{loongson => loongson64}/common/dma-swiotlb.c  |    0
 .../{loongson => loongson64}/common/early_printk.c |    0
 arch/mips/{loongson => loongson64}/common/env.c    |    0
 arch/mips/{loongson => loongson64}/common/gpio.c   |    0
 arch/mips/{loongson => loongson64}/common/init.c   |    0
 arch/mips/{loongson => loongson64}/common/irq.c    |    0
 .../{loongson => loongson64}/common/machtype.c     |    0
 arch/mips/{loongson => loongson64}/common/mem.c    |    0
 arch/mips/{loongson => loongson64}/common/pci.c    |    0
 .../{loongson => loongson64}/common/platform.c     |    0
 arch/mips/{loongson => loongson64}/common/pm.c     |    0
 arch/mips/{loongson => loongson64}/common/reset.c  |    0
 arch/mips/{loongson => loongson64}/common/rtc.c    |    0
 arch/mips/{loongson => loongson64}/common/serial.c |    0
 arch/mips/{loongson => loongson64}/common/setup.c  |    0
 arch/mips/{loongson => loongson64}/common/time.c   |    0
 .../{loongson => loongson64}/common/uart_base.c    |    0
 .../{loongson => loongson64}/fuloong-2e/Makefile   |    0
 .../mips/{loongson => loongson64}/fuloong-2e/irq.c |    0
 .../{loongson => loongson64}/fuloong-2e/reset.c    |    0
 .../{loongson => loongson64}/lemote-2f/Makefile    |    0
 .../{loongson => loongson64}/lemote-2f/clock.c     |    0
 .../lemote-2f/ec_kb3310b.c                         |    0
 .../lemote-2f/ec_kb3310b.h                         |    0
 arch/mips/{loongson => loongson64}/lemote-2f/irq.c |    0
 .../{loongson => loongson64}/lemote-2f/machtype.c  |    0
 arch/mips/{loongson => loongson64}/lemote-2f/pm.c  |    0
 .../{loongson => loongson64}/lemote-2f/reset.c     |    0
 .../{loongson => loongson64}/loongson-3/Makefile   |    0
 .../{loongson => loongson64}/loongson-3/cop2-ex.c  |    0
 .../{loongson => loongson64}/loongson-3/hpet.c     |    0
 .../mips/{loongson => loongson64}/loongson-3/irq.c |    0
 .../{loongson => loongson64}/loongson-3/numa.c     |    0
 .../{loongson => loongson64}/loongson-3/platform.c |    0
 .../mips/{loongson => loongson64}/loongson-3/smp.c |    0
 .../mips/{loongson => loongson64}/loongson-3/smp.h |    0
 drivers/clk/Makefile                               |    2 +-
 drivers/cpufreq/ls1x-cpufreq.c                     |    4 +-
 drivers/rtc/Kconfig                                |    2 +-
 drivers/rtc/rtc-ls1x.c                             |    2 +-
 103 files changed, 105 insertions(+), 103 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-loongson/workarounds.h
 rename arch/mips/include/asm/{mach-loongson1 => mach-loongson32}/cpufreq.h (81%)
 rename arch/mips/include/asm/{mach-loongson1 => mach-loongson32}/irq.h (95%)
 rename arch/mips/include/asm/{mach-loongson1 => mach-loongson32}/loongson1.h (91%)
 rename arch/mips/include/asm/{mach-loongson1 => mach-loongson32}/platform.h (85%)
 rename arch/mips/include/asm/{mach-loongson1 => mach-loongson32}/prom.h (84%)
 rename arch/mips/include/asm/{mach-loongson1 => mach-loongson32}/regs-clk.h (90%)
 rename arch/mips/include/asm/{mach-loongson1 => mach-loongson32}/regs-mux.h (94%)
 rename arch/mips/include/asm/{mach-loongson1 => mach-loongson32}/regs-pwm.h (84%)
 rename arch/mips/include/asm/{mach-loongson1 => mach-loongson32}/regs-wdt.h (77%)
 rename arch/mips/include/asm/{mach-loongson => mach-loongson64}/boot_param.h (98%)
 rename arch/mips/include/asm/{mach-loongson => mach-loongson64}/cpu-feature-overrides.h (90%)
 rename arch/mips/include/asm/{mach-loongson => mach-loongson64}/cs5536/cs5536.h (100%)
 rename arch/mips/include/asm/{mach-loongson => mach-loongson64}/cs5536/cs5536_mfgpt.h (100%)
 rename arch/mips/include/asm/{mach-loongson => mach-loongson64}/cs5536/cs5536_pci.h (100%)
 rename arch/mips/include/asm/{mach-loongson => mach-loongson64}/cs5536/cs5536_vsm.h (100%)
 rename arch/mips/include/asm/{mach-loongson => mach-loongson64}/dma-coherence.h (93%)
 rename arch/mips/include/asm/{mach-loongson => mach-loongson64}/gpio.h (100%)
 rename arch/mips/include/asm/{mach-loongson => mach-loongson64}/irq.h (92%)
 rename arch/mips/include/asm/{mach-loongson => mach-loongson64}/kernel-entry-init.h (88%)
 rename arch/mips/include/asm/{mach-loongson => mach-loongson64}/loongson.h (98%)
 rename arch/mips/include/asm/{mach-loongson => mach-loongson64}/loongson_hwmon.h (100%)
 rename arch/mips/include/asm/{mach-loongson => mach-loongson64}/machine.h (84%)
 rename arch/mips/include/asm/{mach-loongson => mach-loongson64}/mc146818rtc.h (85%)
 rename arch/mips/include/asm/{mach-loongson => mach-loongson64}/mem.h (89%)
 rename arch/mips/include/asm/{mach-loongson => mach-loongson64}/mmzone.h (100%)
 rename arch/mips/include/asm/{mach-loongson => mach-loongson64}/pci.h (93%)
 rename arch/mips/include/asm/{mach-loongson => mach-loongson64}/spaces.h (65%)
 rename arch/mips/include/asm/{mach-loongson => mach-loongson64}/topology.h (100%)
 create mode 100644 arch/mips/include/asm/mach-loongson64/workarounds.h
 rename arch/mips/{loongson1 => loongson32}/Kconfig (96%)
 rename arch/mips/{loongson1 => loongson32}/Makefile (74%)
 rename arch/mips/{loongson1 => loongson32}/Platform (59%)
 rename arch/mips/{loongson1 => loongson32}/common/Makefile (100%)
 rename arch/mips/{loongson1 => loongson32}/common/irq.c (100%)
 rename arch/mips/{loongson1 => loongson32}/common/platform.c (100%)
 rename arch/mips/{loongson1 => loongson32}/common/prom.c (100%)
 rename arch/mips/{loongson1 => loongson32}/common/reset.c (100%)
 rename arch/mips/{loongson1 => loongson32}/common/setup.c (100%)
 rename arch/mips/{loongson1 => loongson32}/common/time.c (100%)
 rename arch/mips/{loongson1 => loongson32}/ls1b/Makefile (100%)
 rename arch/mips/{loongson1 => loongson32}/ls1b/board.c (100%)
 rename arch/mips/{loongson => loongson64}/Kconfig (98%)
 rename arch/mips/{loongson => loongson64}/Makefile (88%)
 rename arch/mips/{loongson => loongson64}/Platform (87%)
 rename arch/mips/{loongson => loongson64}/common/Makefile (100%)
 rename arch/mips/{loongson => loongson64}/common/bonito-irq.c (100%)
 rename arch/mips/{loongson => loongson64}/common/cmdline.c (100%)
 rename arch/mips/{loongson => loongson64}/common/cs5536/Makefile (100%)
 rename arch/mips/{loongson => loongson64}/common/cs5536/cs5536_acc.c (100%)
 rename arch/mips/{loongson => loongson64}/common/cs5536/cs5536_ehci.c (100%)
 rename arch/mips/{loongson => loongson64}/common/cs5536/cs5536_ide.c (100%)
 rename arch/mips/{loongson => loongson64}/common/cs5536/cs5536_isa.c (100%)
 rename arch/mips/{loongson => loongson64}/common/cs5536/cs5536_mfgpt.c (100%)
 rename arch/mips/{loongson => loongson64}/common/cs5536/cs5536_ohci.c (100%)
 rename arch/mips/{loongson => loongson64}/common/cs5536/cs5536_pci.c (100%)
 rename arch/mips/{loongson => loongson64}/common/dma-swiotlb.c (100%)
 rename arch/mips/{loongson => loongson64}/common/early_printk.c (100%)
 rename arch/mips/{loongson => loongson64}/common/env.c (100%)
 rename arch/mips/{loongson => loongson64}/common/gpio.c (100%)
 rename arch/mips/{loongson => loongson64}/common/init.c (100%)
 rename arch/mips/{loongson => loongson64}/common/irq.c (100%)
 rename arch/mips/{loongson => loongson64}/common/machtype.c (100%)
 rename arch/mips/{loongson => loongson64}/common/mem.c (100%)
 rename arch/mips/{loongson => loongson64}/common/pci.c (100%)
 rename arch/mips/{loongson => loongson64}/common/platform.c (100%)
 rename arch/mips/{loongson => loongson64}/common/pm.c (100%)
 rename arch/mips/{loongson => loongson64}/common/reset.c (100%)
 rename arch/mips/{loongson => loongson64}/common/rtc.c (100%)
 rename arch/mips/{loongson => loongson64}/common/serial.c (100%)
 rename arch/mips/{loongson => loongson64}/common/setup.c (100%)
 rename arch/mips/{loongson => loongson64}/common/time.c (100%)
 rename arch/mips/{loongson => loongson64}/common/uart_base.c (100%)
 rename arch/mips/{loongson => loongson64}/fuloong-2e/Makefile (100%)
 rename arch/mips/{loongson => loongson64}/fuloong-2e/irq.c (100%)
 rename arch/mips/{loongson => loongson64}/fuloong-2e/reset.c (100%)
 rename arch/mips/{loongson => loongson64}/lemote-2f/Makefile (100%)
 rename arch/mips/{loongson => loongson64}/lemote-2f/clock.c (100%)
 rename arch/mips/{loongson => loongson64}/lemote-2f/ec_kb3310b.c (100%)
 rename arch/mips/{loongson => loongson64}/lemote-2f/ec_kb3310b.h (100%)
 rename arch/mips/{loongson => loongson64}/lemote-2f/irq.c (100%)
 rename arch/mips/{loongson => loongson64}/lemote-2f/machtype.c (100%)
 rename arch/mips/{loongson => loongson64}/lemote-2f/pm.c (100%)
 rename arch/mips/{loongson => loongson64}/lemote-2f/reset.c (100%)
 rename arch/mips/{loongson => loongson64}/loongson-3/Makefile (100%)
 rename arch/mips/{loongson => loongson64}/loongson-3/cop2-ex.c (100%)
 rename arch/mips/{loongson => loongson64}/loongson-3/hpet.c (100%)
 rename arch/mips/{loongson => loongson64}/loongson-3/irq.c (100%)
 rename arch/mips/{loongson => loongson64}/loongson-3/numa.c (100%)
 rename arch/mips/{loongson => loongson64}/loongson-3/platform.c (100%)
 rename arch/mips/{loongson => loongson64}/loongson-3/smp.c (100%)
 rename arch/mips/{loongson => loongson64}/loongson-3/smp.h (100%)

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index 39cf40d..a424e46 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -15,8 +15,8 @@ platforms += jazz
 platforms += jz4740
 platforms += lantiq
 platforms += lasat
-platforms += loongson
-platforms += loongson1
+platforms += loongson32
+platforms += loongson64
 platforms += mti-malta
 platforms += mti-sead3
 platforms += netlogic
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 1c971be..96d87a0 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -25,7 +25,7 @@ config MIPS
 	select HAVE_SYSCALL_TRACEPOINTS
 	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if CPU_SUPPORTS_HUGEPAGES && 64BIT
-	select RTC_LIB if !MACH_LOONGSON
+	select RTC_LIB if !MACH_LOONGSON64
 	select GENERIC_ATOMIC64 if !64BIT
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select HAVE_DMA_ATTRS
@@ -342,26 +342,28 @@ config LASAT
 	select SYS_SUPPORTS_64BIT_KERNEL if BROKEN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
-config MACH_LOONGSON
-	bool "Loongson family of machines"
+config MACH_LOONGSON32
+	bool "Loongson-1 family of machines"
 	select SYS_SUPPORTS_ZBOOT
 	help
-	  This enables the support of Loongson family of machines.
+	  This enables support for the Loongson-1 family of machines.
 
-	  Loongson is a family of general-purpose MIPS-compatible CPUs.
-	  developed at Institute of Computing Technology (ICT),
-	  Chinese Academy of Sciences (CAS) in the People's Republic
-	  of China. The chief architect is Professor Weiwu Hu.
+	  Loongson-1 is a family of 32-bit MIPS-compatible SoCs developed by
+	  the Institute of Computing Technology (ICT), Chinese Academy of
+	  Sciences (CAS).
 
-config MACH_LOONGSON1
-	bool "Loongson 1 family of machines"
+config MACH_LOONGSON64
+	bool "Loongson-2/3 family of machines"
 	select SYS_SUPPORTS_ZBOOT
 	help
-	  This enables support for the Loongson 1 based machines.
+	  This enables the support of Loongson-2/3 family of machines.
 
-	  Loongson 1 is a family of 32-bit MIPS-compatible SoCs developed by
-	  the ICT (Institute of Computing Technology) and the Chinese Academy
-	  of Sciences.
+	  Loongson-2 is a family of single-core CPUs and Loongson-3 is a
+	  family of multi-core CPUs. They are both 64-bit general-purpose
+	  MIPS-compatible CPUs. Loongson-2/3 are developed by the Institute
+	  of Computing Technology (ICT), Chinese Academy of Sciences (CAS)
+	  in the People's Republic of China. The chief architect is Professor
+	  Weiwu Hu.
 
 config MACH_PISTACHIO
 	bool "IMG Pistachio SoC based boards"
@@ -941,8 +943,8 @@ source "arch/mips/sibyte/Kconfig"
 source "arch/mips/txx9/Kconfig"
 source "arch/mips/vr41xx/Kconfig"
 source "arch/mips/cavium-octeon/Kconfig"
-source "arch/mips/loongson/Kconfig"
-source "arch/mips/loongson1/Kconfig"
+source "arch/mips/loongson32/Kconfig"
+source "arch/mips/loongson64/Kconfig"
 source "arch/mips/netlogic/Kconfig"
 source "arch/mips/paravirt/Kconfig"
 
diff --git a/arch/mips/boot/compressed/uart-16550.c b/arch/mips/boot/compressed/uart-16550.c
index 237494b..408799a 100644
--- a/arch/mips/boot/compressed/uart-16550.c
+++ b/arch/mips/boot/compressed/uart-16550.c
@@ -7,7 +7,7 @@
 
 #include <asm/addrspace.h>
 
-#if defined(CONFIG_MACH_LOONGSON) || defined(CONFIG_MIPS_MALTA)
+#if defined(CONFIG_MACH_LOONGSON64) || defined(CONFIG_MIPS_MALTA)
 #define UART_BASE 0x1fd003f8
 #define PORT(offset) (CKSEG1ADDR(UART_BASE) + (offset))
 #endif
diff --git a/arch/mips/configs/fuloong2e_defconfig b/arch/mips/configs/fuloong2e_defconfig
index 0026806..325e64b 100644
--- a/arch/mips/configs/fuloong2e_defconfig
+++ b/arch/mips/configs/fuloong2e_defconfig
@@ -1,4 +1,4 @@
-CONFIG_MACH_LOONGSON=y
+CONFIG_MACH_LOONGSON64=y
 CONFIG_64BIT=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
diff --git a/arch/mips/configs/lemote2f_defconfig b/arch/mips/configs/lemote2f_defconfig
index e51aad9..9c62986 100644
--- a/arch/mips/configs/lemote2f_defconfig
+++ b/arch/mips/configs/lemote2f_defconfig
@@ -1,4 +1,4 @@
-CONFIG_MACH_LOONGSON=y
+CONFIG_MACH_LOONGSON64=y
 CONFIG_LEMOTE_MACH2F=y
 CONFIG_CS5536_MFGPT=y
 CONFIG_64BIT=y
diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
index 7eabcd2..cf9e056 100644
--- a/arch/mips/configs/loongson3_defconfig
+++ b/arch/mips/configs/loongson3_defconfig
@@ -1,4 +1,4 @@
-CONFIG_MACH_LOONGSON=y
+CONFIG_MACH_LOONGSON64=y
 CONFIG_SWIOTLB=y
 CONFIG_LOONGSON_MACH3X=y
 CONFIG_CPU_LOONGSON3=y
diff --git a/arch/mips/configs/ls1b_defconfig b/arch/mips/configs/ls1b_defconfig
index 7eb7554..1b2cc1f 100644
--- a/arch/mips/configs/ls1b_defconfig
+++ b/arch/mips/configs/ls1b_defconfig
@@ -1,4 +1,4 @@
-CONFIG_MACH_LOONGSON1=y
+CONFIG_MACH_LOONGSON32=y
 CONFIG_PREEMPT=y
 # CONFIG_SECCOMP is not set
 CONFIG_EXPERIMENTAL=y
diff --git a/arch/mips/include/asm/mach-loongson/workarounds.h b/arch/mips/include/asm/mach-loongson/workarounds.h
deleted file mode 100644
index e180c14..0000000
--- a/arch/mips/include/asm/mach-loongson/workarounds.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __ASM_MACH_LOONGSON_WORKAROUNDS_H_
-#define __ASM_MACH_LOONGSON_WORKAROUNDS_H_
-
-#define WORKAROUND_CPUFREQ	0x00000001
-#define WORKAROUND_CPUHOTPLUG	0x00000002
-
-#endif
diff --git a/arch/mips/include/asm/mach-loongson1/cpufreq.h b/arch/mips/include/asm/mach-loongson32/cpufreq.h
similarity index 81%
rename from arch/mips/include/asm/mach-loongson1/cpufreq.h
rename to arch/mips/include/asm/mach-loongson32/cpufreq.h
index e7765ce..6843fa1 100644
--- a/arch/mips/include/asm/mach-loongson1/cpufreq.h
+++ b/arch/mips/include/asm/mach-loongson32/cpufreq.h
@@ -10,8 +10,8 @@
  */
 
 
-#ifndef __ASM_MACH_LOONGSON1_CPUFREQ_H
-#define __ASM_MACH_LOONGSON1_CPUFREQ_H
+#ifndef __ASM_MACH_LOONGSON32_CPUFREQ_H
+#define __ASM_MACH_LOONGSON32_CPUFREQ_H
 
 struct plat_ls1x_cpufreq {
 	const char	*clk_name;	/* CPU clk */
@@ -20,4 +20,4 @@ struct plat_ls1x_cpufreq {
 	unsigned int	min_freq;	/* in kHz */
 };
 
-#endif /* __ASM_MACH_LOONGSON1_CPUFREQ_H */
+#endif /* __ASM_MACH_LOONGSON32_CPUFREQ_H */
diff --git a/arch/mips/include/asm/mach-loongson1/irq.h b/arch/mips/include/asm/mach-loongson32/irq.h
similarity index 95%
rename from arch/mips/include/asm/mach-loongson1/irq.h
rename to arch/mips/include/asm/mach-loongson32/irq.h
index 96bfb1c..0d35b99 100644
--- a/arch/mips/include/asm/mach-loongson1/irq.h
+++ b/arch/mips/include/asm/mach-loongson32/irq.h
@@ -10,8 +10,8 @@
  */
 
 
-#ifndef __ASM_MACH_LOONGSON1_IRQ_H
-#define __ASM_MACH_LOONGSON1_IRQ_H
+#ifndef __ASM_MACH_LOONGSON32_IRQ_H
+#define __ASM_MACH_LOONGSON32_IRQ_H
 
 /*
  * CPU core Interrupt Numbers
@@ -70,4 +70,4 @@
 
 #define NR_IRQS			(MIPS_CPU_IRQS + LS1X_IRQS)
 
-#endif /* __ASM_MACH_LOONGSON1_IRQ_H */
+#endif /* __ASM_MACH_LOONGSON32_IRQ_H */
diff --git a/arch/mips/include/asm/mach-loongson1/loongson1.h b/arch/mips/include/asm/mach-loongson32/loongson1.h
similarity index 91%
rename from arch/mips/include/asm/mach-loongson1/loongson1.h
rename to arch/mips/include/asm/mach-loongson32/loongson1.h
index 20e0c2b..12aa129 100644
--- a/arch/mips/include/asm/mach-loongson1/loongson1.h
+++ b/arch/mips/include/asm/mach-loongson32/loongson1.h
@@ -10,8 +10,8 @@
  */
 
 
-#ifndef __ASM_MACH_LOONGSON1_LOONGSON1_H
-#define __ASM_MACH_LOONGSON1_LOONGSON1_H
+#ifndef __ASM_MACH_LOONGSON32_LOONGSON1_H
+#define __ASM_MACH_LOONGSON32_LOONGSON1_H
 
 #define DEFAULT_MEMSIZE			256	/* If no memsize provided */
 
@@ -47,4 +47,4 @@
 #include <regs-pwm.h>
 #include <regs-wdt.h>
 
-#endif /* __ASM_MACH_LOONGSON1_LOONGSON1_H */
+#endif /* __ASM_MACH_LOONGSON32_LOONGSON1_H */
diff --git a/arch/mips/include/asm/mach-loongson1/platform.h b/arch/mips/include/asm/mach-loongson32/platform.h
similarity index 85%
rename from arch/mips/include/asm/mach-loongson1/platform.h
rename to arch/mips/include/asm/mach-loongson32/platform.h
index 47de55e..c32f03f 100644
--- a/arch/mips/include/asm/mach-loongson1/platform.h
+++ b/arch/mips/include/asm/mach-loongson32/platform.h
@@ -8,8 +8,8 @@
  */
 
 
-#ifndef __ASM_MACH_LOONGSON1_PLATFORM_H
-#define __ASM_MACH_LOONGSON1_PLATFORM_H
+#ifndef __ASM_MACH_LOONGSON32_PLATFORM_H
+#define __ASM_MACH_LOONGSON32_PLATFORM_H
 
 #include <linux/platform_device.h>
 
@@ -23,4 +23,4 @@ extern struct platform_device ls1x_rtc_pdev;
 extern void __init ls1x_clk_init(void);
 extern void __init ls1x_serial_setup(struct platform_device *pdev);
 
-#endif /* __ASM_MACH_LOONGSON1_PLATFORM_H */
+#endif /* __ASM_MACH_LOONGSON32_PLATFORM_H */
diff --git a/arch/mips/include/asm/mach-loongson1/prom.h b/arch/mips/include/asm/mach-loongson32/prom.h
similarity index 84%
rename from arch/mips/include/asm/mach-loongson1/prom.h
rename to arch/mips/include/asm/mach-loongson32/prom.h
index 34859a4..a08503c 100644
--- a/arch/mips/include/asm/mach-loongson1/prom.h
+++ b/arch/mips/include/asm/mach-loongson32/prom.h
@@ -7,8 +7,8 @@
  * option) any later version.
  */
 
-#ifndef __ASM_MACH_LOONGSON1_PROM_H
-#define __ASM_MACH_LOONGSON1_PROM_H
+#ifndef __ASM_MACH_LOONGSON32_PROM_H
+#define __ASM_MACH_LOONGSON32_PROM_H
 
 #include <linux/io.h>
 #include <linux/init.h>
@@ -21,4 +21,4 @@ extern unsigned long memsize, highmemsize;
 extern char *prom_getenv(char *name);
 extern void __init prom_init_cmdline(void);
 
-#endif /* __ASM_MACH_LOONGSON1_PROM_H */
+#endif /* __ASM_MACH_LOONGSON32_PROM_H */
diff --git a/arch/mips/include/asm/mach-loongson1/regs-clk.h b/arch/mips/include/asm/mach-loongson32/regs-clk.h
similarity index 90%
rename from arch/mips/include/asm/mach-loongson1/regs-clk.h
rename to arch/mips/include/asm/mach-loongson32/regs-clk.h
index ee2445b..1f5a715 100644
--- a/arch/mips/include/asm/mach-loongson1/regs-clk.h
+++ b/arch/mips/include/asm/mach-loongson32/regs-clk.h
@@ -9,8 +9,8 @@
  * option) any later version.
  */
 
-#ifndef __ASM_MACH_LOONGSON1_REGS_CLK_H
-#define __ASM_MACH_LOONGSON1_REGS_CLK_H
+#ifndef __ASM_MACH_LOONGSON32_REGS_CLK_H
+#define __ASM_MACH_LOONGSON32_REGS_CLK_H
 
 #define LS1X_CLK_REG(x) \
 		((void __iomem *)KSEG1ADDR(LS1X_CLK_BASE + (x)))
@@ -48,4 +48,4 @@
 #define BYPASS_DDR_WIDTH		1
 #define BYPASS_CPU_WIDTH		1
 
-#endif /* __ASM_MACH_LOONGSON1_REGS_CLK_H */
+#endif /* __ASM_MACH_LOONGSON32_REGS_CLK_H */
diff --git a/arch/mips/include/asm/mach-loongson1/regs-mux.h b/arch/mips/include/asm/mach-loongson32/regs-mux.h
similarity index 94%
rename from arch/mips/include/asm/mach-loongson1/regs-mux.h
rename to arch/mips/include/asm/mach-loongson32/regs-mux.h
index fb1e36e..8302d92 100644
--- a/arch/mips/include/asm/mach-loongson1/regs-mux.h
+++ b/arch/mips/include/asm/mach-loongson32/regs-mux.h
@@ -9,8 +9,8 @@
  * option) any later version.
  */
 
-#ifndef __ASM_MACH_LOONGSON1_REGS_MUX_H
-#define __ASM_MACH_LOONGSON1_REGS_MUX_H
+#ifndef __ASM_MACH_LOONGSON32_REGS_MUX_H
+#define __ASM_MACH_LOONGSON32_REGS_MUX_H
 
 #define LS1X_MUX_REG(x) \
 		((void __iomem *)KSEG1ADDR(LS1X_MUX_BASE + (x)))
@@ -64,4 +64,4 @@
 #define GMAC1_USE_PWM23			(0x1 << 1)
 #define GMAC0_USE_PWM01			0x1
 
-#endif /* __ASM_MACH_LOONGSON1_REGS_MUX_H */
+#endif /* __ASM_MACH_LOONGSON32_REGS_MUX_H */
diff --git a/arch/mips/include/asm/mach-loongson1/regs-pwm.h b/arch/mips/include/asm/mach-loongson32/regs-pwm.h
similarity index 84%
rename from arch/mips/include/asm/mach-loongson1/regs-pwm.h
rename to arch/mips/include/asm/mach-loongson32/regs-pwm.h
index 99f2bcc..69f174e 100644
--- a/arch/mips/include/asm/mach-loongson1/regs-pwm.h
+++ b/arch/mips/include/asm/mach-loongson32/regs-pwm.h
@@ -9,8 +9,8 @@
  * option) any later version.
  */
 
-#ifndef __ASM_MACH_LOONGSON1_REGS_PWM_H
-#define __ASM_MACH_LOONGSON1_REGS_PWM_H
+#ifndef __ASM_MACH_LOONGSON32_REGS_PWM_H
+#define __ASM_MACH_LOONGSON32_REGS_PWM_H
 
 /* Loongson 1 PWM Timer Register Definitions */
 #define PWM_CNT			0x0
@@ -26,4 +26,4 @@
 #define PWM_OE			(0x1 << 3)
 #define CNT_EN			0x1
 
-#endif /* __ASM_MACH_LOONGSON1_REGS_PWM_H */
+#endif /* __ASM_MACH_LOONGSON32_REGS_PWM_H */
diff --git a/arch/mips/include/asm/mach-loongson1/regs-wdt.h b/arch/mips/include/asm/mach-loongson32/regs-wdt.h
similarity index 77%
rename from arch/mips/include/asm/mach-loongson1/regs-wdt.h
rename to arch/mips/include/asm/mach-loongson32/regs-wdt.h
index c39ee98..6644ab6 100644
--- a/arch/mips/include/asm/mach-loongson1/regs-wdt.h
+++ b/arch/mips/include/asm/mach-loongson32/regs-wdt.h
@@ -9,11 +9,11 @@
  * option) any later version.
  */
 
-#ifndef __ASM_MACH_LOONGSON1_REGS_WDT_H
-#define __ASM_MACH_LOONGSON1_REGS_WDT_H
+#ifndef __ASM_MACH_LOONGSON32_REGS_WDT_H
+#define __ASM_MACH_LOONGSON32_REGS_WDT_H
 
 #define WDT_EN			0x0
 #define WDT_TIMER		0x4
 #define WDT_SET			0x8
 
-#endif /* __ASM_MACH_LOONGSON1_REGS_WDT_H */
+#endif /* __ASM_MACH_LOONGSON32_REGS_WDT_H */
diff --git a/arch/mips/include/asm/mach-loongson/boot_param.h b/arch/mips/include/asm/mach-loongson64/boot_param.h
similarity index 98%
rename from arch/mips/include/asm/mach-loongson/boot_param.h
rename to arch/mips/include/asm/mach-loongson64/boot_param.h
index fa80292..d3f3258 100644
--- a/arch/mips/include/asm/mach-loongson/boot_param.h
+++ b/arch/mips/include/asm/mach-loongson64/boot_param.h
@@ -1,5 +1,5 @@
-#ifndef __ASM_MACH_LOONGSON_BOOT_PARAM_H_
-#define __ASM_MACH_LOONGSON_BOOT_PARAM_H_
+#ifndef __ASM_MACH_LOONGSON64_BOOT_PARAM_H_
+#define __ASM_MACH_LOONGSON64_BOOT_PARAM_H_
 
 #define SYSTEM_RAM_LOW		1
 #define SYSTEM_RAM_HIGH		2
diff --git a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
similarity index 90%
rename from arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
rename to arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
index acc3768..98963c2 100644
--- a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
@@ -13,8 +13,8 @@
  *	loongson2f user manual.
  */
 
-#ifndef __ASM_MACH_LOONGSON_CPU_FEATURE_OVERRIDES_H
-#define __ASM_MACH_LOONGSON_CPU_FEATURE_OVERRIDES_H
+#ifndef __ASM_MACH_LOONGSON64_CPU_FEATURE_OVERRIDES_H
+#define __ASM_MACH_LOONGSON64_CPU_FEATURE_OVERRIDES_H
 
 #define cpu_dcache_line_size()	32
 #define cpu_icache_line_size()	32
@@ -58,4 +58,4 @@
 
 #define cpu_has_wsbh		IS_ENABLED(CONFIG_CPU_LOONGSON3)
 
-#endif /* __ASM_MACH_LOONGSON_CPU_FEATURE_OVERRIDES_H */
+#endif /* __ASM_MACH_LOONGSON64_CPU_FEATURE_OVERRIDES_H */
diff --git a/arch/mips/include/asm/mach-loongson/cs5536/cs5536.h b/arch/mips/include/asm/mach-loongson64/cs5536/cs5536.h
similarity index 100%
rename from arch/mips/include/asm/mach-loongson/cs5536/cs5536.h
rename to arch/mips/include/asm/mach-loongson64/cs5536/cs5536.h
diff --git a/arch/mips/include/asm/mach-loongson/cs5536/cs5536_mfgpt.h b/arch/mips/include/asm/mach-loongson64/cs5536/cs5536_mfgpt.h
similarity index 100%
rename from arch/mips/include/asm/mach-loongson/cs5536/cs5536_mfgpt.h
rename to arch/mips/include/asm/mach-loongson64/cs5536/cs5536_mfgpt.h
diff --git a/arch/mips/include/asm/mach-loongson/cs5536/cs5536_pci.h b/arch/mips/include/asm/mach-loongson64/cs5536/cs5536_pci.h
similarity index 100%
rename from arch/mips/include/asm/mach-loongson/cs5536/cs5536_pci.h
rename to arch/mips/include/asm/mach-loongson64/cs5536/cs5536_pci.h
diff --git a/arch/mips/include/asm/mach-loongson/cs5536/cs5536_vsm.h b/arch/mips/include/asm/mach-loongson64/cs5536/cs5536_vsm.h
similarity index 100%
rename from arch/mips/include/asm/mach-loongson/cs5536/cs5536_vsm.h
rename to arch/mips/include/asm/mach-loongson64/cs5536/cs5536_vsm.h
diff --git a/arch/mips/include/asm/mach-loongson/dma-coherence.h b/arch/mips/include/asm/mach-loongson64/dma-coherence.h
similarity index 93%
rename from arch/mips/include/asm/mach-loongson/dma-coherence.h
rename to arch/mips/include/asm/mach-loongson64/dma-coherence.h
index 4bf4e19..1602a9e 100644
--- a/arch/mips/include/asm/mach-loongson/dma-coherence.h
+++ b/arch/mips/include/asm/mach-loongson64/dma-coherence.h
@@ -8,8 +8,8 @@
  * Author: Fuxin Zhang, zhangfx@lemote.com
  *
  */
-#ifndef __ASM_MACH_LOONGSON_DMA_COHERENCE_H
-#define __ASM_MACH_LOONGSON_DMA_COHERENCE_H
+#ifndef __ASM_MACH_LOONGSON64_DMA_COHERENCE_H
+#define __ASM_MACH_LOONGSON64_DMA_COHERENCE_H
 
 #ifdef CONFIG_SWIOTLB
 #include <linux/swiotlb.h>
@@ -82,4 +82,4 @@ static inline void plat_post_dma_flush(struct device *dev)
 {
 }
 
-#endif /* __ASM_MACH_LOONGSON_DMA_COHERENCE_H */
+#endif /* __ASM_MACH_LOONGSON64_DMA_COHERENCE_H */
diff --git a/arch/mips/include/asm/mach-loongson/gpio.h b/arch/mips/include/asm/mach-loongson64/gpio.h
similarity index 100%
rename from arch/mips/include/asm/mach-loongson/gpio.h
rename to arch/mips/include/asm/mach-loongson64/gpio.h
diff --git a/arch/mips/include/asm/mach-loongson/irq.h b/arch/mips/include/asm/mach-loongson64/irq.h
similarity index 92%
rename from arch/mips/include/asm/mach-loongson/irq.h
rename to arch/mips/include/asm/mach-loongson64/irq.h
index a281cca..d18c45c 100644
--- a/arch/mips/include/asm/mach-loongson/irq.h
+++ b/arch/mips/include/asm/mach-loongson64/irq.h
@@ -1,5 +1,5 @@
-#ifndef __ASM_MACH_LOONGSON_IRQ_H_
-#define __ASM_MACH_LOONGSON_IRQ_H_
+#ifndef __ASM_MACH_LOONGSON64_IRQ_H_
+#define __ASM_MACH_LOONGSON64_IRQ_H_
 
 #include <boot_param.h>
 
@@ -40,4 +40,4 @@ extern void fixup_irqs(void);
 extern void loongson3_ipi_interrupt(struct pt_regs *regs);
 
 #include_next <irq.h>
-#endif /* __ASM_MACH_LOONGSON_IRQ_H_ */
+#endif /* __ASM_MACH_LOONGSON64_IRQ_H_ */
diff --git a/arch/mips/include/asm/mach-loongson/kernel-entry-init.h b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
similarity index 88%
rename from arch/mips/include/asm/mach-loongson/kernel-entry-init.h
rename to arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
index df5fca8..3f2f84f 100644
--- a/arch/mips/include/asm/mach-loongson/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
@@ -8,8 +8,8 @@
  * Copyright (C) 2009 Jiajie Chen (chenjiajie@cse.buaa.edu.cn)
  * Copyright (C) 2012 Huacai Chen (chenhc@lemote.com)
  */
-#ifndef __ASM_MACH_LOONGSON_KERNEL_ENTRY_H
-#define __ASM_MACH_LOONGSON_KERNEL_ENTRY_H
+#ifndef __ASM_MACH_LOONGSON64_KERNEL_ENTRY_H
+#define __ASM_MACH_LOONGSON64_KERNEL_ENTRY_H
 
 /*
  * Override macros used in arch/mips/kernel/head.S.
@@ -49,4 +49,4 @@
 #endif
 	.endm
 
-#endif /* __ASM_MACH_LOONGSON_KERNEL_ENTRY_H */
+#endif /* __ASM_MACH_LOONGSON64_KERNEL_ENTRY_H */
diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson64/loongson.h
similarity index 98%
rename from arch/mips/include/asm/mach-loongson/loongson.h
rename to arch/mips/include/asm/mach-loongson64/loongson.h
index 9783103..d1ff774 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson64/loongson.h
@@ -8,8 +8,8 @@
  * option) any later version.
  */
 
-#ifndef __ASM_MACH_LOONGSON_LOONGSON_H
-#define __ASM_MACH_LOONGSON_LOONGSON_H
+#ifndef __ASM_MACH_LOONGSON64_LOONGSON_H
+#define __ASM_MACH_LOONGSON64_LOONGSON_H
 
 #include <linux/io.h>
 #include <linux/init.h>
@@ -357,4 +357,4 @@ extern unsigned long _loongson_addrwincfg_base;
 
 #endif	/* ! CONFIG_CPU_SUPPORTS_ADDRWINCFG */
 
-#endif /* __ASM_MACH_LOONGSON_LOONGSON_H */
+#endif /* __ASM_MACH_LOONGSON64_LOONGSON_H */
diff --git a/arch/mips/include/asm/mach-loongson/loongson_hwmon.h b/arch/mips/include/asm/mach-loongson64/loongson_hwmon.h
similarity index 100%
rename from arch/mips/include/asm/mach-loongson/loongson_hwmon.h
rename to arch/mips/include/asm/mach-loongson64/loongson_hwmon.h
diff --git a/arch/mips/include/asm/mach-loongson/machine.h b/arch/mips/include/asm/mach-loongson64/machine.h
similarity index 84%
rename from arch/mips/include/asm/mach-loongson/machine.h
rename to arch/mips/include/asm/mach-loongson64/machine.h
index cb2b602..c52549b 100644
--- a/arch/mips/include/asm/mach-loongson/machine.h
+++ b/arch/mips/include/asm/mach-loongson64/machine.h
@@ -8,8 +8,8 @@
  * option) any later version.
  */
 
-#ifndef __ASM_MACH_LOONGSON_MACHINE_H
-#define __ASM_MACH_LOONGSON_MACHINE_H
+#ifndef __ASM_MACH_LOONGSON64_MACHINE_H
+#define __ASM_MACH_LOONGSON64_MACHINE_H
 
 #ifdef CONFIG_LEMOTE_FULOONG2E
 
@@ -30,4 +30,4 @@
 
 #endif /* CONFIG_LOONGSON_MACH3X */
 
-#endif /* __ASM_MACH_LOONGSON_MACHINE_H */
+#endif /* __ASM_MACH_LOONGSON64_MACHINE_H */
diff --git a/arch/mips/include/asm/mach-loongson/mc146818rtc.h b/arch/mips/include/asm/mach-loongson64/mc146818rtc.h
similarity index 85%
rename from arch/mips/include/asm/mach-loongson/mc146818rtc.h
rename to arch/mips/include/asm/mach-loongson64/mc146818rtc.h
index ed7fe97..ebdccfe 100644
--- a/arch/mips/include/asm/mach-loongson/mc146818rtc.h
+++ b/arch/mips/include/asm/mach-loongson64/mc146818rtc.h
@@ -7,8 +7,8 @@
  *
  * RTC routines for PC style attached Dallas chip.
  */
-#ifndef __ASM_MACH_LOONGSON_MC146818RTC_H
-#define __ASM_MACH_LOONGSON_MC146818RTC_H
+#ifndef __ASM_MACH_LOONGSON64_MC146818RTC_H
+#define __ASM_MACH_LOONGSON64_MC146818RTC_H
 
 #include <linux/io.h>
 
@@ -33,4 +33,4 @@ static inline void CMOS_WRITE(unsigned char data, unsigned long addr)
 #define mc146818_decode_year(year) ((year) < 70 ? (year) + 2000 : (year) + 1970)
 #endif
 
-#endif /* __ASM_MACH_LOONGSON_MC146818RTC_H */
+#endif /* __ASM_MACH_LOONGSON64_MC146818RTC_H */
diff --git a/arch/mips/include/asm/mach-loongson/mem.h b/arch/mips/include/asm/mach-loongson64/mem.h
similarity index 89%
rename from arch/mips/include/asm/mach-loongson/mem.h
rename to arch/mips/include/asm/mach-loongson64/mem.h
index f4a36d7..75c16be 100644
--- a/arch/mips/include/asm/mach-loongson/mem.h
+++ b/arch/mips/include/asm/mach-loongson64/mem.h
@@ -8,8 +8,8 @@
  * option) any later version.
  */
 
-#ifndef __ASM_MACH_LOONGSON_MEM_H
-#define __ASM_MACH_LOONGSON_MEM_H
+#ifndef __ASM_MACH_LOONGSON64_MEM_H
+#define __ASM_MACH_LOONGSON64_MEM_H
 
 /*
  * high memory space
@@ -38,4 +38,4 @@
 #define LOONGSON_MMIO_MEM_END	0x80000000
 #endif
 
-#endif /* __ASM_MACH_LOONGSON_MEM_H */
+#endif /* __ASM_MACH_LOONGSON64_MEM_H */
diff --git a/arch/mips/include/asm/mach-loongson/mmzone.h b/arch/mips/include/asm/mach-loongson64/mmzone.h
similarity index 100%
rename from arch/mips/include/asm/mach-loongson/mmzone.h
rename to arch/mips/include/asm/mach-loongson64/mmzone.h
diff --git a/arch/mips/include/asm/mach-loongson/pci.h b/arch/mips/include/asm/mach-loongson64/pci.h
similarity index 93%
rename from arch/mips/include/asm/mach-loongson/pci.h
rename to arch/mips/include/asm/mach-loongson64/pci.h
index 1212774..3401f55 100644
--- a/arch/mips/include/asm/mach-loongson/pci.h
+++ b/arch/mips/include/asm/mach-loongson64/pci.h
@@ -9,8 +9,8 @@
  * option) any later version.
  */
 
-#ifndef __ASM_MACH_LOONGSON_PCI_H_
-#define __ASM_MACH_LOONGSON_PCI_H_
+#ifndef __ASM_MACH_LOONGSON64_PCI_H_
+#define __ASM_MACH_LOONGSON64_PCI_H_
 
 extern struct pci_ops loongson_pci_ops;
 
@@ -52,4 +52,4 @@ extern struct pci_ops loongson_pci_ops;
 
 #endif	/* !CONFIG_CPU_SUPPORTS_ADDRWINCFG */
 
-#endif /* !__ASM_MACH_LOONGSON_PCI_H_ */
+#endif /* !__ASM_MACH_LOONGSON64_PCI_H_ */
diff --git a/arch/mips/include/asm/mach-loongson/spaces.h b/arch/mips/include/asm/mach-loongson64/spaces.h
similarity index 65%
rename from arch/mips/include/asm/mach-loongson/spaces.h
rename to arch/mips/include/asm/mach-loongson64/spaces.h
index e2506ee..c6040b9 100644
--- a/arch/mips/include/asm/mach-loongson/spaces.h
+++ b/arch/mips/include/asm/mach-loongson64/spaces.h
@@ -1,5 +1,5 @@
-#ifndef __ASM_MACH_LOONGSON_SPACES_H_
-#define __ASM_MACH_LOONGSON_SPACES_H_
+#ifndef __ASM_MACH_LOONGSON64_SPACES_H_
+#define __ASM_MACH_LOONGSON64_SPACES_H_
 
 #if defined(CONFIG_64BIT)
 #define CAC_BASE        _AC(0x9800000000000000, UL)
diff --git a/arch/mips/include/asm/mach-loongson/topology.h b/arch/mips/include/asm/mach-loongson64/topology.h
similarity index 100%
rename from arch/mips/include/asm/mach-loongson/topology.h
rename to arch/mips/include/asm/mach-loongson64/topology.h
diff --git a/arch/mips/include/asm/mach-loongson64/workarounds.h b/arch/mips/include/asm/mach-loongson64/workarounds.h
new file mode 100644
index 0000000..e659f04
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson64/workarounds.h
@@ -0,0 +1,7 @@
+#ifndef __ASM_MACH_LOONGSON64_WORKAROUNDS_H_
+#define __ASM_MACH_LOONGSON64_WORKAROUNDS_H_
+
+#define WORKAROUND_CPUFREQ	0x00000001
+#define WORKAROUND_CPUHOTPLUG	0x00000002
+
+#endif
diff --git a/arch/mips/loongson1/Kconfig b/arch/mips/loongson32/Kconfig
similarity index 96%
rename from arch/mips/loongson1/Kconfig
rename to arch/mips/loongson32/Kconfig
index a2b796e..3867ae7 100644
--- a/arch/mips/loongson1/Kconfig
+++ b/arch/mips/loongson32/Kconfig
@@ -1,4 +1,4 @@
-if MACH_LOONGSON1
+if MACH_LOONGSON32
 
 choice
 	prompt "Machine Type"
@@ -58,4 +58,4 @@ config TIMER_USE_PWM3
 
 endchoice
 
-endif # MACH_LOONGSON1
+endif # MACH_LOONGSON32
diff --git a/arch/mips/loongson1/Makefile b/arch/mips/loongson32/Makefile
similarity index 74%
rename from arch/mips/loongson1/Makefile
rename to arch/mips/loongson32/Makefile
index 9719c75..5f4bd6e 100644
--- a/arch/mips/loongson1/Makefile
+++ b/arch/mips/loongson32/Makefile
@@ -2,7 +2,7 @@
 # Common code for all Loongson 1 based systems
 #
 
-obj-$(CONFIG_MACH_LOONGSON1) += common/
+obj-$(CONFIG_MACH_LOONGSON32) += common/
 
 #
 # Loongson LS1B board
diff --git a/arch/mips/loongson1/Platform b/arch/mips/loongson32/Platform
similarity index 59%
rename from arch/mips/loongson1/Platform
rename to arch/mips/loongson32/Platform
index 1186344..ebb6dc2 100644
--- a/arch/mips/loongson1/Platform
+++ b/arch/mips/loongson32/Platform
@@ -2,6 +2,6 @@ cflags-$(CONFIG_CPU_LOONGSON1)	+= \
 	$(call cc-option,-march=mips32r2,-mips32r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
 	-Wa,-mips32r2 -Wa,--trap
 
-platform-$(CONFIG_MACH_LOONGSON1)	+= loongson1/
-cflags-$(CONFIG_MACH_LOONGSON1)		+= -I$(srctree)/arch/mips/include/asm/mach-loongson1
+platform-$(CONFIG_MACH_LOONGSON32)	+= loongson32/
+cflags-$(CONFIG_MACH_LOONGSON32)	+= -I$(srctree)/arch/mips/include/asm/mach-loongson32
 load-$(CONFIG_LOONGSON1_LS1B)		+= 0xffffffff80100000
diff --git a/arch/mips/loongson1/common/Makefile b/arch/mips/loongson32/common/Makefile
similarity index 100%
rename from arch/mips/loongson1/common/Makefile
rename to arch/mips/loongson32/common/Makefile
diff --git a/arch/mips/loongson1/common/irq.c b/arch/mips/loongson32/common/irq.c
similarity index 100%
rename from arch/mips/loongson1/common/irq.c
rename to arch/mips/loongson32/common/irq.c
diff --git a/arch/mips/loongson1/common/platform.c b/arch/mips/loongson32/common/platform.c
similarity index 100%
rename from arch/mips/loongson1/common/platform.c
rename to arch/mips/loongson32/common/platform.c
diff --git a/arch/mips/loongson1/common/prom.c b/arch/mips/loongson32/common/prom.c
similarity index 100%
rename from arch/mips/loongson1/common/prom.c
rename to arch/mips/loongson32/common/prom.c
diff --git a/arch/mips/loongson1/common/reset.c b/arch/mips/loongson32/common/reset.c
similarity index 100%
rename from arch/mips/loongson1/common/reset.c
rename to arch/mips/loongson32/common/reset.c
diff --git a/arch/mips/loongson1/common/setup.c b/arch/mips/loongson32/common/setup.c
similarity index 100%
rename from arch/mips/loongson1/common/setup.c
rename to arch/mips/loongson32/common/setup.c
diff --git a/arch/mips/loongson1/common/time.c b/arch/mips/loongson32/common/time.c
similarity index 100%
rename from arch/mips/loongson1/common/time.c
rename to arch/mips/loongson32/common/time.c
diff --git a/arch/mips/loongson1/ls1b/Makefile b/arch/mips/loongson32/ls1b/Makefile
similarity index 100%
rename from arch/mips/loongson1/ls1b/Makefile
rename to arch/mips/loongson32/ls1b/Makefile
diff --git a/arch/mips/loongson1/ls1b/board.c b/arch/mips/loongson32/ls1b/board.c
similarity index 100%
rename from arch/mips/loongson1/ls1b/board.c
rename to arch/mips/loongson32/ls1b/board.c
diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson64/Kconfig
similarity index 98%
rename from arch/mips/loongson/Kconfig
rename to arch/mips/loongson64/Kconfig
index 156de85..005b7e8 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson64/Kconfig
@@ -1,4 +1,4 @@
-if MACH_LOONGSON
+if MACH_LOONGSON64
 
 choice
 	prompt "Machine Type"
@@ -155,4 +155,4 @@ config LOONGSON_MC146818
 config LEFI_FIRMWARE_INTERFACE
 	bool
 
-endif # MACH_LOONGSON
+endif # MACH_LOONGSON64
diff --git a/arch/mips/loongson/Makefile b/arch/mips/loongson64/Makefile
similarity index 88%
rename from arch/mips/loongson/Makefile
rename to arch/mips/loongson64/Makefile
index 7429994..4fe3d88 100644
--- a/arch/mips/loongson/Makefile
+++ b/arch/mips/loongson64/Makefile
@@ -2,7 +2,7 @@
 # Common code for all Loongson based systems
 #
 
-obj-$(CONFIG_MACH_LOONGSON) += common/
+obj-$(CONFIG_MACH_LOONGSON64) += common/
 
 #
 # Lemote Fuloong mini-PC (Loongson 2E-based)
diff --git a/arch/mips/loongson/Platform b/arch/mips/loongson64/Platform
similarity index 87%
rename from arch/mips/loongson/Platform
rename to arch/mips/loongson64/Platform
index 0ac20eb..2e48e83 100644
--- a/arch/mips/loongson/Platform
+++ b/arch/mips/loongson64/Platform
@@ -26,8 +26,8 @@ endif
 # Loongson Machines' Support
 #
 
-platform-$(CONFIG_MACH_LOONGSON) += loongson/
-cflags-$(CONFIG_MACH_LOONGSON) += -I$(srctree)/arch/mips/include/asm/mach-loongson -mno-branch-likely
+platform-$(CONFIG_MACH_LOONGSON64) += loongson64/
+cflags-$(CONFIG_MACH_LOONGSON64) += -I$(srctree)/arch/mips/include/asm/mach-loongson64 -mno-branch-likely
 load-$(CONFIG_LEMOTE_FULOONG2E) += 0xffffffff80100000
 load-$(CONFIG_LEMOTE_MACH2F) += 0xffffffff80200000
 load-$(CONFIG_LOONGSON_MACH3X) += 0xffffffff80200000
diff --git a/arch/mips/loongson/common/Makefile b/arch/mips/loongson64/common/Makefile
similarity index 100%
rename from arch/mips/loongson/common/Makefile
rename to arch/mips/loongson64/common/Makefile
diff --git a/arch/mips/loongson/common/bonito-irq.c b/arch/mips/loongson64/common/bonito-irq.c
similarity index 100%
rename from arch/mips/loongson/common/bonito-irq.c
rename to arch/mips/loongson64/common/bonito-irq.c
diff --git a/arch/mips/loongson/common/cmdline.c b/arch/mips/loongson64/common/cmdline.c
similarity index 100%
rename from arch/mips/loongson/common/cmdline.c
rename to arch/mips/loongson64/common/cmdline.c
diff --git a/arch/mips/loongson/common/cs5536/Makefile b/arch/mips/loongson64/common/cs5536/Makefile
similarity index 100%
rename from arch/mips/loongson/common/cs5536/Makefile
rename to arch/mips/loongson64/common/cs5536/Makefile
diff --git a/arch/mips/loongson/common/cs5536/cs5536_acc.c b/arch/mips/loongson64/common/cs5536/cs5536_acc.c
similarity index 100%
rename from arch/mips/loongson/common/cs5536/cs5536_acc.c
rename to arch/mips/loongson64/common/cs5536/cs5536_acc.c
diff --git a/arch/mips/loongson/common/cs5536/cs5536_ehci.c b/arch/mips/loongson64/common/cs5536/cs5536_ehci.c
similarity index 100%
rename from arch/mips/loongson/common/cs5536/cs5536_ehci.c
rename to arch/mips/loongson64/common/cs5536/cs5536_ehci.c
diff --git a/arch/mips/loongson/common/cs5536/cs5536_ide.c b/arch/mips/loongson64/common/cs5536/cs5536_ide.c
similarity index 100%
rename from arch/mips/loongson/common/cs5536/cs5536_ide.c
rename to arch/mips/loongson64/common/cs5536/cs5536_ide.c
diff --git a/arch/mips/loongson/common/cs5536/cs5536_isa.c b/arch/mips/loongson64/common/cs5536/cs5536_isa.c
similarity index 100%
rename from arch/mips/loongson/common/cs5536/cs5536_isa.c
rename to arch/mips/loongson64/common/cs5536/cs5536_isa.c
diff --git a/arch/mips/loongson/common/cs5536/cs5536_mfgpt.c b/arch/mips/loongson64/common/cs5536/cs5536_mfgpt.c
similarity index 100%
rename from arch/mips/loongson/common/cs5536/cs5536_mfgpt.c
rename to arch/mips/loongson64/common/cs5536/cs5536_mfgpt.c
diff --git a/arch/mips/loongson/common/cs5536/cs5536_ohci.c b/arch/mips/loongson64/common/cs5536/cs5536_ohci.c
similarity index 100%
rename from arch/mips/loongson/common/cs5536/cs5536_ohci.c
rename to arch/mips/loongson64/common/cs5536/cs5536_ohci.c
diff --git a/arch/mips/loongson/common/cs5536/cs5536_pci.c b/arch/mips/loongson64/common/cs5536/cs5536_pci.c
similarity index 100%
rename from arch/mips/loongson/common/cs5536/cs5536_pci.c
rename to arch/mips/loongson64/common/cs5536/cs5536_pci.c
diff --git a/arch/mips/loongson/common/dma-swiotlb.c b/arch/mips/loongson64/common/dma-swiotlb.c
similarity index 100%
rename from arch/mips/loongson/common/dma-swiotlb.c
rename to arch/mips/loongson64/common/dma-swiotlb.c
diff --git a/arch/mips/loongson/common/early_printk.c b/arch/mips/loongson64/common/early_printk.c
similarity index 100%
rename from arch/mips/loongson/common/early_printk.c
rename to arch/mips/loongson64/common/early_printk.c
diff --git a/arch/mips/loongson/common/env.c b/arch/mips/loongson64/common/env.c
similarity index 100%
rename from arch/mips/loongson/common/env.c
rename to arch/mips/loongson64/common/env.c
diff --git a/arch/mips/loongson/common/gpio.c b/arch/mips/loongson64/common/gpio.c
similarity index 100%
rename from arch/mips/loongson/common/gpio.c
rename to arch/mips/loongson64/common/gpio.c
diff --git a/arch/mips/loongson/common/init.c b/arch/mips/loongson64/common/init.c
similarity index 100%
rename from arch/mips/loongson/common/init.c
rename to arch/mips/loongson64/common/init.c
diff --git a/arch/mips/loongson/common/irq.c b/arch/mips/loongson64/common/irq.c
similarity index 100%
rename from arch/mips/loongson/common/irq.c
rename to arch/mips/loongson64/common/irq.c
diff --git a/arch/mips/loongson/common/machtype.c b/arch/mips/loongson64/common/machtype.c
similarity index 100%
rename from arch/mips/loongson/common/machtype.c
rename to arch/mips/loongson64/common/machtype.c
diff --git a/arch/mips/loongson/common/mem.c b/arch/mips/loongson64/common/mem.c
similarity index 100%
rename from arch/mips/loongson/common/mem.c
rename to arch/mips/loongson64/common/mem.c
diff --git a/arch/mips/loongson/common/pci.c b/arch/mips/loongson64/common/pci.c
similarity index 100%
rename from arch/mips/loongson/common/pci.c
rename to arch/mips/loongson64/common/pci.c
diff --git a/arch/mips/loongson/common/platform.c b/arch/mips/loongson64/common/platform.c
similarity index 100%
rename from arch/mips/loongson/common/platform.c
rename to arch/mips/loongson64/common/platform.c
diff --git a/arch/mips/loongson/common/pm.c b/arch/mips/loongson64/common/pm.c
similarity index 100%
rename from arch/mips/loongson/common/pm.c
rename to arch/mips/loongson64/common/pm.c
diff --git a/arch/mips/loongson/common/reset.c b/arch/mips/loongson64/common/reset.c
similarity index 100%
rename from arch/mips/loongson/common/reset.c
rename to arch/mips/loongson64/common/reset.c
diff --git a/arch/mips/loongson/common/rtc.c b/arch/mips/loongson64/common/rtc.c
similarity index 100%
rename from arch/mips/loongson/common/rtc.c
rename to arch/mips/loongson64/common/rtc.c
diff --git a/arch/mips/loongson/common/serial.c b/arch/mips/loongson64/common/serial.c
similarity index 100%
rename from arch/mips/loongson/common/serial.c
rename to arch/mips/loongson64/common/serial.c
diff --git a/arch/mips/loongson/common/setup.c b/arch/mips/loongson64/common/setup.c
similarity index 100%
rename from arch/mips/loongson/common/setup.c
rename to arch/mips/loongson64/common/setup.c
diff --git a/arch/mips/loongson/common/time.c b/arch/mips/loongson64/common/time.c
similarity index 100%
rename from arch/mips/loongson/common/time.c
rename to arch/mips/loongson64/common/time.c
diff --git a/arch/mips/loongson/common/uart_base.c b/arch/mips/loongson64/common/uart_base.c
similarity index 100%
rename from arch/mips/loongson/common/uart_base.c
rename to arch/mips/loongson64/common/uart_base.c
diff --git a/arch/mips/loongson/fuloong-2e/Makefile b/arch/mips/loongson64/fuloong-2e/Makefile
similarity index 100%
rename from arch/mips/loongson/fuloong-2e/Makefile
rename to arch/mips/loongson64/fuloong-2e/Makefile
diff --git a/arch/mips/loongson/fuloong-2e/irq.c b/arch/mips/loongson64/fuloong-2e/irq.c
similarity index 100%
rename from arch/mips/loongson/fuloong-2e/irq.c
rename to arch/mips/loongson64/fuloong-2e/irq.c
diff --git a/arch/mips/loongson/fuloong-2e/reset.c b/arch/mips/loongson64/fuloong-2e/reset.c
similarity index 100%
rename from arch/mips/loongson/fuloong-2e/reset.c
rename to arch/mips/loongson64/fuloong-2e/reset.c
diff --git a/arch/mips/loongson/lemote-2f/Makefile b/arch/mips/loongson64/lemote-2f/Makefile
similarity index 100%
rename from arch/mips/loongson/lemote-2f/Makefile
rename to arch/mips/loongson64/lemote-2f/Makefile
diff --git a/arch/mips/loongson/lemote-2f/clock.c b/arch/mips/loongson64/lemote-2f/clock.c
similarity index 100%
rename from arch/mips/loongson/lemote-2f/clock.c
rename to arch/mips/loongson64/lemote-2f/clock.c
diff --git a/arch/mips/loongson/lemote-2f/ec_kb3310b.c b/arch/mips/loongson64/lemote-2f/ec_kb3310b.c
similarity index 100%
rename from arch/mips/loongson/lemote-2f/ec_kb3310b.c
rename to arch/mips/loongson64/lemote-2f/ec_kb3310b.c
diff --git a/arch/mips/loongson/lemote-2f/ec_kb3310b.h b/arch/mips/loongson64/lemote-2f/ec_kb3310b.h
similarity index 100%
rename from arch/mips/loongson/lemote-2f/ec_kb3310b.h
rename to arch/mips/loongson64/lemote-2f/ec_kb3310b.h
diff --git a/arch/mips/loongson/lemote-2f/irq.c b/arch/mips/loongson64/lemote-2f/irq.c
similarity index 100%
rename from arch/mips/loongson/lemote-2f/irq.c
rename to arch/mips/loongson64/lemote-2f/irq.c
diff --git a/arch/mips/loongson/lemote-2f/machtype.c b/arch/mips/loongson64/lemote-2f/machtype.c
similarity index 100%
rename from arch/mips/loongson/lemote-2f/machtype.c
rename to arch/mips/loongson64/lemote-2f/machtype.c
diff --git a/arch/mips/loongson/lemote-2f/pm.c b/arch/mips/loongson64/lemote-2f/pm.c
similarity index 100%
rename from arch/mips/loongson/lemote-2f/pm.c
rename to arch/mips/loongson64/lemote-2f/pm.c
diff --git a/arch/mips/loongson/lemote-2f/reset.c b/arch/mips/loongson64/lemote-2f/reset.c
similarity index 100%
rename from arch/mips/loongson/lemote-2f/reset.c
rename to arch/mips/loongson64/lemote-2f/reset.c
diff --git a/arch/mips/loongson/loongson-3/Makefile b/arch/mips/loongson64/loongson-3/Makefile
similarity index 100%
rename from arch/mips/loongson/loongson-3/Makefile
rename to arch/mips/loongson64/loongson-3/Makefile
diff --git a/arch/mips/loongson/loongson-3/cop2-ex.c b/arch/mips/loongson64/loongson-3/cop2-ex.c
similarity index 100%
rename from arch/mips/loongson/loongson-3/cop2-ex.c
rename to arch/mips/loongson64/loongson-3/cop2-ex.c
diff --git a/arch/mips/loongson/loongson-3/hpet.c b/arch/mips/loongson64/loongson-3/hpet.c
similarity index 100%
rename from arch/mips/loongson/loongson-3/hpet.c
rename to arch/mips/loongson64/loongson-3/hpet.c
diff --git a/arch/mips/loongson/loongson-3/irq.c b/arch/mips/loongson64/loongson-3/irq.c
similarity index 100%
rename from arch/mips/loongson/loongson-3/irq.c
rename to arch/mips/loongson64/loongson-3/irq.c
diff --git a/arch/mips/loongson/loongson-3/numa.c b/arch/mips/loongson64/loongson-3/numa.c
similarity index 100%
rename from arch/mips/loongson/loongson-3/numa.c
rename to arch/mips/loongson64/loongson-3/numa.c
diff --git a/arch/mips/loongson/loongson-3/platform.c b/arch/mips/loongson64/loongson-3/platform.c
similarity index 100%
rename from arch/mips/loongson/loongson-3/platform.c
rename to arch/mips/loongson64/loongson-3/platform.c
diff --git a/arch/mips/loongson/loongson-3/smp.c b/arch/mips/loongson64/loongson-3/smp.c
similarity index 100%
rename from arch/mips/loongson/loongson-3/smp.c
rename to arch/mips/loongson64/loongson-3/smp.c
diff --git a/arch/mips/loongson/loongson-3/smp.h b/arch/mips/loongson64/loongson-3/smp.h
similarity index 100%
rename from arch/mips/loongson/loongson-3/smp.h
rename to arch/mips/loongson64/loongson-3/smp.h
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index e43ff53..e229d93 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -24,7 +24,7 @@ obj-$(CONFIG_COMMON_CLK_CDCE706)	+= clk-cdce706.o
 obj-$(CONFIG_ARCH_CLPS711X)		+= clk-clps711x.o
 obj-$(CONFIG_ARCH_EFM32)		+= clk-efm32gg.o
 obj-$(CONFIG_ARCH_HIGHBANK)		+= clk-highbank.o
-obj-$(CONFIG_MACH_LOONGSON1)		+= clk-ls1x.o
+obj-$(CONFIG_MACH_LOONGSON32)		+= clk-ls1x.o
 obj-$(CONFIG_COMMON_CLK_MAX_GEN)	+= clk-max-gen.o
 obj-$(CONFIG_COMMON_CLK_MAX77686)	+= clk-max77686.o
 obj-$(CONFIG_COMMON_CLK_MAX77802)	+= clk-max77802.o
diff --git a/drivers/cpufreq/ls1x-cpufreq.c b/drivers/cpufreq/ls1x-cpufreq.c
index f0913ee..262581b 100644
--- a/drivers/cpufreq/ls1x-cpufreq.c
+++ b/drivers/cpufreq/ls1x-cpufreq.c
@@ -17,8 +17,8 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include <asm/mach-loongson1/cpufreq.h>
-#include <asm/mach-loongson1/loongson1.h>
+#include <cpufreq.h>
+#include <loongson1.h>
 
 static struct {
 	struct device *dev;
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index b5b5c3d..56f2543 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1464,7 +1464,7 @@ config RTC_DRV_PUV3
 
 config RTC_DRV_LOONGSON1
 	tristate "loongson1 RTC support"
-	depends on MACH_LOONGSON1
+	depends on MACH_LOONGSON32
 	help
 	  This is a driver for the loongson1 on-chip Counter0 (Time-Of-Year
 	  counter) to be used as a RTC.
diff --git a/drivers/rtc/rtc-ls1x.c b/drivers/rtc/rtc-ls1x.c
index 8445e56..22a9ec4 100644
--- a/drivers/rtc/rtc-ls1x.c
+++ b/drivers/rtc/rtc-ls1x.c
@@ -17,7 +17,7 @@
 #include <linux/delay.h>
 #include <linux/types.h>
 #include <linux/io.h>
-#include <asm/mach-loongson1/loongson1.h>
+#include <loongson1.h>
 
 #define LS1X_RTC_REG_OFFSET	(LS1X_RTC_BASE + 0x20)
 #define LS1X_RTC_REGS(x) \
-- 
1.7.7.3


8X5X/yà
