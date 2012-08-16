Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2012 03:59:29 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:43013 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903476Ab2HPB7S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Aug 2012 03:59:18 +0200
Received: by pbbrq8 with SMTP id rq8so760546pbb.36
        for <multiple recipients>; Wed, 15 Aug 2012 18:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lFipB3L2JOw9tOaNbmp+DPu9t7LlMeovncZETIbJiRY=;
        b=xIYnJLBCQh6KGW8zJK814Dhr1+LUxwonShB+GGNsFTfH5GQRSPvuMH0SlRmAMW5ru1
         UWcf56W/Cp2zp3ozOVXF/UMU7rC36P+ZQmf3p8wRW2XXydQaCM8d5eSBh2Tx/sjGMU/j
         Am3oUfdcdC2JxB/F4ocPEIzayHtKO9kfXjO/oG9m9Mz8BvBKzUcmNxlpvNefPCi/gSCc
         YeJtqyIcCJLVQdzU5dsecSy6vf2+Upz9LOVxfGoVn0iGE+Uhw+b9mq8VddQ9Ic9zlXgz
         qf3gD8KV9lII5JX9QdjKkCH/4AqVCGlSBcnXuYF/+ICTVnftYRQTZhGJTNYiL1pciIa4
         i3yg==
Received: by 10.68.203.200 with SMTP id ks8mr31648882pbc.142.1345082351860;
 Wed, 15 Aug 2012 18:59:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.74.136 with HTTP; Wed, 15 Aug 2012 18:58:51 -0700 (PDT)
In-Reply-To: <1344677543-22591-14-git-send-email-chenhc@lemote.com>
References: <1344677543-22591-1-git-send-email-chenhc@lemote.com> <1344677543-22591-14-git-send-email-chenhc@lemote.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Wed, 15 Aug 2012 18:58:51 -0700
Message-ID: <CAEdQ38EW_N2Qcquyvn5UxfEc8978i4=zQE_5H65PXahQPOOEuw@mail.gmail.com>
Subject: Re: [PATCH V5 13/18] drm: Define SAREA_MAX for Loongson (PageSize = 16KB).
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
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

On Sat, Aug 11, 2012 at 2:32 AM, Huacai Chen <chenhuacai@gmail.com> wrote:
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Hongliang Tao <taohl@lemote.com>
> Signed-off-by: Hua Yan <yanh@lemote.com>
> Cc: dri-devel@lists.freedesktop.org
> ---
>  include/drm/drm_sarea.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
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
>  #define SAREA_MAX                       0x10000U       /* 64kB */
>  #else
> --
> 1.7.7.3

SAREA is a DRI-1 concept. The Radeon drivers you're using is DRI-2, so
what do you need this for? All the DRI-1 drivers have been removed
from Mesa, so I think the answer is nothing.
