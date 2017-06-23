Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jun 2017 00:05:22 +0200 (CEST)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33186 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993853AbdFWWFPdlHm- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Jun 2017 00:05:15 +0200
Received: by mail-pf0-f193.google.com with SMTP id w12so9168642pfk.0;
        Fri, 23 Jun 2017 15:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mqg76eOTqrfBzpEAkMAUFHroRak3f8mLLNrK/wcIiH0=;
        b=AtJLD7FurUN1lKOAcOqIZbjcU60hbDZgxuDuUrogzV1IYFjmsRBb25jdT+b/eg5UsJ
         nhJLVb8Ug6lAIRym97EUgN2cILvQ1q6N5TY8SeDYzD/xLDCqw1nZVJxFQpplusUXG7Bk
         oIBM1i9uLHaaeobNbRggMvOFbJPn3rfZBDbdD38kwQebdem42gqWz/+F+/r2QAbex97K
         2532ZRHp2umzIUV1NUd5xINUANX3yl/FeKfI3hLBEEhAZ/z90qmFumKUdj4a8EP6dTqo
         gffh6GlMUliClF992ZpvKjqjQ3oK2zFKt+n0BEBVlY2vNgRQdRC218BxfvmFwiAwbLP1
         xKxQ==
X-Gm-Message-State: AKS2vOxaa3lWmYpR33mVIed/70U7n6iZ+1dPx2zFJUmAGSvxwZHtm18i
        l0xZeoiBc6g7Og==
X-Received: by 10.99.161.25 with SMTP id b25mr10163918pgf.26.1498255509677;
        Fri, 23 Jun 2017 15:05:09 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id z4sm10956536pfg.91.2017.06.23.15.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Jun 2017 15:05:09 -0700 (PDT)
Date:   Fri, 23 Jun 2017 17:05:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de
Subject: Re: [PATCH v5 05/16] watchdog: lantiq: add device tree binding
 documentation
Message-ID: <20170623220508.2kgxfadjeee76eqt@rob-hp-laptop>
References: <20170620223743.13735-1-hauke@hauke-m.de>
 <20170620223743.13735-6-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170620223743.13735-6-hauke@hauke-m.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58774
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

On Wed, Jun 21, 2017 at 12:37:32AM +0200, Hauke Mehrtens wrote:
> The binding was not documented before, add the documentation now.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  .../devicetree/bindings/watchdog/lantiq-wdt.txt    | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt b/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
> new file mode 100644
> index 000000000000..1d41142ca55f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
> @@ -0,0 +1,22 @@
> +Lantiq WTD watchdog binding
> +============================
> +
> +This describes the binding of the Lantiq watchdog driver.
> +
> +-------------------------------------------------------------------------------
> +Required properties:
> +- compatible		: Should be one of
> +				"lantiq,wdt"
> +				"lantiq,xrx100-wdt"
> +				"lantiq,falcon-wdt"
> +- regmap		: A phandle to the RCU syscon (required for
> +			  "lantiq,falcon-wdt" and "lantiq,xrx100-wdt")

regmap is a Linuxism. I'd suggest "lantiq,rcu" instead.

> +
> +-------------------------------------------------------------------------------
> +Example for the watchdog on the xRX200 SoCs:
> +		watchdog@803f0 {
> +			compatible = "lantiq,xrx100-wdt";

Why did you remove the xrx200 compatible? You should add it to the 
compatible list (with the fallback).

> +			reg = <0x803f0 0x10>;
> +
> +			regmap = <&rcu0>;
> +		};
> -- 
> 2.11.0
> 
