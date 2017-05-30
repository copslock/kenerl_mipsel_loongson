Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2017 01:12:00 +0200 (CEST)
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35368 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993457AbdE3XLxhfFTV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2017 01:11:53 +0200
Received: by mail-oi0-f67.google.com with SMTP id v80so60679oie.2;
        Tue, 30 May 2017 16:11:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CIwtISmEp3OebHBhn76HxU2BUBf1NCQ4KoM3H4LMVJQ=;
        b=C0ZUPWMoVFEFAq+ffnCL/hq0wbXinnFfy1MDxWJGMn6FNHufQY2YXCYkZt0rYXSFfS
         P35tJLapcuYMayhGq8EPGmKhibmuUTW1BaAeJ5/csZSfe8/J5rO8OjKQPdlo7ghBKfl2
         IBMwmycfa5jGvyKyzgBz0AF0llOhW5KbCUNhkRl7Js8Pg23rqSZrpC1H+NHNU9dmSz73
         no+Prc7hyp+DVl7m6Rg94QxZw7m6VPkC+C0uZI+DtmjNrsGtZ7WwQYz7F64vUi78iX/H
         oS+cvojklhFmDqF0WelRUXYurJePkiXBOkhcTgkuBURq+xJDhm3AajAp31P8U0IoYB0Z
         vIRg==
X-Gm-Message-State: AODbwcDxjbewSe5BZWc8k5k0SjZ9fKgZxzOUdwM9O5Z4W/LeT4oy6nVh
        qDdpxIyJDVwIXw==
X-Received: by 10.202.107.80 with SMTP id g77mr11046267oic.14.1496185907735;
        Tue, 30 May 2017 16:11:47 -0700 (PDT)
Received: from localhost (66-90-148-125.dyn.grandenetworks.net. [66.90.148.125])
        by smtp.gmail.com with ESMTPSA id q206sm6491949oia.2.2017.05.30.16.11.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 May 2017 16:11:47 -0700 (PDT)
Date:   Tue, 30 May 2017 18:11:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com
Subject: Re: [PATCH v2 07/15] MIPS: lantiq: Convert the xbar driver to a
 platform_driver
Message-ID: <20170530231146.sk2zdq24a2oul6v4@rob-hp-laptop>
References: <20170521130918.27446-1-hauke@hauke-m.de>
 <20170521130918.27446-8-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170521130918.27446-8-hauke@hauke-m.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58080
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

On Sun, May 21, 2017 at 03:09:10PM +0200, Hauke Mehrtens wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> This allows using the xbar driver on ARX300 based SoCs which require the
> same xbar setup as the xRX200 chipsets because the xbar driver
> initialization is not guarded by an xRX200 specific
> of_machine_is_compatible condition anymore. Additionally the new driver
> takes a syscon phandle to configure the XBAR endianness bits in RCU
> (before this was done in arch/mips/lantiq/xway/reset.c and also
> guarded by an VRX200 specific if-statement).
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../devicetree/bindings/mips/lantiq/xbar.txt       |  24 +++++
>  MAINTAINERS                                        |   1 +
>  arch/mips/lantiq/xway/reset.c                      |   4 -
>  arch/mips/lantiq/xway/sysctrl.c                    |  41 ---------
>  drivers/soc/Makefile                               |   1 +
>  drivers/soc/lantiq/Makefile                        |   1 +
>  drivers/soc/lantiq/xbar.c                          | 101 +++++++++++++++++++++
>  7 files changed, 128 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/xbar.txt
>  create mode 100644 drivers/soc/lantiq/Makefile
>  create mode 100644 drivers/soc/lantiq/xbar.c
> 
> diff --git a/Documentation/devicetree/bindings/mips/lantiq/xbar.txt b/Documentation/devicetree/bindings/mips/lantiq/xbar.txt
> new file mode 100644
> index 000000000000..7e1ea5299744
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/lantiq/xbar.txt
> @@ -0,0 +1,24 @@
> +Lantiq XWAY SoC XBAR binding
> +============================
> +
> +
> +-------------------------------------------------------------------------------
> +Required properties:
> +- compatible	: Should be one of
> +				"lantiq,xbar-xway"
> +				"lantiq,xbar-xrx200"

The normal form is <vendor>,<soc>-<block>.

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
