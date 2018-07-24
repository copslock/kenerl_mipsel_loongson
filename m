Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2018 13:37:08 +0200 (CEST)
Received: from mail-pg1-x542.google.com ([IPv6:2607:f8b0:4864:20::542]:34854
        "EHLO mail-pg1-x542.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993981AbeGXLhEEREsS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jul 2018 13:37:04 +0200
Received: by mail-pg1-x542.google.com with SMTP id e6-v6so2719656pgv.2
        for <linux-mips@linux-mips.org>; Tue, 24 Jul 2018 04:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QeeM71aeEdeHqsIApKbxvYSLkWypZV4f3jtXqqmGzz4=;
        b=iSbMzF9iItrsoS+XJ0AOdwgdobMkSU2vZYGFQMMrIII2kctyerpgHHNlhvZG6brBSb
         khxPt03VOLKNP4vUktV72uKA3mPUaG4MRhUgkY+fFAo2i0sLssKDOlzqxP85/Kf+mibX
         9DaeWtUchaaX2CABP+3X9QtwJCC0v6+2rdqrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QeeM71aeEdeHqsIApKbxvYSLkWypZV4f3jtXqqmGzz4=;
        b=gR7AW/67boZejRgJBwtKyx+C1IfnokzgU04svhj+uiA1VRdcUbuy+LYlDKXxeWdC/7
         RjxYBG17HioJgY/9WRVx1Pk8ponv3f/KKQGZomw0Q2LiGs0n1+ynRBVzUmrZJ+wFHz0Q
         Skg2EvvG3iV58XtqHM6PBYbrV1tqjw+vMbGxdsqkZ3PaUisdG4FQfEriA9tB5i4l8N7Z
         Lw/eEZiC+zbnoiMUU1o3DI33j7coE/frJFJhvx2HxJeGkLr1405c4oTy60EyKT+xTl0B
         XyTimxTj4nBtodUrpJ/RxHFHRf5H4wlA65LaVeSvmwRtuUxdI2IF6vGdUj562thx3Lvb
         /WMw==
X-Gm-Message-State: AOUpUlEz8F5H9HBYg1g9MDA2v1BtNZTsK9FwaWkeMHAEMwPfub8L4efx
        8yDFy7rMtmbIPBt+UKUpjihrpw==
X-Google-Smtp-Source: AAOMgpfe+1eRJYnzu7vZAz1tsJ9S4MI2zFs1vF9HRZLjNuOF5dOxMK7LhkiIHRwKth2BFYek1NHIRQ==
X-Received: by 2002:a62:3001:: with SMTP id w1-v6mr17318574pfw.19.1532432216869;
        Tue, 24 Jul 2018 04:36:56 -0700 (PDT)
Received: from localhost ([106.201.120.141])
        by smtp.gmail.com with ESMTPSA id h69-v6sm33359751pfh.13.2018.07.24.04.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 04:36:56 -0700 (PDT)
Date:   Tue, 24 Jul 2018 17:06:54 +0530
From:   Vinod Koul <vinod.koul@linaro.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Damien Horsley <damien.horsley@imgtec.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 09/15] dmaengine: img-mdc: Handle early status read
Message-ID: <20180724113654.GL3219@vkoul-mobl>
References: <20180722212010.3979-1-afaerber@suse.de>
 <20180722212010.3979-10-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180722212010.3979-10-afaerber@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Return-Path: <vinod.koul@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vinod.koul@linaro.org
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

On 22-07-18, 23:20, Andreas Färber wrote:
> From: Damien Horsley <damien.horsley@imgtec.com>
> 
> It is possible that mdc_tx_status may be called before the first
> node has been read from memory.
> 
> In this case, the residue value stored in the register is undefined.
> Return the transfer size instead.
> 
> Signed-off-by: Damien Horsley <damien.horsley@imgtec.com>
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  drivers/dma/img-mdc-dma.c | 40 ++++++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/dma/img-mdc-dma.c b/drivers/dma/img-mdc-dma.c
> index 25cec9c243e1..0f2f0f52d83a 100644
> --- a/drivers/dma/img-mdc-dma.c
> +++ b/drivers/dma/img-mdc-dma.c
> @@ -621,25 +621,33 @@ static enum dma_status mdc_tx_status(struct dma_chan *chan,
>  			(MDC_CMDS_PROCESSED_CMDS_DONE_MASK + 1);
>  
>  		/*
> -		 * If the command loaded event hasn't been processed yet, then
> -		 * the difference above includes an extra command.
> +		 * If the first node has not yet been read from memory,
> +		 * the residue register value is undefined

so is this the case when transfer is not started ?

>  		 */
> -		if (!mdesc->cmd_loaded)
> -			cmds--;
> -		else
> -			cmds += mdesc->list_cmds_done;
> -
> -		bytes = mdesc->list_xfer_size;
> -		ldesc = mdesc->list;
> -		for (i = 0; i < cmds; i++) {
> -			bytes -= ldesc->xfer_size + 1;
> -			ldesc = ldesc->next_desc;
> -		}
> -		if (ldesc) {
> -			if (residue != MDC_TRANSFER_SIZE_MASK)
> -				bytes -= ldesc->xfer_size - residue;
> +		if (!mdesc->cmd_loaded && !cmds) {
> +			bytes = mdesc->list_xfer_size;
> +		} else {
> +			/*
> +			 * If the command loaded event hasn't been processed yet, then
> +			 * the difference above includes an extra command.
> +			 */
> +			if (!mdesc->cmd_loaded)
> +				cmds--;
>  			else
> +				cmds += mdesc->list_cmds_done;
> +
> +			bytes = mdesc->list_xfer_size;
> +			ldesc = mdesc->list;
> +			for (i = 0; i < cmds; i++) {
>  				bytes -= ldesc->xfer_size + 1;
> +				ldesc = ldesc->next_desc;
> +			}
> +			if (ldesc) {
> +				if (residue != MDC_TRANSFER_SIZE_MASK)
> +					bytes -= ldesc->xfer_size - residue;
> +				else
> +					bytes -= ldesc->xfer_size + 1;
> +			}
>  		}
>  	}
>  	spin_unlock_irqrestore(&mchan->vc.lock, flags);
> -- 
> 2.16.4

-- 
~Vinod
