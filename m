Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2018 01:13:25 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:59218 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993888AbeGKXNScN2H7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Jul 2018 01:13:18 +0200
Date:   Thu, 12 Jul 2018 01:13:05 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 02/14] dmaengine: dma-jz4780: Separate chan/ctrl registers
To:     Vinod <vkoul@kernel.org>
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
Message-Id: <1531350785.2021.0@smtp.crapouillou.net>
In-Reply-To: <20180711121655.GS3219@vkoul-mobl>
References: <20180703123214.23090-1-paul@crapouillou.net>
        <20180703123214.23090-3-paul@crapouillou.net>
        <20180709170359.GI22377@vkoul-mobl> <1531237019.17118.1@crapouillou.net>
        <20180711121655.GS3219@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1531350797; bh=WooJveTkznmLjUJQ5TqNtVojk+ltu1x+RlD7ac0DIjg=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=KdeqVshMn2vpfr/2WEETGEUdoqIYLAu2ItaRoXA0vpnN9MSf7e2iFtbSsDPSyo/gDyTQyuVclwtE2RvuEZEDIngn3yZ3CW1x5/mu7WwCv8lprzKGgLIBqyQrw5WtLSg27w8MEx65xjZWq9PWB6oKhY7qsRoRF2O5dDwZS9ETBEg=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64806
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



Le mer. 11 juil. 2018 à 14:16, Vinod <vkoul@kernel.org> a écrit :
> On 10-07-18, 17:36, Paul Cercueil wrote:
> 
>>  > >  @@ -3,7 +3,8 @@
>>  > >   Required properties:
>>  > >
>>  > >   - compatible: Should be "ingenic,jz4780-dma"
>>  > >  -- reg: Should contain the DMA controller registers location 
>> and
>>  > > length.
>>  > >  +- reg: Should contain the DMA channel registers location and
>>  > > length, followed
>>  > >  +  by the DMA controller registers location and length.
>>  > >   - interrupts: Should contain the interrupt specifier of the 
>> DMA
>>  > > controller.
>>  > >   - interrupt-parent: Should be the phandle of the interrupt
>>  > > controller that
>>  > >   - clocks: Should contain a clock specifier for the JZ4780 PDMA
>>  > > clock.
>>  > >  @@ -22,7 +23,8 @@ Example:
>>  > >
>>  > >   dma: dma@13420000 {
>>  > >   	compatible = "ingenic,jz4780-dma";
>>  > >  -	reg = <0x13420000 0x10000>;
>>  > >  +	reg = <0x13420000 0x400
>>  > >  +	       0x13421000 0x40>;
>>  >
>>  > Second should be optional or we break platform which may not have
>>  > updated DT..
>> 
>>  See comment below.
>> 
>>  > >  -	jzdma->base = devm_ioremap_resource(dev, res);
>>  > >  -	if (IS_ERR(jzdma->base))
>>  > >  -		return PTR_ERR(jzdma->base);
>>  > >  +	jzdma->chn_base = devm_ioremap_resource(dev, res);
>>  > >  +	if (IS_ERR(jzdma->chn_base))
>>  > >  +		return PTR_ERR(jzdma->chn_base);
>>  > >  +
>>  > >  +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>>  > >  +	if (!res) {
>>  > >  +		dev_err(dev, "failed to get I/O memory\n");
>>  > >  +		return -EINVAL;
>>  > >  +	}
>>  >
>>  > okay and this breaks if you happen to get probed on older DT. I 
>> think DT
>>  > is treated as ABI so you need to continue support older method 
>> while
>>  > finding if DT has split resources
>> 
>>  See my response to PrasannaKumar. All the Ingenic-based boards do 
>> compile
>>  the devicetree within the kernel, so I think it's still fine to add 
>> breaking
>>  changes. I'll wait on @Rob to give his point of view on this, 
>> though.
>> 
>>  (It's not something hard to change, but I'd like to know what's the 
>> policy
>>  in that case. I have other DT-breaking patches to submit)
> 
> The policy is that DT is an ABI and should not break :)
> 
> Who maintains Ingenic arch. MAINTAINERS doesn't tell me.

Unofficially that would be me :)

Otherwise that would be the MIPS maintainers, Ralf and Paul (Burton).

> --
> ~Vinod
