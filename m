Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Oct 2017 11:43:36 +0200 (CEST)
Received: from mail-lf0-x236.google.com ([IPv6:2a00:1450:4010:c07::236]:57163
        "EHLO mail-lf0-x236.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990439AbdJQJn3JHy0v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Oct 2017 11:43:29 +0200
Received: by mail-lf0-x236.google.com with SMTP id 90so1250746lfs.13
        for <linux-mips@linux-mips.org>; Tue, 17 Oct 2017 02:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/8a46oJNRvDD5flynzF78qBx4vvuIWggw7EZrbb1zkM=;
        b=eI1rTirOfxMXlt8d87TaE2gc2nV1q/3kQG62U/2zMQ0CzMbPzEe5J1ki5KgqcUGrOV
         TZMMYxLYHUtZ2ArShgan1rnwkByveclNgIMm2jeN7IEyCg+JPCq047RX7XzlBvuYo+qt
         8T2QAGCpoRGqqM6Nd/TImSbx722qqN/PuzOXPuZLoIekWTNdNw84koTVfQjz6s7ntlfe
         ZsBvHH9hTkCzUl+AYKiHZzv8rwNNJSuYeAzNRG5u7VJ6SclX6GOJSG2CuqwIGGxL8A1a
         jXyE8p3BXefDewml7MwwdLTXhS2zYNp4MsUcnHQe0GtOnMJ+tMR+v6tBHmmw0c6bCoT9
         SD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/8a46oJNRvDD5flynzF78qBx4vvuIWggw7EZrbb1zkM=;
        b=GV4ldMQHlsf/GjfT4GjeVsmu1gyJdrszEFtw/pvOKQ96ODO/ogd7IFi8pRbU3w0JWS
         bgHmSRUN+lRdk+PfZaM429Uy/IxP2kPvUE79aDx+74BmTd8XAy+MB9v3iwhoJAd1SmgA
         PZ/hxyUwIOiFWJ7Ajk41LrX/FH5q+h0kytT/+0NSnmjUgYuTxrQxbUauzyMyPa/nsVcb
         8cs+MsPxcbCpBgx4QVPnXsRwpUeC/YyfL+QmBnRXs7RdwCOy4ekopwavZktDrbET+wzf
         h7/0eBl9LIkEMgkCgTy9jC18JKCNRzb5j5SgkK27D5eDcvez4nOYpv3EkRm9Kcj5mQKg
         V2wA==
X-Gm-Message-State: AMCzsaU86ThxB/jOoFfC6Bc5UWd4+XFYm+yR9QKPBa2zhE5IL0tztaU+
        RNZcO9yP0yPD/TZ4nsuly+AyCw==
X-Google-Smtp-Source: ABhQp+SJi9hyrvBqBud3UVViahSjy9N0KqzZBLZR3neodLfTcTICr2WkIsYL/3xR/IKoEmVZTrP9xA==
X-Received: by 10.25.38.8 with SMTP id m8mr1498504lfm.37.1508233403568;
        Tue, 17 Oct 2017 02:43:23 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.84.54])
        by smtp.gmail.com with ESMTPSA id p88sm1976501lja.65.2017.10.17.02.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Oct 2017 02:43:22 -0700 (PDT)
Subject: Re: [PATCH V8 5/5] libata: Align DMA buffer to
 dma_get_cache_alignment()
To:     Huacai Chen <chenhc@lemote.com>, Christoph Hellwig <hch@lst.de>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fuxin Zhang <zhangfx@lemote.com>, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org, stable@vger.kernel.org
References: <1508227542-13165-1-git-send-email-chenhc@lemote.com>
 <1508227542-13165-5-git-send-email-chenhc@lemote.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <94f55c1e-7553-0fc8-124e-ac6df5ac10ce@cogentembedded.com>
Date:   Tue, 17 Oct 2017 12:43:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <1508227542-13165-5-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60423
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

On 10/17/2017 11:05 AM, Huacai Chen wrote:

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
>   drivers/ata/libata-core.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index ee4c1ec..e134955 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1833,8 +1833,19 @@ static u32 ata_pio_mask_no_iordy(const struct ata_device *adev)
>   unsigned int ata_do_dev_read_id(struct ata_device *dev,
>   					struct ata_taskfile *tf, u16 *id)
>   {
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

    This function is called only for the PIO mode commands, so I doubt this is 
necessary...

MBR, Sergei
