Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2018 00:01:31 +0200 (CEST)
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34329 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994601AbeIJWB1V8APf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Sep 2018 00:01:27 +0200
Received: by mail-oi0-f67.google.com with SMTP id 13-v6so43406658ois.1
        for <linux-mips@linux-mips.org>; Mon, 10 Sep 2018 15:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f1EGZvcxeItxNq6BTz8Hn6Z7xIn+4p8D412ltVrRu1U=;
        b=D1xXAjv8dDfPi5k7mRD4RhpbeOGyWJvVWYmVC1/1PbGKmjWi4V5Pm7d0kHDDB90hw8
         VerilBEWUlHstMPpKFYgC6SEitWNkUVq0K+KmAxTyqqF2Mby1gonqN1f+A7xKOAHcyvF
         rS1aXrK23f1dHVifhGYDC0QMMpFx9KPnbezz8bddt8xKKOsQuLdMS/a51/fThqdgXwyr
         3feuRz4YgpgoxN1aW98F3BZPqO+hV13HjOfrAItKCx0iNr9SqPtz0kzLXpAt/MklwQO9
         0+9/Gz7jRDcoHnqAeNFetgKFnCHfYWXv+s5SwE6cMoyLuG0+fj+Ktcmh1+Y8IH7rprps
         jaFQ==
X-Gm-Message-State: APzg51C2rdzmEzI/s/cFvR8VD3voHjKu27m7ChRa3x3OSdsduiPxv5HG
        ELkbTmiqCp+HW4o2L1EyHw==
X-Google-Smtp-Source: ANB0VdbuGpHcXZ361dlEwj7endPtZUVuGm1P+IDohcWE7pDuM35I/FRCAh1nyQufNyIQc+15TzlUtA==
X-Received: by 2002:aca:b641:: with SMTP id g62-v6mr22711441oif.71.1536616881145;
        Mon, 10 Sep 2018 15:01:21 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x126-v6sm32789282oig.15.2018.09.10.15.01.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 15:01:20 -0700 (PDT)
Date:   Mon, 10 Sep 2018 17:01:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 net-next 5/6] dt-bindings: net: dsa: Add
 lantiq,xrx200-gswip DT bindings
Message-ID: <20180910220119.GA32582@bogus>
References: <20180909201647.32727-1-hauke@hauke-m.d>
 <20180909202027.411-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180909202027.411-1-hauke@hauke-m.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66190
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

On Sun, Sep 09, 2018 at 10:20:27PM +0200, Hauke Mehrtens wrote:
> This adds the binding for the GSWIP (Gigabit switch) core found in the
> xrx200 / VR9 Lantiq / Intel SoC.
> 
> This part takes care of the switch, MDIO bus, and loading the FW into
> the embedded GPHYs.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: devicetree@vger.kernel.org
> ---
>  .../devicetree/bindings/net/dsa/lantiq-gswip.txt   | 141 +++++++++++++++++++++
>  1 file changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt b/Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt
> new file mode 100644
> index 000000000000..a089f5856778
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/lantiq-gswip.txt
> @@ -0,0 +1,141 @@
> +Lantiq GSWIP Ethernet switches
> +==================================
> +
> +Required properties for GSWIP core:
> +
> +- compatible	: "lantiq,xrx200-gswip" for the embedded GSWIP in the
> +		  xRX200 SoC
> +- reg		: memory range of the GSWIP core registers
> +		: memory range of the GSWIP MDIO registers
> +		: memory range of the GSWIP MII registers
> +
> +See Documentation/devicetree/bindings/net/dsa/dsa.txt for a list of
> +additional required and optional properties.
> +
> +
> +Required properties for MDIO bus:
> +- compatible	: "lantiq,xrx200-mdio" for the MDIO bus inside the GSWIP
> +		  core of the xRX200 SoC and the PHYs connected to it.
> +
> +See Documentation/devicetree/bindings/net/mdio.txt for a list of additional
> +required and optional properties.
> +
> +
> +Required properties for GPHY firmware loading:
> +- compatible	: "lantiq,gphy-fw" and "lantiq,xrx200-gphy-fw",
> +		  "lantiq,xrx200a1x-gphy-fw", "lantiq,xrx200a2x-gphy-fw",
> +		  "lantiq,xrx300-gphy-fw", or "lantiq,xrx330-gphy-fw"
> +		  for the loading of the firmware into the embedded
> +		  GPHY core of the SoC.

One valid combination of compatibles per line please.

> +- lantiq,rcu	: reference to the rcu syscon
> +
> +The GPHY firmware loader has a list of GPHY entries, one for each
> +embedded GPHY
> +
> +- reg		: Offset of the GPHY firmware register in the RCU
> +		  register range

This use of reg is strange. This node should probably be a child of 
the RCU.

> +- resets	: list of resets of the embedded GPHY
> +- reset-names	: list of names of the resets
> +
> +Example:
> +
> +Ethernet switch on the VRX200 SoC:
> +
> +gswip: gswip@E108000 {

switch@... or ethernet-switch@...

We need a standard name here and add it to the DT spec.

> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	compatible = "lantiq,xrx200-gswip";
> +	reg = <	0xE108000 0x3000 /* switch */
> +		0xE10B100 0x70 /* mdio */
> +		0xE10B1D8 0x30 /* mii */
> +		>;
> +	dsa,member = <0 0>;

Not documented.

> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@0 {
> +			reg = <0>;
> +			label = "lan3";
> +			phy-mode = "rgmii";
> +			phy-handle = <&phy0>;
> +		};
> +
> +		port@1 {
> +			reg = <1>;
> +			label = "lan4";
> +			phy-mode = "rgmii";
> +			phy-handle = <&phy1>;
> +		};
> +
> +		port@2 {
> +			reg = <2>;
> +			label = "lan2";
> +			phy-mode = "internal";
> +			phy-handle = <&phy11>;
> +		};
> +
> +		port@4 {
> +			reg = <4>;
> +			label = "lan1";
> +			phy-mode = "internal";
> +			phy-handle = <&phy13>;
> +		};
> +
> +		port@5 {
> +			reg = <5>;
> +			label = "wan";
> +			phy-mode = "rgmii";
> +			phy-handle = <&phy5>;
> +		};
> +
> +		port@6 {
> +			reg = <0x6>;
> +			label = "cpu";
> +			ethernet = <&eth0>;
> +		};
> +	};
> +
> +	mdio@0 {

What's the address 0 here?

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "lantiq,xrx200-mdio";
> +		reg = <0>;
> +
> +		phy0: ethernet-phy@0 {
> +			reg = <0x0>;
> +		};
> +		phy1: ethernet-phy@1 {
> +			reg = <0x1>;
> +		};
> +		phy5: ethernet-phy@5 {
> +			reg = <0x5>;
> +		};
> +		phy11: ethernet-phy@11 {
> +			reg = <0x11>;
> +		};
> +		phy13: ethernet-phy@13 {
> +			reg = <0x13>;
> +		};
> +	};
> +
> +	gphy-fw {
> +		compatible = "lantiq,xrx200-gphy-fw", "lantiq,gphy-fw";
> +		lantiq,rcu = <&rcu0>;

Missing #size-cells and #address-cells, but this should change as I said 
above.

> +
> +		gphy@20 {
> +			reg = <0x20>;
> +
> +			resets = <&reset0 31 30>;
> +			reset-names = "gphy";
> +		};
> +
> +		gphy@68 {
> +			reg = <0x68>;
> +
> +			resets = <&reset0 29 28>;
> +			reset-names = "gphy";
> +		};
> +	};
> +};
> -- 
> 2.11.0
> 
