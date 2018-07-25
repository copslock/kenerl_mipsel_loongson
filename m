Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2018 17:29:23 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:51496 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991947AbeGYP3SqWVXl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Jul 2018 17:29:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=nH9S0LjWh4oTkmn63aZ2ajZQBlwJkJU0JRfUHqM8uz8=;
        b=dcO185ZM06TNpCfDFjVVYM69i5B2G4ZB9fl61+xnNJObFHMGEzaQKFC4iKDpow5kU0InY1oKtq6poAER+jh9FFqWCq/IczyH6vc5PtzYrTC/Z2Dkq7l6+xRgLTitATnnRRdkRxb2RMJLEStWZ31R2iaEuTFELhtGe2I2C9axxDo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fiLij-0004aR-RZ; Wed, 25 Jul 2018 17:28:57 +0200
Date:   Wed, 25 Jul 2018 17:28:57 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com
Subject: Re: [PATCH 3/4] net: lantiq: Add Lantiq / Intel vrx200 Ethernet
 driver
Message-ID: <20180725152857.GB16819@lunn.ch>
References: <20180721191358.13952-1-hauke@hauke-m.de>
 <20180721191358.13952-4-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180721191358.13952-4-hauke@hauke-m.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65142
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

> +	/* Make sure the firmware of the embedded GPHY is loaded before,
> +	 * otherwise they will not be detectable on the MDIO bus.
> +	 */
> +	of_for_each_phandle(&it, err, np, "lantiq,phys", NULL, 0) {
> +		phy_np = it.node;
> +		if (phy_np) {
> +			struct platform_device *phy = of_find_device_by_node(phy_np);
> +
> +			of_node_put(phy_np);
> +			if (!platform_get_drvdata(phy))
> +				return -EPROBE_DEFER;
> +		}
> +	}

Is there a device tree binding document for this somewhere?

   Andrew
