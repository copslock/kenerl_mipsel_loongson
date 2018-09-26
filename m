Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2018 23:35:22 +0200 (CEST)
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42523 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992328AbeIZVfRRSOz8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Sep 2018 23:35:17 +0200
Received: by mail-oi1-f193.google.com with SMTP id v198-v6so395851oif.9;
        Wed, 26 Sep 2018 14:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XpuiZxTm/LyHp68Wieb6rdyIqn1THyhmdL6yKRpa8vY=;
        b=KsUhk9LhRXGxp0hkktGERr7zkTNPSpLnobiuLKhxW318Dv2fNFyqlvHPndoxmaeth9
         cYYrOm33T4+tA3c/UJbAdgJTfgiTBuwwKFcS+ayOYqGxaMF3U/NTjVmQHiBVQlokN6GD
         8eCThU4M1C+nDekpcMoDZSTAbFFMnFPDZFou96MjKom4bzeknjMBKEFzhoU+aYRdz9dK
         BpgrzCMH7gP8e7st3xVu+jDc//wYalMzRHVa177y3JTwq+y/48jMw3tztZzMhx8m2+IY
         UzhXMRv4uXeSfde0NknaVvOtIOGajeXIWDSUtPozsi6Lhxo+Rg63lmdYa7eRpeUxBntU
         jw0g==
X-Gm-Message-State: ABuFfohYSi/NBuM6MCj0rpE5KK2OSjV3aa7Q4Hc8n/xiuZJzxaeWFyoc
        F4b6zUgbbY+Wqc+STJyxpQ==
X-Google-Smtp-Source: ACcGV62UJH5Dzd1JkSxkHJSgwOWCpzSfp3pqKqavLsDYLPGHrfFJxlDJHrTjMOfHf6eGzJJYz/f9lA==
X-Received: by 2002:aca:b154:: with SMTP id a81-v6mr1781307oif.34.1537997711144;
        Wed, 26 Sep 2018 14:35:11 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y26-v6sm44579otk.64.2018.09.26.14.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 14:35:10 -0700 (PDT)
Date:   Wed, 26 Sep 2018 16:35:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, mark.rutland@arm.com,
        davem@davemloft.net, kishon@ti.com, andrew@lunn.ch,
        f.fainelli@gmail.com, allan.nielsen@microchip.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next v3 07/11] dt-bindings: phy: add DT binding for
 Microsemi Ocelot SerDes muxing
Message-ID: <20180926213509.GA7454@bogus>
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
 <f392dafca9165800439fc09cd7d16e6a9506d457.1536912834.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f392dafca9165800439fc09cd7d16e6a9506d457.1536912834.git-series.quentin.schulz@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66587
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

On Fri, Sep 14, 2018 at 10:16:05AM +0200, Quentin Schulz wrote:
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
>  Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt | 40 +++++++-
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt b/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
> new file mode 100644
> index 0000000..2a88cc3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
> @@ -0,0 +1,40 @@
> +Microsemi Ocelot SerDes muxing driver
> +-------------------------------------
> +
> +On Microsemi Ocelot, there is a handful of registers in HSIO address
> +space for setting up the SerDes to switch port muxing.
> +
> +A SerDes X can be "muxed" to work with switch port Y or Z for example.
> +One specific SerDes can also be used as a PCIe interface.
> +
> +Hence, a SerDes represents an interface, be it an Ethernet or a PCIe one.
> +
> +There are two kinds of SerDes: SERDES1G supports 10/100Mbps in
> +half/full-duplex and 1000Mbps in full-duplex mode while SERDES6G supports
> +10/100Mbps in half/full-duplex and 1000/2500Mbps in full-duplex mode.
> +
> +Also, SERDES6G number (aka "macro") 0 is the only interface supporting
> +QSGMII.
> +
> +Required properties:
> +
> +- compatible: should be "mscc,vsc7514-serdes"
> +- #phy-cells : from the generic phy bindings, must be 2.
> +	       The first number defines the input port to use for a given
> +	       SerDes macro. The second defines the macro to use. They are
> +	       defined in dt-bindings/phy/phy-ocelot-serdes.h

You need to define what this is a child of.

> +
> +Example:
> +
> +	serdes: serdes {
> +		compatible = "mscc,vsc7514-serdes";
> +		#phy-cells = <2>;

However, if there are no other resources associated with this, then you 
don't even need this child node. The parent can be a phy provider and 
provider of other functions too.

> +	};
> +
> +	ethernet {
> +		port1 {
> +			phy-handle = <&phy_foo>;
> +			/* Link SERDES1G_5 to port1 */
> +			phys = <&serdes 1 SERDES1G_5>;
> +		};
> +	};
> -- 
> git-series 0.9.1
