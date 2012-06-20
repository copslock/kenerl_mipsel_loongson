Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2012 03:27:15 +0200 (CEST)
Received: from mail-gh0-f177.google.com ([209.85.160.177]:62231 "EHLO
        mail-gh0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903676Ab2FTB1E convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Jun 2012 03:27:04 +0200
Received: by ghbf11 with SMTP id f11so5658586ghb.36
        for <multiple recipients>; Tue, 19 Jun 2012 18:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=N96qkrz/wlf8ds7iQicTsWgte+yMofHIhOmuGwuJVjs=;
        b=Q/WKLKnItKRSLgjJehoPzOCAR82K49MpWpZSo/O6uQHOQz5myBvymZmbHi6tMHi+5n
         gGcGKnYNC1WLIsO1G9T6ZFvdGraZQsR249Shf61DURr3z9JJiwMZjUSte4o+hE1e50/k
         QQ0dduqbxxXqWTH5xIKGEEszS1stuFIXrT4kt9YEhOuFIvVygWnhyrIndY8vBbLpWw//
         8PpLQ0IsqIS9nws2zSDauLRM3diVE18l5sAsALx/x71opiVKoHbXA4ZMY3Js81zo09/K
         uMF73kMc59TWKdXEhbqPpkPf87sXiYm0bOQ6pMqT3I3LLFGQiQm3uClAfulsZSRe++AZ
         ppxw==
MIME-Version: 1.0
Received: by 10.42.197.197 with SMTP id el5mr9427928icb.35.1340155617154; Tue,
 19 Jun 2012 18:26:57 -0700 (PDT)
Received: by 10.231.24.2 with HTTP; Tue, 19 Jun 2012 18:26:57 -0700 (PDT)
In-Reply-To: <20120619135703.GA1979@gmail.com>
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
        <1340088624-25550-13-git-send-email-chenhc@lemote.com>
        <20120619135703.GA1979@gmail.com>
Date:   Tue, 19 Jun 2012 21:26:57 -0400
Message-ID: <CADnq5_NdqE0w6eN7V1aToH=wOr-DXMGVvy_GuaUtg4QS=H1wGA@mail.gmail.com>
Subject: Re: [PATCH V2 12/16] drm/radeon: Make radeon card usable for Loongson.
From:   Alex Deucher <alexdeucher@gmail.com>
To:     "j.glisse" <j.glisse@gmail.com>
Cc:     Huacai Chen <chenhuacai@gmail.com>, linux-mips@linux-mips.org,
        Zhangjin Wu <wuzhangjin@gmail.com>, Hua Yan <yanh@lemote.com>,
        dri-devel@lists.freedesktop.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 33729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexdeucher@gmail.com
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

On Tue, Jun 19, 2012 at 9:57 AM, j.glisse <j.glisse@gmail.com> wrote:
> On Tue, Jun 19, 2012 at 02:50:20PM +0800, Huacai Chen wrote:
>> 1, Use 32-bit DMA as a workaround (Loongson has a hardware bug that it
>>    doesn't support DMA address above 4GB).
>> 2, Read vga bios offered by system firmware.
>> 3, Handle io prot correctly for MIPS.
>> 4, Don't use swiotlb on Loongson machines (when use swiotlb, GPU reset
>>    occurs at resume from suspend).
>>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> Signed-off-by: Hongliang Tao <taohl@lemote.com>
>> Signed-off-by: Hua Yan <yanh@lemote.com>
>> Cc: dri-devel@lists.freedesktop.org
>> ---
>>  drivers/gpu/drm/drm_vm.c               |    2 +-
>>  drivers/gpu/drm/radeon/radeon_bios.c   |   32 ++++++++++++++++++++++++++++++++
>>  drivers/gpu/drm/radeon/radeon_device.c |    5 +++++
>>  drivers/gpu/drm/radeon/radeon_ttm.c    |    6 +++---
>>  drivers/gpu/drm/ttm/ttm_bo_util.c      |    2 +-
>>  include/drm/drm_sarea.h                |    2 ++
>>  6 files changed, 44 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
>> index 961ee08..3f06166 100644
>> --- a/drivers/gpu/drm/drm_vm.c
>> +++ b/drivers/gpu/drm/drm_vm.c
>> @@ -62,7 +62,7 @@ static pgprot_t drm_io_prot(uint32_t map_type, struct vm_area_struct *vma)
>>               tmp = pgprot_writecombine(tmp);
>>       else
>>               tmp = pgprot_noncached(tmp);
>> -#elif defined(__sparc__) || defined(__arm__)
>> +#elif defined(__sparc__) || defined(__arm__) || defined(__mips__)
>>       tmp = pgprot_noncached(tmp);
>>  #endif
>>       return tmp;
>> diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
>> index 501f488..2630e22 100644
>> --- a/drivers/gpu/drm/radeon/radeon_bios.c
>> +++ b/drivers/gpu/drm/radeon/radeon_bios.c
>> @@ -29,6 +29,7 @@
>>  #include "radeon_reg.h"
>>  #include "radeon.h"
>>  #include "atom.h"
>> +#include <asm/bootinfo.h>
>>
>>  #include <linux/vga_switcheroo.h>
>>  #include <linux/slab.h>
>> @@ -73,6 +74,32 @@ static bool igp_read_bios_from_vram(struct radeon_device *rdev)
>>       return true;
>>  }
>>
>> +#ifdef CONFIG_CPU_LOONGSON3
>> +extern u64 vgabios_addr;
>
> Ugly, is this how platform specific stuff are handled usualy ? I hope not,
> i would rather see a platform specific function such as loongson3_get_vga_bios.

