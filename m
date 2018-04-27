Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Apr 2018 22:08:21 +0200 (CEST)
Received: from mail-oi0-f68.google.com ([209.85.218.68]:42456 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990401AbeD0UINx-Vmc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Apr 2018 22:08:13 +0200
Received: by mail-oi0-f68.google.com with SMTP id t27-v6so2629814oij.9
        for <linux-mips@linux-mips.org>; Fri, 27 Apr 2018 13:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eNpSHywaA5vopDrpOA0VVP/3yFo4Z8zJz6c7Uv7wbJE=;
        b=nz1YuHZasvRRu3oQn+VvAXHi+DF4t6dDXa7Jr/PTvVELEys+rbO41iff6ug9ZLbPw5
         +2lgAflnbufq9E05nDPC4tm1aY+nYtLuo8sypE/nUopxL13qis/xKPeqir1Hfp1Iqu2L
         DOIF2lk4nr0VZZp2VHyHMSMu0UJ91YLaZtPxWinVwZpE1HG04JpO5bB+hbvy6+bZyvL/
         CYc7A44buXjumCtXM1r2JGVL0Yh0NNBRsOES0m0ddUB2jtTr6c5R1fjC3PVSug19CsoD
         d1YWD3iezlYWpOjv58vuWMhZdj+9qOeRvwO5j57s5u8QoDuz/7UweCkSvg0Nqud3g8bz
         wdMw==
X-Gm-Message-State: ALQs6tAJtFvo994ndu9L7uSpzPmxZFAAJ93mhH9hEYhTs+87Vk8Lbrjd
        KSK8udtkaDSSE0JMB+mBhA==
X-Google-Smtp-Source: AB8JxZrvacPPD8oRhZeXmhEtf+JU7G9OSI3MU2BGyaJwwcmP3IVISn4H/7URFHEdRj6Z96b8POKHng==
X-Received: by 2002:aca:5405:: with SMTP id i5-v6mr2222197oib.262.1524859687821;
        Fri, 27 Apr 2018 13:08:07 -0700 (PDT)
Received: from localhost (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.gmail.com with ESMTPSA id 76-v6sm1117069oii.25.2018.04.27.13.08.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Apr 2018 13:08:07 -0700 (PDT)
Date:   Fri, 27 Apr 2018 15:08:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH net-next v2 1/7] dt-bindings: net: add DT bindings for
 Microsemi MIIM
Message-ID: <20180427200806.ga3xkift6kvc7sbv@rob-hp-laptop>
References: <20180426195931.5393-1-alexandre.belloni@bootlin.com>
 <20180426195931.5393-2-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426195931.5393-2-alexandre.belloni@bootlin.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63816
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

On Thu, Apr 26, 2018 at 09:59:25PM +0200, Alexandre Belloni wrote:
> DT bindings for the Microsemi MII Management Controller found on Microsemi
> SoCs
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  .../devicetree/bindings/net/mscc-miim.txt     | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/mscc-miim.txt

Reviewed-by: Rob Herring <robh@kernel.org>
