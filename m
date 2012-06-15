Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2012 10:10:55 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:47368 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903386Ab2FOIKs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2012 10:10:48 +0200
Received: by dadm1 with SMTP id m1so3727436dad.36
        for <multiple recipients>; Fri, 15 Jun 2012 01:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=EDthsg/dIuMrTk39q6NxPzSDi7IscDwECGSLN8HS9Pw=;
        b=Ll6F80GpiT0MKuK6Oth3osr59SNoFjsRa5h4+vfI76P/b8i72wR4tAHEIgPPs/TrMi
         HX2GIFTJvuRjwg0flO3o4k/ydb0hMNQ+E2dZWm8MLw9ak3LpSoc2BHB6QayA+RdjyVUt
         XMdE6i+rdT9g6MzUJ8UbmzSWNnPTuKbO2SO1nNK6hBdsglNw/9c7alGgffe2PfIe03ut
         UtzKIRhk5VG33T7eHxo8mxY3jpFcS9qm1AWltQI+8C1BULUaWGefQRdi5rpi8rm+sROD
         bEDXH4ocPeHfcp0HAFUAVdgQ35ML2hrR09rD9mwuWMTjcSyR1fNzABFmz0pQVhOiSt3O
         vK5w==
Received: by 10.68.217.234 with SMTP id pb10mr17766640pbc.79.1339747840636;
        Fri, 15 Jun 2012 01:10:40 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id nh8sm12437247pbc.60.2012.06.15.01.10.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jun 2012 01:10:39 -0700 (PDT)
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH 00/14] MIPS: Add Loongson-3 based machines support.
Date:   Fri, 15 Jun 2012 16:09:47 +0800
Message-Id: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
X-archive-position: 33638
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

Huacai Chen(14):
 MIPS: Loongson: Add basic Loongson 3 CPU support.
 MIPS: Loongson 3: Add Lemote-3A machtypes definition.
 MIPS: Loongson: Make Loongson 3 to use BCD format for RTC.
 MIPS: Loongson: Add UEFI-like firmware interface support.
 MIPS: Loongson 3: Add HT-linked PCI support.
 MIPS: Loongson 3: Add IRQ init and dispatch support.
 MIPS: Loongson 3: Add serial port support.
 MIPS: Loongson: Add swiotlb to support big memory (>4GB).
 ata: Use 32bit DMA in AHCI for Loongson 3.
 drm/radeon: Make radeon card usable for Loongson.
 ALSA: Make hda sound card usable for Loongson.
 MIPS: Loongson 3: Add Loongson-3 SMP support.
 MIPS: Loongson 3: Add CPU Hotplug support.
 MIPS: Loongson: Add a Loongson 3 default config file.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
---
 arch/mips/Kconfig                                  |   23 +
 arch/mips/configs/loongson3_defconfig              |  704 ++++++++++++++++++++
 arch/mips/include/asm/addrspace.h                  |    6 +
 arch/mips/include/asm/bootinfo.h                   |   23 +-
 arch/mips/include/asm/cpu.h                        |    6 +-
 arch/mips/include/asm/mach-loongson/boot_param.h   |  150 +++++
 .../mips/include/asm/mach-loongson/dma-coherence.h |   25 +-
 arch/mips/include/asm/mach-loongson/irq.h          |   26 +
 arch/mips/include/asm/mach-loongson/loongson.h     |   29 +-
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
 arch/mips/loongson/Kconfig                         |   52 ++
 arch/mips/loongson/Makefile                        |    6 +
 arch/mips/loongson/Platform                        |    1 +
 arch/mips/loongson/common/Makefile                 |    5 +
 arch/mips/loongson/common/dma-swiotlb.c            |  147 ++++
 arch/mips/loongson/common/env.c                    |   67 ++-
 arch/mips/loongson/common/init.c                   |   14 +-
 arch/mips/loongson/common/machtype.c               |    5 +-
 arch/mips/loongson/common/mem.c                    |   42 ++
 arch/mips/loongson/common/pci.c                    |    6 +-
 arch/mips/loongson/common/reset.c                  |   14 +
 arch/mips/loongson/common/serial.c                 |   27 +
 arch/mips/loongson/common/setup.c                  |    6 +-
 arch/mips/loongson/common/uart_base.c              |    5 +
 arch/mips/loongson/loongson-3/Makefile             |    6 +
 arch/mips/loongson/loongson-3/irq.c                |   97 +++
 arch/mips/loongson/loongson-3/smp.c                |  453 +++++++++++++
 arch/mips/loongson/loongson-3/smp.h                |   24 +
 arch/mips/mm/Makefile                              |    1 +
 arch/mips/mm/c-r4k.c                               |   84 +++
 arch/mips/mm/dma-default.c                         |   13 +-
 arch/mips/mm/tlb-r4k.c                             |    2 +-
 arch/mips/mm/tlbex.c                               |    1 +
 arch/mips/pci/Makefile                             |    1 +
 arch/mips/pci/fixup-loongson3.c                    |   50 ++
 arch/mips/pci/ops-loongson3.c                      |  104 +++
 drivers/ata/ahci.c                                 |    5 +
 drivers/gpu/drm/drm_vm.c                           |    2 +-
 drivers/gpu/drm/radeon/radeon_bios.c               |   32 +
 drivers/gpu/drm/radeon/radeon_device.c             |    5 +
 drivers/gpu/drm/radeon/radeon_ttm.c                |    6 +-
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |    2 +-
 include/drm/drm_sarea.h                            |    2 +
 include/linux/pci_ids.h                            |    2 +
 sound/pci/hda/hda_intel.c                          |    5 +
 sound/pci/hda/patch_conexant.c                     |   52 ++-
 56 files changed, 2339 insertions(+), 57 deletions(-)
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
