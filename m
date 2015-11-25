Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2015 21:05:32 +0100 (CET)
Received: from mail-ob0-f169.google.com ([209.85.214.169]:35995 "EHLO
        mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012581AbbKYUFaOpOop (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Nov 2015 21:05:30 +0100
Received: by obdgf3 with SMTP id gf3so47791889obd.3;
        Wed, 25 Nov 2015 12:05:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=RTsGOpRESbOf5oI6abeSLyw3ZtWSXvrgOCPVD9NqoWg=;
        b=d1vqTf7GlfS+H4OEMZfB3oWiWX7IB/QP/N3y7CW0Q6hYcoihAWecx5rEiSexOR2ReQ
         7RgDHuFKM0SBb2wBM4LG+VT5cRNTTVdaxBQxZodLFwAMdUcf2/SkLopTj3faOL9K4JTj
         fR2bDHhO+7nm+Yl2N4k/+KFandcvx3g63ha3kqGyAl59c+efdYE45dknxFdR+Dqz6+xR
         Ob1OAEVQQkBAwA3/ebDfajAkopfjbz7YHBWcXAuFSqSl15Utu6NEknw+1pLzcZPi9z8j
         FUSQXdHGJZFjsJMifuB3FbGayJdbpLZVRaqITQmaWvwxnwVWKtZ36hqv+pwapfymfbNy
         WKdg==
X-Received: by 10.182.251.170 with SMTP id zl10mr24958815obc.8.1448481924337;
        Wed, 25 Nov 2015 12:05:24 -0800 (PST)
Received: from rob-hp-laptop (c-73-166-181-108.hsd1.tx.comcast.net. [73.166.181.108])
        by smtp.gmail.com with ESMTPSA id x71sm11216504oie.18.2015.11.25.12.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Nov 2015 12:05:23 -0800 (PST)
Date:   Wed, 25 Nov 2015 14:05:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Schiller <mschiller@tdt.de>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linus.walleij@linaro.org,
        pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        ralf@linux-mips.org, blogic@openwrt.org, hauke@hauke-m.de,
        jogo@openwrt.org, daniel.schwierzeck@gmail.com
Subject: Re: [PATCH v2 1/4] pinctrl/lantiq: updating devicetree binding
 description
Message-ID: <20151125200522.GB30473@rob-hp-laptop>
References: <1448446739-5541-1-git-send-email-mschiller@tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1448446739-5541-1-git-send-email-mschiller@tdt.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50114
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

On Wed, Nov 25, 2015 at 11:18:56AM +0100, Martin Schiller wrote:
> This patch adds the new dedicated "lantiq,<chip>-pinctrl" compatible strings
> to the devicetree bindings Documentation, where <chip> is one of "ase",
> "danube", "xrx100", "xrx200" or "xrx300" and marks the "lantiq,pinctrl-xway",
> "lantiq,pinctrl-ase" and "lantiq,pinctrl-xr9" compatible strings as DEPRECATED.
> 
> Signed-off-by: Martin Schiller <mschiller@tdt.de>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  .../bindings/pinctrl/lantiq,pinctrl-xway.txt       | 110 +++++++++++++++++++--
>  1 file changed, 102 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/lantiq,pinctrl-xway.txt b/Documentation/devicetree/bindings/pinctrl/lantiq,pinctrl-xway.txt
> index e89b467..8e5216b 100644
> --- a/Documentation/devicetree/bindings/pinctrl/lantiq,pinctrl-xway.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/lantiq,pinctrl-xway.txt
> @@ -1,7 +1,16 @@
>  Lantiq XWAY pinmux controller
>  
>  Required properties:
> -- compatible: "lantiq,pinctrl-xway" or "lantiq,pinctrl-xr9"
> +- compatible: "lantiq,pinctrl-xway", (DEPRECATED: Use "lantiq,pinctrl-danube")
> +	      "lantiq,pinctrl-xr9", (DEPRECATED: Use "lantiq,xrx100-pinctrl" or
> +					"lantiq,xrx200-pinctrl")
> +	      "lantiq,pinctrl-ase", (DEPRECATED: Use "lantiq,ase-pinctrl")
> +	      "lantiq,<chip>-pinctrl", where <chip> is:
> +		"ase" (XWAY AMAZON Family)
> +		"danube" (XWAY DANUBE Family)
> +		"xrx100" (XWAY xRX100 Family)
> +		"xrx200" (XWAY xRX200 Family)
> +		"xrx300" (XWAY xRX300 Family)
>  - reg: Should contain the physical address and length of the gpio/pinmux
>    register range
>  
> @@ -36,19 +45,87 @@ Required subnode-properties:
>  
>  Valid values for group and function names:
>  
> +XWAY: (DEPRECATED: Use DANUBE)
>    mux groups:
>      exin0, exin1, exin2, jtag, ebu a23, ebu a24, ebu a25, ebu clk, ebu cs1,
>      ebu wait, nand ale, nand cs1, nand cle, spi, spi_cs1, spi_cs2, spi_cs3,
> -    spi_cs4, spi_cs5, spi_cs6, asc0, asc0 cts rts, stp, nmi , gpt1, gpt2,
> +    spi_cs4, spi_cs5, spi_cs6, asc0, asc0 cts rts, stp, nmi, gpt1, gpt2,
>      gpt3, clkout0, clkout1, clkout2, clkout3, gnt1, gnt2, gnt3, req1, req2,
>      req3
>  
> -  additional mux groups (XR9 only):
> -    mdio, nand rdy, nand rd, exin3, exin4, gnt4, req4
> +  functions:
> +    spi, asc, cgu, jtag, exin, stp, gpt, nmi, pci, ebu
> +
> +XR9: ( DEPRECATED: Use xRX100/xRX200)
> +  mux groups:
> +    exin0, exin1, exin2, exin3, exin4, jtag, ebu a23, ebu a24, ebu a25,
> +    ebu clk, ebu cs1, ebu wait, nand ale, nand cs1, nand cle, nand rdy,
> +    nand rd, spi, spi_cs1, spi_cs2, spi_cs3, spi_cs4, spi_cs5, spi_cs6,
> +    asc0, asc0 cts rts, stp, nmi, gpt1, gpt2, gpt3, clkout0, clkout1,
> +    clkout2, clkout3, gnt1, gnt2, gnt3, gnt4, req1, req2, req3, req4, mdio,
> +    gphy0 led0, gphy0 led1, gphy0 led2, gphy1 led0, gphy1 led1, gphy1 led2
> +
> +  functions:
> +    spi, asc, cgu, jtag, exin, stp, gpt, nmi, pci, ebu, mdio, gphy
> +
> +AMAZON:
> +  mux groups:
> +    exin0, exin1, exin2, jtag, spi_di, spi_do, spi_clk, spi_cs1, spi_cs2,
> +    spi_cs3, spi_cs4, spi_cs5, spi_cs6, asc, stp, gpt1, gpt2, gpt3, clkout0,
> +    clkout1, clkout2, mdio, dfe led0, dfe led1, ephy led0, ephy led1, ephy led2
> +
> +  functions:
> +    spi, asc, cgu, jtag, exin, stp, gpt, mdio, ephy, dfe
> +
> +DANUBE:
> +  mux groups:
> +    exin0, exin1, exin2, jtag, ebu a23, ebu a24, ebu a25, ebu clk, ebu cs1,
> +    ebu wait, nand ale, nand cs1, nand cle, spi_di, spi_do, spi_clk, spi_cs1,
> +    spi_cs2, spi_cs3, spi_cs4, spi_cs5, spi_cs6, asc0, asc0 cts rts, stp, nmi,
> +    gpt1, gpt2, gpt3, clkout0, clkout1, clkout2, clkout3, gnt1, gnt2, gnt3,
> +    req1, req2, req3, dfe led0, dfe led1
>  
>    functions:
> -    spi, asc, cgu, jtag, exin, stp, gpt, nmi, pci, ebu, mdio
> +    spi, asc, cgu, jtag, exin, stp, gpt, nmi, pci, ebu, dfe
>  
> +xRX100:
> +  mux groups:
> +    exin0, exin1, exin2, exin3, exin4, ebu a23, ebu a24, ebu a25, ebu clk,
> +    ebu cs1, ebu wait, nand ale, nand cs1, nand cle, nand rdy, nand rd,
> +    spi_di, spi_do, spi_clk, spi_cs1, spi_cs2, spi_cs3, spi_cs4, spi_cs5,
> +    spi_cs6, asc0, asc0 cts rts, stp, nmi, gpt1, gpt2, gpt3, clkout0, clkout1,
> +    clkout2, clkout3, gnt1, gnt2, gnt3, gnt4, req1, req2, req3, req4, mdio,
> +    dfe led0, dfe led1
> +
> +  functions:
> +    spi, asc, cgu, exin, stp, gpt, nmi, pci, ebu, mdio, dfe
> +
> +xRX200:
> +  mux groups:
> +    exin0, exin1, exin2, exin3, exin4, ebu a23, ebu a24, ebu a25, ebu clk,
> +    ebu cs1, ebu wait, nand ale, nand cs1, nand cle, nand rdy, nand rd,
> +    spi_di, spi_do, spi_clk, spi_cs1, spi_cs2, spi_cs3, spi_cs4, spi_cs5,
> +    spi_cs6, usif uart_rx, usif uart_tx, usif uart_rts, usif uart_cts,
> +    usif uart_dtr, usif uart_dsr, usif uart_dcd, usif uart_ri, usif spi_di,
> +    usif spi_do, usif spi_clk, usif spi_cs0, usif spi_cs1, usif spi_cs2,
> +    stp, nmi, gpt1, gpt2, gpt3, clkout0, clkout1, clkout2, clkout3, gnt1,
> +    gnt2, gnt3, gnt4, req1, req2, req3, req4, mdio, dfe led0, dfe led1,
> +    gphy0 led0, gphy0 led1, gphy0 led2, gphy1 led0, gphy1 led1, gphy1 led2
> +
> +  functions:
> +    spi, usif, cgu, exin, stp, gpt, nmi, pci, ebu, mdio, dfe, gphy
> +
> +xRX300:
> +  mux groups:
> +    exin0, exin1, exin2, exin4, nand ale, nand cs0, nand cs1, nand cle,
> +    nand rdy, nand rd, nand_d0, nand_d1, nand_d2, nand_d3, nand_d4, nand_d5,
> +    nand_d6, nand_d7, nand_d1, nand wr, nand wp, nand se, spi_di, spi_do,
> +    spi_clk, spi_cs1, spi_cs4, spi_cs6, usif uart_rx, usif uart_tx,
> +    usif spi_di, usif spi_do, usif spi_clk, usif spi_cs0, stp, clkout2,
> +    mdio, dfe led0, dfe led1, ephy0 led0, ephy0 led1, ephy1 led0, ephy1 led1
> +
> +  functions:
> +    spi, usif, cgu, exin, stp, ebu, mdio, dfe, ephy
>  
>  
>  Definition of pin configurations:
> @@ -62,15 +139,32 @@ Optional subnode-properties:
>      0: none, 1: down, 2: up.
>  - lantiq,open-drain: Boolean, enables open-drain on the defined pin.
>  
> -Valid values for XWAY pin names:
> +Valid values for XWAY pin names: (DEPRECATED: Use DANUBE)
>    Pinconf pins can be referenced via the names io0-io31.
>  
> -Valid values for XR9 pin names:
> +Valid values for XR9 pin names: (DEPRECATED: Use xrX100/xRX200)
>    Pinconf pins can be referenced via the names io0-io55.
>  
> +Valid values for AMAZON pin names:
> +  Pinconf pins can be referenced via the names io0-io31.
> +
> +Valid values for DANUBE pin names:
> +  Pinconf pins can be referenced via the names io0-io31.
> +
> +Valid values for xRX100 pin names:
> +  Pinconf pins can be referenced via the names io0-io55.
> +
> +Valid values for xRX200 pin names:
> +  Pinconf pins can be referenced via the names io0-io49.
> +
> +Valid values for xRX300 pin names:
> +  Pinconf pins can be referenced via the names io0-io1,io3-io6,io8-io11,
> +						io13-io19,io23-io27,io34-io36,
> +						io42-io43,io48-io61.
> +
>  Example:
>  	gpio: pinmux@E100B10 {
> -		compatible = "lantiq,pinctrl-xway";
> +		compatible = "lantiq,danube-pinctrl";
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&state_default>;
>  
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
