Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2012 08:51:44 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:54432 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903562Ab2FSGvj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2012 08:51:39 +0200
Received: by pbbrq13 with SMTP id rq13so9836365pbb.36
        for <multiple recipients>; Mon, 18 Jun 2012 23:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=v1iq90mwioqal0w5LMFTz1jDaJiHLSOWXhfri01EWKg=;
        b=p4/T14uSK+bQCKUGnerQEQaLpLeTdQRjQDzomANbvx4JK9iZqyPv5YSIF9WGVPt7sK
         kWpA0asHCDxtAvmLpXAnvOJHfwngKfsqJsBhjE4QYnUvECG2MkPZcU205SKUOLn97rhl
         BTCIM/yUf3lHKb3biVnF75T6frgJULEIk5VWMAdOUN+hX6PT0RZGmsDRN8UakdItTLbO
         gpYNTrUgIEqiCnV28/6y+oxn+nShJQmD7CrkL/ZU9rmJr9UCLYSDRIW2XPqGol5xl8nC
         EaN6NWEOEu1IankpS/70oyWej0nLub/QedY7S8uv+pSHFntk++d1HsZO+ENGDBn/Qs4o
         tsMg==
Received: by 10.68.136.68 with SMTP id py4mr19141449pbb.151.1340088689899;
        Mon, 18 Jun 2012 23:51:29 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id gk3sm20156319pbc.1.2012.06.18.23.51.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jun 2012 23:51:28 -0700 (PDT)
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V2 00/14] MIPS: Add Loongson-3 based machines support.
Date:   Tue, 19 Jun 2012 14:50:08 +0800
Message-Id: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
X-archive-position: 33690
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
 ata: Use 32bit DMA in AHCI for Loongson 3.
 drm/radeon: Make radeon card usable for Loongson.
 ALSA: HDA: Make hda sound card usable for Loongson.
 MIPS: Loongson 3: Add Loongson-3 SMP support.
 MIPS: Loongson 3: Add CPU Hotplug support.
 MIPS: Loongson: Add a Loongson-3 default config file.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
---
 arch/mips/Kconfig                                  |   23 +
 arch/mips/configs/loongson3_defconfig              |  279 ++++++++++++
 arch/mips/include/asm/addrspace.h                  |    6 +
 arch/mips/include/asm/bootinfo.h                   |   23 +-
 arch/mips/include/asm/cpu.h                        |    6 +-
 arch/mips/include/asm/mach-loongson/boot_param.h   |  150 +++++++
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
 arch/mips/loongson/common/dma-swiotlb.c            |  147 +++++++
 arch/mips/loongson/common/env.c                    |   67 +++-
 arch/mips/loongson/common/init.c                   |   14 +-
 arch/mips/loongson/common/machtype.c               |    5 +-
 arch/mips/loongson/common/mem.c                    |   42 ++
 arch/mips/loongson/common/pci.c                    |    6 +-
 arch/mips/loongson/common/reset.c                  |   14 +
 arch/mips/loongson/common/serial.c                 |   25 +-
 arch/mips/loongson/common/setup.c                  |    6 +-
 arch/mips/loongson/common/uart_base.c              |    8 +-
 arch/mips/loongson/loongson-3/Makefile             |    6 +
 arch/mips/loongson/loongson-3/irq.c                |   97 +++++
 arch/mips/loongson/loongson-3/smp.c                |  453 ++++++++++++++++++++
 arch/mips/loongson/loongson-3/smp.h                |   24 +
 arch/mips/mm/Makefile                              |    1 +
 arch/mips/mm/c-r4k.c                               |   84 ++++
 arch/mips/mm/dma-default.c                         |   13 +-
 arch/mips/mm/tlb-r4k.c                             |    2 +-
 arch/mips/mm/tlbex.c                               |    1 +
 arch/mips/pci/Makefile                             |    1 +
 arch/mips/pci/fixup-loongson3.c                    |   50 +++
 arch/mips/pci/ops-loongson3.c                      |  104 +++++
 drivers/ata/ahci.c                                 |    5 +
 drivers/gpu/drm/drm_vm.c                           |    2 +-
 drivers/gpu/drm/radeon/radeon_bios.c               |   32 ++
 drivers/gpu/drm/radeon/radeon_device.c             |    5 +
 drivers/gpu/drm/radeon/radeon_ttm.c                |    6 +-
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |    2 +-
 include/drm/drm_sarea.h                            |    2 +
 include/linux/pci_ids.h                            |    2 +
 sound/pci/hda/hda_intel.c                          |    5 +
 sound/pci/hda/patch_conexant.c                     |   52 +++-
 56 files changed, 1898 insertions(+), 69 deletions(-)
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
