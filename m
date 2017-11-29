Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 03:02:33 +0100 (CET)
Received: from vps0.lunn.ch ([185.16.172.187]:44493 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990490AbdK2CCX6A4Iy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Nov 2017 03:02:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=lGLuMyvvuOokLASABXBaJGqNW3r2aORFfiPLFvIoNG0=;
        b=D1bTZZdPrLCNV8DIVguWFPynt5Jo056LQ1lUjHY+2uDwikXQvDxjXcDw5518m8d3ll0PW7VcccfQjBrEVqeBiBD09Ff/0fNwAt5I5HMR2zAO8Sf981Jwa90j89xUJOxmZDYF7QPkrVPsTfk5t+0/NfA0pju4bCB6zeJGgHu3MRs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1eJrhB-00037F-DZ; Wed, 29 Nov 2017 03:01:53 +0100
Date:   Wed, 29 Nov 2017 03:01:53 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Carlos Munoz <cmunoz@cavium.com>
Subject: Re: [PATCH v4 1/8] dt-bindings: Add Cavium Octeon Common Ethernet
 Interface.
Message-ID: <20171129020153.GN14512@lunn.ch>
References: <20171129005540.28829-1-david.daney@cavium.com>
 <20171129005540.28829-2-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129005540.28829-2-david.daney@cavium.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrew@lunn.ch
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

On Tue, Nov 28, 2017 at 04:55:33PM -0800, David Daney wrote:
> From: Carlos Munoz <cmunoz@cavium.com>
> 
> Add bindings for Common Ethernet Interface (BGX) block.
> 
> Acked-by: Rob Herring <robh@kernel.org>
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
> index 000000000000..830c5f08dddd
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

Hi David

In the probe function we have:

+       reg = of_get_property(pdev->dev.of_node, "reg", NULL);
+       addr = of_translate_address(pdev->dev.of_node, reg);
+       interface = (addr >> 24) & 0xf;
+       numa_node = (addr >> 36) & 0x7;

Is this documented somewhere? The numa_node is particularly
interesting. MMIO changes depends on what node this is in the cluster?

	Andrew
