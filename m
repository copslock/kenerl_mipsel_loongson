Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jul 2018 17:45:14 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:53092 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994272AbeGJPpH6c70- convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Jul 2018 17:45:07 +0200
Date:   Tue, 10 Jul 2018 17:45:02 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 06/14] dmaengine: dma-jz4780: Add support for the JZ4725B
 SoC
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
Message-Id: <1531237502.17118.3@crapouillou.net>
In-Reply-To: <20180709171458.GL22377@vkoul-mobl>
References: <20180703123214.23090-1-paul@crapouillou.net>
        <20180703123214.23090-7-paul@crapouillou.net>
        <20180709171458.GL22377@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1531237507; bh=WjTJmSBBrurN9JyF9IyWDMyPaD+mqwPGq8mYopQDoG8=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=DqSrVO4z5BhlGLAOU7Z7L7XLCxV2kHd9ITCUDKWOvlkRE+7O0nP2/683PCeGYv3cWc3IJg75AogCbLYK/lEnrvC2CDpXNh/7qnaTqTTlxitVmskMLN6u8CHblLLIT36BaR2eRDLMn7z9CBmhWFHhg82K+V0WC6boUZNfTN4v+K0=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64760
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



Le lun. 9 juil. 2018 à 19:14, Vinod <vkoul@kernel.org> a écrit :
> On 03-07-18, 14:32, Paul Cercueil wrote:
>>  The JZ4725B has one DMA core starring six DMA channels.
>>  As for the JZ4770, each DMA channel's clock can be enabled with
>>  a register write, the difference here being that once started, it
>>  is not possible to turn it off.
> 
> ok so disable for this, right..
> 
>>  @@ -204,6 +205,8 @@ static inline void 
>> jz4780_dma_chan_enable(struct jz4780_dma_dev *jzdma,
>>   {
>>   	if (jzdma->version == ID_JZ4770)
>>   		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKES, BIT(chn));
>>  +	else if (jzdma->version == ID_JZ4725B)
>>  +		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKE, BIT(chn));
> 
> but you are writing to a different register here..

Yes. SoCs >= JZ4770 have the DCKE read-only register, and DCKES/DCKEC 
to set/clear bits in DCKE.
On JZ4725B, DCKE is read/write, but the zeros written are ignored (at 
least that's what the
documentation says).

> --
> ~Vinod

Thanks,
-Paul
