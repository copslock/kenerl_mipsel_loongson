Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jun 2017 10:07:27 +0200 (CEST)
Received: from mx6.bahnhof.se ([213.80.101.16]:48659 "EHLO mx6.bahnhof.se"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990506AbdFLIHVEHOaT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Jun 2017 10:07:21 +0200
Received: from localhost (mf.bahnhof.se [213.80.101.20])
        by mx6-reinject (Postfix) with ESMTP id C667B40DFB;
        Mon, 12 Jun 2017 10:07:19 +0200 (CEST)
X-Virus-Scanned: by amavisd-new using ClamAV at bahnhof.se (MF1)
Received: from mf1.bahnhof.se ([127.0.0.1])
        by localhost (mf1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bOz4x72hhdEw; Mon, 12 Jun 2017 10:07:13 +0200 (CEST)
Received: from [192.168.0.25] (h-187-120.A137.corp.bahnhof.se [81.170.187.120])
        by mf1.bahnhof.se (Postfix) with ESMTP id BE52433083E;
        Mon, 12 Jun 2017 10:07:05 +0200 (CEST)
Message-ID: <593E4B82.70306@gaisler.com>
Date:   Mon, 12 Jun 2017 10:06:26 +0200
From:   Andreas Larsson <andreas@gaisler.com>
Organization: Cobham Gaisler AB
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org
CC:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 27/44] sparc: remove leon_dma_ops
References: <20170608132609.32662-1-hch@lst.de> <20170608132609.32662-28-hch@lst.de>
In-Reply-To: <20170608132609.32662-28-hch@lst.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <andreas@gaisler.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreas@gaisler.com
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

On 2017-06-08 15:25, Christoph Hellwig wrote:
> We can just use pci32_dma_ops.
>
> Btw, given that leon is 32-bit and appears to be PCI based, do even need
> the special case for it in get_arch_dma_ops at all?

Hi!

Yes, it is needed. LEON systems are AMBA bus based. The common case here 
is DMA over AMBA buses. Some LEON systems have PCI bridges, but in 
general CONFIG_PCI is not a given.

-- 
Andreas Larsson
Software Engineer
Cobham Gaisler
