Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Apr 2017 16:49:03 +0200 (CEST)
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34060 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991867AbdDTOszw6vbC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Apr 2017 16:48:55 +0200
Received: by mail-oi0-f68.google.com with SMTP id y11so8185803oie.1;
        Thu, 20 Apr 2017 07:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UCm2x/76CuUiNmxpJlmFra6YxDkd/FhXWV05k3xqlKE=;
        b=O8ebThWIP48/o2Fh6o31R5xNt7Wy9Upw3fzb7fBE6aS5OfgivP8+X1oNdRerP3/1dn
         KQPyMuJ9zhrF1LRkZCDBuw3zcsQkBEPyOpCLohe1fhPHUpVu3uiVTlduVr5uanTyRoXu
         C9FhWSfG6QHWdO5Vo8xP6OuqPiJmFq/cL4ZubpXaPb6ntHq/wU5EDspi/iyD0KiG+yWg
         /XNLYNsKo1LDzJP6YSiq4Po9g6NcrxbptlXnF4rwh8U5hbm18VJZZnHE0G0mhon8LpdW
         qSeTmAUxDZM/Fmuv4paDuIqtbJq9VzagyXH2gNMm6O8GrIqjAly/gH8/aHaVnwj4yRfm
         8OJw==
X-Gm-Message-State: AN3rC/5V4jOp5ybA9LBnXc7x8d7XkiLHQ4kerNaaR3y8wEJxi4Gr5wPA
        eJaZkn1w7Sy/CQ==
X-Received: by 10.157.13.23 with SMTP id 23mr4413314oti.204.1492699729995;
        Thu, 20 Apr 2017 07:48:49 -0700 (PDT)
Received: from localhost (66-90-148-125.dyn.grandenetworks.net. [66.90.148.125])
        by smtp.gmail.com with ESMTPSA id x67sm1336479ota.6.2017.04.20.07.48.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Apr 2017 07:48:49 -0700 (PDT)
Date:   Thu, 20 Apr 2017 09:48:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com
Subject: Re: [PATCH 06/13] MIPS: lantiq: Convert the xbar driver to a
 platform_driver
Message-ID: <20170420144848.hwvtrhnwxcsxyv7x@rob-hp-laptop>
References: <20170417192942.32219-1-hauke@hauke-m.de>
 <20170417192942.32219-7-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170417192942.32219-7-hauke@hauke-m.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57745
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

On Mon, Apr 17, 2017 at 09:29:35PM +0200, Hauke Mehrtens wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> This allows using the xbar driver on ARX300 based SoCs which require the
> same xbar setup as the xRX200 chipsets because the xbar driver
> initialization is not guarded by an xRX200 specific
> of_machine_is_compatible condition anymore. Additionally the new driver
> takes a syscon phandle to configure the XBAR endianness bits in RCU
> (before this was done in arch/mips/lantiq/xway/reset.c and also
> guarded by an xRX200 specific if-statement).
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  .../devicetree/bindings/mips/lantiq/xbar.txt       |  22 +++++
>  MAINTAINERS                                        |   1 +
>  arch/mips/lantiq/xway/reset.c                      |   4 -
>  arch/mips/lantiq/xway/sysctrl.c                    |  41 ---------
>  drivers/soc/Makefile                               |   1 +
>  drivers/soc/lantiq/Makefile                        |   1 +
>  drivers/soc/lantiq/xbar.c                          | 100 +++++++++++++++++++++
>  7 files changed, 125 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/xbar.txt
>  create mode 100644 drivers/soc/lantiq/Makefile
>  create mode 100644 drivers/soc/lantiq/xbar.c
> 
> diff --git a/Documentation/devicetree/bindings/mips/lantiq/xbar.txt b/Documentation/devicetree/bindings/mips/lantiq/xbar.txt
> new file mode 100644
> index 000000000000..86e53ff3b0d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/lantiq/xbar.txt
> @@ -0,0 +1,22 @@
> +Lantiq XWAY SoC XBAR binding
> +============================
> +
> +
> +-------------------------------------------------------------------------------
> +Required properties:
> +- compatible	: Should be "lantiq,xbar-xway"

This compatible is already in use so it is fine, but you should also 
have per SoC compatible strings.

> +- reg		: The address and length of the XBAR registers
> +
> +Optional properties:
> +- lantiq,rcu-syscon	: A phandle and offset to the endianness configuration
> +			  registers in the RCU module
> +
> +
> +-------------------------------------------------------------------------------
> +Example for the XBAR on the xRX200 SoCs:
> +	xbar0: xbar@400000 {
> +		compatible = "lantiq,xbar-xway";
> +		reg = <0x400000 0x1000>;
> +		big-endian;
> +		lantiq,rcu-syscon = <&rcu0 0x4c>;
> +	};
