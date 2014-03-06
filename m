Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Mar 2014 14:23:03 +0100 (CET)
Received: from mail-bk0-f45.google.com ([209.85.214.45]:36021 "EHLO
        mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822478AbaCFNW5yzP8a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Mar 2014 14:22:57 +0100
Received: by mail-bk0-f45.google.com with SMTP id na10so695770bkb.32
        for <multiple recipients>; Thu, 06 Mar 2014 05:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=qjO7K95BqkY1am0mBJ/d0QH6bGiv4Jogvrb+kqCrFq8=;
        b=BRpCfEN9FhnFjz3E5I9z/YzPNTGlZsFTIZqqLXdQ8RXqIjR2J50+IydMJHoPgHQXSN
         IY6mjRb7E5yDXapWiyZNmCIXGM5sVJUrMLgQtCWmO9Q15KLeghp32WFdL4yoyBOgxXF8
         FL5QFZhuziWXNNLGu4xIUnIvWX8MPwlP95UfNPRlpkwiUeUh2xp7X9FdO2nh0qRZ3PTq
         RhxnYuiE4qhLXmOvHVDJk1Uf/gvzKA9a4fLfdt1Vc12cGagdLDsW7XBRFzlDfkMAgOA0
         woawwNoIymXMw4ziLLspd4hTdFhg4dnIm3lZ3YF0yxc0nUMBzaYRJt1pODJbTj4rabed
         CD5Q==
MIME-Version: 1.0
X-Received: by 10.204.61.200 with SMTP id u8mr320841bkh.64.1394112172217; Thu,
 06 Mar 2014 05:22:52 -0800 (PST)
Received: by 10.204.169.76 with HTTP; Thu, 6 Mar 2014 05:22:52 -0800 (PST)
In-Reply-To: <20140306103017.GX16461@mails.so.argh.org>
References: <1392537690-5961-1-git-send-email-chenhc@lemote.com>
        <20140306103017.GX16461@mails.so.argh.org>
Date:   Thu, 6 Mar 2014 21:22:52 +0800
X-Google-Sender-Auth: 9ObMQWEYO_UhtjlR_eBL6KmFGbE
Message-ID: <CAAhV-H63AVebQCs8uCAp7wnVF=TfzqECftkML4GfKiwamFt2Gg@mail.gmail.com>
Subject: Re: [PATCH V19 00/13] MIPS: Add Loongson-3 based machines support
From:   Huacai Chen <chenhc@lemote.com>
To:     Andreas Barth <aba@ayous.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39431
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

Hi,

I think it's time to merge now :)

Huacai

On Thu, Mar 6, 2014 at 6:30 PM, Andreas Barth <aba@ayous.org> wrote:
> Hi together,
>
> looking at the review comment it seems to me like this patch set could
> go into mainline now. Or am I missing something?
>
> Would be good if we could get into the next merge cycle.
>
>
> Andi
>
>
> * Huacai Chen (chenhc@lemote.com) [140216 09:03]:
>> This patchset is prepared for the next 3.15 release for Linux/MIPS.
>> Loongson-3 is a multi-core MIPS family CPU, it is MIPS64R2 compatible
>> and has the same IMP field (0x6300) as Loongson-2. These patches make
>> Linux kernel support Loongson-3 CPU and Loongson-3 based computers
>> (including Laptop, Mini-ITX, All-In-One PC, etc.)
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
>> V5 -> V6:
>> 1, For better management, two non-Loongson-specific patches are sent
>>    independently.
>> 2, Introduce cpu_has_coherent_cache feature and split cache flushing
>>    changes to a separate patch.
>> 3, Remove PRID_IMP_LOONGSON3 and use PRID_IMP_LOONGSON2 since they are
>>    the same.
>> 4, Don't define RTC_ALWAYS_BCD for Loongson-3 since BCD format can be
>>    checked by RTC_CONTROL at runtime.
>> 5, Don't modify dma-default.c for Loongson since it is unnecessary.
>> 6, Don't define SAREA_MAX since it is useless.
>> 7, Increase the default boost of internal mic for Lemote A1004.
>> 8, Fix a #ifdef issue in dma-coherence.h.
>> 9, Some other small fixes.
>>
>> V6 -> V7:
>> 1, Fix boot failure when NR_CPUS is more than present cpus.
>> 2, Fix error messages after poweroff & reboot.
>> 3, Update the default config file.
>> 4, Sync the code to upstream.
>>
>> V7 -> V8:
>> 1, Add WEAK_ORDERING/WEAK_REORDERING_BEYOND_LLSC for Loongson-3.
>> 2, Fix a deadlock of cpu-hotplug.
>> 3, Include swiotlb.h in arch-specific code to avoid driver modification.
>> 4, Remove the patch "drm: Handle io prot correctly for MIPS" since it
>>    is already in upstream code.
>> 5, Remove the patch "ALSA: HDA: Make hda sound card usable for Loongson"
>>    since it is already in upstream code.
>> 6, Use LZMA compression and do some adjustment of config file to reduce
>>    kernel size.
>>
>> V8 -> V9:
>> 1, Fix spurious IPI interrupt.
>> 2, remove __dev* attributes since CONFIG_HOTPLUG is going away as an option.
>> 3, Use dev_info() to print messages in fixup-loongson3.c.
>> 4, Update the default config file.
>> 5, Sync the code to upstream.
>>
>> V9 -> V10:
>> 1, Rework "Introduce and use cpu_has_coherent_cache feature".
>> 2, Handle the case that System BIOS doesn't contain a VGA BIOS.
>> 3, Sync the code to upstream (mostly indentation adjustment).
>>
>> V10 -> V11:
>> 1, Remove normal labels and useless nops in inline assembler.
>> 2, Sync the code to upstream (Prepared for 3.12).
>>
>> V11 -> V12:
>> 1, Delete __cpuinit usage;
>> 2, Remove the third patch since it is contentious;
>> 3, Sync the code to upstream (Prepared for 3.13).
>>
>> V12 -> V13:
>> 1, Rework addrspace.h and spaces.h;
>> 2, Move the modification of Platform from patch 1 to patch 12;
>> 3, Sync the code to upstream (the mips-for-linux-next branch, for 3.13).
>>
>> V13 -> V14:
>> 1, Avoid spurious interrupt from serial port;
>> 2, Drop CONFIG_LOONGSON_BIGMEM and use CONFIG_SWIOTLB directly;
>> 3, Sync the code to upstream (the mips-for-linux-next branch, for 3.14).
>>
>> V14 -> V15:
>> 1, Fix duplicate ARCH_SPARSEMEM_ENABLE in Kconfig.
>>
>> V15 -> V16:
>> 1, Fix all coding style errors and most of warnings;
>> 2, Make dma address translation simple and elegant;
>> 3, Fix potential bugs in swiotlb code;
>> 4, Rename UEFI firmware interface to LEFI;
>> 5, Remove 32-bit kernel support temporarily;
>> 6, Some other small fixes (thanks to Aurelien Jarno).
>>
>> V16 -> V17:
>> 1, Kconfig adjustment;
>> 2, Make some functions static;
>> 3, Capitalize macros in smp code;
>> 4, Make dma-swiotlb.c more simple;
>> 5, Some other small fixes (thanks to Aurelien Jarno and Alex Smith).
>>
>> V17 -> V18:
>> 1, Fix two Loongson 2 breakages.
>> 2, Tested and Reviewed by Alex Smith.
>>
>> V18 -> V19:
>> 1, Rewrite the commit message of the dma-swiotlb patch.
>> 2, LEFI export the dma_mask_bits, which make it possible to support
>>    both 32-bit and 40-bit DMA.
>>
>> Huacai Chen(13):
>>  MIPS: Loongson: Rename PRID_IMP_LOONGSON1 and PRID_IMP_LOONGSON2.
>>  MIPS: Loongson: Add basic Loongson-3 definition.
>>  MIPS: Loongson: Add basic Loongson-3 CPU support.
>>  MIPS: Loongson 3: Add Lemote-3A machtypes definition.
>>  MIPS: Loongson: Add UEFI-like firmware interface (LEFI) support.
>>  MIPS: Loongson 3: Add HT-linked PCI support.
>>  MIPS: Loongson 3: Add IRQ init and dispatch support.
>>  MIPS: Loongson 3: Add serial port support.
>>  MIPS: Loongson: Add swiotlb to support All-Memory DMA.
>>  MIPS: Loongson: Add Loongson-3 Kconfig options.
>>  MIPS: Loongson 3: Add Loongson-3 SMP support.
>>  MIPS: Loongson 3: Add CPU hotplug support.
>>  MIPS: Loongson: Add a Loongson-3 default config file.
>>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> Signed-off-by: Hongliang Tao <taohl@lemote.com>
>> Signed-off-by: Hua Yan <yanh@lemote.com>
>> ---
>>  arch/mips/Kconfig                                  |   29 ++-
>>  arch/mips/configs/loongson3_defconfig              |  348 ++++++++++++++++
>>  arch/mips/include/asm/addrspace.h                  |    2 +
>>  arch/mips/include/asm/bootinfo.h                   |   24 +-
>>  arch/mips/include/asm/cpu-type.h                   |    4 +
>>  arch/mips/include/asm/cpu.h                        |    9 +-
>>  arch/mips/include/asm/dma-mapping.h                |    5 +
>>  arch/mips/include/asm/mach-loongson/boot_param.h   |  163 ++++++++
>>  .../mips/include/asm/mach-loongson/dma-coherence.h |   22 +-
>>  arch/mips/include/asm/mach-loongson/irq.h          |   44 ++
>>  arch/mips/include/asm/mach-loongson/loongson.h     |   28 +-
>>  arch/mips/include/asm/mach-loongson/machine.h      |    6 +
>>  arch/mips/include/asm/mach-loongson/pci.h          |    5 +
>>  arch/mips/include/asm/mach-loongson/spaces.h       |   13 +
>>  arch/mips/include/asm/module.h                     |    2 +
>>  arch/mips/include/asm/pgtable-bits.h               |    9 +
>>  arch/mips/include/asm/smp.h                        |    1 +
>>  arch/mips/kernel/cpu-probe.c                       |   16 +-
>>  arch/mips/loongson/Kconfig                         |   47 +++
>>  arch/mips/loongson/Makefile                        |    6 +
>>  arch/mips/loongson/Platform                        |    1 +
>>  arch/mips/loongson/common/Makefile                 |    5 +
>>  arch/mips/loongson/common/dma-swiotlb.c            |  136 ++++++
>>  arch/mips/loongson/common/env.c                    |   67 +++-
>>  arch/mips/loongson/common/init.c                   |   12 +-
>>  arch/mips/loongson/common/machtype.c               |    4 +
>>  arch/mips/loongson/common/mem.c                    |   42 ++
>>  arch/mips/loongson/common/pci.c                    |    6 +-
>>  arch/mips/loongson/common/reset.c                  |   21 +
>>  arch/mips/loongson/common/serial.c                 |   26 +-
>>  arch/mips/loongson/common/setup.c                  |    8 +-
>>  arch/mips/loongson/common/uart_base.c              |    9 +-
>>  arch/mips/loongson/loongson-3/Makefile             |    6 +
>>  arch/mips/loongson/loongson-3/irq.c                |  125 ++++++
>>  arch/mips/loongson/loongson-3/smp.c                |  434 ++++++++++++++++++++
>>  arch/mips/loongson/loongson-3/smp.h                |   29 ++
>>  arch/mips/mm/c-r4k.c                               |   59 +++
>>  arch/mips/mm/tlb-r4k.c                             |    5 +-
>>  arch/mips/mm/tlbex.c                               |    1 +
>>  arch/mips/pci/Makefile                             |    1 +
>>  arch/mips/pci/fixup-loongson3.c                    |   66 +++
>>  arch/mips/pci/ops-loongson3.c                      |  101 +++++
>>  42 files changed, 1885 insertions(+), 62 deletions(-)
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
>> --
>> 1.7.7.3
>>
>>
>
