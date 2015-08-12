Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Aug 2015 13:52:12 +0200 (CEST)
Received: from e06smtp10.uk.ibm.com ([195.75.94.106]:55472 "EHLO
        e06smtp10.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011669AbbHLLwJeBtsz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Aug 2015 13:52:09 +0200
Received: from /spool/local
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <sebott@linux.vnet.ibm.com>;
        Wed, 12 Aug 2015 12:52:03 +0100
Received: from d06dlp03.portsmouth.uk.ibm.com (9.149.20.15)
        by e06smtp10.uk.ibm.com (192.168.101.140) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 12 Aug 2015 12:52:02 +0100
X-Helo: d06dlp03.portsmouth.uk.ibm.com
X-MailFrom: sebott@linux.vnet.ibm.com
X-RcptTo: linux-mips@linux-mips.org
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 29B231B0806E
        for <linux-mips@linux-mips.org>; Wed, 12 Aug 2015 12:53:28 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com [9.149.37.247])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t7CBq1Fl21561588
        for <linux-mips@linux-mips.org>; Wed, 12 Aug 2015 11:52:02 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t7CBpx4a015261
        for <linux-mips@linux-mips.org>; Wed, 12 Aug 2015 05:52:01 -0600
Received: from dyn-9-152-212-141.boeblingen.de.ibm.com (dyn-9-152-212-141.boeblingen.de.ibm.com [9.152.212.141])
        by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id t7CBpw8W015203
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 12 Aug 2015 05:51:58 -0600
Date:   Wed, 12 Aug 2015 13:51:58 +0200 (CEST)
From:   Sebastian Ott <sebott@linux.vnet.ibm.com>
X-X-Sender: sebott@denkbrett
To:     Christoph Hellwig <hch@lst.de>
cc:     torvalds@linux-foundation.org, axboe@kernel.dk,
        dan.j.williams@intel.com, vgupta@synopsys.com,
        hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com,
        dhowells@redhat.com, monstr@monstr.eu, x86@kernel.org,
        dwmw2@infradead.org, alex.williamson@redhat.com,
        grundler@parisc-linux.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-nvdimm@ml01.01.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 16/31] s390: handle page-less SG entries
In-Reply-To: <1439363150-8661-17-git-send-email-hch@lst.de>
Message-ID: <alpine.LFD.2.11.1508121350090.1732@denkbrett>
References: <1439363150-8661-1-git-send-email-hch@lst.de> <1439363150-8661-17-git-send-email-hch@lst.de>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
Organization: =?ISO-8859-15?Q?=22IBM_Deutschland_Research_&_Development_GmbH_=2F_Vorsitzende_des_Aufsichtsrats=3A_Martina_Koederitz_Gesch=E4ftsf=FChrung=3A_Dirk_Wittkopp_Sitz_der_Gesellschaft=3A_B=F6blingen_=2F_Registergericht?=
 =?ISO-8859-15?Q?=3A_Amtsgericht_Stuttgart=2C_HRB_243294=22?=
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 15081211-0041-0000-0000-0000053BC8E3
Return-Path: <sebott@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48816
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sebott@linux.vnet.ibm.com
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

On Wed, 12 Aug 2015, Christoph Hellwig wrote:

> Use sg_phys() instead of page_to_phys(sg_page(sg)) so that we don't
> require a page structure for all DMA memory.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Sebastian Ott <sebott@linux.vnet.ibm.com>


> ---
>  arch/s390/pci/pci_dma.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
> index 6fd8d58..aae5a47 100644
> --- a/arch/s390/pci/pci_dma.c
> +++ b/arch/s390/pci/pci_dma.c
> @@ -272,14 +272,13 @@ int dma_set_mask(struct device *dev, u64 mask)
>  }
>  EXPORT_SYMBOL_GPL(dma_set_mask);
>  
> -static dma_addr_t s390_dma_map_pages(struct device *dev, struct page *page,
> -				     unsigned long offset, size_t size,
> +static dma_addr_t s390_dma_map_phys(struct device *dev, unsigned long pa,
> +				     size_t size,
>  				     enum dma_data_direction direction,
>  				     struct dma_attrs *attrs)
>  {
>  	struct zpci_dev *zdev = get_zdev(to_pci_dev(dev));
>  	unsigned long nr_pages, iommu_page_index;
> -	unsigned long pa = page_to_phys(page) + offset;
>  	int flags = ZPCI_PTE_VALID;
>  	dma_addr_t dma_addr;
>  
> @@ -301,7 +300,7 @@ static dma_addr_t s390_dma_map_pages(struct device *dev, struct page *page,
>  
>  	if (!dma_update_trans(zdev, pa, dma_addr, size, flags)) {
>  		atomic64_add(nr_pages, &zdev->mapped_pages);
> -		return dma_addr + (offset & ~PAGE_MASK);
> +		return dma_addr + (pa & ~PAGE_MASK);
>  	}
>  
>  out_free:
> @@ -312,6 +311,16 @@ out_err:
>  	return DMA_ERROR_CODE;
>  }
>  
> +static dma_addr_t s390_dma_map_pages(struct device *dev, struct page *page,
> +				     unsigned long offset, size_t size,
> +				     enum dma_data_direction direction,
> +				     struct dma_attrs *attrs)
> +{
> +	unsigned long pa = page_to_phys(page) + offset;
> +
> +	return s390_dma_map_phys(dev, pa, size, direction, attrs);
> +}
> +
>  static void s390_dma_unmap_pages(struct device *dev, dma_addr_t dma_addr,
>  				 size_t size, enum dma_data_direction direction,
>  				 struct dma_attrs *attrs)
> @@ -384,8 +393,7 @@ static int s390_dma_map_sg(struct device *dev, struct scatterlist *sg,
>  	int i;
>  
>  	for_each_sg(sg, s, nr_elements, i) {
> -		struct page *page = sg_page(s);
> -		s->dma_address = s390_dma_map_pages(dev, page, s->offset,
> +		s->dma_address = s390_dma_map_phys(dev, sg_phys(s),
>  						    s->length, dir, NULL);
>  		if (!dma_mapping_error(dev, s->dma_address)) {
>  			s->dma_length = s->length;
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
