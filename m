Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2018 18:02:00 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:42390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994243AbeGXQB5FdWT- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Jul 2018 18:01:57 +0200
Received: from localhost (unknown [171.61.90.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE8432088E;
        Tue, 24 Jul 2018 16:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532448110;
        bh=lRaTDOaAEEOMshC7cwZp7kz+U0prMg2/7vx7+guroUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j8bxJLlBU9OyebRBaGm45N44spzwLlV/uNeSmksk72ZXG6+ViGfEM+f3K/ZAtwcpT
         09Eo2mZDsMavLmCrKdCH9EiKSYWWCi0RtbFv7aRXo10tFZVt0nt54x3Jwzkb+9zN8s
         6tBG2cYmcKj95QsedrIjnTnNu5sxHti2CeZej4e0=
Date:   Tue, 24 Jul 2018 21:31:40 +0530
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
Subject: Re: [PATCH v3 07/18] dmaengine: dma-jz4780: Add support for the
 JZ4770 SoC
Message-ID: <20180724160140.GI3661@vkoul-mobl>
References: <20180721110643.19624-1-paul@crapouillou.net>
 <20180721110643.19624-8-paul@crapouillou.net>
 <20180724133229.GG3661@vkoul-mobl>
 <1532444695.2610.1@smtp.crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1532444695.2610.1@smtp.crapouillou.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Return-Path: <vkoul@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65087
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

On 24-07-18, 17:04, Paul Cercueil wrote:
> Hi Vinod,
> 
> Le mar. 24 juil. 2018 � 15:32, Vinod <vkoul@kernel.org> a �crit :
> > On 21-07-18, 13:06, Paul Cercueil wrote:
> > >  +static inline void jz4780_dma_chan_enable(struct jz4780_dma_dev
> > > *jzdma,
> > >  +	unsigned int chn)
> > 
> > right justified and aligned with preceding please. While adding new
> > code to a existing driver it is a good idea to conform to existing style
> 
> OK.
> 
> > >  +{
> > >  +	if (jzdma->version == ID_JZ4770)
> > >  +		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKES, BIT(chn));
> > >  +}
> > >  +
> > >  +static inline void jz4780_dma_chan_disable(struct jz4780_dma_dev
> > > *jzdma,
> > >  +	unsigned int chn)
> > >  +{
> > >  +	if (jzdma->version == ID_JZ4770)
> > >  +		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKEC, BIT(chn));
> > 
> > so if another version has this feature we would do:
> >         if (jzdma->version == ID_JZ4770) ||
> >                 if (jzdma->version == ID_JZXXXX))
> > 
> > and so on.. why not add a value, clk_enable in the description and use
> > that. For each controller it is set to true or false
> 
> I agree with what you said in your other answers.
> However here I still need to check the "version", because on JZ4725B and
> JZ4770+
> the way to start/stop each DMA channel's clock is different, so I can't use
> a boolean

sure describe the behavior and use that. Versions is not a very scalable
way..

-- 
~Vinod
