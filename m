Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 13:17:24 +0100 (CET)
Received: from mail-pd0-f181.google.com ([209.85.192.181]:32941 "EHLO
        mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013374AbaKLMRVjoAYQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 13:17:21 +0100
Received: by mail-pd0-f181.google.com with SMTP id y10so12170432pdj.40
        for <multiple recipients>; Wed, 12 Nov 2014 04:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=UaKleZrRRQXAECrnNuEqvnCuV8GGV5saOyaj32mTfU4=;
        b=pNGR2be+iHNxFOQcN1edPlJi8kG1bmXPIc6kqJTnMEiLDHE2bY4tcIiYt7R5SP8H3y
         J09pPOCHv5FCijOZQHVif6FjfEaT+V9oflCIIAGn9KiN2dV0u9RaKjkRrVq4bRonjiFp
         DsXWQ091289939Ykk2a2SV4qECW+KaphNnAjpytCV00RUggYA5SePoW6HC0A02cyi5MS
         s7egaMw0popVbFmjfZEZ5WnhDva6Na5ATckRFL8W1mOS+oE0//flK7EwqSFkzpWp9goz
         VmxvnmNDrjmnVnuh6ppBz9g6aA/loGfPwY36HpLMKGcwMJU87bxec44N4zR3rZ96IMC0
         K5Aw==
X-Received: by 10.66.140.69 with SMTP id re5mr47317962pab.18.1415794634751;
        Wed, 12 Nov 2014 04:17:14 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id u8sm7261864pdr.10.2014.11.12.04.17.11
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 12 Nov 2014 04:17:13 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>
Subject: [PATCH V3 0/5] MIPS: Loongson-3: Improve kernel functionality
Date:   Wed, 12 Nov 2014 20:17:00 +0800
Message-Id: <1415794620-7480-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44051
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

V2 -> V3:
1, Remove patches which have merged in upstream.
2, Moving GPIO driver from arch/mips to drivers/gpio directory.
3, Optimize cacheflush by moving cpu_has_coherent_cache checking from
   local version to global version.

Huacai Chen(5):
 MIPS: Loongson: Introduce and use cpu_has_coherent_cache feature.
 MIPS: Loongson: Add Loongson-3A/3B GPIO support.
 MIPS: Loongson-3: Add CPU Hwmon platform driver.
 MIPS: Loongson-3: Add chipset ACPI platform driver.
 MIPS: Loongson: Make CPUFreq usable for Loongson-3.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
---
 arch/mips/Kconfig                                  |    4 +
 arch/mips/configs/lemote2f_defconfig               |    1 +
 arch/mips/configs/loongson3_defconfig              |    1 +
 arch/mips/include/asm/cpu-features.h               |    3 +
 .../asm/mach-loongson/cpu-feature-overrides.h      |    1 +
 arch/mips/include/asm/mach-loongson/loongson.h     |    5 +
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
 drivers/cpufreq/Kconfig                            |   14 ++
 drivers/cpufreq/Makefile                           |    1 +
 drivers/cpufreq/loongson3_cpufreq.c                |  240 ++++++++++++++++++++
 drivers/gpio/Kconfig                               |    6 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-loongson.c                       |  148 ++++++++++++
 drivers/platform/Kconfig                           |    3 +
 drivers/platform/Makefile                          |    1 +
 drivers/platform/mips/Kconfig                      |   26 ++
 drivers/platform/mips/Makefile                     |    2 +
 drivers/platform/mips/acpi_init.c                  |  131 +++++++++++
 drivers/platform/mips/cpu_hwmon.c                  |  206 +++++++++++++++++
 28 files changed, 1035 insertions(+), 145 deletions(-)
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
