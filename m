Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2018 19:15:19 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:49504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993928AbeGIRPNVeoPb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Jul 2018 19:15:13 +0200
Received: from localhost (unknown [106.201.46.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F55C20871;
        Mon,  9 Jul 2018 17:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531156507;
        bh=mnbJASZQ6vB8nBRDMUBh+xawH7madxOgrKeixrgkcv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ofsTksSX/OSzuLwld6bgnPx84JXyEDgvLYae5hmFcq+C5xpapSSGuRBb/I0fIcKof
         jIDXVppVVgwFinJ1GeQtA0su3VJjeNr7YXz+c9bYAjmLJ8+18eMxpOg0bg+v4aYWS8
         +ZLT7+W3eKh2+jiMfpsxQfXqGEcRZ1U+iPc6w4Qc=
Date:   Mon, 9 Jul 2018 22:44:58 +0530
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
Subject: Re: [PATCH 06/14] dmaengine: dma-jz4780: Add support for the JZ4725B
 SoC
Message-ID: <20180709171458.GL22377@vkoul-mobl>
References: <20180703123214.23090-1-paul@crapouillou.net>
 <20180703123214.23090-7-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703123214.23090-7-paul@crapouillou.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Return-Path: <vkoul@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64721
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
> The JZ4725B has one DMA core starring six DMA channels.
> As for the JZ4770, each DMA channel's clock can be enabled with
> a register write, the difference here being that once started, it
> is not possible to turn it off.

ok so disable for this, right..

> @@ -204,6 +205,8 @@ static inline void jz4780_dma_chan_enable(struct jz4780_dma_dev *jzdma,
>  {
>  	if (jzdma->version == ID_JZ4770)
>  		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKES, BIT(chn));
> +	else if (jzdma->version == ID_JZ4725B)
> +		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKE, BIT(chn));

but you are writing to a different register here.. 

-- 
~Vinod
