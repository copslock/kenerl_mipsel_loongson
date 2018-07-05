Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jul 2018 20:24:14 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:35318 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993041AbeGESYGzA003 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Jul 2018 20:24:06 +0200
Date:   Thu, 05 Jul 2018 20:23:41 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 02/14] dmaengine: dma-jz4780: Separate chan/ctrl registers
To:     Paul Burton <paul.burton@mips.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Message-Id: <1530815021.6642.0@smtp.crapouillou.net>
In-Reply-To: <20180703165302.3gdukxwwro5cwqba@pburton-laptop>
References: <20180703123214.23090-1-paul@crapouillou.net>
        <20180703123214.23090-3-paul@crapouillou.net>
        <20180703165302.3gdukxwwro5cwqba@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1530815041; bh=GkJ0v/PlN6KmOdXHOdu7cXcDaWHEpMnzgLnjo6vl3lI=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type; b=OdWsqM4UQ/YOVatGIHcfpJ3OL21gi0eytzFYs2F+8EwCDjjwslS43wNo2ItxDEZBoUENn+96tXJp1ZyUORkrTQFHwA1jHbQaFiSgTnLioYqPUsQpCc7AwA5NdB+3jvKQQOq5moBUeglvFCEee25Dia8Wz7teqw+GmdTkOp36g+8=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

Hi Paul,

> Hi Paul,
> 
> On Tue, Jul 03, 2018 at 02:32:02PM +0200, Paul Cercueil wrote:
>>  @@ -804,9 +818,19 @@ static int jz4780_dma_probe(struct 
>> platform_device *pdev)
>>   		return -EINVAL;
>>   	}
>> 
>>  -	jzdma->base = devm_ioremap_resource(dev, res);
>>  -	if (IS_ERR(jzdma->base))
>>  -		return PTR_ERR(jzdma->base);
>>  +	jzdma->chn_base = devm_ioremap_resource(dev, res);
>>  +	if (IS_ERR(jzdma->chn_base))
>>  +		return PTR_ERR(jzdma->chn_base);
>>  +
>>  +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>>  +	if (!res) {
>>  +		dev_err(dev, "failed to get I/O memory\n");
>>  +		return -EINVAL;
>>  +	}
>>  +
>>  +	jzdma->ctrl_base = devm_ioremap_resource(dev, res);
>>  +	if (IS_ERR(jzdma->ctrl_base))
>>  +		return PTR_ERR(jzdma->ctrl_base);
> 
> Could we have this failure case fall back to the existing behaviour
> where we only have a single resource covering all the registers? That
> would avoid breaking bisection between this patch & the one that 
> updates
> the JZ4780 DT.
> 
> For example:
> 
> 	#define JZ4780_DMA_CTRL_OFFSET	0x1000
> 
> 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> 	if (res) {
> 		jzdma->ctrl_base = devm_ioremap_resource(dev, res);
> 		if (IS_ERR(jzdma->ctrl_base))
> 			return PTR_ERR(jzdma->ctrl_base);
> 	} else {
> 		jzdma->ctrl_base = jzdma->chn_base + JZ4780_DMA_CTRL_OFFSET;
> 	}
> 
> Then you could remove the fallback after patch 13, to end up with the
> same code you have now but without breaking bisection.
> 
> Most correct might be to move patch 13 to right after this one, so 
> that
> the JZ4780-specific fallback can be removed before adding support for
> any of the other SoCs.

Sure, I can do that for the V2.

Thanks,
-Paul
