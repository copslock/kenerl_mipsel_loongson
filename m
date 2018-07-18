Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jul 2018 07:27:32 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:46564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990423AbeGRF12ccbi1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Jul 2018 07:27:28 +0200
Received: from localhost (unknown [106.200.213.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE1FB20684;
        Wed, 18 Jul 2018 05:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531891641;
        bh=/ieGR3d+D0SiRFYhDVh4gOFVfjw5t1O+MSo6UJUyRvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MJP0CSkp86A84YUhy16p1GANZ81tgC/pIxNSS82dnTzfLZgr6XG+BDFySLaZHJPoZ
         a19u8HD+WXmiDgoG4UZlCsVONUbBkaKc2TYp7dMeCr3MzMhUshGVFNQpP4kTf2hw+N
         7v0jqFZPV5wbTfkvKJTwpuHxnu7vIW/iQSSJ6+K0=
Date:   Wed, 18 Jul 2018 10:57:13 +0530
From:   Vinod <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 05/14] dmaengine: dma-jz4780: Add support for the JZ4740
 SoC
Message-ID: <20180718052713.GH3219@vkoul-mobl>
References: <20180703123214.23090-1-paul@crapouillou.net>
 <20180703123214.23090-6-paul@crapouillou.net>
 <20180709171226.GK22377@vkoul-mobl>
 <20180716213339.GA19161@rob-hp-laptop>
 <20180717153407.GF3219@vkoul-mobl>
 <CAL_JsqJBw9vBURZQxa4RkDAfiinnNRK6CVTBmpnC3TaSukZLRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJBw9vBURZQxa4RkDAfiinnNRK6CVTBmpnC3TaSukZLRA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Return-Path: <vkoul@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64912
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

On 17-07-18, 11:40, Rob Herring wrote:
> On Tue, Jul 17, 2018 at 9:34 AM Vinod <vkoul@kernel.org> wrote:
> >
> > On 16-07-18, 15:33, Rob Herring wrote:
> > > On Mon, Jul 09, 2018 at 10:42:26PM +0530, Vinod wrote:
> > > > On 03-07-18, 14:32, Paul Cercueil wrote:
> > > >
> > > > >  enum jz_version {
> > > > > + ID_JZ4740,
> > > > >   ID_JZ4770,
> > > > >   ID_JZ4780,
> > > > >  };
> > > > > @@ -247,6 +248,7 @@ static void jz4780_dma_desc_free(struct virt_dma_desc *vdesc)
> > > > >  }
> > > > >
> > > > >  static const unsigned int jz4780_dma_ord_max[] = {
> > > > > + [ID_JZ4740] = 5,
> > > > >   [ID_JZ4770] = 6,
> > > > >   [ID_JZ4780] = 7,
> > > > >  };
> > > > > @@ -801,11 +803,13 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
> > > > >  }
> > > > >
> > > > >  static const unsigned int jz4780_dma_nb_channels[] = {
> > > > > + [ID_JZ4740] = 6,
> > > > >   [ID_JZ4770] = 6,
> > > > >   [ID_JZ4780] = 32,
> > > > >  };
> > > >
> > > > I feel these should be done away with if we describe hardware in DT
> > >
> > > The compatible property can imply things like this.
> >
> > So what is the general recommendation, let DT describe hardware
> > including version delta or use compatible to code that in driver?
> 
> Compatible is the version. Looking at the above, the version or ID
> isn't even stable.
> 
> > Is it documented anywhere?
> 
> Not really. It's a judgment call generally. Maybe # of DMA channels
> should be a property because that is something most controllers have.
> But you really have to define the property up front, not when the 2nd
> version of h/w shows up with different properties.
> 
> To start defining guidelines, a couple of things come to mind:
> 
> - Define properties for parameters that vary from board to board (for one SoC).
> - You can't add new required properties to existing bindings, so the
> not present default must work for all existing compatibles (or you
> need per compatible driver data).
> - Bugs/quirks/errata should be handled by compatible, not adding a
> property. Because bugs should be fixable without a dtb update and only
> a kernel update.

Sounds good to me, thanks for the guide.

-- 
~Vinod
