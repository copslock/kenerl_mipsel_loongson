Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2017 22:58:21 +0200 (CEST)
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33153 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992213AbdEaU6O40PZO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2017 22:58:14 +0200
Received: by mail-oi0-f66.google.com with SMTP id h4so3803256oib.0;
        Wed, 31 May 2017 13:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=88AG4jd8vwL0xNhFjL28E47Bz6+Xp4R2Nrs9vKDLz70=;
        b=Bl/KM/Pq553U4FUY9mxLZTZ0HlGHxGchDMepdcvyNDoeVWY0g5NoQp+RTmrF99o5Wl
         66a+MtBTJRoremWxS/OZ68JyEzkubP6pbrngLdIzm3ShbC/RqNnqBr0PeUeB+CzG7qHZ
         0++vE8V2tak3ZCWX6/x8XNdECXAy+ERSTAqR9wRKghXb2fYIPE8Y3Mu+D0TnWduwlY5e
         8j8vLjU14829jWQQMiBOszQn+pbR8kpEL79W40fnMq27AJKubDinbmFQxWA2HqfDEiF6
         yTlTXKPBfb8u89ujWQWFv+m8rYdg6RqdAiGVkyVq+mJSUIx/2MvE/5uxLUEjtoD6PU+A
         NG4g==
X-Gm-Message-State: AODbwcDuvtP5gf+yKgVjgTsU46TsVTGVI49Q+1ARMiXC2YIEZb7YCkCA
        vwrdzBCdDFmwFQ==
X-Received: by 10.202.231.83 with SMTP id e80mr10257053oih.132.1496264287928;
        Wed, 31 May 2017 13:58:07 -0700 (PDT)
Received: from localhost (66-90-148-125.dyn.grandenetworks.net. [66.90.148.125])
        by smtp.gmail.com with ESMTPSA id w70sm7970254oia.9.2017.05.31.13.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 May 2017 13:58:07 -0700 (PDT)
Date:   Wed, 31 May 2017 15:58:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, ralf@linux-mips.org,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v3 10/16] reset: Add a reset controller driver for the
 Lantiq XWAY based SoCs
Message-ID: <20170531205806.uohn2tr6qtrocpl6@rob-hp-laptop>
References: <20170528184006.31668-1-hauke@hauke-m.de>
 <20170528184006.31668-11-hauke@hauke-m.de>
 <1496053214.17695.49.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496053214.17695.49.camel@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58110
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

On Mon, May 29, 2017 at 12:20:14PM +0200, Philipp Zabel wrote:
> Hi Hauke,
> 
> On Sun, 2017-05-28 at 20:40 +0200, Hauke Mehrtens wrote:
> [...]
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/reset/lantiq,reset.txt
> > @@ -0,0 +1,30 @@
> > +Lantiq XWAY SoC RCU reset controller binding
> > +============================================
> > +
> > +This binding describes a reset-controller found on the RCU module on Lantiq
> > +XWAY SoCs.
> > +
> > +
> > +-------------------------------------------------------------------------------
> > +Required properties:
> > +- compatible		: Should be one of
> > +				"lantiq,reset-danube"
> > +				"lantiq,reset-xrx200"
> > +- regmap		: A phandle to the RCU syscon
> > +- offset-set		: Offset of the reset set register
> > +- offset-status		: Offset of the reset status register
> > +- #reset-cells		: Specifies the number of cells needed to encode the
> > +			  reset line, should be 2.
> > +			  The first cell takes the reset set bit and the
> > +			  second cell takes the status bit.
> > +
> > +-------------------------------------------------------------------------------
> > +Example for the reset-controllers on the xRX200 SoCs:
> > +	reset0: reset-controller@0 {
> > +		compatible = "lantiq,reset-xrx200";
> > +
> > +		regmap = <&rcu0>;
> 
> Why not place these nodes as children of &rcu0 ? This property would be
> superfluous then.

They are children. So it should be removed and made clear that these are 
child nodes of rcu (here and in other patches in this series).

Rob
