Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Apr 2017 16:54:19 +0200 (CEST)
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34114 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991867AbdDTOyMQfxpC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Apr 2017 16:54:12 +0200
Received: by mail-oi0-f67.google.com with SMTP id y11so8235194oie.1;
        Thu, 20 Apr 2017 07:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q6buAHxxVCeVjYqcdaOTACub2e5uIMWNLc/qt9Bc2po=;
        b=NCu9qLNvSqzu/XAn0V6mH8tdFwcS4N6D4RqAvpwqJES677n3ovGSQSnCXcYv9XDKLd
         LLLJNsMQ6hk+gukKpqUYd8XG4B0yXYwI0XjR55dscqg58Nls0KGZ75M5NHy1NQWjrv0e
         XqwbfOoNC7qjLo+eHfXHRmK511UqSoSqp/3iQxuEgqKhefokI8SWDDgJ7RMEivA7eHRC
         mpZgIs4Sl1FSnkDJLsFVwYKNpsEc3Nkx4bKmz5SSCPOD0muaLXvBpCLNDHfouhaQdXTU
         wa+J6RjFxCTPotcKVawusVUffRS79dgpiZMV8n9smYShVGoQzvPw8RaA+GX2/poa1ts/
         oOcw==
X-Gm-Message-State: AN3rC/6K6Y6ZhBiD1v+9bkcujJuFf6scx7yZwfH1fTLqDEZIebPUZt90
        SmTHxJGObUfb3A==
X-Received: by 10.157.43.40 with SMTP id o37mr2249904otb.64.1492700046588;
        Thu, 20 Apr 2017 07:54:06 -0700 (PDT)
Received: from localhost (66-90-148-125.dyn.grandenetworks.net. [66.90.148.125])
        by smtp.gmail.com with ESMTPSA id e31sm2607888ote.42.2017.04.20.07.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Apr 2017 07:54:05 -0700 (PDT)
Date:   Thu, 20 Apr 2017 09:54:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com
Subject: Re: [PATCH 08/13] reset: Add a reset controller driver for the
 Lantiq XWAY based SoCs
Message-ID: <20170420145405.7s3iapxggr5575d2@rob-hp-laptop>
References: <20170417192942.32219-1-hauke@hauke-m.de>
 <20170417192942.32219-9-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170417192942.32219-9-hauke@hauke-m.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57746
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

On Mon, Apr 17, 2017 at 09:29:37PM +0200, Hauke Mehrtens wrote:
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
> ---
>  .../devicetree/bindings/reset/lantiq,rcu-reset.txt |  43 ++++
>  arch/mips/lantiq/xway/reset.c                      |  68 ------
>  drivers/reset/Kconfig                              |   6 +
>  drivers/reset/Makefile                             |   1 +
>  drivers/reset/reset-lantiq-rcu.c                   | 231 +++++++++++++++++++++
>  5 files changed, 281 insertions(+), 68 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/reset/lantiq,rcu-reset.txt
>  create mode 100644 drivers/reset/reset-lantiq-rcu.c
> 
> diff --git a/Documentation/devicetree/bindings/reset/lantiq,rcu-reset.txt b/Documentation/devicetree/bindings/reset/lantiq,rcu-reset.txt
> new file mode 100644
> index 000000000000..7f097d16bbb7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/lantiq,rcu-reset.txt
> @@ -0,0 +1,43 @@
> +Lantiq XWAY SoC RCU reset controller binding
> +============================================
> +
> +This binding describes a reset-controller found on the RCU module on Lantiq
> +XWAY SoCs.
> +
> +
> +-------------------------------------------------------------------------------
> +Required properties (controller (parent) node):
> +- compatible		: Should be "lantiq,rcu-reset"
> +- lantiq,rcu-syscon	: A phandle to the RCU syscon, the reset register
> +			  offset and the status register offset.
> +- #reset-cells		: Specifies the number of cells needed to encode the
> +			  reset line, should be 1.
> +
> +Optional properties:
> +- reset-status		: The request status bit. For some bits the request bit
> +			  and the status bit are different. This is depending
> +			  on the SoC. If the reset-status bit does not match
> +			  the reset-request bit, put the reset number into the
> +			  reset-request property and the status bit at the same
> +			  index into the reset-status property. If no
> +			  reset-request bit is given here, the driver assume
> +			  status and request bit are the same.
> +- reset-request		: The reset request bit, to map it to the reset-status
> +			  bit.

These should either be implied by SoC specific compatible or be made 
part of the reset cells. In the latter case, you still need the SoC 
specific compatible.

> +-------------------------------------------------------------------------------
> +Example for the reset-controllers on the xRX200 SoCs:
> +	rcu_reset0: rcu_reset {
> +		compatible = "lantiq,rcu-reset";
> +		lantiq,rcu-syscon = <&rcu0 0x10 0x14>;
> +		#reset-cells = <1>;
> +		reset-request = <31>, <29>, <21>, <19>, <16>, <12>;
> +		reset-status  = <30>, <28>, <16>, <25>, <5>,  <24>;
> +	};
> +
> +	rcu_reset1: rcu_reset {
> +		compatible = "lantiq,rcu-reset";

These 2 blocks are identical? Given different registers sizes, I'd say 
not. So they should have different compatible strings.

> +		lantiq,rcu-syscon = <&rcu0 0x48 0x24>;
> +		#reset-cells = <1>;
> +	};
