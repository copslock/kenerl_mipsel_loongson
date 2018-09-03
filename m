Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2018 15:35:25 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:56556 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993066AbeICNecRVvYP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 3 Sep 2018 15:34:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=0ismcyFEdKy2NtuNHu9oJzlL1USrKbxK6NkE/nWJxBE=;
        b=udWYhFwQN8P2OkQ8ek3xp+YbFTHCMTj/D6cw5gXC0kKvGPNT55MvQwA7m8p4sYY3kDIgM/fV7MbpGETjEsTY+sYWzdbY1omHUasGkQy/TMqKmlOze2aY9R34LWApDF2YQXUdKIcQYam4x5pmY6QXHEqXeHXT8dq64xoTin7EE44=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fwozf-0001az-CR; Mon, 03 Sep 2018 15:34:15 +0200
Date:   Mon, 3 Sep 2018 15:34:15 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        f.fainelli@gmail.com, allan.nielsen@microchip.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v2 00/11] mscc: ocelot: add support for SerDes muxing
 configuration
Message-ID: <20180903133415.GF4445@lunn.ch>
References: <20180903093308.24366-1-quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903093308.24366-1-quentin.schulz@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65892
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

> I suggest patches 1 and 8 go through MIPS tree, 2 to 5 and 11 go through
> net while the others (6, 7, 9 and 10) go through the generic PHY subsystem.

Hi Quentin

Are you expecting merge conflicts? If not, it might be simpler to gets
ACKs from each maintainer, and then merge it though one tree.

     Andrew
