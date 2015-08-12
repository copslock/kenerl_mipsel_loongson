Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Aug 2015 12:29:17 +0200 (CEST)
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:37640 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011520AbbHLK3OIJgL4 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 12 Aug 2015 12:29:14 +0200
Received: from dc8secmta2.synopsys.com (dc8secmta2.synopsys.com [10.13.218.202])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 0090E24E0F23;
        Wed, 12 Aug 2015 03:29:04 -0700 (PDT)
Received: from dc8secmta2.internal.synopsys.com (dc8secmta2.internal.synopsys.com [127.0.0.1])
        by dc8secmta2.internal.synopsys.com (Service) with ESMTP id E606BA4112;
        Wed, 12 Aug 2015 03:29:03 -0700 (PDT)
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by dc8secmta2.internal.synopsys.com (Service) with ESMTP id 54697A4102;
        Wed, 12 Aug 2015 03:29:03 -0700 (PDT)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
        by mailhost.synopsys.com (Postfix) with ESMTP id 2ED253D2;
        Wed, 12 Aug 2015 03:29:03 -0700 (PDT)
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 09E38384;
        Wed, 12 Aug 2015 03:29:00 -0700 (PDT)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.195.1; Wed, 12 Aug 2015 03:28:59 -0700
Received: from IN01WEMBXB.internal.synopsys.com ([169.254.4.157]) by
 IN01WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0195.001; Wed, 12
 Aug 2015 15:58:56 +0530
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Christoph Hellwig <hch@lst.de>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "hskinnemoen@gmail.com" <hskinnemoen@gmail.com>,
        "egtvedt@samfundet.no" <egtvedt@samfundet.no>,
        "realmz6@gmail.com" <realmz6@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "x86@kernel.org" <x86@kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "grundler@parisc-linux.org" <grundler@parisc-linux.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-nvdimm@ml01.01.org" <linux-nvdimm@ml01.01.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Subject: Re: [PATCH 19/31] arc: handle page-less SG entries
Thread-Topic: [PATCH 19/31] arc: handle page-less SG entries
Thread-Index: AQHQ1M3b26KgfKsShEK4yGPzrGC9cQ==
Date:   Wed, 12 Aug 2015 10:28:55 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075665B21F5@IN01WEMBXB.internal.synopsys.com>
References: <1439363150-8661-1-git-send-email-hch@lst.de>
 <1439363150-8661-20-git-send-email-hch@lst.de>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.12.197.191]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Vineet.Gupta1@synopsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Vineet.Gupta1@synopsys.com
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

On Wednesday 12 August 2015 12:39 PM, Christoph Hellwig wrote:
> Make all cache invalidation conditional on sg_has_page() and use
> sg_phys to get the physical address directly.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

With a minor nit below.

Acked-by: Vineet Gupta <vgupta@synopsys.com>

> ---
>  arch/arc/include/asm/dma-mapping.h | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arc/include/asm/dma-mapping.h b/arch/arc/include/asm/dma-mapping.h
> index 2d28ba9..42eb526 100644
> --- a/arch/arc/include/asm/dma-mapping.h
> +++ b/arch/arc/include/asm/dma-mapping.h
> @@ -108,9 +108,13 @@ dma_map_sg(struct device *dev, struct scatterlist *sg,
>  	struct scatterlist *s;
>  	int i;
>  
> -	for_each_sg(sg, s, nents, i)
> -		s->dma_address = dma_map_page(dev, sg_page(s), s->offset,
> -					       s->length, dir);
> +	for_each_sg(sg, s, nents, i) {
> +		if (sg_has_page(s)) {
> +			_dma_cache_sync((unsigned long)sg_virt(s), s->length,
> +					dir);
> +		}
> +		s->dma_address = sg_phys(s);
> +	}
>  
>  	return nents;
>  }
> @@ -163,8 +167,12 @@ dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sglist, int nelems,
>  	int i;
>  	struct scatterlist *sg;
>  
> -	for_each_sg(sglist, sg, nelems, i)
> -		_dma_cache_sync((unsigned int)sg_virt(sg), sg->length, dir);
> +	for_each_sg(sglist, sg, nelems, i) {
> +		if (sg_has_page(sg)) {
> +			_dma_cache_sync((unsigned int)sg_virt(sg), sg->length,
> +					dir);
> +		}
> +	}
>  }
>  
>  static inline void
> @@ -174,8 +182,12 @@ dma_sync_sg_for_device(struct device *dev, struct scatterlist *sglist,
>  	int i;
>  	struct scatterlist *sg;
>  
> -	for_each_sg(sglist, sg, nelems, i)
> -		_dma_cache_sync((unsigned int)sg_virt(sg), sg->length, dir);
> +	for_each_sg(sglist, sg, nelems, i) {
> +		if (sg_has_page(sg)) {
> +			_dma_cache_sync((unsigned int)sg_virt(sg), sg->length,
> +				dir);

For consistency, could u please fix the left alignment of @dir above - another tab
perhaps ?

> +		}
> +	}
>  }
>  
>  static inline int dma_supported(struct device *dev, u64 dma_mask)
