Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Apr 2016 15:53:53 +0200 (CEST)
Received: from mail-yw0-f177.google.com ([209.85.161.177]:36204 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027022AbcDSNxrU78ej (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Apr 2016 15:53:47 +0200
Received: by mail-yw0-f177.google.com with SMTP id o66so17548311ywc.3
        for <linux-mips@linux-mips.org>; Tue, 19 Apr 2016 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=QZyKoF7BrN5/3cYj2ocL0M2glsmiDFHbBcvaX1Hp2To=;
        b=xkFgSfLglokHZ/hG1V88CtAuJnqX0i1RKRErbPaaikKzibFO7zrboV2eYSDlADI2rq
         qReLdHFK8dGVd059tjFswVO5Pt/paDcCiMFDecoP70kH/3+RHKEgwHoOaAz/MTO5h3EM
         U5zRiQF3ykNHIZgbQW5LhHTbUX6IMZ0bl8KDIdTtNHNquahx9r+2WXXNBNvA6knvKrVc
         P71nfCmiBflBJoZLt5UNFuAnDY+0/nmq9prWwS5guf96MmF4tJ2dfZVm0wIyTSEBgH+s
         pKR88NGm/vj0iUFnwh25wvUHrfBb+NzsYagZr6pB4LtvKh25J8BA2FwI4USB83/ql7k6
         w8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=QZyKoF7BrN5/3cYj2ocL0M2glsmiDFHbBcvaX1Hp2To=;
        b=PtGpO8z8C1IFm9bJThRZ82WNKiAFoCkKgdbqc7Gp2ZXDKHmvQ61FCE5aCzRy0TfjKI
         Kd9hPt+PXE5D8dB1FMPcR2Xih+fOx0y4KUE9ZhwMLI5ftW2kqiXfKKLqGSVvN/ZhztjG
         8IPN9RLuA/FtZq3uIfT9qUr6jo8yOgsra5xDa1WtcdFFAaNlwC/mIoR4vnaMY6fKEOfw
         DvyfE1m5H/OnEpclgll1CoSrFUlrKZ8jNhKjZ9ExcR5eTWBa0w/uLrD98YaUel7hWg/B
         t7bpQlsvrInPGavn7VAPr6S0pgA5VVy4wGU2P50G+yN3v5RWC/QLGFl4V1ilBPqitOun
         AlWw==
X-Gm-Message-State: AOPr4FVfxIGkfjW6j77tZklEi6jJLl6UdXJMy6GyhENcS0o5mtpeR1R4LtoMU8NRe3SxobzydAacSvpR73vgTQ==
MIME-Version: 1.0
X-Received: by 10.37.15.130 with SMTP id 124mr1660314ybp.84.1461074021387;
 Tue, 19 Apr 2016 06:53:41 -0700 (PDT)
Received: by 10.37.92.85 with HTTP; Tue, 19 Apr 2016 06:53:41 -0700 (PDT)
In-Reply-To: <1461064751-17873-1-git-send-email-chenhc@lemote.com>
References: <1461064751-17873-1-git-send-email-chenhc@lemote.com>
Date:   Tue, 19 Apr 2016 09:53:41 -0400
Message-ID: <CADnq5_OyS_pCu-4wW5uFpnr5kvqkHK5uPdmBKgHHmfZ-dOdXvw@mail.gmail.com>
Subject: Re: [PATCH] drm: Loongson-3 doesn't fully support wc memory
From:   Alex Deucher <alexdeucher@gmail.com>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     David Airlie <airlied@linux.ie>, linux-mips@linux-mips.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <alexdeucher@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53104
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

On Tue, Apr 19, 2016 at 7:19 AM, Huacai Chen <chenhc@lemote.com> wrote:
> Signed-off-by: Huacai Chen <chenhc@lemote.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  include/drm/drm_cache.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/drm/drm_cache.h b/include/drm/drm_cache.h
> index 461a055..cebecff 100644
> --- a/include/drm/drm_cache.h
> +++ b/include/drm/drm_cache.h
> @@ -39,6 +39,8 @@ static inline bool drm_arch_can_wc_memory(void)
>  {
>  #if defined(CONFIG_PPC) && !defined(CONFIG_NOT_COHERENT_CACHE)
>         return false;
> +#elif defined(CONFIG_MIPS) && defined(CONFIG_CPU_LOONGSON3)
> +       return false;
>  #else
>         return true;
>  #endif
> --
> 2.7.0
>
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
