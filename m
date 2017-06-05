Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jun 2017 20:45:45 +0200 (CEST)
Received: from mail-lf0-x231.google.com ([IPv6:2a00:1450:4010:c07::231]:33236
        "EHLO mail-lf0-x231.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992078AbdFESpaSA2p7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Jun 2017 20:45:30 +0200
Received: by mail-lf0-x231.google.com with SMTP id a136so61221859lfa.0
        for <linux-mips@linux-mips.org>; Mon, 05 Jun 2017 11:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=kLelscESAqVocqLldLVu8pZ/Em+tq058PE0xFuH/qmo=;
        b=KSDbOY8+xx6DC0AxFR1KjPbGkp5prYsvsptmhTO/0847kMggTfshKWPRbmakBBvOui
         1oXTZ+9UjU58JK5FNOwbRD2tLnyWvKel1/ffNge8SdT9skzheBQYJfgp9/GkaiAD98VY
         agIuS88kjszvEvLrd9sqhKukkI/O1VtdAjV+jBfI8sR2NOIKXUaGJKwKF53qOmcuMnHk
         uYqzdFrGc/qAx6xWQgcmZelA9pvzSuefEZmPfNZwW2jO1G8F8daiFI5P0yF3ytoHEdh3
         ddTPyWzTZ+q+S2IRQU8G0+oXi7UeqOIytBoICWkprHE7DcvPDn5vCO0046bd60lxobeL
         +O2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=kLelscESAqVocqLldLVu8pZ/Em+tq058PE0xFuH/qmo=;
        b=OKFvVjL3ykfjb7oqYyN6KUoQo5fuYt02bQyc1ltH6uXGn4i+YFKfukeevheX/lZdNU
         BxjtP0GH+0aJ8v1jsIm0hHsMem3JthB+6cqQHh42FRJzyoO3zFUP2adwlm+MoIRriW73
         Xf1LWmzSnJn4+9wG8v1cXaPVmz1nLad7M8TGCvnC7fLBdq9jjShLy0+zWqE9RZ0Byl+C
         paQVEyNUolDim5Wjc5M3XakMAWh6p6lpeFjqIqEFRsE/ChbQSsfY8lZBg6F5zqLxvIeT
         i6aNpWhP/RlnWcHdMb0iBo8/Z2ShILukBpF0BmDN+5+2HXFMmitHkhH9bnpe4AH+VmXm
         cV7A==
X-Gm-Message-State: AODbwcBTdZZJDmiYih5KS48Ebz6kNMOE5Qj62emSxfGiHc8CIupU/zD+
        Ycl3ASPvX2Y2Ek6j
X-Received: by 10.25.77.149 with SMTP id a143mr6268273lfb.121.1496688324343;
        Mon, 05 Jun 2017 11:45:24 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.86.22])
        by smtp.gmail.com with ESMTPSA id 2sm7124870lju.0.2017.06.05.11.45.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jun 2017 11:45:23 -0700 (PDT)
Subject: Re: [PATCH v4 3/7] dt-bindings: net: Document Intel pch_gbe binding
To:     Paul Burton <paul.burton@imgtec.com>, netdev@vger.kernel.org
References: <20170602234042.22782-1-paul.burton@imgtec.com>
 <20170605173136.10795-1-paul.burton@imgtec.com>
 <20170605173136.10795-4-paul.burton@imgtec.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-mips@linux-mips.org, Eric Dumazet <edumazet@google.com>,
        Jarod Wilson <jarod@redhat.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <ff45315f-72ae-4d32-3f25-3444f4d4f1fc@cogentembedded.com>
Date:   Mon, 5 Jun 2017 21:45:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170605173136.10795-4-paul.burton@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58229
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

Hello!

On 06/05/2017 08:31 PM, Paul Burton wrote:

> Introduce documentation for a device tree binding for the Intel Platform
> Controller Hub (PCH) GigaBit Ethernet (GBE) device. Although this is a
> PCIe device & thus largely auto-detectable, this binding will be used to
> provide the driver with the PHY reset GPIO.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jarod Wilson <jarod@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Cc: devicetree@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: netdev@vger.kernel.org
>
> ---
>
> Changes in v4: None
>
> Changes in v3:
> - New patch.
>
> Changes in v2: None
>
>  Documentation/devicetree/bindings/net/pch_gbe.txt | 25 +++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/pch_gbe.txt
>
> diff --git a/Documentation/devicetree/bindings/net/pch_gbe.txt b/Documentation/devicetree/bindings/net/pch_gbe.txt
> new file mode 100644
> index 000000000000..5de479c26b04
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pch_gbe.txt
> @@ -0,0 +1,25 @@
> +Intel Platform Controller Hub (PCH) GigaBit Ethernet (GBE)
> +
> +Required properties:
> +- compatible:		Should be the PCI vendor & device ID, eg. "pci8086,8802".
> +- reg:			Should be a PCI device number as specified by the PCI bus
> +			binding to IEEE Std 1275-1994.
> +- phy-reset-gpios:	Should be a GPIO list containing a single GPIO that
> +			resets the attached PHY when active.
> +
> +Example:
> +
> +	eg20t_mac@2,0,1 {
> +		compatible = "pci8086,8802";
> +		reg = <0x00020100 0 0 0 0>;
> +		phy-reset-gpios = <&eg20t_gpio 6
> +				   GPIO_ACTIVE_LOW>;
> +	};
> +
> +	eg20t_gpio: eg20t_gpio@2,0,2 {

    Name it "gpio@2,0,2" please -- the node names need to be generic and 
"gpio" is explicitly listed in the DT 1.0 spec...

MBR, Sergei
