Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Sep 2018 14:53:34 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:34990 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992554AbeIJMx1HqfrV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Sep 2018 14:53:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=HX8FDYPnETgjLj5aoDGMx6GCp2A3kK4rqtkhE2PakWk=;
        b=X3fn+VmHqE0gr2qsidj9V10JBvr6UoqbVla2jNsnw0qW1+qmU7mL7SONXFF8PeeB8rMrUcR/uuEeMaDx8l0d3c58gS5ex3t8EHipT3CGLVFrjBfUz/qSdwOFNwn21XhAN+70GndXthlQGkwpjIHcDLtxn5UMjnmRXaUagnnBgxA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fzLgi-0008NT-Ne; Mon, 10 Sep 2018 14:53:08 +0200
Date:   Mon, 10 Sep 2018 14:53:08 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 net-next 3/6] dt-bindings: net: Add lantiq,xrx200-net
 DT bindings
Message-ID: <20180910125308.GC30395@lunn.ch>
References: <20180909201647.32727-1-hauke@hauke-m.de>
 <20180909201647.32727-4-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180909201647.32727-4-hauke@hauke-m.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66177
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

On Sun, Sep 09, 2018 at 10:16:44PM +0200, Hauke Mehrtens wrote:
> This adds the binding for the PMAC core between the CPU and the GSWIP
> switch found on the xrx200 / VR9 Lantiq / Intel SoC.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: devicetree@vger.kernel.org
> ---
>  .../devicetree/bindings/net/lantiq,xrx200-net.txt   | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/lantiq,xrx200-net.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/lantiq,xrx200-net.txt b/Documentation/devicetree/bindings/net/lantiq,xrx200-net.txt
> new file mode 100644
> index 000000000000..8a2fe5200cdc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/lantiq,xrx200-net.txt
> @@ -0,0 +1,21 @@
> +Lantiq xRX200 GSWIP PMAC Ethernet driver
> +==================================
> +
> +Required properties:
> +
> +- compatible	: "lantiq,xrx200-net" for the PMAC of the embedded
> +		: GSWIP in the xXR200
> +- reg		: memory range of the PMAC core inside of the GSWIP core
> +- interrupts	: TX and RX DMA interrupts. Use interrupt-names "tx" for
> +		: the TX interrupt and "rx" for the RX interrupt.
> +
> +Example:
> +
> +eth0: eth@E10B308 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	compatible = "lantiq,xrx200-net";
> +	reg = <0xE10B308 0x30>;

Hi Hauke

This binding itself looks fine. I just find this address range a bit
odd. What are 0xe10b300-0xe10b307 used for? Are all 0x30 bytes used in
the range? The address range ending at 0xe10b338 seems a bit
odd. 0xe10b33f would be more typical.

I'm asking because it can be messy when you find out you need to
change the address range, and not break backwards compatibility.

     Andrew
