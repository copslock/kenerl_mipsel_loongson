Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Aug 2012 10:10:13 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:48234 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903414Ab2HLIKJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Aug 2012 10:10:09 +0200
Received: by lbbgf7 with SMTP id gf7so1477794lbb.36
        for <linux-mips@linux-mips.org>; Sun, 12 Aug 2012 01:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=v4gBiLtRzq6Cu8Ui942LQFgmldqq5zcCyq7eykiZYEc=;
        b=sF2ib7E5uM63QSNhjoVdcxsYMYH43e9oUbVesrvP/b2DnBWjyd69oz4gDgsK/NODDa
         YIRiMcFLYLDaYDYRoowpfbxTCBpNlj8L67xAT+Vx3bGA9ezDHJU4LTBNK1UHZCtj14D+
         8cxAWJcExPRB67duTldwnpENKDu5vXzSalEM+To9DczxWjhsrvGTXN9PeoKn8N4nZozB
         RIz1Qv5FIV+d96TnCXEwSR3NOU43UN1Sh8nrOo27XAUHVt893XUzpfSPzaNV6xsgJzDe
         SRP/Kg/Zc+AbFlhto3ZSXZRv7DKnGtjItsHouhYlTfFqC9VXNuSUa4Fx3IWy3LD+bsp7
         aHrw==
MIME-Version: 1.0
Received: by 10.152.105.173 with SMTP id gn13mr8142949lab.20.1344759003232;
 Sun, 12 Aug 2012 01:10:03 -0700 (PDT)
Received: by 10.152.105.51 with HTTP; Sun, 12 Aug 2012 01:10:03 -0700 (PDT)
In-Reply-To: <5027498C.6020205@phrozen.org>
References: <1344677543-22591-1-git-send-email-chenhc@lemote.com>
        <5027498C.6020205@phrozen.org>
Date:   Sun, 12 Aug 2012 16:10:03 +0800
Message-ID: <CAAhV-H4J+0wZVw2FevTf2P5wCDHfZ6=WGA9sZ1OipvFiVe=g5g@mail.gmail.com>
Subject: Re: [PATCH V5 00/16] MIPS: Add Loongson-3 based machines support.
From:   Huacai Chen <chenhuacai@gmail.com>
To:     John Crispin <john@phrozen.org>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34118
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

Thank you, I think the 11th and 17th patch can be sent independently,
and the 14th patch can be sent after the Loongson patch series.

