Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jan 2018 14:17:07 +0100 (CET)
Received: from mail-qt0-x242.google.com ([IPv6:2607:f8b0:400d:c0d::242]:42377
        "EHLO mail-qt0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994661AbeALNQ7I1A8d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Jan 2018 14:16:59 +0100
Received: by mail-qt0-x242.google.com with SMTP id c2so5943745qtn.9
        for <linux-mips@linux-mips.org>; Fri, 12 Jan 2018 05:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S2VrLKhJHAh0dKuEQzWxiXtDw8x8Tb9LRCIrg9P3Uaw=;
        b=P/wxkDz2beGylQBR9RyNJ9PnCii8w3iBPW0P9Q6NNegs/ZWGGxytI0Ja23Knak7C8p
         Q9/I7HxiNIIZ9Urt/OLEqB+zzs34hFHPHl7cw9kKKe66avfcDtXySQncdqrgDFhnqs6J
         cd9gfnosdYAhg3J4HRhncgDCm0HOlDQRAw92wEeusfZGBRrVWXSPfxxcHJU+DeU/3Cun
         elKEbYpnCCS+4DNph1sZVxYzunlcENYa8ormU+wTSloKbVb2v89y/U29ykC026WT/DEo
         4XKBhrrEgJk9oWLmxLryNOzV854BsYZQfr+s7LfkfPW2r9/yLSefjVvsMb/AFp0EqU1Y
         R2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=S2VrLKhJHAh0dKuEQzWxiXtDw8x8Tb9LRCIrg9P3Uaw=;
        b=IpEND9En2maBwT+7jZbYphx8+fenQq4DYzjTvKLhKJTE+Fcn6eWyw/3TpIW0v8pkII
         cyf0M2e+7EEdG4mGRObU+3h2p9PWvBKbE9WhRdmSluYLnFxluwe4lHP1WaNI6/hd7rky
         0YC/OkHZp/QvNTezEaFCBk8D3CqQGV6GpRYOWJVHWP2zJLCN1E9HV5JUgUSWg74hfULB
         +9Q7sGzh9nmshNIJK2eF778MEAeTQ5jUQhkuPZq1kvicWLpm1pE21j9q9eTld33kTZXP
         nVI5Tjj3tSGEE8IMZjEaLXgEfLwEV/3m+F1MrxAJW73vcd0CVC4ZbvpX4782bsvJZGHo
         /52A==
X-Gm-Message-State: AKwxytfVXfYwQsDJfMdoyJUO4qJmoCgre5ErV1kYv91KiT+AymodweA0
        hLgxhiHzTZsSrvgnkA+OzxA=
X-Google-Smtp-Source: ACJfBosIJnvehbcZesAIlg3FnmupYOzJxD/5ZELthFKCLIXLRfBPNpU4Pn5uQMp7msA/ZNkw1emEwA==
X-Received: by 10.237.55.71 with SMTP id i65mr10940082qtb.224.1515763012723;
        Fri, 12 Jan 2018 05:16:52 -0800 (PST)
Received: from localhost.localdomain (209-6-200-48.s4398.c3-0.smr-ubr2.sbo-smr.ma.cable.rcncustomer.com. [209.6.200.48])
        by smtp.gmail.com with ESMTPSA id 24sm6324251qkv.64.2018.01.12.05.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jan 2018 05:16:51 -0800 (PST)
Date:   Fri, 12 Jan 2018 08:16:48 -0500
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/33] dma-mapping: warn when there is no
 coherent_dma_mask
Message-ID: <20180112131646.GA26900@localhost.localdomain>
References: <20180110080027.13879-1-hch@lst.de>
 <20180110080027.13879-20-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180110080027.13879-20-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <konrad.r.wilk@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: konrad@darnok.org
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

On Wed, Jan 10, 2018 at 09:00:13AM +0100, Christoph Hellwig wrote:
> These days all devices should have a DMA coherent mask, and most dma_ops
> implementations rely on that fact.  But just to be sure add an assert to
> ring the warning bell if that is not the case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  include/linux/dma-mapping.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index d84951865be7..9f28b2fa329e 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -513,6 +513,7 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
>  	void *cpu_addr;
>  
>  	BUG_ON(!ops);
> +	WARN_ON_ONCE(!dev->coherent_dma_mask);
>  
>  	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
>  		return cpu_addr;
> -- 
> 2.14.2
> 
