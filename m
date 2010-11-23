Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2010 16:00:30 +0100 (CET)
Received: from mail-out.m-online.net ([212.18.0.10]:40970 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491914Ab0KWPAW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Nov 2010 16:00:22 +0100
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
        by mail-out.m-online.net (Postfix) with ESMTP id 1CCAE186DECA;
        Tue, 23 Nov 2010 16:00:20 +0100 (CET)
X-Auth-Info: tAqK5jgpP1sZqrDOl7Xf7VkI4rmaPnN3sPn2j2EbyJU=
Received: from lancy.mylan.de (p4FF05130.dip.t-dialin.net [79.240.81.48])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mnet-online.de (Postfix) with ESMTPSA id 77D191C001E1;
        Tue, 23 Nov 2010 16:00:20 +0100 (CET)
Message-ID: <4CEBD751.7090807@grandegger.com>
Date:   Tue, 23 Nov 2010 16:01:37 +0100
From:   Wolfgang Grandegger <wg@grandegger.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     Linux-MIPS <linux-mips@linux-mips.org>, Netdev@vger.kernel.org
Subject: Re: alchemy/gpr: au1000_eth regression with v2.6.37rc2
References: <4CE58593.50509@grandegger.com> <201011182330.08488.florian@openwrt.org> <4CE65199.7030007@grandegger.com> <201011191146.01454.florian@openwrt.org>
In-Reply-To: <201011191146.01454.florian@openwrt.org>
X-Enigmail-Version: 1.0.1
Content-Type: multipart/mixed;
 boundary="------------080703020109020809040101"
Return-Path: <wg@grandegger.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wg@grandegger.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------080703020109020809040101
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Hi Florian,

On 11/19/2010 11:46 AM, Florian Fainelli wrote:
> Hello Wolfgang,
> 
> On Friday 19 November 2010 11:29:45 Wolfgang Grandegger wrote:
>> Hello Florian,
>>
>> On 11/18/2010 11:30 PM, Florian Fainelli wrote:
>>> Hello Wolfgang,
>>>
>>> Le Thursday 18 November 2010 20:59:15, Wolfgang Grandegger a écrit :
>>>> Hello,
>>>>
>>>> I just realized that the v2.6.37-rc2 kernel does not boot any more on
>>>> the Alchemy GPR board. It works fine with v2.6.36. It hangs in the
>>>> probe function of the au1000_eth driver when probing the second
>>>>
>>>> ethernet port (eth1):
>>>>   au1000_eth_mii: probed
>>>>   au1000-eth au1000-eth.0: (unregistered net_device): attached PHY
>>>>   driver
>>>>
>>>> [Generic PHY] (mii_bus:phy_addr=0:00, irq=-1) au1000-eth au1000-eth.0:
>>>> eth0: Au1xx0 Ethernet found at 0x10500000, irq 35 au1000_eth: au1000_eth
>>>> version 1.7 Pete Popov <ppopov@embeddedalley.com> ... hangs ...
>>>>
>>>> Similar messages should follow for eth1. I narrowed down (bisect'ed) the
>>>>
>>>> problem to commit:
>>>>   commit d0e7cb5d401695809ba8c980124ab1d8c66efc8b
>>>>   Author: Florian Fainelli <florian@openwrt.org>
>>>>   Date:   Wed Sep 8 11:15:13 2010 +0000
>>>>   
>>>>     au1000-eth: remove volatiles, switch to I/O accessors
>>>>     
>>>>     Remove all the volatile keywords where they were used, switch to
>>>>     using
>>>>
>>>> the proper readl/writel accessors.
>>>>
>>>>     Signed-off-by: Florian Fainelli <florian@openwrt.org>
>>>>     Signed-off-by: David S. Miller <davem@davemloft.net>
>>>>
>>>> The kernel actually hangs when accessing "&aup->mac->mii_control" in
>>>> au1000_mdio_read(), but only for eth1. Any idea what does go wrong?
>>>
>>> I do not understand so far while it hangs only for eth1. My device only
>>> has one ethernet MAC, so I could not notice the problem. Looking at this
>>> close, there are a couple of u32 const* usages in
>>> au1000_mdio_{read,write} which are looking wrong to me now. Can you try
>>> to remove these?
>>
>> That did not help.
> 
> I suspected it, but thanks for the confirmation.
> 
>>
>>>> In principle, I do not want to access the MII regs of the MAC because
>>>> eth0 and eth1 are connected to switches. But that's not possible, even
>>>> with "aup->phy_static_config=1" and "aup->phy_addr=0".
>>>
>>> If you think this is another issue, I will fix it in another patch.
>>
>> Accessing the MII registers of the MAC should not hang the system even
>> if I do not need to. First I want to  understand why. Looks like a wired
>> optimizer issue.
> 
> I definitively agree, furthermore since there is a timeout for read and write 
> operations. I will look at the assembly and see if I can see anything 
> different.

The attached patch fixes the issue. It's caused by a simple porting
error. I'm going to prepare a proper patch later today.

Wolfgang.



--------------080703020109020809040101
Content-Type: text/x-diff;
 name="au1000-eth-mac-enable.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="au1000-eth-mac-enable.patch"

diff --git a/drivers/net/au1000_eth.c b/drivers/net/au1000_eth.c
index 43489f8..53eff9b 100644
--- a/drivers/net/au1000_eth.c
+++ b/drivers/net/au1000_eth.c
@@ -155,10 +155,10 @@ static void au1000_enable_mac(struct net_device *dev, int force_reset)
 	spin_lock_irqsave(&aup->lock, flags);
 
 	if (force_reset || (!aup->mac_enabled)) {
-		writel(MAC_EN_CLOCK_ENABLE, &aup->enable);
+		writel(MAC_EN_CLOCK_ENABLE, aup->enable);
 		au_sync_delay(2);
 		writel((MAC_EN_RESET0 | MAC_EN_RESET1 | MAC_EN_RESET2
-				| MAC_EN_CLOCK_ENABLE), &aup->enable);
+				| MAC_EN_CLOCK_ENABLE), aup->enable);
 		au_sync_delay(2);
 
 		aup->mac_enabled = 1;
@@ -503,9 +503,9 @@ static void au1000_reset_mac_unlocked(struct net_device *dev)
 
 	au1000_hard_stop(dev);
 
-	writel(MAC_EN_CLOCK_ENABLE, &aup->enable);
+	writel(MAC_EN_CLOCK_ENABLE, aup->enable);
 	au_sync_delay(2);
-	writel(0, &aup->enable);
+	writel(0, aup->enable);
 	au_sync_delay(2);
 
 	aup->tx_full = 0;
@@ -1119,7 +1119,7 @@ static int __devinit au1000_probe(struct platform_device *pdev)
 	/* set a random MAC now in case platform_data doesn't provide one */
 	random_ether_addr(dev->dev_addr);
 
-	writel(0, &aup->enable);
+	writel(0, aup->enable);
 	aup->mac_enabled = 0;
 
 	pd = pdev->dev.platform_data;

--------------080703020109020809040101--
