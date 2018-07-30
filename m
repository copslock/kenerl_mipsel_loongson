Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2018 15:35:04 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:56215 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993047AbeG3Ne7rx7Wo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Jul 2018 15:34:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=m/UngLPTmZIQ+RQ2vs0wOdHdGz9MGHtZfbBwdMsJfoU=;
        b=RB6Z8MTCYeHVUoWm3fJw/kXu+bhHQT3rCIAg90Kmj56JM36GO4/LiYlPp+iyB0/V4Wynpj4puuQE/ZFrjcxULd2012nAg6gBAXHQaLenovgjLRn5/rXxanZ6CLn6+VR4LPtXzMAYc/15LfJSL1mNcQVKtT03TetK6v0n0An02EA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fk8K0-00085O-LS; Mon, 30 Jul 2018 15:34:48 +0200
Date:   Mon, 30 Jul 2018 15:34:48 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        f.fainelli@gmail.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, allan.nielsen@microsemi.com,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 07/10] dt-bindings: phy: add DT binding for Microsemi
 Ocelot SerDes muxing
Message-ID: <20180730133448.GD13198@lunn.ch>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
 <cd75c96640cc7fe306ee355acb1db85adb5b796f.1532954208.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd75c96640cc7fe306ee355acb1db85adb5b796f.1532954208.git-series.quentin.schulz@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65253
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

> +Required properties:
> +
> +- compatible: should be "mscc,vsc7514-serdes"
> +- #phy-cells : from the generic phy bindings, must be 3. The first number
> +               defines the kind of Serdes (1 for SERDES1G_X, 6 for
> +	       SERDES6G_X), the second defines the macros in the specified
> +	       kind of Serdes (X for SERDES1G_X or SERDES6G_X) and the
> +	       last one defines the input port to use for a given SerDes
> +	       macro,

It looks like there are some space vs tab issues here.

> +
> +Example:
> +
> +	serdes: serdes {

Maybe this should be serdes-mux? The SERDES itself should have some
registers somewhere. If you ever decide to make use of phylink,
e.g. to support SFP, you are going to need to know if the SERDES is
up. So you might need to add the actual SERDES device, in addition to
the mux for the SERDES.

> +		compatible = "mscc,vsc7514-serdes";
> +		#phy-cells = <3>;
> +	};
