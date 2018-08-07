Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2018 17:01:43 +0200 (CEST)
Received: from mail-io0-f195.google.com ([209.85.223.195]:37943 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994702AbeHGPBgRo8Yl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Aug 2018 17:01:36 +0200
Received: by mail-io0-f195.google.com with SMTP id v26-v6so14240457iog.5;
        Tue, 07 Aug 2018 08:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2bfpvkev53o9yaQQ9M/RxMH9P5Wk+KrNDI7wCnruyCI=;
        b=PWdAGozVR1pwauHF/+nDpA1ooJA9jrEq4nYDa5Fg5WE79ZwadhgAGvsR/mzfwzJnny
         +4swUd1XQLvv0OXi2slJSd5rod5C5BJCuJFp0uNQ3gwwqQ0VZsIk7gaxaQq6QZvFIMIE
         G/ywOv1tMmPpL9erqXaj4AN+HnIz4bT3EV1cOjML5D+uimwA04n8AQs2TiwkUfBRoIOi
         ksypm2RBtI2Ih4ijI4fIp6zr6+2Rx8Mi/w8cxq/9OplCY4plywUeQpRyO/yAkjc9vSeg
         dVZD/mIVAqGK8ex8+SZn3wMFHkb8D9jQtorV5vp/UGiD2Xde6O8MUnHcKC1eYUwQMMBv
         8/mw==
X-Gm-Message-State: AOUpUlGf0SdDpYJXH2YRefFSYFyN/egDvfALb4YISMKvr5TSRZABUNFC
        0+IjgdGVUsTa4ah7wuX5Lg==
X-Google-Smtp-Source: AA+uWPykaNvmyvc3jHpflAD0xYgGa7mWtrnlTVTYN0KZIC+effdXwuPbUjP7f4YXuLxmxFbtvMfobw==
X-Received: by 2002:a6b:9bd1:: with SMTP id d200-v6mr20540129ioe.147.1533654090218;
        Tue, 07 Aug 2018 08:01:30 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id l10-v6sm913816itb.27.2018.08.07.08.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 08:01:29 -0700 (PDT)
Date:   Tue, 7 Aug 2018 09:01:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Vinod Koul <vkoul@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v4 01/18] doc: dt-bindings: jz4780-dma: Update bindings
 to reflect driver changes
Message-ID: <20180807150129.GA9404@rob-hp-laptop>
References: <20180807114218.20091-1-paul@crapouillou.net>
 <20180807114218.20091-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807114218.20091-2-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65468
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

On Tue, Aug 07, 2018 at 01:42:01PM +0200, Paul Cercueil wrote:
> The driver now expects the devicetree to supply a second memory
> resource. This resource is mandatory on the newly supported SoCs.
> For the JZ4780, new devicetree code must also provide it, although the
> driver is still compatible with older devicetree binaries.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Mathieu Malaterre <malat@debian.org>
> ---
>  Documentation/devicetree/bindings/dma/jz4780-dma.txt | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Drop the 'doc: ' from the subject if you respin. Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
