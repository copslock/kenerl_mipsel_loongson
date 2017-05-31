Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2017 22:05:55 +0200 (CEST)
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34212 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993179AbdEaUFseruL3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2017 22:05:48 +0200
Received: by mail-oi0-f68.google.com with SMTP id w10so3594868oif.1;
        Wed, 31 May 2017 13:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=86uxN3VckIcWErURgUMrIAP/PDK+LGVX45tsuaOGnnQ=;
        b=V4VBW1DSYmvD0zj4n1mIdDl2JdJ7jwLVmcuStpV04/+ypfQozLq7ZphCvYfN+kE62E
         HVDEwCMNVEMqCYBhlk822/14qGdGs0FeG2MYwMlJc35dlLNEePb4H3exC3rwTKqW6FYa
         dTW6sNBiDWn9TEW0j52hcg0dKEOAFHE7Un5ZEcnIr/dxdszBJU4Cwqp3c9HP2n8G0W14
         S5AzJO7Xt+L7eoG9kjr9e9+7vY9V2K/JX4arniCSy0a/+fZHDIxbKnOxNFf/chBJzXmE
         DE+uh+uMy5HClDoEfhXvAdXt9ZUNF9OwdOwILv4Njb1yNhHpIM1ZxaYC8v2yEJp5z3o9
         kE0w==
X-Gm-Message-State: AODbwcCXZnQh4TMo2Dh7SgGbaQm1DpRWleKSA9w0/UCX9H80PUB4tOBQ
        5c6TakiVGkoH83BzVtXuTw==
X-Received: by 10.202.80.134 with SMTP id e128mr13277723oib.118.1496261141881;
        Wed, 31 May 2017 13:05:41 -0700 (PDT)
Received: from localhost (66-90-148-125.dyn.grandenetworks.net. [66.90.148.125])
        by smtp.gmail.com with ESMTPSA id q206sm7803816oif.0.2017.05.31.13.05.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 May 2017 13:05:41 -0700 (PDT)
Date:   Wed, 31 May 2017 15:05:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de
Subject: Re: [PATCH v3 07/16] Documentation: DT: MIPS: lantiq: Add docs for
 the RCU bindings
Message-ID: <20170531200540.joludfqpy35yc5yy@rob-hp-laptop>
References: <20170528184006.31668-1-hauke@hauke-m.de>
 <20170528184006.31668-8-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170528184006.31668-8-hauke@hauke-m.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58106
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

On Sun, May 28, 2017 at 08:39:57PM +0200, Hauke Mehrtens wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> This adds the initial documentation for the RCU module (a MFD device
> which provides USB PHYs, reset controllers and more).
> 
> The RCU register range is used for multiple purposes. Mostly one device
> uses one or multiple register exclusively, but for some registers some
> bits are for one driver and some other bits are for a different driver.
> With this patch all accesses to the RCU registers will go through
> syscon.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  .../devicetree/bindings/mips/lantiq/rcu.txt        | 97 ++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu.txt
> 
> diff --git a/Documentation/devicetree/bindings/mips/lantiq/rcu.txt b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
> new file mode 100644
> index 000000000000..3e2461262218
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
> @@ -0,0 +1,97 @@
> +Lantiq XWAY SoC RCU binding
> +===========================
> +
> +This binding describes the RCU (reset controller unit) multifunction device,
> +where each sub-device has it's own set of registers.
> +
> +The RCU register range is used for multiple purposes. Mostly one device
> +uses one or multiple register exclusively, but for some registers some
> +bits are for one driver and some other bits are for a different driver.
> +With this patch all accesses to the RCU registers will go through
> +syscon.
> +
> +
> +-------------------------------------------------------------------------------
> +Required properties:
> +- compatible	: The first and second values must be: "simple-mfd", "syscon"
> +- reg		: The address and length of the system control registers
> +
> +
> +-------------------------------------------------------------------------------
> +Example of the RCU bindings on a xRX200 SoC:
> +	rcu0: rcu@203000 {
> +		compatible = "lantiq,rcu-xrx200", "simple-mfd", "syscon";
> +		reg = <0x203000 0x100>;
> +		big-endian;
> +
> +		gphy0: gphy@0 {

Unit address without reg address is not valid.

> +			compatible = "lantiq,xrx200a2x-rcu-gphy";
> +
> +			regmap = <&rcu0>;
> +			offset = <0x20>;

Does reg not work instead?

> +			resets = <&reset0 31 30>, <&reset1 7 7>;
> +			reset-names = "gphy", "gphy2";
> +			lantiq,gphy-mode = <GPHY_MODE_GE>;
> +		};
> +
> +		gphy1: gphy@1 {
> +			compatible = "lantiq,xrx200a2x-rcu-gphy";
> +
> +			regmap = <&rcu0>;
> +			offset = <0x68>;
> +			resets = <&reset0 29 28>, <&reset1 6 6>;
> +			reset-names = "gphy", "gphy2";
> +			lantiq,gphy-mode = <GPHY_MODE_GE>;
> +		};
> +
> +		reset0: reset-controller@0 {
> +			compatible = "lantiq,rcu-reset";
> +
> +			regmap = <&rcu0>;
> +			offset-set = <0x10>;
> +			offset-status = <0x14>;
> +			#reset-cells = <2>;
> +		};
> +
> +		reset1: reset-controller@1 {
> +			compatible = "lantiq,rcu-reset";
> +
> +			regmap = <&rcu0>;
> +			offset-set = <0x48>;
> +			offset-status = <0x24>;
> +			#reset-cells = <2>;
> +		};
> +
> +		usb_phy0: usb2-phy@0 {
> +			compatible = "lantiq,xrx200-rcu-usb2-phy";
> +			status = "disabled";
> +
> +			regmap = <&rcu0>;
> +			offset-phy = <0x18>;
> +			offset-ana = <0x38>;
> +			resets = <&reset1 4 4>, <&reset0 4 4>;
> +			reset-names = "phy", "ctrl";
> +			#phy-cells = <0>;
> +		};
> +
> +		usb_phy1: usb2-phy@1 {
> +			compatible = "lantiq,xrx200-rcu-usb2-phy";
> +			status = "disabled";
> +
> +			regmap = <&rcu0>;
> +			offset-phy = <0x34>;
> +			offset-ana = <0x3C>;
> +			resets = <&reset1 5 4>, <&reset0 4 4>;
> +			reset-names = "phy", "ctrl";
> +			#phy-cells = <0>;
> +		};
> +
> +		reboot {
> +			compatible = "syscon-reboot";
> +
> +			regmap = <&rcu0>;
> +			offset = <0x10>;
> +			mask = <0x40000000>;
> +		};
> +	};
> +
> -- 
> 2.11.0
> 
