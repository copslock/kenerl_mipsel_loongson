Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jul 2018 19:44:33 +0200 (CEST)
Received: from mx1.mailbox.org ([80.241.60.212]:29974 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993016AbeG2Ro2GmIL4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 29 Jul 2018 19:44:28 +0200
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 9716248245;
        Sun, 29 Jul 2018 19:44:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id ZetUls3sK6Ed; Sun, 29 Jul 2018 19:44:21 +0200 (CEST)
Subject: Re: [PATCH 3/4] net: lantiq: Add Lantiq / Intel vrx200 Ethernet
 driver
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com
References: <20180721191358.13952-1-hauke@hauke-m.de>
 <20180721191358.13952-4-hauke@hauke-m.de> <20180725152857.GB16819@lunn.ch>
 <0ba31982-1657-aea8-42bc-0ea838621256@hauke-m.de>
 <20180729155106.GB13198@lunn.ch>
 <18f8bbd5-0623-7bed-c96a-c7b10f1e2cd2@hauke-m.de>
 <20180729164052.GA14420@lunn.ch>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <7c866f1b-70f3-8221-debd-be1bd0b6f7dd@hauke-m.de>
Date:   Sun, 29 Jul 2018 19:44:19 +0200
MIME-Version: 1.0
In-Reply-To: <20180729164052.GA14420@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 07/29/2018 06:40 PM, Andrew Lunn wrote:
>> I am thinking about merging this into the switch driver, then we do not
>> have to configure the dependency any more.
> 
> Hi Hauke
> 
> Are there any PHYs which are not part of the switch?

The embedded PHYs are only connected to the switch in this SoC and on
all other SoCs from this line I am aware of.

> Making it part of the switch driver would make sense. Are there any
> backwards compatibility issues? I don't actually see any boards in
> mailine using the compatible strings.

There is currently no device tree file added for any board in mainline.
I would then prefer to add this to the switch driver.

I have to make sure the firmware gets loaded before we scan the MDIO
bus. When no FW is loaded they do not get detected.

More recent SoC have more embedded Ethernet PHYs so I would like to
support a variable number of these PHYs.

The firmware is 64KBytes big and we have to load that into continuous
memory which is then used by the PHY itself. When we are late in the
boot process we could run into memory problems, most devices have 64MB
or 128MB of RAM.

How should the device tree binding should look like?

Should I create an extra sub node:

gswip: gswip@E108000 {
	#address-cells = <1>;
	#size-cells = <0>;
	compatible = "lantiq,xrx200-gswip";
	reg = <	0xE108000 0x3000 /* switch */
		0xE10B100 0x70 /* mdio */
		0xE10B1D8 0x30 /* mii */
		>;
	dsa,member = <0 0>;

	ports {
		#address-cells = <1>;
		#size-cells = <0>;

		port@0 {
			reg = <0>;
			label = "lan3";
			phy-mode = "rgmii";
			phy-handle = <&phy0>;
		};
		....
	};

	mdio@0 {
		#address-cells = <1>;
		#size-cells = <0>;
		compatible = "lantiq,xrx200-mdio";
		reg = <0>;

		phy0: ethernet-phy@0 {
			reg = <0x0>;
		};
		....
	};

	# this would be the new part
	phys {
		gphy0: gphy@20 {
			compatible = "lantiq,xrx200a2x-gphy";
			reg = <0x20 0x4>;
			rcu = <&rcu0>;

			resets = <&reset0 31 30>, <&reset1 7 7>;
			reset-names = "gphy", "gphy2";
			clocks = <&pmu0 XRX200_PMU_GATE_GPHY>;
			lantiq,gphy-mode = <GPHY_MODE_GE>;
		};
		....
	};
};

> Another option would be to write an independent mdio driver, and make
> firmware download part of that. That gives the advantage of supporting
> PHYs which are not part of the switch.
> 
>      Andrew
> 
