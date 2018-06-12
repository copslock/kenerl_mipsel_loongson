Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jun 2018 00:40:09 +0200 (CEST)
Received: from mail-yb0-f193.google.com ([209.85.213.193]:41560 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994658AbeFLWkAiBWwP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jun 2018 00:40:00 +0200
Received: by mail-yb0-f193.google.com with SMTP id u11-v6so217436ybi.8
        for <linux-mips@linux-mips.org>; Tue, 12 Jun 2018 15:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9VxIY8A1QgTl9wG8rWxmmjfVioRKwSc3V0fBAbeN1L4=;
        b=jqilrhSlJcmIuOQEVD/gZXXVtYa7utkMmPKQRitAJDYakyLYOShgqjNEerUjzTnz8X
         WiLPlADo3PPjT98YQpa5vDgryomo4tXzEVJBZ+DVNFXKSTQs0MNYsG8mIn4C99zo2FJy
         V031XQcXxVFnIXeF+4SNYhmk6SqkUbznP7/hSI1M4zS/TCsVvC/IVge76K1neQa35dK5
         fw3AvvJNDde/m9U6hLOVxGk/ME8maQV7xCqKAyGDDB9bzOiU294ansz4khc/8cJehL5i
         R7sznl2EGkuXPbgxbom8nSya5JjK59tEbqUtr1y9uHSLKXw5FggBnjIxMm8N9ihL2LcS
         8kEQ==
X-Gm-Message-State: APt69E3rD702G0suksBM+67UvT9S48GTY0rPDBIeK2DGKwm8QB/ld23p
        Oeu1CZ8a+9btdNY1OxaLZQ==
X-Google-Smtp-Source: ADUXVKJ2mjvZ2ESBoC4mnqRXKKg8conwXymjqZZZSF96yMP1h6iEdQm8oyJMt8QZpctwkPn8XuuXlA==
X-Received: by 2002:a25:7910:: with SMTP id u16-v6mr1138500ybc.209.1528843194920;
        Tue, 12 Jun 2018 15:39:54 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id u17-v6sm542970ywu.16.2018.06.12.15.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 15:39:54 -0700 (PDT)
Date:   Tue, 12 Jun 2018 16:39:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@intel.com, linux-mips@linux-mips.org,
        qi-ming.wu@intel.com, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 7/7] tty: serial: lantiq: Add CCF support
Message-ID: <20180612223953.GA21621@rob-hp-laptop>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
 <20180612054034.4969-8-songjun.wu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612054034.4969-8-songjun.wu@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64251
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

On Tue, Jun 12, 2018 at 01:40:34PM +0800, Songjun Wu wrote:
> Previous implementation uses platform-dependent API to get the clock.
> Those functions are not available for other SoC which uses the same IP.
> The CCF (Common Clock Framework) have an abstraction based APIs
> for clock.
> Change to use CCF APIs to get clock and rate.
> So that different SoCs can use the same driver.
> Clocks and clock-names are updated in device tree binding.
> 
> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> 
> ---
> 
>  .../devicetree/bindings/serial/lantiq_asc.txt      |  15 +++

Please split bindings to separate patch.

>  drivers/tty/serial/Kconfig                         |   2 +-
>  drivers/tty/serial/lantiq.c                        | 101 +++++++++++++++++----
>  3 files changed, 98 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/lantiq_asc.txt b/Documentation/devicetree/bindings/serial/lantiq_asc.txt
> index 3acbd309ab9d..608f0c87a4af 100644
> --- a/Documentation/devicetree/bindings/serial/lantiq_asc.txt
> +++ b/Documentation/devicetree/bindings/serial/lantiq_asc.txt
> @@ -6,6 +6,10 @@ Required properties:
>  - interrupts: the 3 (tx rx err) interrupt numbers. The interrupt specifier
>    depends on the interrupt-parent interrupt controller.
>  
> +Optional properties:
> +- clocks: Should contain frequency clock and gate clock
> +- clock-names: Should be "freq" and "asc"
> +
>  Example:
>  
>  asc1: serial@e100c00 {
> @@ -14,3 +18,14 @@ asc1: serial@e100c00 {
>  	interrupt-parent = <&icu0>;
>  	interrupts = <112 113 114>;
>  };
> +
> +asc0: serial@600000 {
> +	compatible = "lantiq,asc";
> +	reg = <0x600000 0x100000>;

1MB of address space? That wastes a lot of virtual space on 32-bit 
systems. Just make the size the actual used range.

> +	interrupt-parent = <&gic>;
> +	interrupts = <GIC_SHARED 103 IRQ_TYPE_LEVEL_HIGH>,
> +	<GIC_SHARED 105 IRQ_TYPE_LEVEL_HIGH>,
> +	<GIC_SHARED 106 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks = <&pll0aclk SSX4_CLK>, <&clkgate1 GATE_URT_CLK>;
> +	clock-names = "freq", "asc";
> +};
