Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Dec 2015 22:36:57 +0100 (CET)
Received: from mail-lb0-f173.google.com ([209.85.217.173]:33346 "EHLO
        mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013666AbbLJVgymnbsJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Dec 2015 22:36:54 +0100
Received: by lbbkw15 with SMTP id kw15so59285658lbb.0
        for <linux-mips@linux-mips.org>; Thu, 10 Dec 2015 13:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=VDjo4xE0DL6sSPPbRL6hj3A1RJdgLjO9IT6fiiAzLaM=;
        b=m8I+K/CXE3rL4ATZeOIdkoI2566vKiaISaBNvo8tRMrwiTv4n/Zo3hfJ6OE8sHNI4f
         JbQM+jtR+bu2T6OOsIjj4kIRCjEKI7+bKEoFvmxWZ5MvK0hRWmbeVq9V0JhodIcTbbEG
         +safpfcpokHFM5j/oxlFHQK4Ms7yYKpm7+MooQvk/FooAV957gv6DwxFK5iY1iKIbz7H
         mgjTVaBUS4qIIyyz4Dmboe+Um+FbjJD6VFZK8G8+wPM+uV/Ka9Sc/dUB0L796J9kkIZA
         qdCQrTi1BtY858RgiFU3V205WpStOoHPwsv6SuXWtl3KLKvC3JNw22aedts82HvlMfD9
         1xfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=VDjo4xE0DL6sSPPbRL6hj3A1RJdgLjO9IT6fiiAzLaM=;
        b=jJBhtUSJhgbYyIhTzVhP85MRZHMXP3aAhb8cL8ZC7P3FavUE/lM44tVqlggfAqax3x
         XN1+aOVpme2cHd8qItOZdCiEbjdpoaM05JMeDulRbVydOL1XCk811+vG5RvqeD+J0LNk
         qgXUkqhdE+NsocqBGQCcc3qcv16wAEZ/mwChwn0EVlkuQlAI7/VMSA72GpZrRnky0wFt
         K80e+4+cpX4IAjbjv2ETruhm7HR/O8O8piVoe+zGTII4eLGRIqp1wA1FufMr/IWiA/3n
         WSOGFL8IAbyhi1QDdAEI/+GbB2YIPmlqXI51X6MrpXJfePix8xteSS7lR3Vgvadrdhif
         WogA==
X-Gm-Message-State: ALoCoQlYaxscjAsp4lS5Tnb2G+ZfRcZzJ+5tVYTI5feMt0BeU+3elArq5Z6HIeIY83KysnPKHOdFdzZQYEYkTuo2gy+flZUs4g==
X-Received: by 10.112.171.99 with SMTP id at3mr6623806lbc.108.1449783409311;
        Thu, 10 Dec 2015 13:36:49 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.80.98])
        by smtp.gmail.com with ESMTPSA id t82sm2665661lfe.14.2015.12.10.13.36.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Dec 2015 13:36:48 -0800 (PST)
Subject: Re: [PATCH linux-next (v3) 1/2] reset: Add brcm,bcm6345-reset device
 tree binding
To:     Simon Arlott <simon@fire.lp0.eu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <5669EE86.8030406@simon.arlott.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Jonas Gorski <jogo@openwrt.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <5669F06E.3060506@cogentembedded.com>
Date:   Fri, 11 Dec 2015 00:36:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <5669EE86.8030406@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50532
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

On 12/11/2015 12:28 AM, Simon Arlott wrote:

> Add device tree binding for the BCM6345 soft reset controller.
>
> The BCM6345 contains a soft-reset controller activated by setting
> a bit (that must previously have been cleared).
>
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> ---
> v3: Resend. Example has changed because usbh now has two compatible
>      strings and uses a power domain instead of a regulator.
>
> v2: Renamed to bcm6345, removed "mask" property.
>      Acked-by: Rob Herring <robh@kernel.org>
>
>   .../bindings/reset/brcm,bcm6345-reset.txt          | 33 ++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.txt
>
> diff --git a/Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.txt b/Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.txt
> new file mode 100644
> index 0000000..0313040
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.txt
> @@ -0,0 +1,33 @@
> +Broadcom BCM6345 reset controller
> +
> +The BCM6345 contains a basic soft reset controller in the perf register
> +set which resets components using a bit in a register.
> +
> +Please also refer to reset.txt in this directory for common reset
> +controller binding usage.
> +
> +Required properties:
> +- compatible:	Should be "brcm,bcm<soc>-reset", "brcm,bcm6345-reset"
> +- regmap:	The register map phandle
> +- offset:	Offset in the register map for the reset register (in bytes)
> +- #reset-cells:	Must be set to 1
> +
> +Example:
> +
> +periph_soft_rst: reset-controller {
> +	compatible = "brcm,bcm63168-reset", "brcm,bcm6345-reset";
> +	regmap = <&periph_cntl>;
> +	offset = <0x10>;
> +
> +	#reset-cells = <1>;
> +};
> +
> +usbh: usbphy@10002700 {

    "usb-phy" please to be more in line with ePAPR standardized "ethernet-phy" 
node name.

[...]

MBR, Sergei
