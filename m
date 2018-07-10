Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jul 2018 17:41:42 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:49570 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994272AbeGJPlcCuMb- convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Jul 2018 17:41:32 +0200
Date:   Tue, 10 Jul 2018 17:41:26 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 04/14] dmaengine: dma-jz4780: Add support for the JZ4770
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
Message-Id: <1531237286.17118.2@crapouillou.net>
In-Reply-To: <20180709171032.GJ22377@vkoul-mobl>
References: <20180703123214.23090-1-paul@crapouillou.net>
        <20180703123214.23090-5-paul@crapouillou.net>
        <20180709171032.GJ22377@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1531237291; bh=d6WE7oAW3jTKnldJTv4nfQHOE3iDxU8Ba4ktfujz9hc=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=TtFbvyldGrWPA010Fu8NOoUy8G3lf4isV0/xHdwMbVgUeaOzenH/5dY+UbGhP7GjcBSXA/7Y4PWI1U82h5BjDYmH+u6YH1dgPyV7eJWZwYFG9ZpBGwbOsBidGK/0BrzPWJqoggaUzzrbSimfZ170hFxbXN7+vAT5p36iHk+NLPk=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64759
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



Le lun. 9 juil. 2018 à 19:10, Vinod <vkoul@kernel.org> a écrit :
> On 03-07-18, 14:32, Paul Cercueil wrote:
> 
>>  +static inline void jz4780_dma_chan_disable(struct jz4780_dma_dev 
>> *jzdma,
>>  +	unsigned int chn)
>>  +{
>>  +	if (jzdma->version == ID_JZ4770)
>>  +		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKEC, BIT(chn));
>>  +}
> 
> this sounds as hardware behaviour, so why not describe as a property 
> in
> DT?

See my response to your message on patch 1.

>>  +
>>   static struct jz4780_dma_desc *jz4780_dma_desc_alloc(
>>   	struct jz4780_dma_chan *jzchan, unsigned int count,
>>   	enum dma_transaction_type type)
>>  @@ -228,8 +246,15 @@ static void jz4780_dma_desc_free(struct 
>> virt_dma_desc *vdesc)
>>   	kfree(desc);
>>   }
>> 
>>  -static uint32_t jz4780_dma_transfer_size(unsigned long val, 
>> uint32_t *shift)
>>  +static const unsigned int jz4780_dma_ord_max[] = {
>>  +	[ID_JZ4770] = 6,
>>  +	[ID_JZ4780] = 7,
>>  +};
> 
> So this gives the transfer length supported?

Yes, exactly. The maximum transfer size is (1 << ord).

> --
> ~Vinod
