Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Dec 2017 09:30:04 +0100 (CET)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:37278
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990434AbdLII34jXn1w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Dec 2017 09:29:56 +0100
Received: by mail-wm0-x242.google.com with SMTP id f140so6398536wmd.2
        for <linux-mips@linux-mips.org>; Sat, 09 Dec 2017 00:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexb-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pK3HSWgGIidCTvl0p+iiMKC0yD3R6+W187hhklvXMCI=;
        b=eR2Sq8lMFbALhZPWj0f9zCponln7aK04gmlatcHBHakQSlYb7AFClt8xa22/vpooh/
         RyDoLBljvnaytC8zn+srnjgjWh9hs70oreZBJTU32TnH/XIfOrEi/3UlntPO3cWiQM9O
         YRXynpg8WexhlSYmuXSDg+wsEIis74P9SXEbBqTxJ29CnlBdPJND+ppzPz2Mp3yOEkds
         nuwWHN3XrY49jC68BlyDgMKizoK+dcUhhXR1XM9bviHaYez52hDTy73dfizBUA0B3We5
         w3XShWAfM7fXtsU3x6/yixStd7aY9ToMyaLF+x9q4g498k6xMAQ/V8CDIA7P6uYVXPWz
         0RPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pK3HSWgGIidCTvl0p+iiMKC0yD3R6+W187hhklvXMCI=;
        b=ENuzkdUjDI4NANmRt1kcPCn1ZdyNAc4MZxQJbhAqGVp/Hf/6+RWtpbYi/t5Lf26g7y
         iCMeHnR135KHkdtKysDs8GGfMXhNJywOjBBt5WWau1I+uryaLt1iEa1XNSNOKJfB06xi
         RNZUgWKzaPetRVaPUgtu1sg3R0n4PQpOE0ympjwxn3vtDyopyS59oFk0qg83HsmyHQZ2
         GdRlvt9ClQGBy7skujbm8FZ0dExFnsFr42NzNzKMMUoWo+x+rvMFFtlf0sExHchcM/6v
         0vXEDDFkY2mJP9Vyh+zK2yshO2fBrCjADwGeD/YCzYrkaOhw/QcZWGxXn9KSY6yGUzHy
         Cz1Q==
X-Gm-Message-State: AKGB3mItcFmrgayvrvViur0T1Zy9sYRW2/bMLS9VVNoPB4JnLDb87hIJ
        etTSUUjWm+1iR99JbUV67AHPZuQsD2ACv+Sk9JT7hQ==
X-Google-Smtp-Source: AGs4zMZpmVyh8OhbQ4nnU7zm/ninIPghHb7q438KcpokdBLSaXuN/WxRhaqq8dmT8okDTeJn8ZapFVGlOFqv38cw6dA=
X-Received: by 10.28.136.15 with SMTP id k15mr5581301wmd.147.1512808191011;
 Sat, 09 Dec 2017 00:29:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.157.195 with HTTP; Sat, 9 Dec 2017 00:29:10 -0800 (PST)
In-Reply-To: <20171209064953.8984-3-jiaxun.yang@flygoat.com>
References: <20171209064953.8984-1-jiaxun.yang@flygoat.com> <20171209064953.8984-3-jiaxun.yang@flygoat.com>
From:   Philippe Ombredanne <pombredanne@nexb.com>
Date:   Sat, 9 Dec 2017 09:29:10 +0100
Message-ID: <CAOFm3uEVduGvpWQNRofAe5_Lb01g+YZSuoaikq1-PPjaUS27FQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] MIPS: Loongson64: lemote-2f move ec_kb3310b.h to
 include dir and clean up
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     James Hogan <james.hogan@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <pombredanne@nexb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pombredanne@nexb.com
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

Dea Jiaxun,

On Sat, Dec 9, 2017 at 7:49 AM, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
> To operate EC from platform driver, this head file need able to be include
> from anywhere. This patch just move ec_kb3310b.h to include dir and
> clean up ec_kb3310b.h.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/include/asm/mach-loongson64/ec_kb3310b.h | 170 +++++++++++++++++++
>  arch/mips/loongson64/lemote-2f/ec_kb3310b.c        |   2 +-
>  arch/mips/loongson64/lemote-2f/ec_kb3310b.h        | 188 ---------------------
>  arch/mips/loongson64/lemote-2f/pm.c                |   4 +-
>  arch/mips/loongson64/lemote-2f/reset.c             |   4 +-
>  5 files changed, 175 insertions(+), 193 deletions(-)
>  create mode 100644 arch/mips/include/asm/mach-loongson64/ec_kb3310b.h
>  delete mode 100644 arch/mips/loongson64/lemote-2f/ec_kb3310b.h
>
> diff --git a/arch/mips/include/asm/mach-loongson64/ec_kb3310b.h b/arch/mips/include/asm/mach-loongson64/ec_kb3310b.h
> new file mode 100644
> index 000000000000..2e8690532ea5
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-loongson64/ec_kb3310b.h
> @@ -0,0 +1,170 @@
> +/*
> + * KB3310B Embedded Controller
> + *
> + *  Copyright (C) 2008 Lemote Inc.
> + *  Author: liujl <liujl@lemote.com>, 2008-03-14
> + *  Copyright (C) 2009 Lemote Inc.
> + *  Author: Wu Zhangjin <wuzhangjin@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */

Have you considered using the new SPDX ids instead of this fine but
long license boilerplate?
That would be very gentle of you if you did!
You can check Thomas documentation patches, as well as Linus comments
on the topic.

-- 
Cordially
Philippe Ombredanne
