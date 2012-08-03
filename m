Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2012 10:01:20 +0200 (CEST)
Received: from darkcity.gna.ch ([195.226.6.51]:42224 "EHLO mail.gna.ch"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1902235Ab2HCIBP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Aug 2012 10:01:15 +0200
Received: from localhost (localhost [127.0.0.1])
        by darkcity.gna.ch (Postfix) with ESMTP id F1EA75E060F;
        Fri,  3 Aug 2012 10:01:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at gna.ch
Received: from mail.gna.ch ([127.0.0.1])
        by localhost (darkcity.gna.ch [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id elKAjUVGe7ks; Fri,  3 Aug 2012 10:01:04 +0200 (CEST)
Received: from thor (77-56-77-139.dclient.hispeed.ch [77.56.77.139])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by darkcity.gna.ch (Postfix) with ESMTPSA id 366C65E0619;
        Fri,  3 Aug 2012 10:01:03 +0200 (CEST)
Received: from daenzer by thor with local (Exim 4.80)
        (envelope-from <michel@daenzer.net>)
        id 1SxCog-0008Ur-9A; Fri, 03 Aug 2012 10:01:02 +0200
Message-ID: <1343980862.1772.211.camel@thor.local>
Subject: Re: [PATCH V4 11/16] drm/radeon: Make radeon card usable for
 Loongson.
From:   Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Zhangjin Wu <wuzhangjin@gmail.com>, Hua Yan <yanh@lemote.com>,
        Fuxin Zhang <zhangfx@lemote.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Hongliang Tao <taohl@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Date:   Fri, 03 Aug 2012 10:01:02 +0200
In-Reply-To: <1343977571-2292-12-git-send-email-chenhc@lemote.com>
References: <1343977571-2292-1-git-send-email-chenhc@lemote.com>
         <1343977571-2292-12-git-send-email-chenhc@lemote.com>
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAAXNSR0IArs4c6QAAADBQTFRFDg4OHh4eLCwsOzs7S0tLWlpaa2treXl5hISEjY2NmJiYqKiotLS0xsbG1dXV/Pz81CO0SQAAArtJREFUOMtd1M9P01AcAHCI/4AtGq/QDfDHRfraEX8eaNeJFw1rO/DCYet7mxc1ZG0x3sStHQkmZpqtHDwAi+tMiFEzbZdwNWEJR48cjPG4g5HhELUbrHvjpYe2n7zvt++977cD/7rjsCry8uNG93Gge9OKUyAAgLB1AlpTZICmAzR15QTEiQAPAKADYLMPfhNnEJR4HvD0tT5YI2KGUcyqihQN7mDwZ3hMN4q2N4ol+gEGTSLWhorrjYXrGPwc0jTDOoKP4xi8G0W6adl2Gz6zGDwag5p5PMON7vZgJuSB976+3U6y2QdeKNet1+uum9/qwVQHvEjtKesY0EIb7CNYe+7DIRXCID/vQ4tksVAY7JFBD7yvqrWTL93xoUmOQsPIddbnuk8v+bBPsigB2KRlFxS4nL/owwEpKBSg2MU3UcDf+nATyyHEQwrHzJZFNpXeuOHDC0qW4sMhEHESFGOUrvgQpWUYFVNQdjQxca8abnSB55CmehdcLSxa1ifoQ4JBpmGYWbhsly3X0fxQ7xmkW3Y5CztLcXI+fAu2oWho3nbV6s5rH35xSC/aBR2tOpVa/Utv25tcTDPL6aT21kG17WrvaFtMBJmFhJCsVF4uu9VG76DWBaRnEiNs7pU659pYlfwtQSRy9GCYlwR7C6/dPQgBw3MsTPNWA4d9SeMDDC9JYdnqq/amdF+diGnVhXFztQ/2lJSWjulOxjRX+uC7EkOqhLRk2ejrqHVBEqCqJLO5cmEXgx8TrBiWVQh1u2DhzQlPsyIveU2YLGorGBxODoR5notlpcUieoLB1/NEmGc4AalGJpLe8WF/8txMWASAkVVViQjzP
 jycPrvgA
        R1goSzOnkp14YCYHsp7QJHAS5QcXDqG1jBxdSITVgBNkBTFloj88Q/gMkFcuItYiQPUCBGc2xh5drsD/wGZrgsgDOE4ZAAAAABJRU5ErkJggg==
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.4.3-1.0 
Mime-Version: 1.0
X-archive-position: 34041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michel@daenzer.net
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

On Fre, 2012-08-03 at 15:06 +0800, Huacai Chen wrote: 
> 1, Handle io prot correctly for MIPS.
> 2, Define SAREA_MAX as the size of one page.
> 3, Include swiotlb.h if SWIOTLB configured.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Hongliang Tao <taohl@lemote.com>
> Signed-off-by: Hua Yan <yanh@lemote.com>
> Cc: dri-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/drm_vm.c            |    2 +-
>  drivers/gpu/drm/radeon/radeon_ttm.c |    4 ++++
>  drivers/gpu/drm/ttm/ttm_bo_util.c   |    2 +-
>  include/drm/drm_sarea.h             |    2 ++
>  4 files changed, 8 insertions(+), 2 deletions(-)
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
> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
> index 5b71c71..fc3ac22 100644
> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> @@ -41,6 +41,10 @@
>  #include "radeon_reg.h"
>  #include "radeon.h"
>  
> +#ifdef CONFIG_SWIOTLB
> +#include <linux/swiotlb.h>
> +#endif
> +
>  #define DRM_FILE_PAGE_OFFSET (0x100000000ULL >> PAGE_SHIFT)
>  
>  static int radeon_ttm_debugfs_init(struct radeon_device *rdev);
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

This should be four separate patches.


-- 
Earthling Michel Dänzer           |                   http://www.amd.com
Libre software enthusiast         |          Debian, X and DRI developer
