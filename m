Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jul 2018 16:03:21 +0200 (CEST)
Received: from mx1.mailbox.org ([80.241.60.212]:59880 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991063AbeG2ODSdHvu8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 29 Jul 2018 16:03:18 +0200
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 0FEEF484A3;
        Sun, 29 Jul 2018 16:03:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id AlDEwqjvGsTU; Sun, 29 Jul 2018 16:03:11 +0200 (CEST)
Subject: Re: [PATCH 3/4] net: lantiq: Add Lantiq / Intel vrx200 Ethernet
 driver
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com
References: <20180721191358.13952-1-hauke@hauke-m.de>
 <20180721191358.13952-4-hauke@hauke-m.de> <20180725152857.GB16819@lunn.ch>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <0ba31982-1657-aea8-42bc-0ea838621256@hauke-m.de>
Date:   Sun, 29 Jul 2018 16:03:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180725152857.GB16819@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65227
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

On 07/25/2018 05:28 PM, Andrew Lunn wrote:
>> +	/* Make sure the firmware of the embedded GPHY is loaded before,
>> +	 * otherwise they will not be detectable on the MDIO bus.
>> +	 */
>> +	of_for_each_phandle(&it, err, np, "lantiq,phys", NULL, 0) {
>> +		phy_np = it.node;
>> +		if (phy_np) {
>> +			struct platform_device *phy = of_find_device_by_node(phy_np);
>> +
>> +			of_node_put(phy_np);
>> +			if (!platform_get_drvdata(phy))
>> +				return -EPROBE_DEFER;
>> +		}
>> +	}
> 
> Is there a device tree binding document for this somewhere?
> 
>    Andrew
> 

No, but I will create one.

I am also not sure iof this is the correct way of doing this.

We first have to load the FW into the Ethernet PHY though some generic
SoC registers and then we can find it normally on the MDIO bus and
interact with it like an external PHY on the MDIO bus.

Hauke
