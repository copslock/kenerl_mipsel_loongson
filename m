Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Sep 2014 10:00:49 +0200 (CEST)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:47706 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006718AbaIMIAqV7Wg2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Sep 2014 10:00:46 +0200
Received: by mail-pa0-f41.google.com with SMTP id bj1so2905816pad.14
        for <multiple recipients>; Sat, 13 Sep 2014 01:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=eijcIruOT+q1ACtCzFPg1b8z4nqZwImtQsWUc9uo0GM=;
        b=riyL2BZZwWJPkabbl6AqmhF0SRkSbwDeiD8lpHaE976yAop0dfexM0HZhu7UO9Esmx
         3tmm8XlJQyyEPmTIbY3d0eyyklBtl8xcw+HETtAk6JcH5MCcGa/YzU1oveRdvNcJQmha
         7xLrDpHSf3E7lmx5QVn4ppClVhRJfaiSw7S/7vKkQCyyv6ib/yB1WM/r1pR9qb2KIbEp
         0z5zQOopnzzP2jh/tm6uAXgex5IUuBCQEIcLaGxKx7G7NQ2I75GBDLLaa/cHAJ2mIhC8
         CXjOoQnRn147oqjyREdWLWt/Asdrr5YQUxbvyTZ/EMe4jAEixDfxly+lTLdgZXoB1/R0
         bkEQ==
X-Received: by 10.70.21.202 with SMTP id x10mr22106346pde.92.1410595239609;
        Sat, 13 Sep 2014 01:00:39 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id wh10sm6062397pac.20.2014.09.13.01.00.36
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 13 Sep 2014 01:00:39 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>
Subject: [PATCH 0/11] MIPS: Loongson-3: Improve kernel functionality
Date:   Sat, 13 Sep 2014 15:59:58 +0800
Message-Id: <1410595207-10994-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42528
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

This patchset is prepared for the next 3.18 release for Linux/MIPS. In
this series we promote Loongson-3's ISA level to MIPS64R1 since it is
not fully compatible with MIPS64R2. Multi-node DMA and coherent cache
features are both added here. LEFI firmware interface is improved to
make the kernel more generic (machtypes can be dropped). Besides, we
add some basic platform drivers (GPIO, CPU Hwmon, ACPI init, oprofile,
HPET and CPUFreq) for Loongson-3. 

Huacai Chen(11):
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
