Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jul 2018 20:10:51 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:55469 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993029AbeG2SKqTh6o4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 29 Jul 2018 20:10:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=8c4c+ASXPBF/kwOziqfbWWj4L2p78iORP8/g4M1hRY0=;
        b=ah8Hd+ZmfOanFoll4LeQ6AU/G/9Ksc1izWfLvsCuzvI1FKuq9zvt1IWCvz19oeiLgVJor/A4vYiRtmRMSJbjEp/zrlFo16IomkvtJYMILHRBaTjHYP1Drds4ZKStiRiHTRCpvGPECMmmXzCe3r6mia44F93uxkivrcxq3zvpWvo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fjq9D-00043B-AW; Sun, 29 Jul 2018 20:10:27 +0200
Date:   Sun, 29 Jul 2018 20:10:27 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com
Subject: Re: [PATCH 3/4] net: lantiq: Add Lantiq / Intel vrx200 Ethernet
 driver
Message-ID: <20180729181027.GA15150@lunn.ch>
References: <20180721191358.13952-1-hauke@hauke-m.de>
 <20180721191358.13952-4-hauke@hauke-m.de>
 <20180725152857.GB16819@lunn.ch>
 <0ba31982-1657-aea8-42bc-0ea838621256@hauke-m.de>
 <20180729155106.GB13198@lunn.ch>
 <18f8bbd5-0623-7bed-c96a-c7b10f1e2cd2@hauke-m.de>
 <20180729164052.GA14420@lunn.ch>
 <7c866f1b-70f3-8221-debd-be1bd0b6f7dd@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c866f1b-70f3-8221-debd-be1bd0b6f7dd@hauke-m.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65234
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

> The embedded PHYs are only connected to the switch in this SoC and on
> all other SoCs from this line I am aware of.

Hi Hauke

O.K, then it makes sense to have it part of the switch driver.

> The firmware is 64KBytes big and we have to load that into continuous
> memory which is then used by the PHY itself. When we are late in the
> boot process we could run into memory problems, most devices have 64MB
> or 128MB of RAM.

You might want to look at using CMA. I've never used it myself, so
cannot help much.

> How should the device tree binding should look like?
> 
> Should I create an extra sub node:
> 
> gswip: gswip@E108000 {
> 	#address-cells = <1>;
> 	#size-cells = <0>;
> 	compatible = "lantiq,xrx200-gswip";
> 	reg = <	0xE108000 0x3000 /* switch */
> 		0xE10B100 0x70 /* mdio */
> 		0xE10B1D8 0x30 /* mii */
> 		>;
> 	dsa,member = <0 0>;
> 
> 	ports {
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 
> 		port@0 {
> 			reg = <0>;
> 			label = "lan3";
> 			phy-mode = "rgmii";
> 			phy-handle = <&phy0>;
> 		};
> 		....
> 	};
> 
> 	mdio@0 {
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 		compatible = "lantiq,xrx200-mdio";
> 		reg = <0>;
> 
> 		phy0: ethernet-phy@0 {
> 			reg = <0x0>;
> 		};
> 		....
> 	};
> 
> 	# this would be the new part
> 	phys {
> 		gphy0: gphy@20 {
> 			compatible = "lantiq,xrx200a2x-gphy";

It would be good to make it clear this is for firmware download. So
scatter "firmware" or "fw" in some of these names. What we don't want
is a mix up with phy's within the mdio subtree. Otherwise this looks
good. But you should cross post the device tree binding to the device
tree mailing list.

	Andrew
