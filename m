Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2012 09:20:04 +0200 (CEST)
Received: from ns.km20343-01.keymachine.de ([84.19.182.79]:45479 "EHLO
        km20343-01.keymachine.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1903589Ab2FSHT7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2012 09:19:59 +0200
Received: from [192.168.1.20] (f053024075.adsl.alicedsl.de [78.53.24.75])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by km20343-01.keymachine.de (Postfix) with ESMTPSA id 3C94D7D4162;
        Tue, 19 Jun 2012 09:19:56 +0200 (CEST)
Message-ID: <1340090395.8334.7.camel@tellur>
Subject: Re: [PATCH V2 12/16] drm/radeon: Make radeon card usable for
 Loongson.
From:   Lucas Stach <dev@lynxeye.de>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Zhangjin Wu <wuzhangjin@gmail.com>, Hua Yan <yanh@lemote.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        dri-devel@lists.freedesktop.org, Hongliang Tao <taohl@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Date:   Tue, 19 Jun 2012 09:19:55 +0200
In-Reply-To: <1340088624-25550-13-git-send-email-chenhc@lemote.com>
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
         <1340088624-25550-13-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.4.2 (3.4.2-1.fc17) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-archive-position: 33707
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dev@lynxeye.de
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

Hello Huacai,

Am Dienstag, den 19.06.2012, 14:50 +0800 schrieb Huacai Chen:
> 1, Use 32-bit DMA as a workaround (Loongson has a hardware bug that it
>    doesn't support DMA address above 4GB).

This is a bug of your platform/CPU and should be fixed at a lower level,
not in every driver. While radeon might be the only device using 40bit
DMA right know, it is very well possible that other devices pop up in
the future. So please fix your platform code to disallow >32bit DMA.

> 2, Read vga bios offered by system firmware.
> 3, Handle io prot correctly for MIPS.

This seems good to me, but you should really split this out in a
separate TTM patch.

> 4, Don't use swiotlb on Loongson machines (when use swiotlb, GPU reset
>    occurs at resume from suspend).
> 
While SWIOTLB might not be a common setup, simply ignoring it because it
doesn't work on your platform is the wrong thing to do. Could you please
try to root-cause the issue?

Thanks,
Lucas

> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Hongliang Tao <taohl@lemote.com>
> Signed-off-by: Hua Yan <yanh@lemote.com>
> Cc: dri-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/drm_vm.c               |    2 +-
>  drivers/gpu/drm/radeon/radeon_bios.c   |   32 ++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/radeon/radeon_device.c |    5 +++++
>  drivers/gpu/drm/radeon/radeon_ttm.c    |    6 +++---
>  drivers/gpu/drm/ttm/ttm_bo_util.c      |    2 +-
>  include/drm/drm_sarea.h                |    2 ++
>  6 files changed, 44 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
> index 961ee08..3f06166 100644
> --- a/drivers/gpu/drm/drm_vm.c
> +++ b/drivers/gpu/drm/drm_vm.c
> @@ -62,7 +62,7 @@ static pgprot_t drm_io_prot(uint32_t map_type, struct vm_area_struct *vma)
>  		tmp = pgprot_writecombine(tmp);
>  	else
>  		tmp = pgprot_noncached(tmp);
> -#elif defined(__sparc__) || defined(__arm__)
> +#elif defined(__sparc__) || defined(__arm__) || defined(__mips__)
>  	tmp = pgprot_noncached(tmp);
>  #endif
>  	return tmp;
> diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
> index 501f488..2630e22 100644
> --- a/drivers/gpu/drm/radeon/radeon_bios.c
> +++ b/drivers/gpu/drm/radeon/radeon_bios.c
> @@ -29,6 +29,7 @@
>  #include "radeon_reg.h"
>  #include "radeon.h"
>  #include "atom.h"
> +#include <asm/bootinfo.h>
>  
>  #include <linux/vga_switcheroo.h>
>  #include <linux/slab.h>
> @@ -73,6 +74,32 @@ static bool igp_read_bios_from_vram(struct radeon_device *rdev)
>  	return true;
>  }
>  
> +#ifdef CONFIG_CPU_LOONGSON3
> +extern u64 vgabios_addr;
> +static bool loongson3_read_bios(struct radeon_device *rdev)
> +{
> +	u8 *bios;
> +	resource_size_t size = 512 * 1024; /* ??? */
> +
> +	rdev->bios = NULL;
> +
> +	bios = (u8 *)vgabios_addr;
> +	if (!bios) {
> +		return false;
> +	}
> +
> +	if (size == 0 || bios[0] != 0x55 || bios[1] != 0xaa) {
> +		return false;
> +	}
> +	rdev->bios = kmalloc(size, GFP_KERNEL);
> +	if (rdev->bios == NULL) {
> +		return false;
> +	}
> +	memcpy(rdev->bios, bios, size);
> +	return true;
> +}
> +#endif
> +
>  static bool radeon_read_bios(struct radeon_device *rdev)
>  {
>  	uint8_t __iomem *bios;
> @@ -490,6 +517,11 @@ bool radeon_get_bios(struct radeon_device *rdev)
>  	if (r == false) {
>  		r = radeon_read_disabled_bios(rdev);
>  	}
> +#ifdef CONFIG_CPU_LOONGSON3
> +	if (r == false) {
> +		r = loongson3_read_bios(rdev);
> +	}
> +#endif
>  	if (r == false || rdev->bios == NULL) {
>  		DRM_ERROR("Unable to locate a BIOS ROM\n");
>  		rdev->bios = NULL;
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
> index 066c98b..8aac7ab 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -777,6 +777,11 @@ int radeon_device_init(struct radeon_device *rdev,
>  	    (rdev->family < CHIP_RS400))
>  		rdev->need_dma32 = true;
>  
> +#ifdef CONFIG_CPU_LOONGSON3
> +	/* Workaround: Loongson 3 doesn't support 40-bits DMA */
> +	rdev->need_dma32 = true;
> +#endif
> +
>  	dma_bits = rdev->need_dma32 ? 32 : 40;
>  	r = pci_set_dma_mask(rdev->pdev, DMA_BIT_MASK(dma_bits));
>  	if (r) {
> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
> index c94a225..f49bdd1 100644
> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> @@ -630,7 +630,7 @@ static int radeon_ttm_tt_populate(struct ttm_tt *ttm)
>  	}
>  #endif
>  
> -#ifdef CONFIG_SWIOTLB
> +#if defined(CONFIG_SWIOTLB) && !defined(CONFIG_CPU_LOONGSON3)
>  	if (swiotlb_nr_tbl()) {
>  		return ttm_dma_populate(&gtt->ttm, rdev->dev);
>  	}
> @@ -676,7 +676,7 @@ static void radeon_ttm_tt_unpopulate(struct ttm_tt *ttm)
>  	}
>  #endif
>  
> -#ifdef CONFIG_SWIOTLB
> +#if defined(CONFIG_SWIOTLB) && !defined(CONFIG_CPU_LOONGSON3)
>  	if (swiotlb_nr_tbl()) {
>  		ttm_dma_unpopulate(&gtt->ttm, rdev->dev);
>  		return;
> @@ -906,7 +906,7 @@ static int radeon_ttm_debugfs_init(struct radeon_device *rdev)
>  	radeon_mem_types_list[i].show = &ttm_page_alloc_debugfs;
>  	radeon_mem_types_list[i].driver_features = 0;
>  	radeon_mem_types_list[i++].data = NULL;
> -#ifdef CONFIG_SWIOTLB
> +#if defined(CONFIG_SWIOTLB) && !defined(CONFIG_CPU_LOONGSON3)
>  	if (swiotlb_nr_tbl()) {
>  		sprintf(radeon_mem_types_names[i], "ttm_dma_page_pool");
>  		radeon_mem_types_list[i].name = radeon_mem_types_names[i];
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
> index f8187ea..0df71ea 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> @@ -472,7 +472,7 @@ pgprot_t ttm_io_prot(uint32_t caching_flags, pgprot_t tmp)
>  	else
>  		tmp = pgprot_noncached(tmp);
>  #endif
> -#if defined(__sparc__)
> +#if defined(__sparc__) || defined(__mips__)
>  	if (!(caching_flags & TTM_PL_FLAG_CACHED))
>  		tmp = pgprot_noncached(tmp);
>  #endif
> diff --git a/include/drm/drm_sarea.h b/include/drm/drm_sarea.h
> index ee5389d..1d1a858 100644
> --- a/include/drm/drm_sarea.h
> +++ b/include/drm/drm_sarea.h
> @@ -37,6 +37,8 @@
>  /* SAREA area needs to be at least a page */
>  #if defined(__alpha__)
>  #define SAREA_MAX                       0x2000U
> +#elif defined(__mips__)
> +#define SAREA_MAX                       0x4000U
>  #elif defined(__ia64__)
>  #define SAREA_MAX                       0x10000U	/* 64kB */
>  #else
