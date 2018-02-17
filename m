Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Feb 2018 23:32:45 +0100 (CET)
Received: from vps0.lunn.ch ([185.16.172.187]:35777 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994647AbeBQWchPEelS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 17 Feb 2018 23:32:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=56kWN/Ik+lSIDkAUPfxMjy1UCPG2wFWZE44ChYN7x6w=;
        b=SCqZQs8p1CxJeANN9lnIM/qcd9fAr84IC8bW8tQCIt1S0ofLnjo9yKAVtIynFaE83BchfqChjouaM0mY+Tr8Lgmm6khB2z4LMJLU3NG6ruNOPBs/LhX5zUWBOQgR47xGFqTp3PY1COCY13RjJ6Q6CkYbJ3/VIleq5Gfd5dcktiU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1enB1x-0006CZ-BM; Sat, 17 Feb 2018 23:32:29 +0100
Date:   Sat, 17 Feb 2018 23:32:29 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Paul Burton <paul.burton@mips.com>
Cc:     netdev@vger.kernel.org, Hassan Naveed <hassan.naveed@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-mips@linux-mips.org, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 03/14] dt-bindings: net: Document Intel pch_gbe binding
Message-ID: <20180217223229.GC21315@lunn.ch>
References: <20180217201037.3006-1-paul.burton@mips.com>
 <20180217201037.3006-4-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180217201037.3006-4-paul.burton@mips.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62601
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

Hi Paul

Please see Documentation/devicetree/bindings/net/phy.txt. In
particular:

reset-gpios: The GPIO phandle and specifier for the PHY reset signal.

You should be conforming to the existing binding.

   Andrew
