Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2018 00:05:44 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:35669 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992375AbeIJWFk5w25f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Sep 2018 00:05:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=822YwDsTlqPdee9CwkIBgI0TF7qYgnA/UIJNLEV3X48=;
        b=OzSmjm4TwWA4j9nu7+jRD61vVXewuLIDmHTTEZFSJXltiCzUtzkpHIgP7NuJkYha7WYhgrEopWY9p/T6kPKnGXMbGf2Ebs+0xX63mDWBCP+DGjScHd8tFPyEDencoNsVrrU2G557yBBrGksBXUVTVcArvmqihyqPtxmX8ThngJs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fzUJ2-0004IY-Gv; Tue, 11 Sep 2018 00:05:16 +0200
Date:   Tue, 11 Sep 2018 00:05:16 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Rob Herring <robh@kernel.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, davem@davemloft.net,
        netdev@vger.kernel.org, vivien.didelot@savoirfairelinux.com,
        f.fainelli@gmail.com, john@phrozen.org, linux-mips@linux-mips.org,
        dev@kresin.me, hauke.mehrtens@intel.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 net-next 5/6] dt-bindings: net: dsa: Add
 lantiq,xrx200-gswip DT bindings
Message-ID: <20180910220516.GA16024@lunn.ch>
References: <20180909201647.32727-1-hauke@hauke-m.d>
 <20180909202027.411-1-hauke@hauke-m.de>
 <20180910220119.GA32582@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910220119.GA32582@bogus>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66191
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

> > +See Documentation/devicetree/bindings/net/dsa/dsa.txt for a list of
> > +additional required and optional properties.
> > +
> > +

snip

> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> > +	compatible = "lantiq,xrx200-gswip";
> > +	reg = <	0xE108000 0x3000 /* switch */
> > +		0xE10B100 0x70 /* mdio */
> > +		0xE10B1D8 0x30 /* mii */
> > +		>;
> > +	dsa,member = <0 0>;
> 
> Not documented.

Hi Rob

It is documented in Documentation/devicetree/bindings/net/dsa/dsa.txt
referenced above.

	   Andrew
