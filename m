Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jul 2018 23:33:54 +0200 (CEST)
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35382 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993024AbeGPVdsBCU96 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jul 2018 23:33:48 +0200
Received: by mail-oi0-f67.google.com with SMTP id i12-v6so77667741oik.2;
        Mon, 16 Jul 2018 14:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tLMg6k/mwE9JutdGNUoTrKQN9z8d0yYh3gZ+rnkmhq0=;
        b=Xlif7eyFSRmfxfaVkZGNm19fELoiOWBGDDjPK3INTXHh/lMbjjUv8oVScvNFO71LvL
         MAKOOjnmwPIMkGMNoPJFpAQ3pscX4y2WiHy5DjdDlmqkHDNbF8CfTZjUMsYF4POTY3iV
         IGdaegkyaSLLqvr47KrLmyBJm3yF5sz4IhGAZBD+OhOoN1yZDN1ZV1vJ7jDHx63inrar
         3tdOfWkyHnPL9XtuKnimh3eghaXhnq/B4Kz+febrC4lKnThvMhH8u3TaqDd8Y8e/BXts
         sp6ahWPJo9AGgE6xrxI42OgSMtCP5ndKSw6upsMIb6djrnFUaJaiMLBU2bS/3l3hI9aL
         YpmA==
X-Gm-Message-State: AOUpUlGs6KLULT9+nSlW3ssqFMgX0Fv7ehFAi1yBlKQiFxZOVmK0S3u3
        37qPN1UqKGECB3b6cKP+3g==
X-Google-Smtp-Source: AAOMgpcte/0EZl5FO8x8p88ft1DpjW4Q6UcDFzZQ1vxbT4Y84K8MQ8EmuxHzhf7mjOz+phEBAES4QA==
X-Received: by 2002:aca:4914:: with SMTP id w20-v6mr1055172oia.5.1531776822226;
        Mon, 16 Jul 2018 14:33:42 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id e2-v6sm12307986oiy.50.2018.07.16.14.33.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 14:33:41 -0700 (PDT)
Date:   Mon, 16 Jul 2018 15:33:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vinod <vkoul@kernel.org>
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
Message-ID: <20180716213339.GA19161@rob-hp-laptop>
References: <20180703123214.23090-1-paul@crapouillou.net>
 <20180703123214.23090-6-paul@crapouillou.net>
 <20180709171226.GK22377@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709171226.GK22377@vkoul-mobl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64865
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

On Mon, Jul 09, 2018 at 10:42:26PM +0530, Vinod wrote:
> On 03-07-18, 14:32, Paul Cercueil wrote:
> 
> >  enum jz_version {
> > +	ID_JZ4740,
> >  	ID_JZ4770,
> >  	ID_JZ4780,
> >  };
> > @@ -247,6 +248,7 @@ static void jz4780_dma_desc_free(struct virt_dma_desc *vdesc)
> >  }
> >  
> >  static const unsigned int jz4780_dma_ord_max[] = {
> > +	[ID_JZ4740] = 5,
> >  	[ID_JZ4770] = 6,
> >  	[ID_JZ4780] = 7,
> >  };
> > @@ -801,11 +803,13 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
> >  }
> >  
> >  static const unsigned int jz4780_dma_nb_channels[] = {
> > +	[ID_JZ4740] = 6,
> >  	[ID_JZ4770] = 6,
> >  	[ID_JZ4780] = 32,
> >  };
> 
> I feel these should be done away with if we describe hardware in DT

The compatible property can imply things like this.

But how this is structured is a bit strange. Normally you have a per 
compatible struct with these as elements and the compatible matching 
selects the struct.

> 
> >  
> >  static const struct of_device_id jz4780_dma_dt_match[] = {
> > +	{ .compatible = "ingenic,jz4740-dma", .data = (void *)ID_JZ4740 },
> 
> adding .compatible should be the only thing required, if at all for this
> addition :)
> 
> -- 
> ~Vinod
