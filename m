Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jul 2018 17:53:55 +0200 (CEST)
Received: from mx1.mailbox.org ([80.241.60.212]:11806 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991063AbeG2PxvYZKnM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 29 Jul 2018 17:53:51 +0200
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id CC80E48326;
        Sun, 29 Jul 2018 17:53:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id Pl9DQT1iFrI3; Sun, 29 Jul 2018 17:53:44 +0200 (CEST)
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
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <18f8bbd5-0623-7bed-c96a-c7b10f1e2cd2@hauke-m.de>
Date:   Sun, 29 Jul 2018 17:53:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180729155106.GB13198@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65229
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

On 07/29/2018 05:51 PM, Andrew Lunn wrote:
> On Sun, Jul 29, 2018 at 04:03:10PM +0200, Hauke Mehrtens wrote:
>> On 07/25/2018 05:28 PM, Andrew Lunn wrote:
>>>> +	/* Make sure the firmware of the embedded GPHY is loaded before,
>>>> +	 * otherwise they will not be detectable on the MDIO bus.
>>>> +	 */
>>>> +	of_for_each_phandle(&it, err, np, "lantiq,phys", NULL, 0) {
>>>> +		phy_np = it.node;
>>>> +		if (phy_np) {
>>>> +			struct platform_device *phy = of_find_device_by_node(phy_np);
>>>> +
>>>> +			of_node_put(phy_np);
>>>> +			if (!platform_get_drvdata(phy))
>>>> +				return -EPROBE_DEFER;
>>>> +		}
>>>> +	}
>>>
>>> Is there a device tree binding document for this somewhere?
>>>
>>>    Andrew
>>>
>>
>> No, but I will create one.
>>
>> I am also not sure iof this is the correct way of doing this.
>>
>> We first have to load the FW into the Ethernet PHY though some generic
>> SoC registers and then we can find it normally on the MDIO bus and
>> interact with it like an external PHY on the MDIO bus.
> 
> Hi Hauke
> 
> It look sensible so far, but it would be good to post the PHY firmware
> download code as well. Lets see the big picture, then we can decide if
> there is a better way.

Hi Andrew,

It is already in the kernel tree and can be found here:
https://elixir.bootlin.com/linux/v4.18-rc6/source/drivers/soc/lantiq/gphy.c

I am thinking about merging this into the switch driver, then we do not
have to configure the dependency any more.

Hauke
