Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Apr 2017 16:52:55 +0200 (CEST)
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35749 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993648AbdDDOwrfgf0p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Apr 2017 16:52:47 +0200
Received: by mail-oi0-f68.google.com with SMTP id d2so17820619oig.2;
        Tue, 04 Apr 2017 07:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bP6a8t6ZPJIY5ShwWSEpu8ArAEwwiV8hieyav8BWuz8=;
        b=NLuL4jFiqV/bdSVjpMMNhye/bhQAlcMAv/dn5C6F6d1wy52/vmc0I7PIWH9PQAGOiz
         gURXEymNaJSXFN6veo9ye40ge3uORI9AImglM1+1Eb7XXKRNkfEP9CIU1a0wmK+UPUpD
         9Vp+oO8XTLYngsmpX0A5b58dTeK0vqRIt6FQC5iWNyRXEYdRSYMzR17Q/uyfj9cFAb3U
         ud/jNkRyJtlOKjL9WaqAxwjjE46GSD4B6RCaTxMbTYN/4/4B7fGHZLTtCVql21l2WMUf
         knu95Grhr5+07OdcxPlu69vLWqQ0sa62j8j2fQ5r73MNWFu2i7ZNdEBQeXBeYO6TWU7t
         K/kw==
X-Gm-Message-State: AFeK/H1cdMFpn0iJo/tVUz+EZlOLYsn/mXFpa+Fxpzj/XrYWo8ypkx4EY3JFywx59kjEgw==
X-Received: by 10.157.80.140 with SMTP id b12mr12095758oth.81.1491317561759;
        Tue, 04 Apr 2017 07:52:41 -0700 (PDT)
Received: from localhost (66-90-148-125.dyn.grandenetworks.net. [66.90.148.125])
        by smtp.gmail.com with ESMTPSA id j128sm8413922oif.32.2017.04.04.07.52.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Apr 2017 07:52:41 -0700 (PDT)
Date:   Tue, 4 Apr 2017 09:52:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>, james.hogan@imgtec.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v4 02/14] dt/bindings: Document gpio-ingenic
Message-ID: <20170404145240.z3vx24svh4dduo2o@rob-hp-laptop>
References: <20170125185207.23902-2-paul@crapouillou.net>
 <20170402204244.14216-1-paul@crapouillou.net>
 <20170402204244.14216-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170402204244.14216-3-paul@crapouillou.net>
User-Agent: Mutt/1.6.2-neo (2016-08-21)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57560
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

On Sun, Apr 02, 2017 at 10:42:32PM +0200, Paul Cercueil wrote:
> This commit adds documentation for the devicetree bindings of the
> gpio-ingenic driver, which handles GPIOs of the Ingenic SoCs
> currently supported by the Linux kernel.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../devicetree/bindings/gpio/ingenic,gpio.txt      | 48 ++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
> 
>  v2: New patch
>  v3: No changes
>  v4: Update for the v4 version of the gpio-ingenic driver
> 
> diff --git a/Documentation/devicetree/bindings/gpio/ingenic,gpio.txt b/Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
> new file mode 100644
> index 000000000000..f54af444f7c3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
> @@ -0,0 +1,48 @@
> +Ingenic jz47xx GPIO controller
> +
> +That the Ingenic GPIO driver node must be a sub-node of the Ingenic pinctrl
> +driver node.
> +
> +Required properties:
> +--------------------
> +
> + - compatible: Must contain one of:
> +    - "ingenic,jz4740-gpio"
> +    - "ingenic,jz4770-gpio"
> +    - "ingenic,jz4780-gpio"
> +	And one of:
> +	- "ingenic,gpio-bank-a"
> +	- "ingenic,gpio-bank-b"
> +	- "ingenic,gpio-bank-c"
> +	- "ingenic,gpio-bank-d"
> +	- "ingenic,gpio-bank-e" (for SoC version > jz4740)
> +	- "ingenic,gpio-bank-f" (for SoC version > jz4740)

This is quite strange. Why do you need the bank? Doesn't gpio-ranges 
give you that info? Maybe use reg property here instead.

> + - interrupt-controller: Marks the device node as an interrupt controller.
> + - interrupts: Interrupt specifier for the controllers interrupt.
> + - #interrupt-cells: Should be 2. Refer to
> +   ../interrupt-controller/interrupts.txt for more details.
> + - gpio-controller: Marks the device node as a GPIO controller.
> + - #gpio-cells: Should be 2. The first cell is the GPIO number and the second
> +    cell specifies GPIO flags, as defined in <dt-bindings/gpio/gpio.h>. Only the
> +    GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW flags are supported.
> + - gpio-ranges: Range of pins managed by the GPIO controller. Refer to
> +   'gpio.txt' in this directory for more details.
> +
> +Example:
> +--------
> +
> +&pinctrl {
> +	gpa: gpio-controller@0 {

gpio@...

> +		compatible = "ingenic,gpio-bank-a", "ingenic,jz4740-gpio";
> +
> +		gpio-controller;
> +		gpio-ranges = <&pinctrl 0 0 32>;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +
> +		interrupt-parent = <&intc>;
> +		interrupts = <28>;
> +	};
> +};
> -- 
> 2.11.0
> 
