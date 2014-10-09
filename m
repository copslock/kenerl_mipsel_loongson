Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 22:30:26 +0200 (CEST)
Received: from mail-lb0-f173.google.com ([209.85.217.173]:55879 "EHLO
        mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010999AbaJIUaYI6Iic (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 22:30:24 +0200
Received: by mail-lb0-f173.google.com with SMTP id 10so1881482lbg.18
        for <linux-mips@linux-mips.org>; Thu, 09 Oct 2014 13:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=tpRBIoEERGamrfOlb7uXMY7mGUAAp1dkVOZg1Yimre4=;
        b=FoGm0g5Pt6A4V4sgXSUZp2I0BTP07ObwEIfeGrJ3eCuvz/tNdhAv+btPzaNxWOWJ2A
         3mwVUUrnAXmDNfeEgGmopWm2psGEQQ8MEjfw4YWClDmwrhRkglCHOgpjcYeHQXFcOvgR
         63pGYoQTZ6eAezIbbtOkGQE1h55xS76/qeBiG5Gx/pphCmIuepw5mb+CFKqFmGEbCe6Z
         t2FJfUdNVDI2AtgclzXW4NIOoIuKumEyTgJi9QEJ82oGgyfmNXAgNWX3BbmJDiAbxseN
         +ukmPIwRPLZp7gRyl4TJ2o7bRixsWRKrkBG5Viod6n8GDh/beCFr5y6HbQrrdebWSHCu
         DFWw==
X-Gm-Message-State: ALoCoQm/z6T6KLW07SvQlyKNu3yif95BbQMiFPTS8nNQk4355NrlEj+WjxVtNXjIuqrqS2dPmJMs
X-Received: by 10.152.20.98 with SMTP id m2mr21106706lae.51.1412886618556;
        Thu, 09 Oct 2014 13:30:18 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp17-169.pppoe.mtu-net.ru. [81.195.17.169])
        by mx.google.com with ESMTPSA id h9sm1230310lae.44.2014.10.09.13.30.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Oct 2014 13:30:17 -0700 (PDT)
Message-ID: <5436F058.6010406@cogentembedded.com>
Date:   Fri, 10 Oct 2014 00:30:16 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     linux-mips@linux-mips.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 1/2] DT: Add documentation for gpio-rt2880
References: <1412885241-12476-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1412885241-12476-1-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 10/10/2014 12:07 AM, John Crispin wrote:

> Describe gpio-rt2880 binding.

> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: linux-mips@linux-mips.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> ---
>   .../devicetree/bindings/gpio/gpio-rt2880.txt       |   40 ++++++++++++++++++++
>   1 file changed, 40 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/gpio/gpio-rt2880.txt

> diff --git a/Documentation/devicetree/bindings/gpio/gpio-rt2880.txt b/Documentation/devicetree/bindings/gpio/gpio-rt2880.txt
> new file mode 100644
> index 0000000..b4acf02
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-rt2880.txt
> @@ -0,0 +1,40 @@
> +Ralink SoC GPIO controller bindings
> +
> +Required properties:
> +- compatible:
> +  - "ralink,rt2880-gpio" for Ralink controllers
> +- #gpio-cells : Should be two.
> +  - first cell is the pin number
> +  - second cell is used to specify optional parameters (unused)
> +- gpio-controller : Marks the device node as a GPIO controller
> +- reg : Physical base address and length of the controller's registers
> +- interrupt-parent: phandle to the INTC device node

    It's not a required property, it can be inherited from the nodes above.

> +- interrupts : Specify the INTC interrupt number
> +- ralink,num-gpios : Specify the number of GPIOs
> +- ralink,register-map : The register layout depends on the GPIO bank and actual
> +		SoC type. Register offsets need to be in this order.
> +		[ INT, EDGE, RENA, FENA, DATA, DIR, POL, SET, RESET, TOGGLE ]

    This should be determined by the "compatible" property alone, I think.

> +
> +Optional properties:
> +- ralink,gpio-base : Specify the GPIO chips base number

WBR, Sergei
