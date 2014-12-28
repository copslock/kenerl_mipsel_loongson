Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Dec 2014 05:57:05 +0100 (CET)
Received: from smtpbguseast2.qq.com ([54.204.34.130]:34366 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007866AbaL1E4tY0Ex- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Dec 2014 05:56:49 +0100
X-QQ-mid: bizesmtp3t1419742587t008t187
Received: from localhost.localdomain (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sun, 28 Dec 2014 12:56:20 +0800 (CST)
X-QQ-SSF: 01100000002000F0FH42B00A0000000
X-QQ-FEAT: rGijdusqze5kvMcU9gHmT63xjSZwBobIjXRj5/6JPdzUdvM0J2DZ3Orloa+Br
        ZA5bqf6m/Idd3z39jgPX8KPKWrQR70ixn49hu2VdutbLauBHFK2da9qQmhS+VLUdIzp53Gp
        /7Gx5eu7rzVwFDWbBxJ4AHoNDPq4OBfsnAyUKVcVNpdnVHzxDONOaTVnclOedo6OTNT8skm
        ctuXgRIFMxQpzUzRclI5otg3KIqiGStI=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>
Subject: [PATCH V6 0/8] MIPS: Loongson-3: Improve kernel functionality
Date:   Sun, 28 Dec 2014 12:56:16 +0800
Message-Id: <1419742578-15047-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44938
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

This patchset is prepared for the next 3.20 release for Linux/MIPS. In
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

V2 -> V3:
1, Remove patches which have merged in upstream.
2, Moving GPIO driver from arch/mips to drivers/gpio directory.
3, Optimize cacheflush by moving cpu_has_coherent_cache checking from
   local version to global version.

V3 -> V4:
1, Don't build CPU Hwmon driver unconditionally.
2, Split the 2nd patch (Loongson GPIO driver) to two patches.

V4 -> V5:
1, Cleanup Loongson-2F's GPIO driver before move to drivers/gpio.

V5 -> V6:
1, Add perf support for Loongson-3.
2, Rebase the code for 3.20.

Huacai Chen(8):
 MIPS: Loongson: Introduce and use cpu_has_coherent_cache feature.
 MIPS: perf: Add hardware perf events support for Loongson-3.
 MIPS: Cleanup Loongson-2F's gpio driver.
 MIPS: Move Loongson GPIO driver to drivers/gpio.
 GPIO: Add Loongson-3A/3B GPIO driver support.
 MIPS: Loongson-3: Add CPU Hwmon platform driver.
 MIPS: Loongson-3: Add chipset ACPI platform driver.
 MIPS: Loongson: Make CPUFreq usable for Loongson-3.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
---
 arch/mips/Kconfig                                  |    6 +-
 arch/mips/configs/lemote2f_defconfig               |    1 +
 arch/mips/configs/loongson3_defconfig              |    1 +
 arch/mips/include/asm/cpu-features.h               |    3 +
 .../asm/mach-loongson/cpu-feature-overrides.h      |    1 +
 arch/mips/include/asm/mach-loongson/gpio.h         |   15 +-
 arch/mips/include/asm/mach-loongson/loongson.h     |    5 +
 arch/mips/kernel/perf_event_mipsxx.c               |   71 ++++++
 arch/mips/kernel/smp.c                             |    3 +-
 arch/mips/loongson/Kconfig                         |    1 +
 arch/mips/loongson/common/Makefile                 |    1 -
 arch/mips/loongson/common/env.c                    |    9 +
 arch/mips/loongson/common/gpio.c                   |  139 -----------
 arch/mips/loongson/common/pci.c                    |    6 +
 arch/mips/loongson/common/platform.c               |   13 +-
 arch/mips/loongson/loongson-3/Makefile             |    2 +-
 arch/mips/loongson/loongson-3/clock.c              |  191 ++++++++++++++++
 arch/mips/mm/c-r4k.c                               |   21 ++
 drivers/cpufreq/Kconfig                            |   15 ++
 drivers/cpufreq/Makefile                           |    1 +
 drivers/cpufreq/loongson3_cpufreq.c                |  240 ++++++++++++++++++++
 drivers/gpio/Kconfig                               |    6 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-loongson.c                       |  129 +++++++++++
 drivers/platform/Kconfig                           |    3 +
 drivers/platform/Makefile                          |    1 +
 drivers/platform/mips/Kconfig                      |   26 ++
 drivers/platform/mips/Makefile                     |    2 +
 drivers/platform/mips/acpi_init.c                  |  131 +++++++++++
 drivers/platform/mips/cpu_hwmon.c                  |  206 +++++++++++++++++
 30 files changed, 1097 insertions(+), 153 deletions(-)
 delete mode 100644 arch/mips/loongson/common/gpio.c
 create mode 100644 arch/mips/loongson/loongson-3/clock.c
 create mode 100644 drivers/cpufreq/loongson3_cpufreq.c
 create mode 100644 drivers/gpio/gpio-loongson.c
 create mode 100644 drivers/platform/mips/Kconfig
 create mode 100644 drivers/platform/mips/Makefile
 create mode 100644 drivers/platform/mips/acpi_init.c
 create mode 100644 drivers/platform/mips/cpu_hwmon.c
--
1.7.7.3
