Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Aug 2013 22:44:30 +0200 (CEST)
Received: from mail-la0-f43.google.com ([209.85.215.43]:42830 "EHLO
        mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6865317Ab3HIUoYkiwlh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Aug 2013 22:44:24 +0200
Received: by mail-la0-f43.google.com with SMTP id ep20so3361931lab.16
        for <linux-mips@linux-mips.org>; Fri, 09 Aug 2013 13:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=fR4pisS+Cge6FS8s/EeRCBfqwHo7tuIQewafW5i0mmc=;
        b=oLF8PhtQ2R8XTgVRPGO7ip3nQGsFOrCOmRQ/fj1ig11PZY695E1+tLml+ELPBJACpE
         ytHVM+pnb2Lp8r6pJtA79WH5FVqskPJ/DNkVVHglXTJwDI0xteHSJQFpNsbnPmgC3Umz
         twyXgp0wRasT9C8rCe7a1z/li5OAej9deNv5sL/ycpEspVRZZUEvv8oMhiIqgab3PjpE
         FbbO4fe4NB9XNkuoxDA9d/0woa2p1PO5VpYblVbndxhFCzFDkB18frLr8eaL5vF0KR/p
         8qr6TZsZGblVm08ZLLtjTnZMdeTVaPsXwXHdhQeUSi2n0n/ex7l9xf9IUAgt/9XlNNq0
         CtSQ==
X-Gm-Message-State: ALoCoQmQhRnMhcQL/oZijsUkDls0WSprFsdoXPHxZYN1acrTGX+NWtWjYXwG+lmTDft0/NDQj86/
X-Received: by 10.112.138.37 with SMTP id qn5mr5106324lbb.52.1376081057245;
        Fri, 09 Aug 2013 13:44:17 -0700 (PDT)
Received: from wasted.dev.rtsoft.ru (ppp91-76-87-123.pppoe.mtu-net.ru. [91.76.87.123])
        by mx.google.com with ESMTPSA id eb20sm7504946lbb.15.2013.08.09.13.44.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 13:44:16 -0700 (PDT)
Message-ID: <520554AA.4030503@cogentembedded.com>
Date:   Sat, 10 Aug 2013 00:44:26 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] DT: Add documentation for spi-rt2880
References: <1376074288-29302-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1376074288-29302-1-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37510
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

On 08/09/2013 10:51 PM, John Crispin wrote:

> Describe the SPI master found on the MIPS based Ralink SoC.

> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-spi@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> ---
>   .../devicetree/bindings/spi/spi-rt2880.txt         |   26 ++++++++++++++++++++
>   1 file changed, 26 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/spi/spi-rt2880.txt

> diff --git a/Documentation/devicetree/bindings/spi/spi-rt2880.txt b/Documentation/devicetree/bindings/spi/spi-rt2880.txt
> new file mode 100644
> index 0000000..d946626
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-rt2880.txt
> @@ -0,0 +1,26 @@
> +Ralink SoC RT2880 and famile SPI master controller.
> +
> +Required properties:
> +- compatible : "ralink,rt2880-spi"
> +- reg : The register base for the controller.
> +- #address-cells : <1>, as required by generic SPI binding.
> +- #size-cells : <0>, also as required by generic SPI binding.
> +
> +Child nodes as per the generic SPI binding.
> +
> +Example:
> +
> +	spi@b00 {
> +		compatible = "ralink,rt2880-spi";
> +		reg = <0xb00 0x100>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		m25p80@0 {

    Don't call nodes with chip names. ePAPR [1] says: "the name of a node 
should be somewhat generic, reflecting the function of the device and not its
precise programming model". I suspect this is a flash device, ePAPR suggests 
using "flash" as a name in this case.

> +			compatible = "m25p80";
> +			reg = <0>;
> +			spi-max-frequency = <10000000>;
> +		};
> +	};
> +

WBR, Sergei
