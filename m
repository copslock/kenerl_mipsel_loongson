Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2012 12:29:11 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:61193 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903393Ab2HCK3G convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Aug 2012 12:29:06 +0200
Received: by lbbgg6 with SMTP id gg6so1491152lbb.36
        for <multiple recipients>; Fri, 03 Aug 2012 03:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=rL6tpwjM6wpP5zC+rhFxRODfB2DkAcRXi6GdDDUFVtQ=;
        b=JPUzcXjk6NoKhuxwlS6LnAOswayvPB+dUnRR/ykIHDNroARa6SOAVwjiGz0F5HZOEn
         Uz7/RWoAQc/owv+tSjcEjZ5pELllQ/6WkZ2hygCZXxBBo5E8OaDqsIUnFFzNCfIMgsMT
         +ya3JeqFQiSxtJC/SGUQkOGKVit8kmDPAFBgutLfQYTkIMHv5ayK7bQHfg/Brsi/XINP
         MeuwnTk9WvnLDpE1ONemjTg1gF2YRVaDdinSZAq6TS4FUULhdj/44nJ6mmTXXyCbnbMd
         pMbZZ9eREKY93OcTuZURXwzAKbcygqGEg0lOh8KnhQFqGiNYQe7JmqvjbB7i+tGpmcgb
         8S4Q==
MIME-Version: 1.0
Received: by 10.152.132.233 with SMTP id ox9mr1176638lab.25.1343989740502;
 Fri, 03 Aug 2012 03:29:00 -0700 (PDT)
Received: by 10.152.105.51 with HTTP; Fri, 3 Aug 2012 03:29:00 -0700 (PDT)
In-Reply-To: <1343980862.1772.211.camel@thor.local>
References: <1343977571-2292-1-git-send-email-chenhc@lemote.com>
        <1343977571-2292-12-git-send-email-chenhc@lemote.com>
        <1343980862.1772.211.camel@thor.local>
Date:   Fri, 3 Aug 2012 18:29:00 +0800
Message-ID: <CAAhV-H6+D6zOr6FsBz9P30ojZoq9bwyFf8RLB=nXV7npcqawWA@mail.gmail.com>
Subject: Re: [PATCH V4 11/16] drm/radeon: Make radeon card usable for Loongson.
From:   Huacai Chen <chenhuacai@gmail.com>
To:     =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Zhangjin Wu <wuzhangjin@gmail.com>, Hua Yan <yanh@lemote.com>,
        Fuxin Zhang <zhangfx@lemote.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Hongliang Tao <taohl@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 34043
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

OK, I'll split it.

On Fri, Aug 3, 2012 at 4:01 PM, Michel Dänzer <michel@daenzer.net> wrote:
> On Fre, 2012-08-03 at 15:06 +0800, Huacai Chen wrote:
>> 1, Handle io prot correctly for MIPS.
>> 2, Define SAREA_MAX as the size of one page.
>> 3, Include swiotlb.h if SWIOTLB configured.
>>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> Signed-off-by: Hongliang Tao <taohl@lemote.com>
>> Signed-off-by: Hua Yan <yanh@lemote.com>
>> Cc: dri-devel@lists.freedesktop.org
>> ---
>>  drivers/gpu/drm/drm_vm.c            |    2 +-
>>  drivers/gpu/drm/radeon/radeon_ttm.c |    4 ++++
>>  drivers/gpu/drm/ttm/ttm_bo_util.c   |    2 +-
>>  include/drm/drm_sarea.h             |    2 ++
>>  4 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
>> index 961ee08..3f06166 100644
>> --- a/drivers/gpu/drm/drm_vm.c
>> +++ b/drivers/gpu/drm/drm_vm.c
>> @@ -62,7 +62,7 @@ static pgprot_t drm_io_prot(uint32_t map_type, struct vm_area_struct *vma)
>>               tmp = pgprot_writecombine(tmp);
>>       else
>>               tmp = pgprot_noncached(tmp);
>> -#elif defined(__sparc__) || defined(__arm__)
>> +#elif defined(__sparc__) || defined(__arm__) || defined(__mips__)
>>       tmp = pgprot_noncached(tmp);
>>  #endif
>>       return tmp;
>> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
>> index 5b71c71..fc3ac22 100644
>> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
>> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
>> @@ -41,6 +41,10 @@
>>  #include "radeon_reg.h"
>>  #include "radeon.h"
>>
>> +#ifdef CONFIG_SWIOTLB
>> +#include <linux/swiotlb.h>
>> +#endif
>> +
>>  #define DRM_FILE_PAGE_OFFSET (0x100000000ULL >> PAGE_SHIFT)
>>
>>  static int radeon_ttm_debugfs_init(struct radeon_device *rdev);
>> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
>> index f8187ea..0df71ea 100644
>> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
>> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
>> @@ -472,7 +472,7 @@ pgprot_t ttm_io_prot(uint32_t caching_flags, pgprot_t tmp)
>>       else
>>               tmp = pgprot_noncached(tmp);
>>  #endif
>> -#if defined(__sparc__)
>> +#if defined(__sparc__) || defined(__mips__)
>>       if (!(caching_flags & TTM_PL_FLAG_CACHED))
>>               tmp = pgprot_noncached(tmp);
>>  #endif
>> diff --git a/include/drm/drm_sarea.h b/include/drm/drm_sarea.h
>> index ee5389d..1d1a858 100644
>> --- a/include/drm/drm_sarea.h
>> +++ b/include/drm/drm_sarea.h
>> @@ -37,6 +37,8 @@
>>  /* SAREA area needs to be at least a page */
>>  #if defined(__alpha__)
>>  #define SAREA_MAX                       0x2000U
>> +#elif defined(__mips__)
>> +#define SAREA_MAX                       0x4000U
>>  #elif defined(__ia64__)
>>  #define SAREA_MAX                       0x10000U     /* 64kB */
>>  #else
>
> This should be four separate patches.
>
>
> --
> Earthling Michel Dänzer           |                   http://www.amd.com
> Libre software enthusiast         |          Debian, X and DRI developer
