Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2014 07:13:55 +0100 (CET)
Received: from mail-pd0-f170.google.com ([209.85.192.170]:49351 "EHLO
        mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010958AbaKDGNwgLTPk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Nov 2014 07:13:52 +0100
Received: by mail-pd0-f170.google.com with SMTP id z10so13014798pdj.15
        for <multiple recipients>; Mon, 03 Nov 2014 22:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=oSwFIOM3nJLyY3SSEn2jUvIjo4do/fpE3T8RWE1C42A=;
        b=H1VHx+mLPzCnekwqHbelRKZ5O4t0GPkaF/edBGScj7em4Id/nzCvn+tGLwNTo00shr
         G1ey1OI1341kQCUaL6UdGxovTrZvmjOK/kpBMXjfMLHnziE/uwFfv+4bHpxaaeupVYSo
         tStDkG8QJdDM5JfVOYwM/gYnjxAmxX9wA/alLbfLDHTKdJhdIGDmMF+RVzqPJjHrPHTI
         5gdrrDw0LUMKpNM0Pvp6GBd+s5F0Ib+BiZvTZ63LF/vUtwYv7C24URa1/9nZNR7d9O1+
         8xWqXb+V2tau8uBHt/gJ534AXlsN2WrO/frizWht1jJrVVWtFVnnFs9305h8T6os0wcZ
         EPgw==
X-Received: by 10.69.26.197 with SMTP id ja5mr13819164pbd.111.1415081625787;
        Mon, 03 Nov 2014 22:13:45 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id cs9sm7712498pac.8.2014.11.03.22.13.41
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 03 Nov 2014 22:13:45 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>
Subject: [PATCH V2 00/12] MIPS: Loongson-3: Improve kernel functionality
Date:   Tue,  4 Nov 2014 14:13:21 +0800
Message-Id: <1415081610-25639-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43849
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

This patchset is prepared for the next 3.19 release for Linux/MIPS. In
this series we promote Loongson-3's ISA level to MIPS64R1 since it is
not fully compatible with MIPS64R2. Multi-node DMA and coherent cache
features are both added here. LEFI firmware interface is improved to
make the kernel more generic (machtypes can be dropped). Besides, we
add some basic platform drivers (GPIO, CPU Hwmon, ACPI init, oprofile,
HPET and CPUFreq) for Loongson-3. 

V1 -> V2:
1, Add a patch to fix Loongson's CCA setting.
2, Rework the third patch.
3, Rebase the code for 3.19.

Huacai Chen(12):
 MIPS: Loongson: Fix the write-combine CCA value setting.
 MIPS: Loongson: set Loongson-3's ISA level to MIPS64R1.
 MIPS: Loongson-3: Add PHYS48_TO_HT40 support.
 MIPS: Loongson: Introduce and use cpu_has_coherent_cache feature.
 MIPS: Loongson: Allow booting from any core.
 MIPS: Loongson: Improve LEFI firmware interface.
 MIPS: Loongson: Add Loongson-3A/3B GPIO support.
 MIPS: Loongson-3: Add CPU Hwmon platform driver.
 MIPS: Loongson-3: Add chipset ACPI platform driver.
 MIPS: Loongson-3: Add oprofile support.
 MIPS: Loongson-3: Add RS780/SBX00 HPET support.
 MIPS: Loongson: Make CPUFreq usable for Loongson-3.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
---
 arch/mips/Kconfig                                  |    4 +
 arch/mips/include/asm/bootinfo.h                   |    5 +-
 arch/mips/include/asm/cpu-features.h               |    3 +
 arch/mips/include/asm/hpet.h                       |   73 ++++++
 arch/mips/include/asm/mach-loongson/boot_param.h   |   49 ++++-
 .../asm/mach-loongson/cpu-feature-overrides.h      |    3 +-
 .../mips/include/asm/mach-loongson/dma-coherence.h |   30 +++-
 arch/mips/include/asm/mach-loongson/irq.h          |    3 +-
 arch/mips/include/asm/mach-loongson/loongson.h     |    7 +-
 .../include/asm/mach-loongson/loongson_hwmon.h     |   55 +++++
 arch/mips/include/asm/mach-loongson/machine.h      |    2 +-
 arch/mips/include/asm/mach-loongson/topology.h     |    2 +-
 arch/mips/include/asm/mach-loongson/workarounds.h  |    7 +
 arch/mips/kernel/cpu-probe.c                       |    5 +-
 arch/mips/kernel/smp.c                             |    3 +-
 arch/mips/loongson/Kconfig                         |   18 ++
 arch/mips/loongson/common/dma-swiotlb.c            |   10 +
 arch/mips/loongson/common/early_printk.c           |    2 +-
 arch/mips/loongson/common/env.c                    |   37 +++-
 arch/mips/loongson/common/gpio.c                   |   53 +++--
 arch/mips/loongson/common/machtype.c               |    5 +-
 arch/mips/loongson/common/pci.c                    |    6 +
 arch/mips/loongson/common/platform.c               |   13 +-
 arch/mips/loongson/common/serial.c                 |   48 +++-
 arch/mips/loongson/common/time.c                   |    5 +
 arch/mips/loongson/common/uart_base.c              |   30 +--
 arch/mips/loongson/loongson-3/Makefile             |    4 +-
 arch/mips/loongson/loongson-3/clock.c              |  191 +++++++++++++++
 arch/mips/loongson/loongson-3/hpet.c               |  257 ++++++++++++++++++++
 arch/mips/loongson/loongson-3/irq.c                |   16 +-
 arch/mips/loongson/loongson-3/numa.c               |   12 +-
 arch/mips/loongson/loongson-3/platform.c           |   43 ++++
 arch/mips/loongson/loongson-3/smp.c                |   70 ++++--
 arch/mips/mm/c-r4k.c                               |   18 ++
 arch/mips/oprofile/Makefile                        |    1 +
 arch/mips/oprofile/common.c                        |    4 +
 arch/mips/oprofile/op_model_loongson3.c            |  220 +++++++++++++++++
 drivers/cpufreq/Kconfig                            |   14 +
 drivers/cpufreq/Makefile                           |    1 +
 drivers/cpufreq/loongson3_cpufreq.c                |  240 ++++++++++++++++++
 drivers/platform/Makefile                          |    1 +
 drivers/platform/mips/Makefile                     |    1 +
 drivers/platform/mips/acpi_init.c                  |  131 ++++++++++
 drivers/platform/mips/cpu_hwmon.c                  |  206 ++++++++++++++++
 44 files changed, 1798 insertions(+), 110 deletions(-)
 create mode 100644 arch/mips/include/asm/hpet.h
 create mode 100644 arch/mips/include/asm/mach-loongson/loongson_hwmon.h
 create mode 100644 arch/mips/include/asm/mach-loongson/workarounds.h
 create mode 100644 arch/mips/loongson/loongson-3/clock.c
 create mode 100644 arch/mips/loongson/loongson-3/hpet.c
 create mode 100644 arch/mips/loongson/loongson-3/platform.c
 create mode 100644 arch/mips/oprofile/op_model_loongson3.c
 create mode 100644 drivers/cpufreq/loongson3_cpufreq.c
 create mode 100644 drivers/platform/mips/Makefile
 create mode 100644 drivers/platform/mips/acpi_init.c
 create mode 100644 drivers/platform/mips/cpu_hwmon.c
--
1.7.7.3
