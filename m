Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2017 22:00:38 +0200 (CEST)
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34951 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993179AbdEaUA31DoC3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2017 22:00:29 +0200
Received: by mail-oi0-f67.google.com with SMTP id j66so737543oib.2;
        Wed, 31 May 2017 13:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yd3yvM3MeilGn6tZV5WJoZFW/utwCnCs4QMqtR6sETU=;
        b=MGR1N28jZ5bPZpMaplZUVm31UKrlwJ6lwmfdPcLMafMzCdng5nnilUnXGRg9qFgslo
         L/uWqFw/HPZQJXiHtJ/JGCap8lU02c1jZW+X7t7Fj8fMg6a4y0Epi9VfD8v9ZKEAFl/n
         tqGcYc21kL7f7Golq7Dvx7Oqf7vuUwK3NW8LBtJ+Zd04tiEIT07ZILH0NY49M6WAW3CT
         Pk10ArD5/Vv/0Py6QcmnaGa/itnKMip1IeZd8EZAnEZIsrtnmZQBaKVLdcSLDnZdxZ/m
         d3xvs0+rbJjYCVnwWNlICktIsphI3UDg+rkdUtE1iTNobwiAU8Mt3FeK4Vjq4z4ADHQx
         pnFQ==
X-Gm-Message-State: AODbwcA+ouA13y+7et+HJO0euXIGSSgSRxswU9UK48RVjMU7Oeyk0Kfg
        IHllqy7HcDdBQg==
X-Received: by 10.202.117.23 with SMTP id q23mr13863196oic.163.1496260823538;
        Wed, 31 May 2017 13:00:23 -0700 (PDT)
Received: from localhost (66-90-148-125.dyn.grandenetworks.net. [66.90.148.125])
        by smtp.gmail.com with ESMTPSA id 42sm7755334otj.30.2017.05.31.13.00.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 May 2017 13:00:22 -0700 (PDT)
Date:   Wed, 31 May 2017 15:00:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de
Subject: Re: [PATCH v3 05/16] watchdog: lantiq: add device tree binding
 documentation
Message-ID: <20170531200021.ld54cecme4ekak4i@rob-hp-laptop>
References: <20170528184006.31668-1-hauke@hauke-m.de>
 <20170528184006.31668-6-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170528184006.31668-6-hauke@hauke-m.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58105
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

On Sun, May 28, 2017 at 08:39:55PM +0200, Hauke Mehrtens wrote:
> The binding was not documented before, add the documentation now.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  .../devicetree/bindings/watchdog/lantiq-wdt.txt    | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt b/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
> new file mode 100644
> index 000000000000..675c30e23b65
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
> @@ -0,0 +1,28 @@
> +Lantiq WTD watchdog binding
> +============================
> +
> +This describes the binding of the Lantiq watchdog driver.
> +
> +-------------------------------------------------------------------------------
> +Required properties:
> +- compatible		: Should be one of
> +				"lantiq,wdt"
> +				"lantiq,wdt-xrx100"
> +				"lantiq,wdt-falcon"
> +
> +Optional properties:
> +- regmap		: A phandle to the RCU syscon
> +- offset-status		: Offset of the reset cause register
> +- mask-status		: Mask of the reset cause register value

These 2 should be implied by the compatible. But if already used in 
upstream dts files, then it's okay.

> +
> +
> +-------------------------------------------------------------------------------
> +Example for the watchdog on the xRX200 SoCs:
> +		watchdog@803F0 {

Lowercase hex please.

> +			compatible = "lantiq,wdt-xrx200", "lantiq,wdt-xrx100";

Doesn't match the documentation.

> +			reg = <0x803F0 0x10>;

Lowercase hex please.

> +
> +			regmap = <&rcu0>;
> +			offset-status = <0x14>;
> +			mask-status = <0x80000000>;
> +		};
> -- 
> 2.11.0
> 
