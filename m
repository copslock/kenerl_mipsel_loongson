Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Oct 2017 15:04:10 +0200 (CEST)
Received: from mail-qk0-x242.google.com ([IPv6:2607:f8b0:400d:c09::242]:45110
        "EHLO mail-qk0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992361AbdJRNED21gxT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Oct 2017 15:04:03 +0200
Received: by mail-qk0-x242.google.com with SMTP id f199so6090744qke.2;
        Wed, 18 Oct 2017 06:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9qAiUGS+z7Vj6IWv34Z61SP/tDHTFFNayL9BHeL93Lw=;
        b=o6wQFocdD0TsGIdiuvGQC+zrjL+CSS2ryf91EobAbF1QysAvVDc+RiuvNVE7Wh5Nzu
         8IzEFrAPt4KWL5rMQDmiTPUlHMsTQ3/OXqgJX44PeDxlQWibLE5hH2l1I0GNVbdktJy1
         86P7uICorIZwlFMrBRmvk207ISjgmcytawcFuCbpano6vFLlDeUBR3GFXKdrcpeBVu0I
         tmKEy6PaFhW7tUmMO5hsmeweEbKzeD7uxQrJrqeuhV6Jf4dNh7MiFajwmhDsb6JqTtCE
         QbfRBwIS1vKhFPtFaoxVrlHLfjgLZEu+KO269TXA7zNr1flESXD9r4DqaFc/MAcl0PKf
         OTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9qAiUGS+z7Vj6IWv34Z61SP/tDHTFFNayL9BHeL93Lw=;
        b=Bnj16GF4x9myYrA8hxlxM2RnkHeX+n5UISRqNFPlQNpQ096C7isL4AuE9Bf83vJgs9
         ffdqz9lb1wQvBf0v7QvMCKiznvoymVBgA4f4KC3iTLJBvN2rkkwlCcjv8tUVnNGrMD+H
         lU684pssDAyyAcL1uSQIeAjgvfMq7sVe5GCbXy4BCc3jP5JNbz+DHYul7REtMzRpmY4r
         q1+58wbRGjWaapw/HEbmUOAeG8mkdFHtS4WWmKhVZY7x14aEx6JyyVU1TTx7CDXLujZp
         6X9arFfvMLPEdudSBUNdsVK0GmEvi4yQWrOY+ROa4xGcUvRxgadaidAePhkUVWPmkfxJ
         9LDw==
X-Gm-Message-State: AMCzsaXuChWXU76IrhDSvH5PMQXNmpvoQ65MgaltDNe5mea0sVvrTQ1S
        vS0aRCvI0DoHa2omzzAaUME=
X-Google-Smtp-Source: ABhQp+SeI0CwYzUwPqma3P5+L4VCnFczinXx3W10rr23d3DmCc8UK1xFWeuCabyXCs8V3NbZOsyUPg==
X-Received: by 10.55.26.91 with SMTP id a88mr2033616qka.11.1508331837261;
        Wed, 18 Oct 2017 06:03:57 -0700 (PDT)
Received: from localhost (dhcp-ec-8-6b-ed-7a-cf.cpe.echoes.net. [72.28.5.223])
        by smtp.gmail.com with ESMTPSA id k7sm2980670qkf.45.2017.10.18.06.03.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Oct 2017 06:03:56 -0700 (PDT)
Date:   Wed, 18 Oct 2017 06:03:53 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fuxin Zhang <zhangfx@lemote.com>, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH V8 5/5] libata: Align DMA buffer to
 dma_get_cache_alignment()
Message-ID: <20171018130353.GA1302522@devbig577.frc2.facebook.com>
References: <1508227542-13165-1-git-send-email-chenhc@lemote.com>
 <1508227542-13165-5-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508227542-13165-5-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <htejun@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tj@kernel.org
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

On Tue, Oct 17, 2017 at 04:05:42PM +0800, Huacai Chen wrote:
> In non-coherent DMA mode, kernel uses cache flushing operations to
> maintain I/O coherency, so in ata_do_dev_read_id() the DMA buffer
> should be aligned to ARCH_DMA_MINALIGN. Otherwise, If a DMA buffer
> and a kernel structure share a same cache line, and if the kernel
> structure has dirty data, cache_invalidate (no writeback) will cause
> data corruption.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  drivers/ata/libata-core.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index ee4c1ec..e134955 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1833,8 +1833,19 @@ static u32 ata_pio_mask_no_iordy(const struct ata_device *adev)
>  unsigned int ata_do_dev_read_id(struct ata_device *dev,
>  					struct ata_taskfile *tf, u16 *id)
>  {
> -	return ata_exec_internal(dev, tf, NULL, DMA_FROM_DEVICE,
> -				     id, sizeof(id[0]) * ATA_ID_WORDS, 0);
> +	u16 *devid;
> +	int res, size = sizeof(u16) * ATA_ID_WORDS;
> +
> +	if (IS_ALIGNED((unsigned long)id, dma_get_cache_alignment(&dev->tdev)))
> +		res = ata_exec_internal(dev, tf, NULL, DMA_FROM_DEVICE, id, size, 0);
> +	else {
> +		devid = kmalloc(size, GFP_KERNEL);
> +		res = ata_exec_internal(dev, tf, NULL, DMA_FROM_DEVICE, devid, size, 0);
> +		memcpy(id, devid, size);
> +		kfree(devid);
> +	}
> +
> +	return res;

Hmm... I think it'd be a lot better to ensure that the buffers are
aligned properly to begin with.  There are only two buffers which are
used for id reading - ata_port->sector_buf and ata_device->id.  Both
are embedded arrays but making them separately allocated aligned
buffers shouldn't be difficult.

Thanks.

-- 
tejun
