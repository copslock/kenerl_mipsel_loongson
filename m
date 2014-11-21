Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2014 10:15:49 +0100 (CET)
Received: from mail-pd0-f182.google.com ([209.85.192.182]:47087 "EHLO
        mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006542AbaKUJPnJ7szm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Nov 2014 10:15:43 +0100
Received: by mail-pd0-f182.google.com with SMTP id r10so4929309pdi.13
        for <multiple recipients>; Fri, 21 Nov 2014 01:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=lixFvA23RH2AOqTdo2jtweCXcnz1cNwMD+jlrxRqwPA=;
        b=MTUgj8nNy4sC5HZsGL5rNb7Qr1apx+pCBip/+hTTcaKV1D49SNgVaBZH5Y1R7d0YH5
         IzLqhap4Ll9ctJo9L266nZZGPWkTpAMp3GR1QoCseUISdSx/7dPQiqvQGdKRiAacnNwd
         UaYCh8RBkm9yhJwN4mHNTeAfHOpm36k9BP/OqAd5yyDSVnMkCtwuLDy3YyGWmphcDdaV
         QXXB5Q709ssJ8wrAcPQH98AJkl0qcVv21vJTvsIn22/UlpHdI6PQ+WSUhexOvAlhClt9
         bJ+wmp8eB8OKGUKbn/NDyKr9ji1SfLbSu1xZf1/pWjUj3zwAwc3l009AqmOlQUOyxx6T
         vDSg==
X-Received: by 10.70.90.80 with SMTP id bu16mr5343402pdb.44.1416561336403;
        Fri, 21 Nov 2014 01:15:36 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id fb7sm4263864pab.10.2014.11.21.01.15.33
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 21 Nov 2014 01:15:35 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>
Subject: [PATCH V5 0/7] MIPS: Loongson-3: Improve kernel functionality
Date:   Fri, 21 Nov 2014 17:12:39 +0800
Message-Id: <1416561160-31199-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44330
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

V3 -> V4:
1, Don't build CPU Hwmon driver unconditionally.
2, Split the 2nd patch (Loongson GPIO driver) to two patches.

V4 -> V5:
1, Cleanup Loongson-2F's GPIO driver before move to drivers/gpio.

Huacai Chen(7):
 MIPS: Loongson: Introduce and use cpu_has_coherent_cache feature.
 MIPS: Cleanup Loongson-2F's gpio driver.
 MIPS: Move Loongson GPIO driver to drivers/gpio.
 GPIO: Add Loongson-3A/3B GPIO driver support.
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
 arch/mips/include/asm/mach-loongson/gpio.h         |   15 +-
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
 drivers/gpio/gpio-loongson.c                       |  129 +++++++++++
 drivers/platform/Kconfig                           |    3 +
 drivers/platform/Makefile                          |    1 +
 drivers/platform/mips/Kconfig                      |   26 ++
 drivers/platform/mips/Makefile                     |    2 +
 drivers/platform/mips/acpi_init.c                  |  131 +++++++++++
 drivers/platform/mips/cpu_hwmon.c                  |  206 +++++++++++++++++
 29 files changed, 1024 insertions(+), 152 deletions(-)
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
