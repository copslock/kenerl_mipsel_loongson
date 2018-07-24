Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2018 17:05:04 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:44202 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993981AbeGXPFBZmrNn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jul 2018 17:05:01 +0200
Date:   Tue, 24 Jul 2018 17:04:55 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 07/18] dmaengine: dma-jz4780: Add support for the
 JZ4770 SoC
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
Message-Id: <1532444695.2610.1@smtp.crapouillou.net>
In-Reply-To: <20180724133229.GG3661@vkoul-mobl>
References: <20180721110643.19624-1-paul@crapouillou.net>
        <20180721110643.19624-8-paul@crapouillou.net>
        <20180724133229.GG3661@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532444700; bh=IqocOiyKOEeKG29E9sBB05Z8CWIQGYK6CZPqTO3/t4I=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=ltOr6WCF6u59Oi0NYPZO06a64uetxdOmtCL4mJC5SfsBkAjSmDttrar4dEsI/A6DTS0cEgAw5RGKEcO3Jp5A866FWwwpnD2oV8X5f7XkJgVuH2YRs1dTiihw+ovasviWJfw7FBmS6uevVUiPm+rtuFoHpxydB3eoRAtRR2Mu9VQ=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65086
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

Hi Vinod,

Le mar. 24 juil. 2018 à 15:32, Vinod <vkoul@kernel.org> a écrit :
> On 21-07-18, 13:06, Paul Cercueil wrote:
>>  +static inline void jz4780_dma_chan_enable(struct jz4780_dma_dev 
>> *jzdma,
>>  +	unsigned int chn)
> 
> right justified and aligned with preceding please. While adding new
> code to a existing driver it is a good idea to conform to existing 
> style

OK.

>>  +{
>>  +	if (jzdma->version == ID_JZ4770)
>>  +		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKES, BIT(chn));
>>  +}
>>  +
>>  +static inline void jz4780_dma_chan_disable(struct jz4780_dma_dev 
>> *jzdma,
>>  +	unsigned int chn)
>>  +{
>>  +	if (jzdma->version == ID_JZ4770)
>>  +		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKEC, BIT(chn));
> 
> so if another version has this feature we would do:
>         if (jzdma->version == ID_JZ4770) ||
>                 if (jzdma->version == ID_JZXXXX))
> 
> and so on.. why not add a value, clk_enable in the description and use
> that. For each controller it is set to true or false

I agree with what you said in your other answers.
However here I still need to check the "version", because on JZ4725B 
and JZ4770+
the way to start/stop each DMA channel's clock is different, so I can't 
use a boolean.

> --
> ~Vinod

Thanks,
-Paul
