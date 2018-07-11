Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2018 14:18:44 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:52140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993634AbeGKMSci-0k0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Jul 2018 14:18:32 +0200
Received: from localhost (unknown [106.200.243.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFEDD2084A;
        Wed, 11 Jul 2018 12:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531311506;
        bh=FDUAlOIMOa2dsSB42iRjaXYLF9vMgJtEJfqna1/YIA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2RtrHlIQvTWeHfqczJ1ZPjrfRJCoMtbNcmexRo3kkJ9zTiQXP/Scfz02XYhSrbxZt
         dKThm4pMadj8GEeZL3RWxKa+mEwF4ydaIDu4BfECzClbCsOKV5krFdx+JTPNFDmkOY
         RFBC0fd9nnoxi+BypFI41ZhQ14t4GRzQ340VL8V0=
Date:   Wed, 11 Jul 2018 17:48:18 +0530
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
Message-ID: <20180711121818.GT3219@vkoul-mobl>
References: <20180703123214.23090-1-paul@crapouillou.net>
 <20180703123214.23090-7-paul@crapouillou.net>
 <20180709171458.GL22377@vkoul-mobl>
 <1531237502.17118.3@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531237502.17118.3@crapouillou.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Return-Path: <vkoul@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64791
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

On 10-07-18, 17:45, Paul Cercueil wrote:
> 
> 
> Le lun. 9 juil. 2018 à 19:14, Vinod <vkoul@kernel.org> a écrit :
> > On 03-07-18, 14:32, Paul Cercueil wrote:
> > >  The JZ4725B has one DMA core starring six DMA channels.
> > >  As for the JZ4770, each DMA channel's clock can be enabled with
> > >  a register write, the difference here being that once started, it
> > >  is not possible to turn it off.
> > 
> > ok so disable for this, right..
> > 
> > >  @@ -204,6 +205,8 @@ static inline void
> > > jz4780_dma_chan_enable(struct jz4780_dma_dev *jzdma,
> > >   {
> > >   	if (jzdma->version == ID_JZ4770)
> > >   		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKES, BIT(chn));
> > >  +	else if (jzdma->version == ID_JZ4725B)
> > >  +		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKE, BIT(chn));
> > 
> > but you are writing to a different register here..
> 
> Yes. SoCs >= JZ4770 have the DCKE read-only register, and DCKES/DCKEC to
> set/clear bits in DCKE.
> On JZ4725B, DCKE is read/write, but the zeros written are ignored (at least
> that's what the
> documentation says).

and that was not documented in the log... so i though it maybe a typo.

-- 
~Vinod
