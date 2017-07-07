Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2017 16:08:47 +0200 (CEST)
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34572 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993943AbdGGOIlfG7RC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Jul 2017 16:08:41 +0200
Received: by mail-yw0-f194.google.com with SMTP id a12so1809314ywh.1;
        Fri, 07 Jul 2017 07:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DySmL7pF7X4XS4Dt9wYxum38PWRJlH95n7/FoGs0uiw=;
        b=kkMbFD6q7OPf6fIkbhXXetYSk6sRfZnOiztyQtibkRsR6s/ls+KKzNxQeFStIG6xqB
         KgK2KLilytrfTavsXhbYLFIA/pgeuS3rzOicQS/SU62lHsOASzzzcxOzE+mMzX3PcnEg
         uBjb5qPdOGx8WkV73drjcwfjyy1N17bT8oFhL+kR15CG1G+RDq0rd/0rTQFcssWLh35J
         ptMQjacwGVZWdMmcXJZeTFo1nmWQax3DYlToZZPziQOnYc6NVejfpUume/7DHYRNcnYX
         qVDtO0isUtZKK0+W1DK/VcVaeVWDV4S97URK+FdO7hNk4AbeWfPK+voVLOdrG2OSUsh4
         /nIQ==
X-Gm-Message-State: AIVw112WVd2NoAgkJKmnFyGi402/1Wlu3a2hz9VNmgeGX9aNQwof9gsn
        a3gAs0kkMlsCnw==
X-Received: by 10.13.224.196 with SMTP id j187mr1871828ywe.167.1499436515793;
        Fri, 07 Jul 2017 07:08:35 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id d16sm1333173ywb.51.2017.07.07.07.08.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jul 2017 07:08:35 -0700 (PDT)
Date:   Fri, 7 Jul 2017 09:08:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de
Subject: Re: [PATCH v7 05/16] watchdog: lantiq: add device tree binding
 documentation
Message-ID: <20170707140834.nugjw5jxkyzwrmzq@rob-hp-laptop>
References: <20170702224051.15109-1-hauke@hauke-m.de>
 <20170702224051.15109-6-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170702224051.15109-6-hauke@hauke-m.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59046
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

On Mon, Jul 03, 2017 at 12:40:40AM +0200, Hauke Mehrtens wrote:
> The binding was not documented before, add the documentation now.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  .../devicetree/bindings/watchdog/lantiq-wdt.txt    | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt b/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
> new file mode 100644
> index 000000000000..c3967feebb6c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
> @@ -0,0 +1,24 @@
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
> +				"lantiq,xrx200-wdt"
> +				"lantiq,falcon-wdt"
> +- lantiq,rcu		: A phandle to the RCU syscon (required for
> +			  "lantiq,falcon-wdt", "lantiq,xrx200-wdt" and
> +			  "lantiq,xrx100-wdt")
> +
> +-------------------------------------------------------------------------------
> +Example for the watchdog on the xRX200 SoCs:
> +		watchdog@803f0 {
> +			compatible = "lantiq,xrx200-wdt", "lantiq,xrx100-wdt";

This is still mismatched. If the example is correct, then the compatible 
list should be:

"lantiq,wdt"
"lantiq,xrx100-wdt"
"lantiq,xrx200-wdt", "lantiq,xrx100-wdt"
"lantiq,falcon-wdt"

You can also remove "lantiq,xrx200-wdt" from the driver if you want as 
"lantiq,xrx100-wdt" is good enough to match on.

Rob
