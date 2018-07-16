Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jul 2018 23:29:10 +0200 (CEST)
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35579 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993024AbeGPV3Am-z96 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jul 2018 23:29:00 +0200
Received: by mail-oi0-f68.google.com with SMTP id i12-v6so77644869oik.2;
        Mon, 16 Jul 2018 14:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z4LTUphqrMF2ZUQkliDnej/gPLyoQjbEBwgTd9g6gvo=;
        b=QnzT055baTYCMSJHzaQbTSZKPcTm82CMBWck3iwS1epignnkQECmdP7wnjGmykhzM2
         uGLgYmwtM7X6Yyioh0ZYQFXNwz25Gd8s9vGGhY4QsZLjmMr3lpjK+JaHXj44/MAaLXnq
         e0GE5sOcOCp82Qf+3ZF7b4p0+L0ZzEhOxbLa93UqHLq/szgiFvHV2uaU3/Fb9eV7boKX
         o0H+X0hwEKAZL2sUzxU3zGwSJHiJG1WoV8GOr1hqNWULq2cmjUSqr1Ed0TBw/j3SjKkY
         hn7+nAxKnDxkz9+n2wB9EMLzH2b2pNtkn9IUUEBVFJy6wKf4gFElgre6LbJwPF9KZLjM
         2z4Q==
X-Gm-Message-State: AOUpUlErzflH8SI9I2Idmc9olxPisHZSw64rmE3CUF45I5+Rq962pVAQ
        B4sPfrLUg7mf2tB+euyodA==
X-Google-Smtp-Source: AAOMgpeZD5rBFhgJQpDu4ehuJR2dtHJPUmFlHhzDv1eC+rbBSiwkybQp+GHo4PbeB0kWRShOBnWs8w==
X-Received: by 2002:aca:a64d:: with SMTP id p74-v6mr1034454oie.149.1531776534378;
        Mon, 16 Jul 2018 14:28:54 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id r133-v6sm30021629oia.33.2018.07.16.14.28.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 14:28:53 -0700 (PDT)
Date:   Mon, 16 Jul 2018 15:28:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Vinod <vkoul@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 02/14] dmaengine: dma-jz4780: Separate chan/ctrl registers
Message-ID: <20180716212852.GA6323@rob-hp-laptop>
References: <20180703123214.23090-1-paul@crapouillou.net>
 <20180703123214.23090-3-paul@crapouillou.net>
 <20180709170359.GI22377@vkoul-mobl>
 <1531237019.17118.1@crapouillou.net>
 <20180711121655.GS3219@vkoul-mobl>
 <20180711232715.djxrbgmcski5xtjp@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711232715.djxrbgmcski5xtjp@pburton-laptop>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64864
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Wed, Jul 11, 2018 at 04:27:15PM -0700, Paul Burton wrote:
> Hi Vinod,
> 
> On Wed, Jul 11, 2018 at 05:46:55PM +0530, Vinod wrote:
> > > > >  -	jzdma->base = devm_ioremap_resource(dev, res);
> > > > >  -	if (IS_ERR(jzdma->base))
> > > > >  -		return PTR_ERR(jzdma->base);
> > > > >  +	jzdma->chn_base = devm_ioremap_resource(dev, res);
> > > > >  +	if (IS_ERR(jzdma->chn_base))
> > > > >  +		return PTR_ERR(jzdma->chn_base);
> > > > >  +
> > > > >  +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > > > >  +	if (!res) {
> > > > >  +		dev_err(dev, "failed to get I/O memory\n");
> > > > >  +		return -EINVAL;
> > > > >  +	}
> > > > 
> > > > okay and this breaks if you happen to get probed on older DT. I think DT
> > > > is treated as ABI so you need to continue support older method while
> > > > finding if DT has split resources
> > > 
> > > See my response to PrasannaKumar. All the Ingenic-based boards do compile
> > > the devicetree within the kernel, so I think it's still fine to add breaking
> > > changes. I'll wait on @Rob to give his point of view on this, though.
> > > 
> > > (It's not something hard to change, but I'd like to know what's the policy
> > > in that case. I have other DT-breaking patches to submit)
> > 
> > The policy is that DT is an ABI and should not break :)
> 
> I think in general that's a good policy to have for compatibility, but
> if it's known for certain that the DT for all users of a driver is
> always built into the kernel then I don't see why we shouldn't feel free
> to change a binding. I agree with Paul that it'd be interesting to hear
> the DT binding maintainers take on this.

If the platform maintainers (and their users) don't care, then I don't 
have an issue with the change. It should still be an exception and not 
just any change goes. The commit message should still highlight that 
compatibility is being broken and why.

Rob
