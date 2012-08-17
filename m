Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Aug 2012 10:44:06 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:41142 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903451Ab2HQIn6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Aug 2012 10:43:58 +0200
Received: by yenq9 with SMTP id q9so4028527yen.36
        for <multiple recipients>; Fri, 17 Aug 2012 01:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=UgUIGcuNIpGr8BCASwOHzVsWbo1CVgbOW9EEpTLXl7I=;
        b=gta8zUvHBd4oOfSrrPu2lMW0bjb3eZlZm+ea00wTiJ3IQZ2HoLn2ZLJLQ7hoTuUvKa
         PNKtYSuRNAq4q722Yk8zNcsVB58L6p4OwELrGInheKL9QsYA5OBaVFnrHIJLFlv7IypZ
         M50GbuRpZlbAS0sZxZ9RghOjabeRbemKb1XqVyvZ2zpGSaAtpGcqYHJ2icwOUH8SAPi6
         cLtLJ4qmf8fXkHDH+EgPR+rPB283cS23I78rbM6oF/W6QM5MoHwuLoFfbRRxKMPt9u11
         ik8y23OHqEAjI8F8Rolwe4KBYTyUn75786e0hy1sx/8bvOFGH6pn4qSdEJfkmKC4HKNa
         /OVA==
Received: by 10.66.88.39 with SMTP id bd7mr7938131pab.50.1345193031983;
        Fri, 17 Aug 2012 01:43:51 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id sz3sm4503572pbc.21.2012.08.17.01.43.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 17 Aug 2012 01:43:50 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V6 00/16] MIPS: Add Loongson-3 based machines support
Date:   Fri, 17 Aug 2012 16:43:20 +0800
Message-Id: <1345193015-3024-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
X-archive-position: 34234
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
Return-Path: <linux-mips-bounce@linux-mips.org>

This patchset is for git repository git://git.linux-mips.org/pub/scm/
ralf/linux. Loongson-3 is a multi-core MIPS family CPU, it is MIPS64
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

V3 -> V4:
1, Include swiotlb.h in radeon_ttm.c if SWIOTLB configured.
2, Remove "Reviewed-by" in patches which are added by mistake.
3, Sync the code to upstream.

V4 -> V5:
1, Split the drm patch to three patches.
2, Use platform-specific pincfgs to replace old alsa quirks.

V5 -> V6:
1, For better management, two non-Loongson-specific patches are sent
   independently.
2, Introduce cpu_has_coherent_cache feature and split cache flushing
   changes to a separate patch.
3, Remove PRID_IMP_LOONGSON3 and use PRID_IMP_LOONGSON2 since they are
   the same.
4, Don't define RTC_ALWAYS_BCD for Loongson-3 since BCD format can be
   checked by RTC_CONTROL at runtime.
5, Don't modify dma-default.c for Loongson since it is unnecessary.
6, Don't define SAREA_MAX since it is useless.
7, Increase the default boost of internal mic for Lemote A1004.
8, Fix a #ifdef issue in dma-coherence.h.
9, Some other small fixes.

Huacai Chen(15):
 MIPS: Loongson: Add basic Loongson-3 definition.
 MIPS: Loongson: Add basic Loongson-3 CPU support.
 MIPS: Loongson: Introduce and use cpu_has_coherent_cache feature.
 MIPS: Loongson 3: Add Lemote-3A machtypes definition.
 MIPS: Loongson: Add UEFI-like firmware interface support.
 MIPS: Loongson 3: Add HT-linked PCI support.
 MIPS: Loongson 3: Add IRQ init and dispatch support.
 MIPS: Loongson 3: Add serial port support.
 MIPS: Loongson: Add swiotlb to support big memory (>4GB).
 MIPS: Loongson: Add Loongson-3 Kconfig options.
 drm: Handle io prot correctly for MIPS.
 ALSA: HDA: Make hda sound card usable for Loongson.
 MIPS: Loongson 3: Add Loongson-3 SMP support.
 MIPS: Loongson 3: Add CPU hotplug support.
 MIPS: Loongson: Add a Loongson-3 default config file.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
---
 arch/mips/Kconfig                                  |   27 ++
 arch/mips/configs/loongson3_defconfig              |  283 ++++++++++++
 arch/mips/include/asm/addrspace.h                  |    6 +
 arch/mips/include/asm/bootinfo.h                   |   24 +-
 arch/mips/include/asm/cacheflush.h                 |    6 +
 arch/mips/include/asm/cpu-features.h               |    6 +
 arch/mips/include/asm/cpu.h                        |    5 +-
 arch/mips/include/asm/dma-mapping.h                |    5 +
 arch/mips/include/asm/mach-loongson/boot_param.h   |  151 +++++++
 .../mips/include/asm/mach-loongson/dma-coherence.h |   19 +
 arch/mips/include/asm/mach-loongson/irq.h          |   24 +
 arch/mips/include/asm/mach-loongson/loongson.h     |   26 +-
 arch/mips/include/asm/mach-loongson/machine.h      |    6 +
 arch/mips/include/asm/mach-loongson/pci.h          |    5 +
 arch/mips/include/asm/mach-loongson/spaces.h       |   15 +
 arch/mips/include/asm/module.h                     |    2 +
 arch/mips/include/asm/pgtable-bits.h               |    7 +
 arch/mips/include/asm/smp.h                        |    1 +
 arch/mips/kernel/Makefile                          |    1 +
 arch/mips/kernel/cpu-probe.c                       |   14 +-
 arch/mips/lib/Makefile                             |    1 +
 arch/mips/loongson/Kconfig                         |   52 +++
 arch/mips/loongson/Makefile                        |    6 +
 arch/mips/loongson/Platform                        |    1 +
 arch/mips/loongson/common/Makefile                 |    5 +
 arch/mips/loongson/common/dma-swiotlb.c            |  163 +++++++
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
 arch/mips/mm/c-r4k.c                               |   83 ++++-
 arch/mips/mm/tlb-r4k.c                             |    2 +-
 arch/mips/mm/tlbex.c                               |    1 +
 arch/mips/pci/Makefile                             |    1 +
 arch/mips/pci/fixup-loongson3.c                    |   64 +++
 arch/mips/pci/ops-loongson3.c                      |  104 +++++
 drivers/gpu/drm/drm_vm.c                           |    2 +-
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |    2 +-
 sound/pci/hda/patch_conexant.c                     |   44 ++
 49 files changed, 1878 insertions(+), 69 deletions(-)
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
