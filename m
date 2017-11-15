Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Nov 2017 20:19:14 +0100 (CET)
Received: from mail-oi0-f65.google.com ([209.85.218.65]:53084 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990394AbdKOTTFHaGTQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Nov 2017 20:19:05 +0100
Received: by mail-oi0-f65.google.com with SMTP id r128so16781227oig.9;
        Wed, 15 Nov 2017 11:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lKI7QvoXX+cMOTbnWQ0D0OYhc/A3nEDtV16HFci6ayQ=;
        b=HC/Y/dPb7HBZZqil2GrSnL1dFjLA//vvW3whhZjcfa+bGX9uT29A5GpUNrZG1kD2Ko
         uUGFH2quggXc00Ns/1V2NoLgv9O+OFlo9aNvlG7HsGoeFb/dWvPNh+ZKVmMvgSFaeVmE
         2sWQDWe1SEVE/Lu/qZbFf963OynLGvvPu6ZbTIRvTkddllFip/ABjFQFTC06a9lzjFf0
         RnFig/A6pkm1VSnT51Xq7yrZiifHoA3yX4pFE36Pu6ckzbkSz4Km0HDz2bW+yPUF8fPq
         MQ6CuMRYd7sOirLgQRAIr/kl9PJAw3W8tgOagdP7cDvi29m9pF6isQJnq0haaue6FbFf
         VEug==
X-Gm-Message-State: AJaThX5E8xSHESNWi7W29ryaqP41r6x75so80RQrV9VoMqinS9VRV2Ne
        99EnBIDH+DUC1sMVWE2oxQ==
X-Google-Smtp-Source: AGs4zMY0LY2REkluRZHs1wvaleWTJ2bJ/83vl+w0FYKmYmJzVzb5rjEe4s3sgOwF1whCtcci49Kl+g==
X-Received: by 10.202.170.80 with SMTP id t77mr10563330oie.314.1510773538830;
        Wed, 15 Nov 2017 11:18:58 -0800 (PST)
Received: from localhost (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.gmail.com with ESMTPSA id j40sm10412866otj.57.2017.11.15.11.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Nov 2017 11:18:58 -0800 (PST)
Date:   Wed, 15 Nov 2017 13:18:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Carlos Munoz <cmunoz@cavium.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: Add Cavium Octeon Common Ethernet
 Interface.
Message-ID: <20171115191857.podohd56knfd4hyh@rob-hp-laptop>
References: <20171109192915.11912-1-david.daney@cavium.com>
 <20171109192915.11912-2-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171109192915.11912-2-david.daney@cavium.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60961
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

On Thu, Nov 09, 2017 at 11:29:08AM -0800, David Daney wrote:
> From: Carlos Munoz <cmunoz@cavium.com>
> 
> Add bindings for Common Ethernet Interface (BGX) block.
> 
> Signed-off-by: Carlos Munoz <cmunoz@cavium.com>
> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  .../devicetree/bindings/net/cavium-bgx.txt         | 61 ++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/cavium-bgx.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/cavium-bgx.txt b/Documentation/devicetree/bindings/net/cavium-bgx.txt
> new file mode 100644
> index 000000000000..6b1f8b994c20
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/cavium-bgx.txt
> @@ -0,0 +1,61 @@
> +* Common Ethernet Interface (BGX) block
> +
> +Properties:
> +
> +- compatible: "cavium,octeon-7890-bgx": Compatibility with all cn7xxx SOCs.
> +
> +- reg: The base address of the BGX block.
> +
> +- #address-cells: Must be <1>.
> +
> +- #size-cells: Must be <0>.  BGX addresses have no size component.
> +
> +A BGX block has several children, each representing an Ethernet
> +interface.
> +
> +
> +* Ethernet Interface (BGX port) connects to PKI/PKO
> +
> +Properties:
> +
> +- compatible: "cavium,octeon-7890-bgx-port": Compatibility with all
> +	      cn7xxx SOCs.
> +
> +	      "cavium,octeon-7360-xcv": Compatibility with cn73xx SOCs
> +	      for RGMII.
> +
> +- reg: The index of the interface within the BGX block.

There's no memory mapped region associated with the sub-blocks?

> +
> +Optional properties:
> +
> +- local-mac-address: Mac address for the interface.
> +
> +- phy-handle: phandle to the phy node connected to the interface.
> +
> +- phy-mode: described in ethernet.txt.
> +
> +- fixed-link: described in fixed-link.txt.
> +
> +Example:
> +
> +	ethernet-mac-nexus@11800e0000000 {
> +		compatible = "cavium,octeon-7890-bgx";
> +		reg = <0x00011800 0xe0000000 0x00000000 0x01000000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethernet-mac@0 {

ethernet@0

> +			compatible = "cavium,octeon-7360-xcv";
> +			reg = <0>;
> +			local-mac-address = [ 00 01 23 45 67 89 ];
> +			phy-handle = <&phy3>;
> +			phy-mode = "rgmii-rxid"
> +		};
> +		ethernet-mac@1 {

ditto.

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>

> +			compatible = "cavium,octeon-7890-bgx-port";
> +			reg = <1>;
> +			local-mac-address = [ 00 01 23 45 67 8a ];
> +			phy-handle = <&phy4>;
> +			phy-mode = "sgmii"
> +		};
> +	};
> -- 
> 2.13.6
> 
