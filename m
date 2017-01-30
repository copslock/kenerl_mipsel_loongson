Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jan 2017 21:33:28 +0100 (CET)
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36863 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993877AbdA3UdUj4Y1y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Jan 2017 21:33:20 +0100
Received: by mail-ot0-f194.google.com with SMTP id 36so39624556otx.3;
        Mon, 30 Jan 2017 12:33:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cLOU9HaeSs7o6SRj25vv4dIYKmEEFMYOa/+f48gr7xs=;
        b=Q1/6CkdBVnFx57D+WtsYRSeCcND/p8zkdt0kWlpLknrWWyLzxOEu2A1Zq6l6xU4yh0
         PYi4enxLQ3cjix+kzzizDzRBRzwROdkexzxW5ae0NMWuF/721PozbCRv38ny40r4MpWl
         Feht74IILSkogl7lCal/K0M1eqMsSFddPGYc5RlkJxif2GXk9uNGk8jOA7K200nyqipz
         a54TNT/nYsOVws2Q8sWndvTz7LrfpTsr2VqMkoKUwG08HKoA0x/58qSnDkVgg8CH491A
         8SAx17eC6chhhgpike8TYiyVu8/60zUZecsPBJc1shJEw4dxUettLdHYGgUPgcFWI3/p
         hY8A==
X-Gm-Message-State: AIkVDXK2uiyyRFzoKX846UoNDN/FWOeGZVaskwM5/l8xLE0ZtPnJPKN7HL0Cuic3QLhlIw==
X-Received: by 10.157.6.46 with SMTP id 43mr10646166otn.143.1485808393901;
        Mon, 30 Jan 2017 12:33:13 -0800 (PST)
Received: from localhost (72-48-98-129.dyn.grandenetworks.net. [72.48.98.129])
        by smtp.gmail.com with ESMTPSA id t8sm7811717oib.23.2017.01.30.12.33.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jan 2017 12:33:13 -0800 (PST)
Date:   Mon, 30 Jan 2017 14:33:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        james.hogan@imgtec.com
Subject: Re: [PATCH v3 02/14] Documentation: dt/bindings: Document
 pinctrl-gpio
Message-ID: <20170130203312.xsvu6rk2sz66m43a@rob-hp-laptop>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net>
 <20170125185207.23902-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170125185207.23902-3-paul@crapouillou.net>
User-Agent: Mutt/1.6.2-neo (2016-08-21)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56540
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

On Wed, Jan 25, 2017 at 07:51:55PM +0100, Paul Cercueil wrote:
> This commit adds documentation for the devicetree bidings of the

s/biding/bindings/

> pinctrl-gpio driver, which handles GPIOs of the Ingenic SoCs
> currently supported by the Linux kernel.

The subject makes no reference that this binding is for Ingenic GPIO. 
Also, drop the "Documentation: " part. It's redundant.

> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../devicetree/bindings/gpio/ingenic,gpio.txt      | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
> 
> v2: New patch
> v3: No changes
> 
> diff --git a/Documentation/devicetree/bindings/gpio/ingenic,gpio.txt b/Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
> new file mode 100644
> index 000000000000..b2eb20494365
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
> @@ -0,0 +1,45 @@
> +Ingenic jz47xx GPIO controller
> +
> +Required properties:
> +  - compatible:
> +    - "ingenic,jz4740-gpio" for the JZ4740 SoC
> +    - "ingenic,jz4780-gpio" for the JZ4780 SoC
> +
> +  - reg: Base address and length of each memory resource used by the GPIO
> +    controller hardware module.
> +
> +  - gpio-controller: Marks the device node as a GPIO controller.
> +  - #gpio-cells: Should be 2. The first cell is the GPIO number and the second
> +    cell specifies GPIO flags, as defined in <dt-bindings/gpio/gpio.h>. Only the
> +    GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW flags are supported.
> +  - gpio-ranges: Range of pins managed by the GPIO controller.
> +
> +Optional properties:
> +  - base: The GPIO number to use as the base for this driver.

Drop this please. This is a Linuxism.

> +  - interrupt-controller: Marks the device node as an interrupt controller.
> +  - interrupts: Interrupt specifier for the controllers interrupt.
> +    Required if 'interrupt-controller' is specified.

Some h/w doesn't have interrupt capability? If not, this should not be 
optional.

> +
> +Please refer to gpio.txt in this directory for details of gpio-ranges property
> +and the common GPIO bindings used by client devices.
> +
> +The GPIO controller also acts as an interrupt controller. It uses the default
> +two cells specifier as described in Documentation/devicetree/bindings/
> +interrupt-controller/interrupts.txt.

Just document #interrupt-cells and its value and drop this paragraph.

> +
> +Example:
> +
> +gpa: gpio-controller@10010000 {
> +	compatible = "ingenic,jz4740-gpio";
> +	reg = <0x10010000 0x100>;
> +
> +	gpio-controller;
> +	gpio-ranges = <&pinctrl 0 0 32>;
> +	#gpio-cells = <2>;
> +
> +	interrupt-controller;
> +	#interrupt-cells = <2>;
> +
> +	interrupt-parent = <&intc>;
> +	interrupts = <28>;
> +};
> -- 
> 2.11.0
> 
