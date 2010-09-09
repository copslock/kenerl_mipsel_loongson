Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Sep 2010 11:36:16 +0200 (CEST)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:58546 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490970Ab0IIJgJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Sep 2010 11:36:09 +0200
Received: by ewy9 with SMTP id 9so784666ewy.36
        for <multiple recipients>; Thu, 09 Sep 2010 02:36:09 -0700 (PDT)
Received: by 10.213.10.195 with SMTP id q3mr619704ebq.29.1284024968861;
        Thu, 09 Sep 2010 02:36:08 -0700 (PDT)
Received: from [192.168.2.2] (ppp85-140-115-148.pppoe.mtu-net.ru [85.140.115.148])
        by mx.google.com with ESMTPS id v59sm1688327eeh.22.2010.09.09.02.36.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Sep 2010 02:36:07 -0700 (PDT)
Message-ID: <4C88AA27.5070206@mvista.com>
Date:   Thu, 09 Sep 2010 13:34:31 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.9) Gecko/20100825 Thunderbird/3.1.3
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] MIPS: DMA: Add plat_extra_sync_for_cpu()
References: <064bb0722da5d8c271c2bd9fe0a521cc@localhost> <99a0868bdbcfa8785a92b4af4f6d9b99@localhost>
In-Reply-To: <99a0868bdbcfa8785a92b4af4f6d9b99@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 27734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 7067

Hello.

On 09-09-2010 3:02, Kevin Cernekee wrote:

> On noncoherent processors with a readahead cache, an extra platform-
> specific invalidation is required during the dma_sync_*_for_cpu()
> operations to keep drivers from seeing stale prefetched data.

> Signed-off-by: Kevin Cernekee<cernekee@gmail.com>
[...]
> diff --git a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
> index 17d5794..8192683 100644
> --- a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
> +++ b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
> @@ -52,6 +52,19 @@ static inline void plat_extra_sync_for_device(struct device *dev)
>   	mb();
>   }
>
> +static inline void plat_extra_sync_for_cpu(struct device *dev,
> +	dma_addr_t dma_handle, unsigned long offset, size_t size,
> +	enum dma_data_direction direction)
> +{
> +	return;

    Why not just empty function bodies?

WBR, Sergei
