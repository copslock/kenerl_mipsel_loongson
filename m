Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2018 17:34:25 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:43708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990401AbeGQPeWxT3-g (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jul 2018 17:34:22 +0200
Received: from localhost (unknown [122.178.206.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A7EF20839;
        Tue, 17 Jul 2018 15:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531841656;
        bh=Odx7C7LLxB0hPvxPLqDMm97N8dkhL4WBzNNd1R8eATI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HQtn2aGjhZTWI145IFcdEmJftV4Ep5/pwmDl0lKvQsZUre3KiCf/dybS5ifHOBtoi
         9aMlR8+svYmFIr7xm3POS3ODBmOOhnF74hWn9YNs3gCAhek1lkxtRZ0WFibq72QSZj
         zG4Y9AuWWJegWriPTK4fQV35bhX/fYKCtNvPNAzc=
Date:   Tue, 17 Jul 2018 21:04:07 +0530
From:   Vinod <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 05/14] dmaengine: dma-jz4780: Add support for the JZ4740
 SoC
Message-ID: <20180717153407.GF3219@vkoul-mobl>
References: <20180703123214.23090-1-paul@crapouillou.net>
 <20180703123214.23090-6-paul@crapouillou.net>
 <20180709171226.GK22377@vkoul-mobl>
 <20180716213339.GA19161@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716213339.GA19161@rob-hp-laptop>
User-Agent: Mutt/1.9.2 (2017-12-15)
Return-Path: <vkoul@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64896
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

On 16-07-18, 15:33, Rob Herring wrote:
> On Mon, Jul 09, 2018 at 10:42:26PM +0530, Vinod wrote:
> > On 03-07-18, 14:32, Paul Cercueil wrote:
> > 
> > >  enum jz_version {
> > > +	ID_JZ4740,
> > >  	ID_JZ4770,
> > >  	ID_JZ4780,
> > >  };
> > > @@ -247,6 +248,7 @@ static void jz4780_dma_desc_free(struct virt_dma_desc *vdesc)
> > >  }
> > >  
> > >  static const unsigned int jz4780_dma_ord_max[] = {
> > > +	[ID_JZ4740] = 5,
> > >  	[ID_JZ4770] = 6,
> > >  	[ID_JZ4780] = 7,
> > >  };
> > > @@ -801,11 +803,13 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
> > >  }
> > >  
> > >  static const unsigned int jz4780_dma_nb_channels[] = {
> > > +	[ID_JZ4740] = 6,
> > >  	[ID_JZ4770] = 6,
> > >  	[ID_JZ4780] = 32,
> > >  };
> > 
> > I feel these should be done away with if we describe hardware in DT
> 
> The compatible property can imply things like this.

So what is the general recommendation, let DT describe hardware
including version delta or use compatible to code that in driver?

Is it documented anywhere?

-- 
~Vinod
