Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Sep 2018 20:13:13 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:55405 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992479AbeIASNH0xHRl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 1 Sep 2018 20:13:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=aNGfvZwqV3ELMyXaH2tqw9GlnEqnE9YDcuWmuDgS598=;
        b=aInaxY2fXecgPX/7subRS7wBGHIMM0wrCPvZP3tNMTEwCkJZcMKbDbRRoHfAjnXI9zSsdgA8VoiYZn7KRPDTe93JRG6qjRsWRWE86OjuXYIcAkJscHeAYqtKfk+2WvTbfWY03vp1QByz3RmKXFoCCsWtdFRGNIjU/vZlxnoJrm8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fwAOD-00023t-Gf; Sat, 01 Sep 2018 20:12:53 +0200
Date:   Sat, 1 Sep 2018 20:12:53 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 net-next 5/7] net: lantiq: Add Lantiq / Intel VRX200
 Ethernet driver
Message-ID: <20180901181253.GD6305@lunn.ch>
References: <20180901114535.9070-1-hauke@hauke-m.de>
 <20180901120427.9983-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180901120427.9983-1-hauke@hauke-m.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65846
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

> +struct xrx200_priv {
> +	struct net_device_stats stats;

net_device has a stats structure in it. Please use that one.

Otherwise, this looks good.

	Andrew
