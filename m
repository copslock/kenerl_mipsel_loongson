Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2018 13:00:43 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:60938 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990395AbeGQLAkv4ChX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jul 2018 13:00:40 +0200
Date:   Tue, 17 Jul 2018 13:00:29 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 05/14] dmaengine: dma-jz4780: Add support for the JZ4740
 SoC
To:     Rob Herring <robh@kernel.org>
Cc:     Vinod <vkoul@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Message-Id: <1531825229.5992.0@smtp.crapouillou.net>
In-Reply-To: <20180716213339.GA19161@rob-hp-laptop>
References: <20180703123214.23090-1-paul@crapouillou.net>
        <20180703123214.23090-6-paul@crapouillou.net>
        <20180709171226.GK22377@vkoul-mobl> <20180716213339.GA19161@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1531825239; bh=aEZbmjqPBJqaEsjPMfUzrceU4haKjosnEaqcb+UBvtA=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=i7x45M6BeTXgcHXrZzOYUCwum1Nm7KcCCLDCwDR7w0Bio+7iMWF8wGyvgq/Eep/Os1creiQ64lvTEIvkq+dc8C6OszRHXh81p3zh/idyMxVAEAuQbpJ3RMZ/iDhFv0Uvw7BXKtEaupI8nbtbNioyyoaRQUtQPuVi1RlaLaQb3ak=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64870
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

Hi,

Le lun. 16 juil. 2018 à 23:33, Rob Herring <robh@kernel.org> a écrit :
> On Mon, Jul 09, 2018 at 10:42:26PM +0530, Vinod wrote:
>>  On 03-07-18, 14:32, Paul Cercueil wrote:
>> 
>>  >  enum jz_version {
>>  > +	ID_JZ4740,
>>  >  	ID_JZ4770,
>>  >  	ID_JZ4780,
>>  >  };
>>  > @@ -247,6 +248,7 @@ static void jz4780_dma_desc_free(struct 
>> virt_dma_desc *vdesc)
>>  >  }
>>  >
>>  >  static const unsigned int jz4780_dma_ord_max[] = {
>>  > +	[ID_JZ4740] = 5,
>>  >  	[ID_JZ4770] = 6,
>>  >  	[ID_JZ4780] = 7,
>>  >  };
>>  > @@ -801,11 +803,13 @@ static struct dma_chan 
>> *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
>>  >  }
>>  >
>>  >  static const unsigned int jz4780_dma_nb_channels[] = {
>>  > +	[ID_JZ4740] = 6,
>>  >  	[ID_JZ4770] = 6,
>>  >  	[ID_JZ4780] = 32,
>>  >  };
>> 
>>  I feel these should be done away with if we describe hardware in DT
> 
> The compatible property can imply things like this.
> 
> But how this is structured is a bit strange. Normally you have a per
> compatible struct with these as elements and the compatible matching
> selects the struct.

You're right, I'll change that.

>> 
>>  >
>>  >  static const struct of_device_id jz4780_dma_dt_match[] = {
>>  > +	{ .compatible = "ingenic,jz4740-dma", .data = (void *)ID_JZ4740 
>> },
>> 
>>  adding .compatible should be the only thing required, if at all for 
>> this
>>  addition :)
>> 
>>  --
>>  ~Vinod
