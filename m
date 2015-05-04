Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 May 2015 11:20:15 +0200 (CEST)
Received: from smtpbg63.qq.com ([103.7.29.150]:1038 "EHLO smtpbg63.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009397AbbEDJUKgq2TC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 May 2015 11:20:10 +0200
X-QQ-mid: bizesmtp3t1430731181t536t043
Received: from localhost.localdomain (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Mon, 04 May 2015 17:19:17 +0800 (CST)
X-QQ-SSF: 01100000002000F0FJ52000A0000000
X-QQ-FEAT: wf6f/1sQVa7eYu5y5FdmlqQbdkl1k7ePIVnyDctfEiP5/yrfowblPWhsr/r17
        +WGeDzrvHNm04g2PEXndeqBNrt14QhNR5Av1qcdc3fHZWtn062H08qDKfTAWvO1GFoH6YUt
        TNPvl5I0o6qS4VPuioMXvl7bBnATqZj4mGGvUGCEWt4cNs+MebsUZYxbiowXukDTZ0R9+z9
        xuYcde4mxxGbv1+31igmrMvUfysK7btw=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 0/4] MIPS: Loongson: Cleanups and improvements
Date:   Mon,  4 May 2015 17:19:07 +0800
Message-Id: <1430731151-4808-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
X-QQ-SENDSIZE: 520
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47224
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

This patchset is prepared for the next 4.2 release for Linux/MIPS. In this
series we cleanup the naming style of Loongson's directory and Kconfig options,
move chipset ACPI code from drivers to arch since it is mostly Loongson-3
specific, introduce coherent cache features to improve performance, and Make
CPU names in /proc/cpuinfo more human-readable.

Huacai Chen(4):
 MIPS: Loongson: Naming style cleanup and rework.
 MIPS: Loongson-3: Move chipset ACPI code from drivers to arch.
 MIPS: Loongson: Introduce and use cpu_has_coherent_cache feature.
 MIPS: Loongson: Make CPU names more clear.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/Kbuild.platforms                         |    4 +-
 arch/mips/Kconfig                                  |   37 +++++++++++--------
 arch/mips/boot/compressed/uart-16550.c             |    2 +-
 arch/mips/configs/fuloong2e_defconfig              |    2 +-
 arch/mips/configs/lemote2f_defconfig               |    2 +-
 arch/mips/configs/loongson3_defconfig              |    2 +-
 arch/mips/configs/ls1b_defconfig                   |    2 +-
 arch/mips/include/asm/cpu-features.h               |    3 ++
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
 .../cpu-feature-overrides.h                        |    7 ++--
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
 arch/mips/kernel/cpu-probe.c                       |    8 ++--
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
 .../{loongson => loongson64}/loongson-3/Makefile   |    2 +-
 .../mips/loongson64/loongson-3}/acpi_init.c        |    0
 .../{loongson => loongson64}/loongson-3/cop2-ex.c  |    0
 .../{loongson => loongson64}/loongson-3/hpet.c     |    0
 .../mips/{loongson => loongson64}/loongson-3/irq.c |    0
 .../{loongson => loongson64}/loongson-3/numa.c     |    0
 .../{loongson => loongson64}/loongson-3/platform.c |    0
 .../mips/{loongson => loongson64}/loongson-3/smp.c |    0
 .../mips/{loongson => loongson64}/loongson-3/smp.h |    0
 arch/mips/mm/c-r4k.c                               |   21 +++++++++++
 drivers/clk/Makefile                               |    2 +-
 drivers/cpufreq/ls1x-cpufreq.c                     |    4 +-
 drivers/platform/mips/Kconfig                      |    4 --
 drivers/platform/mips/Makefile                     |    1 -
 drivers/rtc/Kconfig                                |    2 +-
 drivers/rtc/rtc-ls1x.c                             |    2 +-
 109 files changed, 138 insertions(+), 113 deletions(-)
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
 rename arch/mips/include/asm/{mach-loongson => mach-loongson64}/cpu-feature-overrides.h (86%)
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
 rename arch/mips/{loongson => loongson64}/loongson-3/Makefile (73%)
 rename {drivers/platform/mips => arch/mips/loongson64/loongson-3}/acpi_init.c (100%)
 rename arch/mips/{loongson => loongson64}/loongson-3/cop2-ex.c (100%)
 rename arch/mips/{loongson => loongson64}/loongson-3/hpet.c (100%)
 rename arch/mips/{loongson => loongson64}/loongson-3/irq.c (100%)
 rename arch/mips/{loongson => loongson64}/loongson-3/numa.c (100%)
 rename arch/mips/{loongson => loongson64}/loongson-3/platform.c (100%)
 rename arch/mips/{loongson => loongson64}/loongson-3/smp.c (100%)
 rename arch/mips/{loongson => loongson64}/loongson-3/smp.h (100%)
--
1.7.7.3
