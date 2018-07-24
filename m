Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2018 01:36:10 +0200 (CEST)
Received: from mail-it0-f68.google.com ([209.85.214.68]:50434 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994541AbeGXXgGXUWJJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jul 2018 01:36:06 +0200
Received: by mail-it0-f68.google.com with SMTP id w16-v6so6237731ita.0;
        Tue, 24 Jul 2018 16:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iw3euw7oC9bkeiUxYufiNbsATI3ldXyqCpm7dffnnL8=;
        b=tbOzlAaVYY0hsXN9EhpdK3ab5QBB9C3N2SiBnJPwB0SY4wzl8WX/YDNsajWe0VJTKT
         9HIuLSIImSv76XJ0qgDRz/4RUgCMM9pdzGToGkweRhvDhgiI1i40SUtbkOLm8kU2YOo7
         RK72uAPE21dMUBEx8hXYJ4atgCFHyezRej0mo7FkRHzhBwb1bGxtBtFrpHiQD6jauVM6
         x8ks4HROvVYkbJ2CXonu5ZoslZmS6d3YBQm3OG8JmMIoTY1VhqGvzTy0kD2uf0dsWLJi
         sEZhEWlCv4KFCz3jkdMes/jCcGo2mREPRHtRKusYct8z0VwMVaDKTm3yioQoAFggyVCy
         kdKw==
X-Gm-Message-State: AOUpUlFqyQbx21374xZiFtXDWBOmZ8sAkJ5zEdRl4rLqqZhrftGroiX1
        fU8R7LqAm8tVJ7splzMnMw==
X-Google-Smtp-Source: AAOMgpe5zr/4tWtXINC/Eb4w/q3ntKLTWr0JjGY7kTHPUkRcj1VEfw8WMBohjRKKwkRtwd7iAN++/g==
X-Received: by 2002:a02:5952:: with SMTP id p79-v6mr16945367jab.129.1532475360345;
        Tue, 24 Jul 2018 16:36:00 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id i3-v6sm1624849iti.40.2018.07.24.16.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 16:35:59 -0700 (PDT)
Date:   Tue, 24 Jul 2018 17:35:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Vinod Koul <vkoul@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v3 01/18] doc: dt-bindings: jz4780-dma: Update bindings
 to reflect driver changes
Message-ID: <20180724233558.GA30764@rob-hp-laptop>
References: <20180721110643.19624-1-paul@crapouillou.net>
 <20180721110643.19624-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180721110643.19624-2-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65122
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

On Sat, Jul 21, 2018 at 01:06:26PM +0200, Paul Cercueil wrote:
> The driver is now compatible with four SoCs: JZ4780, JZ4770, JZ4725B and
> JZ4740.

What the driver supports is irrelevant to the binding.
>
> Besides, it now expects the devicetree to supply a second memory
> resource. This resource is mandatory on the newly supported SoCs.
> For the JZ4780, new devicetree code must also provide it, although the
> driver is still compatible with older devicetree binaries.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Mathieu Malaterre <malat@debian.org>
> ---
>  Documentation/devicetree/bindings/dma/jz4780-dma.txt | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
>  v2: New patch in this series; regroups the changes made to the
>  jz4780-dma.txt doc file in the previous version of the patchset.
> 
>  v3: Updated example to comply with devicetree specification
> 
> diff --git a/Documentation/devicetree/bindings/dma/jz4780-dma.txt b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
> index f25feee62b15..14f33305e194 100644
> --- a/Documentation/devicetree/bindings/dma/jz4780-dma.txt
> +++ b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
> @@ -2,8 +2,13 @@
>  
>  Required properties:
>  
> -- compatible: Should be "ingenic,jz4780-dma"
> -- reg: Should contain the DMA controller registers location and length.
> +- compatible: Should be one of:
> +  * ingenic,jz4740-dma
> +  * ingenic,jz4725b-dma
> +  * ingenic,jz4770-dma
> +  * ingenic,jz4780-dma

So none of these are compatible with each other? It should be one valid 
combination per line.

> +- reg: Should contain the DMA channel registers location and length, followed
> +  by the DMA controller registers location and length.
>  - interrupts: Should contain the interrupt specifier of the DMA controller.
>  - interrupt-parent: Should be the phandle of the interrupt controller that
>  - clocks: Should contain a clock specifier for the JZ4780 PDMA clock.
> @@ -20,9 +25,10 @@ Optional properties:
>  
>  Example:
>  
> -dma: dma@13420000 {
> +dma: dma-controller@13420000 {
>  	compatible = "ingenic,jz4780-dma";
> -	reg = <0x13420000 0x10000>;
> +	reg = <0x13420000 0x400
> +	       0x13421000 0x40>;
>  
>  	interrupt-parent = <&intc>;
>  	interrupts = <10>;
> -- 
> 2.11.0
> 
