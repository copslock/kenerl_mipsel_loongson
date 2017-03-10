Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Mar 2017 11:21:29 +0100 (CET)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:36799
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992123AbdCJKVVmCveY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Mar 2017 11:21:21 +0100
Received: by mail-wm0-x244.google.com with SMTP id v190so1507418wme.3;
        Fri, 10 Mar 2017 02:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jdjyM0RJ9nY8Oqv4ox3joICEs8lDUJlt9M4M6A7lN4Q=;
        b=G08YlZiqRDFeONMsWKSHHhYF8Czp/oidw+Spt/4bYpWK84QjAo8SEWMkYMQMEDcZSA
         r6cwK5GvZRXWvJe8bstbTYqN0PuiBwo8AMO2mQRfw5XrEMk3TFX0Iyy19oDjIDXlGpW8
         CAIIk8F2XBDi6465QaYEpakkibXbirxNK5RfowPDkh+u3zFSMxFGG38o/+fLrlJAftcN
         900mYZUA77qhknT9pNb/i9LacB/0dhmIGLaUViw075G9pulfD85uNgWLkRYhDOVe4KMD
         MqxNbfLler3SHfiwJnSshlIWrQCzXCToL+afrjgoPaL32zL3mcMSpX6BsqAbKBAXnxO8
         FRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=jdjyM0RJ9nY8Oqv4ox3joICEs8lDUJlt9M4M6A7lN4Q=;
        b=ShGIMr7Ft51R84u/su9Kb2Au+DnB31PW9+3GhdRw11C89lBQwegw8W61ofUofeZ/+8
         ufK8WEUqmHYg+qzjXBsaTO6bKmUccgEl8Kiqh+r9PV5CjRmR1kJBwD5vXIXyL0zMvlEf
         LaUc2OsuGU+tzbBQIT21pNFSraWs1N2LJln2rXnvMdwKXD0+6vfEa0zk1JuKndrYX8vH
         cFmvBShPMqEuRvaimuQ9263O5/1+5gaiy6n7rhqpD7jeRF1nEYpv/WsrIWpfof4n3lKV
         kjCCxsQ+boBZZBfZu/2fWMw1OwAOCI8PFkRiCVitwvIvPHp9prlbcQGxlqowKL2xG8eq
         DRig==
X-Gm-Message-State: AFeK/H2ooxZ7Cpee/dCr1/XJ7Jjvqf9dRTTXQxu2X9Vs4bhlP6zouZTU6/q/oehwoKmrpg==
X-Received: by 10.28.96.130 with SMTP id u124mr1827569wmb.81.1489141276291;
        Fri, 10 Mar 2017 02:21:16 -0800 (PST)
Received: from debian64.daheim (p200300D5FBC0C7FCD63D7EFFFEBDE96E.dip0.t-ipconnect.de. [2003:d5:fbc0:c7fc:d63d:7eff:febd:e96e])
        by smtp.gmail.com with ESMTPSA id m29sm12190747wrm.38.2017.03.10.02.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Mar 2017 02:21:15 -0800 (PST)
Received: from localhost.daheim ([127.0.0.1] helo=debian64.localnet)
        by debian64.daheim with esmtp (Exim 4.89_RC7)
        (envelope-from <chunkeey@googlemail.com>)
        id 1cmHfe-00021Y-JB; Fri, 10 Mar 2017 11:21:14 +0100
From:   Christian Lamparter <chunkeey@googlemail.com>
To:     Nathan Sullivan <nathan.sullivan@ni.com>
Cc:     linus.walleij@linaro.org, gnurou@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        ralf@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] gpio: mmio: add support for NI 169445 NAND GPIO
Date:   Fri, 10 Mar 2017 11:21:14 +0100
Message-ID: <4019620.oLiLCkQLlD@debian64>
User-Agent: KMail/5.2.3 (Linux/4.11.0-rc1-wt-only+; KDE/5.28.0; x86_64; ; )
In-Reply-To: <1489001744-26545-2-git-send-email-nathan.sullivan@ni.com>
References: <1489001744-26545-1-git-send-email-nathan.sullivan@ni.com> <1489001744-26545-2-git-send-email-nathan.sullivan@ni.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Return-Path: <chunkeey@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chunkeey@googlemail.com
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

On Wednesday, March 8, 2017 1:35:43 PM CET Nathan Sullivan wrote:
> The GPIO-based NAND controller on National Instruments 169445 hardware
> exposes a set of simple lines for the control signals.
> 
> Signed-off-by: Nathan Sullivan <nathan.sullivan@ni.com>
> ---
>  .../bindings/gpio/ni,169445-nand-gpio.txt          | 36 ++++++++++++++++++++++
>  drivers/gpio/gpio-mmio.c                           |  1 +
>  2 files changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/ni,169445-nand-gpio.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/ni,169445-nand-gpio.txt b/Documentation/devicetree/bindings/gpio/ni,169445-nand-gpio.txt
> new file mode 100644
> index 0000000..ca2c14f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/ni,169445-nand-gpio.txt
> @@ -0,0 +1,36 @@
> +Bindings for the National Instruments 169445 GPIO NAND controller
> +
> +The 169445 GPIO NAND controller has two memory mapped GPIO registers, one
> +for input (the ready signal) and one for output (control signals).  It is
> +intended to be used with the GPIO NAND driver.
> +
> +Required properties:
> +	- compatible: should be "ni,169445-nand-gpio"
> +	- reg-names: must contain
> +		"dat" - data register
> +	- reg: address + size pairs describing the GPIO register sets;
> +		order must correspond with the order of entries in reg-names
> +	- #gpio-cells: must be set to 2. The first cell is the pin number and
> +			the second cell is used to specify the gpio polarity:
> +			0 = active high
> +			1 = active low
> +	- gpio-controller: Marks the device node as a gpio controller.
> +
> +Examples:
> +	gpio1: nand-gpio-out@1f300010 {
> +		compatible = "ni,169445-nand-gpio";
> +		reg = <0x1f300010 0x4>;
> +		reg-names = "dat";
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		ngpios = <5>;
ngpios? Where is this parameter parsed? Is there a description for it
in the Documentation?

> +	};
> +
> +	gpio2: nand-gpio-in@1f300014 {
^^ I assume this GPIO only has input? Is this right?
If so you can specify the following dt property:

	no-output;

So, all gpios can only be inputs.

> +		compatible = "ni,169445-nand-gpio";
> +		reg = <0x1f300014 0x4>;
> +		reg-names = "dat";
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		ngpios = <1>;
Same as above.

I think you should could either add a parser for the ngpios property.
by adding of_property_read_u16(&pdev->dev, "ngpios", &gc->ngpio);
in the right place. or remove the property.

> +	};
> diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
> index d7d03ad..f7da40e 100644
> --- a/drivers/gpio/gpio-mmio.c
> +++ b/drivers/gpio/gpio-mmio.c
> @@ -575,6 +575,7 @@ static void __iomem *bgpio_map(struct platform_device *pdev,
>  static const struct of_device_id bgpio_of_match[] = {
>  	{ .compatible = "brcm,bcm6345-gpio" },
>  	{ .compatible = "wd,mbl-gpio" },
> +	{ .compatible = "ni,169445-nand-gpio" },
Maybe you could add this entry above the wd,mbl-gpio. 
So it's in alphabetical order. That's said, it's fine
the way it is.

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, bgpio_of_match);
> 
