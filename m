Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jun 2012 05:02:07 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:64551 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903464Ab2FVDCC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jun 2012 05:02:02 +0200
Received: by pbbrq13 with SMTP id rq13so3155885pbb.36
        for <multiple recipients>; Thu, 21 Jun 2012 20:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=e31BDD8IKqZDtMJJHNa7qG09lQ4w1oBE72L5SO34Bw4=;
        b=ENYhY3Ng2zWsaNgmuwdWRZI5StWcOzqoQ1HEQ3Ow6VTDUb1fva9QsQXeaAWI5kb4vc
         AKr/LmzzgX9B1sLIXuG1L/96zJY4Ybu+PF2JK5q8lUQXzu/x8ZRJ5DGhibxHMdXsuBb5
         zxlv5E6+nq5TtH2H7Uu5F+GtPM1pZ4sFD6Bdg5P855XbxNOhBwDSSYDaVzkhEGD/aNNm
         Z6U3yUBCS8r53xUpW8fOWYwzAiU71iPGaRmAJOB6vUPWYbW7vXNkmd5QWdDVKCRjHcID
         0jBedN6IBXqJpmqXZvNaUFUXVDperxav0ewU8hn1p6kHHQr2Aspw5IjHzHIMAkIhrSaa
         SWfA==
Received: by 10.68.218.103 with SMTP id pf7mr5394834pbc.67.1340334114715;
        Thu, 21 Jun 2012 20:01:54 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id wk3sm37516519pbc.21.2012.06.21.20.01.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jun 2012 20:01:53 -0700 (PDT)
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V3 00/16] MIPS: Add Loongson-3 based machines support.
Date:   Fri, 22 Jun 2012 11:00:57 +0800
Message-Id: <1340334073-17804-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
X-archive-position: 33757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

This patchset is for git repository git://git.linux-mips.org/pub/scm/
ralf/linux. Loongson-3 is a multi-core MIPS family CPU, it is MIPS64R2
compatible and has the same IMP field (0x6300) as Loongson-2. These
patches make Linux kernel support Loongson-3 CPU and Loongson-3 based
computers (including Laptop, Mini-ITX, All-In-One PC, etc.)

V1 -> V2:
1, Split the first patch to two patches, one is constant definition and
   the other is CPU probing, cache initializing, etc.
2, Remove Kconfig options in the first 9 patches and put all of them in
   the 10th patch.
3, Use "make savedefconfig" to generate the new default config file.
4, Rework serial port support to use PORT and PORT_M macros.
5, Fix some compile warnings.