It could be hooked in as a pci quirk similar to how we read the vbios
from the legacy vga location on x86.

Alex

>
> Cheers,
> Jerome
>
>> +static bool loongson3_read_bios(struct radeon_device *rdev)
>> +{
>> +     u8 *bios;
>> +     resource_size_t size = 512 * 1024; /* ??? */
>> +
>> +     rdev->bios = NULL;
>> +
>> +     bios = (u8 *)vgabios_addr;
>> +     if (!bios) {
>> +             return false;
>> +     }
>> +
>> +     if (size == 0 || bios[0] != 0x55 || bios[1] != 0xaa) {
>> +             return false;
>> +     }
>> +     rdev->bios = kmalloc(size, GFP_KERNEL);
>> +     if (rdev->bios == NULL) {
>> +             return false;
>> +     }
>> +     memcpy(rdev->bios, bios, size);
>> +     return true;
>> +}
>> +#endif
>> +
>>  static bool radeon_read_bios(struct radeon_device *rdev)
>>  {
>>       uint8_t __iomem *bios;
>> @@ -490,6 +517,11 @@ bool radeon_get_bios(struct radeon_device *rdev)
>>       if (r == false) {
>>               r = radeon_read_disabled_bios(rdev);
>>       }
>> +#ifdef CONFIG_CPU_LOONGSON3
>> +     if (r == false) {
>> +             r = loongson3_read_bios(rdev);
>> +     }
>> +#endif
>>       if (r == false || rdev->bios == NULL) {
>>               DRM_ERROR("Unable to locate a BIOS ROM\n");
>>               rdev->bios = NULL;
>> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
>> index 066c98b..8aac7ab 100644
>> --- a/drivers/gpu/drm/radeon/radeon_device.c
>> +++ b/drivers/gpu/drm/radeon/radeon_device.c
>> @@ -777,6 +777,11 @@ int radeon_device_init(struct radeon_device *rdev,
>>           (rdev->family < CHIP_RS400))
>>               rdev->need_dma32 = true;
>>
>> +#ifdef CONFIG_CPU_LOONGSON3
>> +     /* Workaround: Loongson 3 doesn't support 40-bits DMA */
>> +     rdev->need_dma32 = true;
>> +#endif
>> +
>>       dma_bits = rdev->need_dma32 ? 32 : 40;
>>       r = pci_set_dma_mask(rdev->pdev, DMA_BIT_MASK(dma_bits));
>>       if (r) {
>> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
>> index c94a225..f49bdd1 100644
>> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
>> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
>> @@ -630,7 +630,7 @@ static int radeon_ttm_tt_populate(struct ttm_tt *ttm)
>>       }
>>  #endif
>>
>> -#ifdef CONFIG_SWIOTLB
>> +#if defined(CONFIG_SWIOTLB) && !defined(CONFIG_CPU_LOONGSON3)
>>       if (swiotlb_nr_tbl()) {
>>               return ttm_dma_populate(&gtt->ttm, rdev->dev);
>>       }
>> @@ -676,7 +676,7 @@ static void radeon_ttm_tt_unpopulate(struct ttm_tt *ttm)
>>       }
>>  #endif
>>
>> -#ifdef CONFIG_SWIOTLB
>> +#if defined(CONFIG_SWIOTLB) && !defined(CONFIG_CPU_LOONGSON3)
>>       if (swiotlb_nr_tbl()) {
>>               ttm_dma_unpopulate(&gtt->ttm, rdev->dev);
>>               return;
>> @@ -906,7 +906,7 @@ static int radeon_ttm_debugfs_init(struct radeon_device *rdev)
>>       radeon_mem_types_list[i].show = &ttm_page_alloc_debugfs;
>>       radeon_mem_types_list[i].driver_features = 0;
>>       radeon_mem_types_list[i++].data = NULL;
>> -#ifdef CONFIG_SWIOTLB
>> +#if defined(CONFIG_SWIOTLB) && !defined(CONFIG_CPU_LOONGSON3)
>>       if (swiotlb_nr_tbl()) {
>>               sprintf(radeon_mem_types_names[i], "ttm_dma_page_pool");
>>               radeon_mem_types_list[i].name = radeon_mem_types_names[i];
>> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
>> index f8187ea..0df71ea 100644
>> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
>> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
>> @@ -472,7 +472,7 @@ pgprot_t ttm_io_prot(uint32_t caching_flags, pgprot_t tmp)
>>       else
>>               tmp = pgprot_noncached(tmp);
>>  #endif
>> -#if defined(__sparc__)
>> +#if defined(__sparc__) || defined(__mips__)
>>       if (!(caching_flags & TTM_PL_FLAG_CACHED))
>>               tmp = pgprot_noncached(tmp);
>>  #endif
>> diff --git a/include/drm/drm_sarea.h b/include/drm/drm_sarea.h
>> index ee5389d..1d1a858 100644
>> --- a/include/drm/drm_sarea.h
>> +++ b/include/drm/drm_sarea.h
>> @@ -37,6 +37,8 @@
>>  /* SAREA area needs to be at least a page */
>>  #if defined(__alpha__)
>>  #define SAREA_MAX                       0x2000U
>> +#elif defined(__mips__)
>> +#define SAREA_MAX                       0x4000U
>>  #elif defined(__ia64__)
>>  #define SAREA_MAX                       0x10000U     /* 64kB */
>>  #else
>> --
>> 1.7.7.3
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> http://lists.freedesktop.org/mailman/listinfo/dri-devel
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