On Sun, Aug 12, 2012 at 2:13 PM, John Crispin <john@phrozen.org> wrote:
>
>
>
>
>
>
>
> On 11/08/12 11:32, Huacai Chen wrote:
>> This patchset is for git repository git://git.linux-mips.org/pub/scm/
>> ralf/linux. Loongson-3 is a multi-core MIPS family CPU, it is MIPS64R2
>> compatible and has the same IMP field (0x6300) as Loongson-2. These
>> patches make Linux kernel support Loongson-3 CPU and Loongson-3 based
>> computers (including Laptop, Mini-ITX, All-In-One PC, etc.)
>>
>> V1 -> V2:
>> 1, Split the first patch to two patches, one is constant definition and
>>    the other is CPU probing, cache initializing, etc.
>> 2, Remove Kconfig options in the first 9 patches and put all of them in
>>    the 10th patch.
>> 3, Use "make savedefconfig" to generate the new default config file.
>> 4, Rework serial port support to use PORT and PORT_M macros.
>> 5, Fix some compile warnings.
>>
>> V2 -> V3:
>> 1, Improve cache flushing code (use cpu_has_coherent_cache macro and
>>    remove #ifdef clauses).
>> 2, Improve platform-specific code to correctly set driver's dma_mask/
>>    coherent_dma_mask so no longer need workarounds for each driver (
>>    SATA, graphics card, sound card, etc.)
>> 3, Use PCI quirk to provide vgabios and loongson3_read_bios() go away.
>> 4, Improve CPU hotplug code and split the poweroff failure related code
>>    to another patch (this issue affect all MIPS CPU, not only Loongson).
>> 5, Some other small fixes.
>>
>> V3 -> V4:
>> 1, Include swiotlb.h in radeon_ttm.c if SWIOTLB configured.
>> 2, Remove "Reviewed-by" in patches which are added by mistake.
>> 3, Sync the code to upstream.
>>
>> V4 -> V5:
>> 1, Split the drm patch to three patches.
>> 2, Use platform-specific pincfgs to replace old alsa quirks.
>>
>> Huacai Chen(18):
>>  MIPS: Loongson: Add basic Loongson-3 definition.
>>  MIPS: Loongson: Add basic Loongson-3 CPU support.
>>  MIPS: Loongson 3: Add Lemote-3A machtypes definition.
>>  MIPS: Loongson: Make Loongson-3 to use BCD format for RTC.
>>  MIPS: Loongson: Add UEFI-like firmware interface support.
>>  MIPS: Loongson 3: Add HT-linked PCI support.
>>  MIPS: Loongson 3: Add IRQ init and dispatch support.
>>  MIPS: Loongson 3: Add serial port support.
>>  MIPS: Loongson: Add swiotlb to support big memory (>4GB).
>>  MIPS: Loongson: Add Loongson-3 Kconfig options.
>>  drm/radeon: Include swiotlb.h if SWIOTLB configured.
>>  drm: Handle io prot correctly for MIPS.
>>  drm: Define SAREA_MAX for Loongson (PageSize = 16KB).
>>  ALSA: HDA: Make hda sound card usable for Loongson.
>>  MIPS: Loongson 3: Add Loongson-3 SMP support.
>>  MIPS: Loongson 3: Add CPU hotplug support.
>>  MIPS: Fix poweroff failure when HOTPLUG_CPU configured.
>>  MIPS: Loongson: Add a Loongson-3 default config file.
>>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> Signed-off-by: Hongliang Tao <taohl@lemote.com>
>> Signed-off-by: Hua Yan <yanh@lemote.com>
>
>
> I just noticed, that you are cc'ing lkml for a series that is 14/18 MIPS
> and the rest subsystems. Please read davem's mail and reconsider posting
> a 18 patch series to lkml.
>
> -> http://marc.info/?l=linux-kernel&m=112112749912944&w=2
>
>
>
>
>
>
>
>
>
>> ---
>>  arch/mips/Kconfig                                  |   23 +
>>  arch/mips/configs/loongson3_defconfig              |  283 ++++++++++++
>>  arch/mips/include/asm/addrspace.h                  |    6 +
>>  arch/mips/include/asm/bootinfo.h                   |   24 +-
>>  arch/mips/include/asm/cpu.h                        |    6 +-
>>  arch/mips/include/asm/dma-mapping.h                |    5 +
>>  arch/mips/include/asm/mach-loongson/boot_param.h   |  151 +++++++
>>  .../mips/include/asm/mach-loongson/dma-coherence.h |   25 +-
>>  arch/mips/include/asm/mach-loongson/irq.h          |   24 +
>>  arch/mips/include/asm/mach-loongson/loongson.h     |   26 +-
>>  arch/mips/include/asm/mach-loongson/machine.h      |    6 +
>>  arch/mips/include/asm/mach-loongson/mc146818rtc.h  |    4 +
>>  arch/mips/include/asm/mach-loongson/pci.h          |    5 +
>>  arch/mips/include/asm/mach-loongson/spaces.h       |   15 +
>>  arch/mips/include/asm/module.h                     |    2 +
>>  arch/mips/include/asm/pgtable-bits.h               |    7 +
>>  arch/mips/include/asm/smp.h                        |    1 +
>>  arch/mips/kernel/Makefile                          |    1 +
>>  arch/mips/kernel/cpu-probe.c                       |   12 +-
>>  arch/mips/kernel/process.c                         |    4 +-
>>  arch/mips/lib/Makefile                             |    1 +
>>  arch/mips/loongson/Kconfig                         |   52 +++
>>  arch/mips/loongson/Makefile                        |    6 +
>>  arch/mips/loongson/Platform                        |    1 +
>>  arch/mips/loongson/common/Makefile                 |    5 +
>>  arch/mips/loongson/common/dma-swiotlb.c            |  159 +++++++
>>  arch/mips/loongson/common/env.c                    |   67 +++-
>>  arch/mips/loongson/common/init.c                   |   14 +-
>>  arch/mips/loongson/common/machtype.c               |   20 +-
>>  arch/mips/loongson/common/mem.c                    |   42 ++
>>  arch/mips/loongson/common/pci.c                    |    6 +-
>>  arch/mips/loongson/common/reset.c                  |   14 +
>>  arch/mips/loongson/common/serial.c                 |   26 +-
>>  arch/mips/loongson/common/setup.c                  |    8 +-
>>  arch/mips/loongson/common/uart_base.c              |    9 +-
>>  arch/mips/loongson/loongson-3/Makefile             |    6 +
>>  arch/mips/loongson/loongson-3/irq.c                |   97 +++++
>>  arch/mips/loongson/loongson-3/smp.c                |  449 ++++++++++++++++++++
>>  arch/mips/loongson/loongson-3/smp.h                |   24 +
>>  arch/mips/mm/Makefile                              |    1 +
>>  arch/mips/mm/c-r4k.c                               |   94 ++++-
>>  arch/mips/mm/dma-default.c                         |   13 +-
>>  arch/mips/mm/tlb-r4k.c                             |    2 +-
>>  arch/mips/mm/tlbex.c                               |    1 +
>>  arch/mips/pci/Makefile                             |    1 +
>>  arch/mips/pci/fixup-loongson3.c                    |   64 +++
>>  arch/mips/pci/ops-loongson3.c                      |  104 +++++
>>  drivers/gpu/drm/drm_vm.c                           |    2 +-
>>  drivers/gpu/drm/radeon/radeon_ttm.c                |    4 +
>>  drivers/gpu/drm/ttm/ttm_bo_util.c                  |    2 +-
>>  include/drm/drm_sarea.h                            |    2 +
>>  include/linux/pci_ids.h                            |    2 +
>>  sound/pci/hda/patch_conexant.c                     |   24 +
>>  53 files changed, 1877 insertions(+), 75 deletions(-)
>>  create mode 100644 arch/mips/configs/loongson3_defconfig
>>  create mode 100644 arch/mips/include/asm/mach-loongson/boot_param.h
>>  create mode 100644 arch/mips/include/asm/mach-loongson/irq.h
>>  create mode 100644 arch/mips/include/asm/mach-loongson/spaces.h
>>  create mode 100644 arch/mips/loongson/common/dma-swiotlb.c
>>  create mode 100644 arch/mips/loongson/loongson-3/Makefile
>>  create mode 100644 arch/mips/loongson/loongson-3/irq.c
>>  create mode 100644 arch/mips/loongson/loongson-3/smp.c
>>  create mode 100644 arch/mips/loongson/loongson-3/smp.h
>>  create mode 100644 arch/mips/pci/fixup-loongson3.c
>>  create mode 100644 arch/mips/pci/ops-loongson3.c
>
>
