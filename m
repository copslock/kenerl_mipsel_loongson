Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2018 09:24:34 +0100 (CET)
Received: from mail-wm0-x233.google.com ([IPv6:2a00:1450:400c:c09::233]:37651
        "EHLO mail-wm0-x233.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994674AbeAJIXPYKZTX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jan 2018 09:23:15 +0100
Received: by mail-wm0-x233.google.com with SMTP id f140so25243198wmd.2
        for <linux-mips@linux-mips.org>; Wed, 10 Jan 2018 00:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gKtoJcCbYfoJFxbLye7fROGf6GCSg8Nv6GOxFVAHJyo=;
        b=b2odIOi1V1tqS44v3o6xWh77S88t+YSUMlxqqamjXWqk9x2EUVbK1EnTm5+LniyVh3
         BOUU7edYKUxSOHP5CynXSlK6k8lkUyxGlKuFUmPLV+FPU1P1Rdhj0C7rHy2vyHJ0nuDS
         hPiMYfs/Hwz+Nb6J2m0pQ2vKHWblnwi4EVyGeLQu9UA939XdyYjfkuf2g2u0U5ajWG7P
         W39iEvpkiMDAXRi8lMnAYj2l16xRDk06PvR5fYiwsAgJT8msW4x7km0tC876yntnumDN
         l3xXmSK9YnMTdWf9S6baH4F8328WY8GAL/66FBXqKEn7x9Dfg3BqJZqvvW08cyzbEuVA
         xrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=gKtoJcCbYfoJFxbLye7fROGf6GCSg8Nv6GOxFVAHJyo=;
        b=e/as85y3IBkahgj8wkwxB+Ws4xGjfa1Hp1VGLIOLvrcYAuFdP4+AdaPdJo8KPIw9fG
         LUVWAT9M0wAjOLddKr1+7GOQrZEZ8RauuHw/CH+H909X5+fge439MK3JRkhRfczEzAZl
         WehT/ig2dA1kmwx7KPJxZpN6xaDDsJb/X25nAJdy3mW4Cm+wcwplnzi5noqMtEYgUHWv
         wnb0V6iH2xgTcSkqyM0aXKPqBUIG+35Ql6fGtGQjGHj5DlZtyQbkX+ioUluPbAjnw/HG
         /nLfVU2wFXjYEOdwPTbYiY/yCKNTtHiq7qK7Bj8a6WD2wWNhRHGQcRyanZHJTMYEKjk5
         4fvA==
X-Gm-Message-State: AKGB3mJ/AJTjvPFt3dMoL/1UAZHEAyugjijFPMnqrKHmHEj7W/fl2ebo
        cM2XOOm2CjI14fwRkAEbt6I=
X-Google-Smtp-Source: ACJfBoux5rv3dNh8w4DLBbTarfdZgQGEZC8HaP+IMYL9T1VfXFRcE+gEoL2XmkkD8777xfPZUDMM5Q==
X-Received: by 10.80.164.175 with SMTP id w44mr24301625edb.57.1515572589908;
        Wed, 10 Jan 2018 00:23:09 -0800 (PST)
Received: from ?IPv6:2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88? ([2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88])
        by smtp.gmail.com with ESMTPSA id e12sm881205edl.13.2018.01.10.00.23.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jan 2018 00:23:09 -0800 (PST)
Reply-To: christian.koenig@amd.com
Subject: Re: consolidate swiotlb dma_map implementations
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Michal Simek <monstr@monstr.eu>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180110080932.14157-1-hch@lst.de>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <5ef96935-f781-96e1-37cc-528d399f0150@gmail.com>
Date:   Wed, 10 Jan 2018 09:23:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180110080932.14157-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Return-Path: <ckoenig.leichtzumerken@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ckoenig.leichtzumerken@gmail.com
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

Acked-by: Christian König <christian.koenig@amd.com> for the whole series.

Regards,
Christian.

Am 10.01.2018 um 09:09 schrieb Christoph Hellwig:
> A lot of architectures have essentially identical dma_map_ops
> implementations to use swiotlb.  This series adds new generic
> swiotlb_alloc/free helpers that take the attrs argument exposed
> in dma_map_ops, and which do an enhanced direct allocation
> modelled after x86 and reused from the dma-direct code, and
> then switches most architectures over to it.  The only exceptions
> are mips, which requires additional cache flushing which will
> need a new abstraction, and x86 itself which will be handled in
> a later series with other x86 dma mapping changes.
>
> To support the generic code a few architectures that currently
> use ZONE_DMA/GFP_DMA for <= 32-bit allocations are switched to
> implement ZONE_DMA32 instead.
>
> This series is based on the previously sent series to consolidate
> the direct dma mapping implementation.  A git tree with this
> series as well as the prerequisites is available here:
>
>     git://git.infradead.org/users/hch/misc.git swiotlb
>
> Gitweb:
>
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/swiotlb
