Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2017 16:16:39 +0200 (CEST)
Received: from mail-yb0-f194.google.com ([209.85.213.194]:36088 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993941AbdGGOQd2QPGC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Jul 2017 16:16:33 +0200
Received: by mail-yb0-f194.google.com with SMTP id o195so1452197yba.3;
        Fri, 07 Jul 2017 07:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2MTHbwAIrOEBfc/H3CCv+hbuek2NWoLO0pDUUqwllWE=;
        b=lOHQuxZrc15LYKqNQowgfYr/wzVgZpPWcBJ1zDPdy9ICmRomveGe1HMRidvsxA2sEh
         QoeM/P4S+VeNRmtiSnYpYJ95ErBuZvkv8/iCgXr82ZnF/WBBJeWJuz4TO6kDuL8Xqpo1
         cphxUXnhE5JNeW8oARxUamUGuzgPG6C/tkcAluuaIx9TeH5TySFDPxaQUq4UT/DAHWJN
         WyA4jKdD/fFYKdvDKRIFMgD93MH6AMr+7O3YybvGheZ2npfmD0VmnIxOCZnpXs5em5Rd
         dlFbnPU8+7FRhEdxjBn11oC97q30Y8E3QkjScn8iNlCL7+8kd1THOis4fhybXIJZcZqr
         9tFw==
X-Gm-Message-State: AIVw113PzWGTlqtM0U+4Ca7ox/5Ramo2oCXSUeHVcJWKWnZIGukc6CS2
        MhPATO5lyX/DI3iXnM8=
X-Received: by 10.37.176.168 with SMTP id f40mr4615907ybj.246.1499436987709;
        Fri, 07 Jul 2017 07:16:27 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id 202sm1390343ywr.2.2017.07.07.07.16.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jul 2017 07:16:27 -0700 (PDT)
Date:   Fri, 7 Jul 2017 09:16:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de
Subject: Re: [PATCH v7 10/16] reset: Add a reset controller driver for the
 Lantiq XWAY based SoCs
Message-ID: <20170707141626.56rz55grulhd3twp@rob-hp-laptop>
References: <20170702224051.15109-1-hauke@hauke-m.de>
 <20170702224051.15109-11-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170702224051.15109-11-hauke@hauke-m.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59049
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

On Mon, Jul 03, 2017 at 12:40:45AM +0200, Hauke Mehrtens wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> The reset controllers (on xRX200 and newer SoCs have two of them) are
> provided by the RCU module. This was initially implemented as a simple
> reset controller. However, the RCU module provides more functionality
> (ethernet GPHYs, USB PHY, etc.), which makes it a MFD device.
> The old reset controller driver implementation from
> arch/mips/lantiq/xway/reset.c did not honor this fact.
> 
> For some devices the request and the status bits are different.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  .../devicetree/bindings/reset/lantiq,reset.txt     |  29 +++
>  drivers/reset/Kconfig                              |   6 +
>  drivers/reset/Makefile                             |   1 +
>  drivers/reset/reset-lantiq.c                       | 210 +++++++++++++++++++++
>  4 files changed, 246 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/lantiq,reset.txt
>  create mode 100644 drivers/reset/reset-lantiq.c
> 
> diff --git a/Documentation/devicetree/bindings/reset/lantiq,reset.txt b/Documentation/devicetree/bindings/reset/lantiq,reset.txt
> new file mode 100644
> index 000000000000..7737ed75f4c1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/lantiq,reset.txt
> @@ -0,0 +1,29 @@
> +Lantiq XWAY SoC RCU reset controller binding
> +============================================
> +
> +This binding describes a reset-controller found on the RCU module on Lantiq
> +XWAY SoCs.
> +
> +This driver has to be a sub node of the Lantiq RCU block.
> +
> +-------------------------------------------------------------------------------
> +Required properties:
> +- compatible		: Should be one of
> +				"lantiq,danube-reset"
> +				"lantiq,xrx200-reset"
> +- offset-set		: Offset of the reset set register
> +- offset-status		: Offset of the reset status register

With reg added (missing here) as shown in the RCU example you can remove 
these 2.

> +- #reset-cells		: Specifies the number of cells needed to encode the
> +			  reset line, should be 2.
> +			  The first cell takes the reset set bit and the
> +			  second cell takes the status bit.
> +
> +-------------------------------------------------------------------------------
> +Example for the reset-controllers on the xRX200 SoCs:
> +	reset0: reset-controller@0 {
> +		compatible = "lantiq,xrx200-reset";
> +
> +		offset-set = <0x10>;
> +		offset-status = <0x14>;
> +		#reset-cells = <2>;
> +	};
