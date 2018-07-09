Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2018 19:10:53 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:48446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993885AbeGIRKrNyiGb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Jul 2018 19:10:47 +0200
Received: from localhost (unknown [106.201.46.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2D7920871;
        Mon,  9 Jul 2018 17:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531156240;
        bh=S2SRd74Sj9T5eX2eyIlX5JtPkaGoBi6f/8cX3t7yjeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O8Uua1Js1grCndzN1Lgqv4c77OV07z0Xg78ZcZ5ZrTyah8K2s0ZYnBP5+0LZ7+t3S
         4Ntv1SaTVUej9kfkfHk9F0zEYbuwFO546xEo2QMMnqZ+8HAbd6GDDPhcPiryh8mp4p
         Xe54O1hSwP5wKutSp17Qvubq7310cJW1LpNGSuTU=
Date:   Mon, 9 Jul 2018 22:40:32 +0530
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
Subject: Re: [PATCH 04/14] dmaengine: dma-jz4780: Add support for the JZ4770
 SoC
Message-ID: <20180709171032.GJ22377@vkoul-mobl>
References: <20180703123214.23090-1-paul@crapouillou.net>
 <20180703123214.23090-5-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703123214.23090-5-paul@crapouillou.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Return-Path: <vkoul@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64719
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

> +static inline void jz4780_dma_chan_disable(struct jz4780_dma_dev *jzdma,
> +	unsigned int chn)
> +{
> +	if (jzdma->version == ID_JZ4770)
> +		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKEC, BIT(chn));
> +}

this sounds as hardware behaviour, so why not describe as a property in
DT?

> +
>  static struct jz4780_dma_desc *jz4780_dma_desc_alloc(
>  	struct jz4780_dma_chan *jzchan, unsigned int count,
>  	enum dma_transaction_type type)
> @@ -228,8 +246,15 @@ static void jz4780_dma_desc_free(struct virt_dma_desc *vdesc)
>  	kfree(desc);
>  }
>  
> -static uint32_t jz4780_dma_transfer_size(unsigned long val, uint32_t *shift)
> +static const unsigned int jz4780_dma_ord_max[] = {
> +	[ID_JZ4770] = 6,
> +	[ID_JZ4780] = 7,
> +};

So this gives the transfer length supported?
-- 
~Vinod