V2 -> V3:
1, Improve cache flushing code (use cpu_has_coherent_cache macro and
   remove #ifdef clauses).
2, Improve platform-specific code to correctly set driver's dma_mask/
   coherent_dma_mask so no longer need workarounds for each driver (
   SATA, graphics card, sound card, etc.)
3, Use PCI quirk to provide vgabios and loongson3_read_bios() go away.
4, Improve CPU hotplug code and split the poweroff failure related code
   to another patch (this issue affect all MIPS CPU, not only Loongson).
5, Some other small fixes.

Huacai Chen(16):
 MIPS: Loongson: Add basic Loongson-3 definition.
 MIPS: Loongson: Add basic Loongson-3 CPU support.
 MIPS: Loongson 3: Add Lemote-3A machtypes definition.
 MIPS: Loongson: Make Loongson-3 to use BCD format for RTC.
 MIPS: Loongson: Add UEFI-like firmware interface support.
 MIPS: Loongson 3: Add HT-linked PCI support.
 MIPS: Loongson 3: Add IRQ init and dispatch support.
 MIPS: Loongson 3: Add serial port support.
 MIPS: Loongson: Add swiotlb to support big memory (>4GB).
 MIPS: Loongson: Add Loongson-3 Kconfig options.
 drm/radeon: Make radeon card usable for Loongson.
 ALSA: HDA: Make hda sound card usable for Loongson.
 MIPS: Loongson 3: Add Loongson-3 SMP support.
 MIPS: Loongson 3: Add CPU hotplug support.
 MIPS: Fix poweroff failure when HOTPLUG_CPU configured.
 MIPS: Loongson: Add a Loongson-3 default config file.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
---
 arch/mips/Kconfig                                  |   23 +
 arch/mips/configs/loongson3_defconfig              |  279 ++++++++++++
 arch/mips/include/asm/addrspace.h                  |    6 +
 arch/mips/include/asm/bootinfo.h                   |   24 +-
 arch/mips/include/asm/cpu.h                        |    6 +-
 arch/mips/include/asm/dma-mapping.h                |    5 +
 arch/mips/include/asm/mach-loongson/boot_param.h   |  151 +++++++
 .../mips/include/asm/mach-loongson/dma-coherence.h |   25 +-
 arch/mips/include/asm/mach-loongson/irq.h          |   24 +
 arch/mips/include/asm/mach-loongson/loongson.h     |   26 +-
 arch/mips/include/asm/mach-loongson/machine.h      |    6 +
 arch/mips/include/asm/mach-loongson/mc146818rtc.h  |    4 +
 arch/mips/include/asm/mach-loongson/pci.h          |    5 +
 arch/mips/include/asm/mach-loongson/spaces.h       |   15 +
 arch/mips/include/asm/module.h                     |    2 +
 arch/mips/include/asm/pgtable-bits.h               |    7 +
 arch/mips/include/asm/smp.h                        |    1 +
 arch/mips/kernel/Makefile                          |    1 +
 arch/mips/kernel/cpu-probe.c                       |   12 +-
 arch/mips/kernel/process.c                         |    4 +-
 arch/mips/lib/Makefile                             |    1 +
 arch/mips/loongson/Kconfig                         |   52 +++
 arch/mips/loongson/Makefile                        |    6 +
 arch/mips/loongson/Platform                        |    1 +
 arch/mips/loongson/common/Makefile                 |    5 +
 arch/mips/loongson/common/dma-swiotlb.c            |  159 +++++++
 arch/mips/loongson/common/env.c                    |   67 +++-
 arch/mips/loongson/common/init.c                   |   14 +-
 arch/mips/loongson/common/machtype.c               |   20 +-
 arch/mips/loongson/common/mem.c                    |   42 ++
 arch/mips/loongson/common/pci.c                    |    6 +-
 arch/mips/loongson/common/reset.c                  |   14 +
 arch/mips/loongson/common/serial.c                 |   26 +-
 arch/mips/loongson/common/setup.c                  |    8 +-
 arch/mips/loongson/common/uart_base.c              |    9 +-
 arch/mips/loongson/loongson-3/Makefile             |    6 +
 arch/mips/loongson/loongson-3/irq.c                |   97 +++++
 arch/mips/loongson/loongson-3/smp.c                |  449 ++++++++++++++++++++
 arch/mips/loongson/loongson-3/smp.h                |   24 +
 arch/mips/mm/Makefile                              |    1 +
 arch/mips/mm/c-r4k.c                               |   94 ++++-
 arch/mips/mm/dma-default.c                         |   13 +-
 arch/mips/mm/tlb-r4k.c                             |    2 +-
 arch/mips/mm/tlbex.c                               |    1 +
 arch/mips/pci/Makefile                             |    1 +
 arch/mips/pci/fixup-loongson3.c                    |   64 +++
 arch/mips/pci/ops-loongson3.c                      |  104 +++++
 drivers/gpu/drm/drm_vm.c                           |    2 +-
 drivers/gpu/drm/radeon/radeon_ttm.c                |    6 +-
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |    2 +-
 include/drm/drm_sarea.h                            |    2 +
 include/linux/pci_ids.h                            |    2 +
 sound/pci/hda/patch_conexant.c                     |   52 +++-
 53 files changed, 1898 insertions(+), 80 deletions(-)
 create mode 100644 arch/mips/configs/loongson3_defconfig
 create mode 100644 arch/mips/include/asm/mach-loongson/boot_param.h
 create mode 100644 arch/mips/include/asm/mach-loongson/irq.h
 create mode 100644 arch/mips/include/asm/mach-loongson/spaces.h
 create mode 100644 arch/mips/loongson/common/dma-swiotlb.c
 create mode 100644 arch/mips/loongson/loongson-3/Makefile
 create mode 100644 arch/mips/loongson/loongson-3/irq.c
 create mode 100644 arch/mips/loongson/loongson-3/smp.c
 create mode 100644 arch/mips/loongson/loongson-3/smp.h
 create mode 100644 arch/mips/pci/fixup-loongson3.c
 create mode 100644 arch/mips/pci/ops-loongson3.c
-- 
1.7.7.3
