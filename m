Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Apr 2017 11:49:20 +0200 (CEST)
Received: from mail-lf0-x236.google.com ([IPv6:2a00:1450:4010:c07::236]:36838
        "EHLO mail-lf0-x236.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993917AbdDKJtMHAN1p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Apr 2017 11:49:12 +0200
Received: by mail-lf0-x236.google.com with SMTP id s141so48387525lfe.3
        for <linux-mips@linux-mips.org>; Tue, 11 Apr 2017 02:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=0zKdR/K5mDlvhRnUCtebiSrW3K/EUuv2xQ2lneXWBG0=;
        b=MsjT4iMbViwAP4zE75EELFdFDFjde3jKNUyTSBURu5ejEeH/HAmBFuP/auiX7/Afel
         Y1G0P4NpqM6AxwpLocHGl70ldyOIwX32rq2k/EGH6rb+SEWSt1aGMmOsB3OXpmAiWmfH
         vLzitD6gHZrA3F9b8+0JAIvuNEMLbqrxOuPlXeW9Pfk4/COWJu4rl6tOVm2ZAFikuJh9
         O0kW4cNXuf/HCPw4NvmCQRo3Za76Us7GHvSdZFI7RiWYZvD6i9/jWPMfcnkY8PlAq0Q9
         LnoB9+Js8j6415ZPN7t+M6TPt8m3nPBe8IFrKH2ETFPdj4G/l9Dl1QmIdqIVd/c3IwjT
         8LDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=0zKdR/K5mDlvhRnUCtebiSrW3K/EUuv2xQ2lneXWBG0=;
        b=XJmqUivxCqJmGep7XGE38/wexoUUKcpFGqKOlebTe6ATXPrpC5OSMgXEs5dGK2Tjz0
         GlUxc3494se/BxgA952lh4cs2AumaIjsltNGypX/Yd1fqjoDwB6ANyj/xtIrNjF+PMAm
         4mRG533WAm8Ab4pniyXA4HGrN14q1vo4tAtQDi+460YEKg4nCLwSBbgvynRw9EeRL2at
         sGJeJoKCZBT4VFdl6P97C8LyZQtoOA/wRjXlFNh8KMtbY8+1F+823D6pJOQiCGCbTlOK
         pjac+AYzGtj8gT5rS0+VpMMgi2d4/i/0RRej1O6s7Wzbk9hOm4ufIuAqR+X3u3D+aYRK
         oG4g==
X-Gm-Message-State: AN3rC/7CqWXFXVfoNcXTPfHlniP1N7yt4avBA686DHTFqJaEKgB13CLx7WiwqbLY0djEWQ==
X-Received: by 10.25.56.65 with SMTP id d1mr202440lfj.30.1491904146507;
        Tue, 11 Apr 2017 02:49:06 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.85.170])
        by smtp.gmail.com with ESMTPSA id i18sm3277402ljb.55.2017.04.11.02.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Apr 2017 02:49:05 -0700 (PDT)
Subject: Re: [PATCH 3/3] MIPS: mm: adjust PKMAP location
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1491894036-5440-1-git-send-email-marcin.nowakowski@imgtec.com>
 <1491894036-5440-4-git-send-email-marcin.nowakowski@imgtec.com>
Cc:     linux-mips@linux-mips.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <0e5c3c4d-abfb-25bb-cb2d-c27448283353@cogentembedded.com>
Date:   Tue, 11 Apr 2017 12:49:05 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1491894036-5440-4-git-send-email-marcin.nowakowski@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello!

On 4/11/2017 10:00 AM, Marcin Nowakowski wrote:

> Space reserved for PKMap should span from PKMAP_BASE to FIXADDR_START.
> For large page sizes this is not the case as eg. for 64k pages the range
> currently defined is from 0xfe000000 to 0x102000000(!!) which obviously
> isn't right.
> Remove the hardcoded location and set the BASE address as an offset from
> FIXADDR_START.
>
> Since all PKMAP ptes have to be placed in a contiguous memory, ensure

    PTEs?

> that this is the case by placing them all in a single page. This is
> achieved by aligning the end address to pkmap pages count pages.
>
> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
> ---
>  arch/mips/include/asm/pgtable-32.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/include/asm/pgtable-32.h b/arch/mips/include/asm/pgtable-32.h
> index 6f94bed..74afe8c 100644
> --- a/arch/mips/include/asm/pgtable-32.h
> +++ b/arch/mips/include/asm/pgtable-32.h
> @@ -19,6 +19,10 @@
>  #define __ARCH_USE_5LEVEL_HACK
>  #include <asm-generic/pgtable-nopmd.h>
>
> +#ifdef CONFIG_HIGHMEM
> +#include <asm/highmem.h>
> +#endif
> +
>  extern int temp_tlb_entry;
>
>  /*
> @@ -62,7 +66,8 @@ extern int add_temporary_entry(unsigned long entrylo0, unsigned long entrylo1,
>
>  #define VMALLOC_START	  MAP_BASE
>
> -#define PKMAP_BASE		(0xfe000000UL)
> +#define PKMAP_END	((FIXADDR_START) & ~((LAST_PKMAP << PAGE_SHIFT)-1))

    Why parens around FIXADDR_START?
    Also could you be consistent and add spaces around - too?

> +#define PKMAP_BASE	(PKMAP_END - PAGE_SIZE * LAST_PKMAP)
>
>  #ifdef CONFIG_HIGHMEM
>  # define VMALLOC_END	(PKMAP_BASE-2*PAGE_SIZE)

MBR, Sergei
