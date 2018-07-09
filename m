Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2018 19:00:08 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:43676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993426AbeGIRAAjIBqb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Jul 2018 19:00:00 +0200
Received: from localhost (unknown [106.201.46.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 313D420883;
        Mon,  9 Jul 2018 16:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531155593;
        bh=x33olNrU2w/2rVY14c1ksA7c+T26jGkdIJl2PQPrtr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y03W5gBVMOqylqr50pg8kdezTzO8SvcuQ3rlWKkJUnOhBR7odr8B/VlW3i3JX0I72
         0NAx3nqeDSU7eL+SeX4Rg7lbs/Si323kdlI67KjaZ7acwus87sPnhArwPmlaP08zHw
         1QqObgRrO9Pp/KmJlAmLYiOw2mE15pwCz8VmUKVQ=
Date:   Mon, 9 Jul 2018 22:29:45 +0530
From:   Vinod <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 01/14] dmaengine: dma-jz4780: Avoid hardcoding number of
 channels
Message-ID: <20180709165945.GH22377@vkoul-mobl>
References: <20180703123214.23090-1-paul@crapouillou.net>
 <20180703123214.23090-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703123214.23090-2-paul@crapouillou.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Return-Path: <vkoul@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64717
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vkoul@kernel.org
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

On 03-07-18, 14:32, Paul Cercueil wrote:

>  struct jz4780_dma_dev {
>  	struct dma_device dma_device;
>  	void __iomem *base;
>  	struct clk *clk;
>  	unsigned int irq;
> +	unsigned int nb_channels;
> +	enum jz_version version;
>  
>  	uint32_t chan_reserved;
> -	struct jz4780_dma_chan chan[JZ_DMA_NR_CHANNELS];
> +	struct jz4780_dma_chan chan[];

why array, why not channel pointer?

> +static const unsigned int jz4780_dma_nb_channels[] = {
> +	[ID_JZ4780] = 32,
> +};
> +
> +static const struct of_device_id jz4780_dma_dt_match[] = {
> +	{ .compatible = "ingenic,jz4780-dma", .data = (void *)ID_JZ4780 },
> +	{},
> +};

Looking at description I was hoping that channels would be in DT,
channels is hardware information, so should come from DT rather than
coding the kernel...

> -	jzdma = devm_kzalloc(dev, sizeof(*jzdma), GFP_KERNEL);
> +	if (of_id)
> +		version = (enum jz_version)of_id->data;
> +	else
> +		version = ID_JZ4780; /* Default when not probed from DT */

where else would it be probed from.... ?
-- 
~Vinod
