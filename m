Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Nov 2010 11:28:39 +0100 (CET)
Received: from mail-out.m-online.net ([212.18.0.9]:37854 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491178Ab0KSK2g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Nov 2010 11:28:36 +0100
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
        by mail-out.m-online.net (Postfix) with ESMTP id 1746C1C089C9;
        Fri, 19 Nov 2010 11:28:30 +0100 (CET)
X-Auth-Info: JHjCkpAFC7/MXyyWJRH+e2qIAfE/frdUMdUZRTclbK8=
Received: from lancy.mylan.de (p4FE63FAF.dip.t-dialin.net [79.230.63.175])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mnet-online.de (Postfix) with ESMTPSA id 8F0C61C00436;
        Fri, 19 Nov 2010 11:28:30 +0100 (CET)
Message-ID: <4CE65199.7030007@grandegger.com>
Date:   Fri, 19 Nov 2010 11:29:45 +0100
From:   Wolfgang Grandegger <wg@grandegger.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     Linux-MIPS <linux-mips@linux-mips.org>, Netdev@vger.kernel.org
Subject: Re: alchemy/gpr: au1000_eth regression with v2.6.37rc2
References: <4CE58593.50509@grandegger.com> <201011182330.08488.florian@openwrt.org>
In-Reply-To: <201011182330.08488.florian@openwrt.org>
X-Enigmail-Version: 1.0.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <wg@grandegger.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wg@grandegger.com
Precedence: bulk
X-list: linux-mips

Hello Florian,

On 11/18/2010 11:30 PM, Florian Fainelli wrote:
> Hello Wolfgang,
> 
> Le Thursday 18 November 2010 20:59:15, Wolfgang Grandegger a écrit :
>> Hello,
>>
>> I just realized that the v2.6.37-rc2 kernel does not boot any more on
>> the Alchemy GPR board. It works fine with v2.6.36. It hangs in the
>> probe function of the au1000_eth driver when probing the second
>> ethernet port (eth1):
>>
>>   au1000_eth_mii: probed
>>   au1000-eth au1000-eth.0: (unregistered net_device): attached PHY driver
>> [Generic PHY] (mii_bus:phy_addr=0:00, irq=-1) au1000-eth au1000-eth.0:
>> eth0: Au1xx0 Ethernet found at 0x10500000, irq 35 au1000_eth: au1000_eth
>> version 1.7 Pete Popov <ppopov@embeddedalley.com> ... hangs ...
>>
>> Similar messages should follow for eth1. I narrowed down (bisect'ed) the
>> problem to commit:
>>
>>   commit d0e7cb5d401695809ba8c980124ab1d8c66efc8b
>>   Author: Florian Fainelli <florian@openwrt.org>
>>   Date:   Wed Sep 8 11:15:13 2010 +0000
>>
>>     au1000-eth: remove volatiles, switch to I/O accessors
>>
>>     Remove all the volatile keywords where they were used, switch to using
>> the proper readl/writel accessors.
>>
>>     Signed-off-by: Florian Fainelli <florian@openwrt.org>
>>     Signed-off-by: David S. Miller <davem@davemloft.net>
>>
>> The kernel actually hangs when accessing "&aup->mac->mii_control" in
>> au1000_mdio_read(), but only for eth1. Any idea what does go wrong?
> 
> I do not understand so far while it hangs only for eth1. My device only has 
> one ethernet MAC, so I could not notice the problem. Looking at this close, 
> there are a couple of u32 const* usages in au1000_mdio_{read,write} which are 
> looking wrong to me now. Can you try to remove these?

That did not help.

>> In principle, I do not want to access the MII regs of the MAC because
>> eth0 and eth1 are connected to switches. But that's not possible, even
>> with "aup->phy_static_config=1" and "aup->phy_addr=0".
> 
> If you think this is another issue, I will fix it in another patch.

Accessing the MII registers of the MAC should not hang the system even
if I do not need to. First I want to  understand why. Looks like a wired
optimizer issue.

BTW: why do you use readl() and writel() instead of the usual au_readl()
and au_writel() to access memory mapped cpu registers? It did not help,
anyway.

Wolfgang
