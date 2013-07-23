Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jul 2013 09:35:03 +0200 (CEST)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:38063 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823044Ab3GWHe6MENxR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Jul 2013 09:34:58 +0200
Received: by mail-pa0-f50.google.com with SMTP id fb1so8084390pad.9
        for <multiple recipients>; Tue, 23 Jul 2013 00:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=D70wkEaxA1fvoy1BM9EQlJ6g9VfxF4fhmPmwB9BYd0A=;
        b=XR70rYnZuNww+HXVxgNEvzOTmgT0SYpSYLoDBrm24ebVOaTfVdTwSDs0L+kcuSILRh
         owFFrJ1qlFHOSQOE/vvWleG72IYomn2k5ZHL6g+8qTA3HVkcN05AnMQJbYArSyntYS1g
         POt9yOZ4lNgtGjMyse5gBL84C12+wcIlhQ5P8d+YiMdUX9AD77R/2f6TqNrrlCwagJIi
         jHzS61HoH+aPG8NJlKYxmx1NF2OpIYNMENkiKrURh/apdlcM6f7PBbz06TzoOfopAdLa
         2fQfUly4odK7ownetSGrqsMGON/dUX05jufRD/8BwO2wTHTLAuOvnwbeWp1xzEKExHP8
         xW2w==
X-Received: by 10.66.146.66 with SMTP id ta2mr36434243pab.11.1374564890979;
        Tue, 23 Jul 2013 00:34:50 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id bb1sm30359772pbc.10.2013.07.23.00.34.44
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jul 2013 00:34:49 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V11 00/13] MIPS: Add Loongson-3 based machines support
Date:   Tue, 23 Jul 2013 15:34:00 +0800
Message-Id: <1374564853-10762-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37348
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

This patchset is prepared for the next 3.12 release for Linux/MIPS. 
Loongson-3 is a multi-core MIPS family CPU, it is MIPS64R2 compatible
and has the same IMP field (0x6300) as Loongson-2. These patches make
Linux kernel support Loongson-3 CPU and Loongson-3 based computers
(including Laptop, Mini-ITX, All-In-One PC, etc.)

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

V6 -> V7:
1, Fix boot failure when NR_CPUS is more than present cpus.
2, Fix error messages after poweroff & reboot.
3, Update the default config file.
4, Sync the code to upstream.

V7 -> V8:
1, Add WEAK_ORDERING/WEAK_REORDERING_BEYOND_LLSC for Loongson-3.
2, Fix a deadlock of cpu-hotplug.
3, Include swiotlb.h in arch-specific code to avoid driver modification.
4, Remove the patch "drm: Handle io prot correctly for MIPS" since it
   is already in upstream code.
5, Remove the patch "ALSA: HDA: Make hda sound card usable for Loongson" 
   since it is already in upstream code.
6, Use LZMA compression and do some adjustment of config file to reduce
   kernel size.

V8 -> V9:
1, Fix spurious IPI interrupt.
2, remove __dev* attributes since CONFIG_HOTPLUG is going away as an option.
3, Use dev_info() to print messages in fixup-loongson3.c.
4, Update the default config file.
5, Sync the code to upstream.

V9 -> V10:
1, Rework "Introduce and use cpu_has_coherent_cache feature".
2, Handle the case that System BIOS doesn't contain a VGA BIOS.
3, Sync the code to upstream (mostly indentation adjustment).

V10 -> V11:
1, Remove normal labels and useless nops in inline assembler.
2, Sync the code to upstream (Prepared for 3.12).

Huacai Chen(13):
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
 MIPS: Loongson 3: Add Loongson-3 SMP support.
 MIPS: Loongson 3: Add CPU hotplug support.
 MIPS: Loongson: Add a Loongson-3 default config file.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
---
 arch/mips/Kconfig                                  |   30 ++
 arch/mips/configs/loongson3_defconfig              |  329 +++++++++++++++
 arch/mips/include/asm/addrspace.h                  |    6 +
 arch/mips/include/asm/bootinfo.h                   |   24 +-
 arch/mips/include/asm/cpu-features.h               |    3 +
 arch/mips/include/asm/cpu.h                        |    5 +-
 arch/mips/include/asm/dma-mapping.h                |    5 +
 arch/mips/include/asm/mach-loongson/boot_param.h   |  151 +++++++
 .../asm/mach-loongson/cpu-feature-overrides.h      |    6 +
 .../mips/include/asm/mach-loongson/dma-coherence.h |   23 +
 arch/mips/include/asm/mach-loongson/irq.h          |   24 +
 arch/mips/include/asm/mach-loongson/loongson.h     |   26 +-
 arch/mips/include/asm/mach-loongson/machine.h      |    6 +
 arch/mips/include/asm/mach-loongson/pci.h          |    5 +
 arch/mips/include/asm/mach-loongson/spaces.h       |   15 +
 arch/mips/include/asm/module.h                     |    2 +
 arch/mips/include/asm/pgtable-bits.h               |    7 +
 arch/mips/include/asm/smp.h                        |    1 +
 arch/mips/kernel/cpu-probe.c                       |   14 +-
 arch/mips/loongson/Kconfig                         |   52 +++
 arch/mips/loongson/Makefile                        |    6 +
 arch/mips/loongson/Platform                        |    1 +
 arch/mips/loongson/common/Makefile                 |    5 +
 arch/mips/loongson/common/dma-swiotlb.c            |  163 +++++++
 arch/mips/loongson/common/env.c                    |   67 +++-
 arch/mips/loongson/common/init.c                   |   14 +-
 arch/mips/loongson/common/machtype.c               |    4 +
 arch/mips/loongson/common/mem.c                    |   42 ++
 arch/mips/loongson/common/pci.c                    |    6 +-
 arch/mips/loongson/common/reset.c                  |   16 +
 arch/mips/loongson/common/serial.c                 |   26 +-
 arch/mips/loongson/common/setup.c                  |    8 +-
 arch/mips/loongson/common/uart_base.c              |    9 +-
 arch/mips/loongson/loongson-3/Makefile             |    6 +
 arch/mips/loongson/loongson-3/irq.c                |   97 +++++
 arch/mips/loongson/loongson-3/smp.c                |  444 ++++++++++++++++++++
 arch/mips/loongson/loongson-3/smp.h                |   24 +
 arch/mips/mm/c-r4k.c                               |   79 ++++-
 arch/mips/mm/tlb-r4k.c                             |    2 +-
 arch/mips/mm/tlbex.c                               |    1 +
 arch/mips/pci/Makefile                             |    1 +
 arch/mips/pci/fixup-loongson3.c                    |   68 +++
 arch/mips/pci/ops-loongson3.c                      |  104 +++++
 43 files changed, 1869 insertions(+), 58 deletions(-)
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
