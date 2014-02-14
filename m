Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Feb 2014 08:58:34 +0100 (CET)
Received: from hall.aurel32.net ([195.154.112.97]:39531 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822682AbaBNH6GgZ31B (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Feb 2014 08:58:06 +0100
Received: from [195.76.232.154] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1WEDeu-0001O5-H3; Fri, 14 Feb 2014 08:58:04 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1WEDel-00066E-Cb; Fri, 14 Feb 2014 08:57:55 +0100
Date:   Fri, 14 Feb 2014 08:57:55 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V18 00/13] MIPS: Add Loongson-3 based machines support
Message-ID: <20140214075755.GA8497@ohm.rr44.fr>
References: <1392293343-5453-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1392293343-5453-1-git-send-email-chenhc@lemote.com>
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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

On Thu, Feb 13, 2014 at 08:08:50PM +0800, Huacai Chen wrote:
> This patchset is prepared for the next 3.15 release for Linux/MIPS.
> Loongson-3 is a multi-core MIPS family CPU, it is MIPS64R2 compatible
> and has the same IMP field (0x6300) as Loongson-2. These patches make
> Linux kernel support Loongson-3 CPU and Loongson-3 based computers
> (including Laptop, Mini-ITX, All-In-One PC, etc.)
> 
> V1 -> V2:
> 1, Split the first patch to two patches, one is constant definition and
>    the other is CPU probing, cache initializing, etc.
> 2, Remove Kconfig options in the first 9 patches and put all of them in
>    the 10th patch.
> 3, Use "make savedefconfig" to generate the new default config file.
> 4, Rework serial port support to use PORT and PORT_M macros.
> 5, Fix some compile warnings.
> 
> V2 -> V3:
> 1, Improve cache flushing code (use cpu_has_coherent_cache macro and
>    remove #ifdef clauses).
> 2, Improve platform-specific code to correctly set driver's dma_mask/
>    coherent_dma_mask so no longer need workarounds for each driver (
>    SATA, graphics card, sound card, etc.)
> 3, Use PCI quirk to provide vgabios and loongson3_read_bios() go away.
> 4, Improve CPU hotplug code and split the poweroff failure related code
>    to another patch (this issue affect all MIPS CPU, not only Loongson).
> 5, Some other small fixes.
> 
> V3 -> V4:
> 1, Include swiotlb.h in radeon_ttm.c if SWIOTLB configured.
> 2, Remove "Reviewed-by" in patches which are added by mistake.
> 3, Sync the code to upstream.
> 
> V4 -> V5:
> 1, Split the drm patch to three patches.
> 2, Use platform-specific pincfgs to replace old alsa quirks.
> 
> V5 -> V6:
> 1, For better management, two non-Loongson-specific patches are sent
>    independently.
> 2, Introduce cpu_has_coherent_cache feature and split cache flushing
>    changes to a separate patch.
> 3, Remove PRID_IMP_LOONGSON3 and use PRID_IMP_LOONGSON2 since they are
>    the same.
> 4, Don't define RTC_ALWAYS_BCD for Loongson-3 since BCD format can be
>    checked by RTC_CONTROL at runtime.
> 5, Don't modify dma-default.c for Loongson since it is unnecessary.
> 6, Don't define SAREA_MAX since it is useless.
> 7, Increase the default boost of internal mic for Lemote A1004.
> 8, Fix a #ifdef issue in dma-coherence.h.
> 9, Some other small fixes.
> 
> V6 -> V7:
> 1, Fix boot failure when NR_CPUS is more than present cpus.
> 2, Fix error messages after poweroff & reboot.
> 3, Update the default config file.
> 4, Sync the code to upstream.
> 
> V7 -> V8:
> 1, Add WEAK_ORDERING/WEAK_REORDERING_BEYOND_LLSC for Loongson-3.
> 2, Fix a deadlock of cpu-hotplug.
> 3, Include swiotlb.h in arch-specific code to avoid driver modification.
> 4, Remove the patch "drm: Handle io prot correctly for MIPS" since it
>    is already in upstream code.
> 5, Remove the patch "ALSA: HDA: Make hda sound card usable for Loongson"
>    since it is already in upstream code.
> 6, Use LZMA compression and do some adjustment of config file to reduce
>    kernel size.
> 
> V8 -> V9:
> 1, Fix spurious IPI interrupt.
> 2, remove __dev* attributes since CONFIG_HOTPLUG is going away as an option.
> 3, Use dev_info() to print messages in fixup-loongson3.c.
> 4, Update the default config file.
> 5, Sync the code to upstream.
> 
> V9 -> V10:
> 1, Rework "Introduce and use cpu_has_coherent_cache feature".
> 2, Handle the case that System BIOS doesn't contain a VGA BIOS.
> 3, Sync the code to upstream (mostly indentation adjustment).
> 
> V10 -> V11:
> 1, Remove normal labels and useless nops in inline assembler.
> 2, Sync the code to upstream (Prepared for 3.12).
> 
> V11 -> V12:
> 1, Delete __cpuinit usage;
> 2, Remove the third patch since it is contentious;
> 3, Sync the code to upstream (Prepared for 3.13).
> 
> V12 -> V13:
> 1, Rework addrspace.h and spaces.h;
> 2, Move the modification of Platform from patch 1 to patch 12;
> 3, Sync the code to upstream (the mips-for-linux-next branch, for 3.13).
> 
> V13 -> V14:
> 1, Avoid spurious interrupt from serial port;
> 2, Drop CONFIG_LOONGSON_BIGMEM and use CONFIG_SWIOTLB directly;
> 3, Sync the code to upstream (the mips-for-linux-next branch, for 3.14).
> 
> V14 -> V15:
> 1, Fix duplicate ARCH_SPARSEMEM_ENABLE in Kconfig.
> 
> V15 -> V16:
> 1, Fix all coding style errors and most of warnings;
> 2, Make dma address translation simple and elegant;
> 3, Fix potential bugs in swiotlb code;
> 4, Rename UEFI firmware interface to LEFI;
> 5, Remove 32-bit kernel support temporarily;
> 6, Some other small fixes (thanks to Aurelien Jarno).
> 
> V16 -> V17:
> 1, Kconfig adjustment;
> 2, Make some functions static;
> 3, Capitalize macros in smp code;
> 4, Make dma-swiotlb.c more simple;
> 5, Some other small fixes (thanks to Aurelien Jarno and Alex Smith).
> 
> V17 -> V18:
> 1, Fix two Loongson 2 breakages.
> 2, Tested and Reviewed by Alex Smith.
> 
> Huacai Chen(13):
>  MIPS: Loongson: Rename PRID_IMP_LOONGSON1 and PRID_IMP_LOONGSON2.
>  MIPS: Loongson: Add basic Loongson-3 definition.
>  MIPS: Loongson: Add basic Loongson-3 CPU support.
>  MIPS: Loongson 3: Add Lemote-3A machtypes definition.
>  MIPS: Loongson: Add UEFI-like firmware interface (LEFI) support.
>  MIPS: Loongson 3: Add HT-linked PCI support.
>  MIPS: Loongson 3: Add IRQ init and dispatch support.
>  MIPS: Loongson 3: Add serial port support.
>  MIPS: Loongson: Add swiotlb to support big memory (>4GB).
>  MIPS: Loongson: Add Loongson-3 Kconfig options.
>  MIPS: Loongson 3: Add Loongson-3 SMP support.
>  MIPS: Loongson 3: Add CPU hotplug support.
>  MIPS: Loongson: Add a Loongson-3 default config file.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Hongliang Tao <taohl@lemote.com>
> Signed-off-by: Hua Yan <yanh@lemote.com> 

Thanks a lot for this new patchset. Unfortunately I have not been able
to test it yet. It looks ok to me except for patch 08 for which I still
think something needs to be fixed. You can add on all the other patches:

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

Thanks,
Aurelien

-- 
Aurelien Jarno                          GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
