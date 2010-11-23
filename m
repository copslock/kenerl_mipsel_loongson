Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2010 16:34:22 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:54088 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491914Ab0KWPeP convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Nov 2010 16:34:15 +0100
Received: by wwb29 with SMTP id 29so1093224wwb.24
        for <linux-mips@linux-mips.org>; Tue, 23 Nov 2010 07:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=LBRsukrIbSLC69F+rCMbK0bRdqGGhcQMP5Mkj8hT1M0=;
        b=YcFkpnZ0MS9BcsJccuHOWxLBMmCdH+jKjR5jQqDrIaYZa72ZrdvjA/NAeiauMK41Hi
         lqgiuqvVW7mH5q8zyql9KdjqTS3tZ3JCapm8283Pwh7qQQ2u2b+Yinz/d8JHFTaq54uK
         oydVNCiWGIVgXl6pYaEOn604PQufGUdPyddPY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=dMgIImK+VsDgaQWJE9tcYbDxT+kzdj/nGL7Veb7cDvk9nEzLpNCOHihnZprL8uAB8q
         aC68CLUqYP01lO+qOu7NyxjAA7QtKdBCPvlQPF1PGsftLf0RWGAglbcQIKphamfm/UOg
         5ihUkb4SU1VI8R+oRj+IhnJQC5COmqReZkE6k=
Received: by 10.216.35.133 with SMTP id u5mr6285861wea.72.1290526449764;
        Tue, 23 Nov 2010 07:34:09 -0800 (PST)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id w29sm2920515weq.19.2010.11.23.07.33.59
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 07:34:03 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: alchemy/gpr: au1000_eth regression with v2.6.37rc2
Date:   Tue, 23 Nov 2010 16:33:49 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.35-22-server; KDE/4.5.1; x86_64; ; )
Cc:     "Linux-MIPS" <linux-mips@linux-mips.org>, Netdev@vger.kernel.org
References: <4CE58593.50509@grandegger.com> <201011191146.01454.florian@openwrt.org> <4CEBD751.7090807@grandegger.com>
In-Reply-To: <4CEBD751.7090807@grandegger.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <201011231633.50040.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hello Wolfgang,

On Tuesday 23 November 2010 16:01:37 Wolfgang Grandegger wrote:
> Hi Florian,
> 
> On 11/19/2010 11:46 AM, Florian Fainelli wrote:
> > Hello Wolfgang,
> > 
> > On Friday 19 November 2010 11:29:45 Wolfgang Grandegger wrote:
> >> Hello Florian,
> >> 
> >> On 11/18/2010 11:30 PM, Florian Fainelli wrote:
> >>> Hello Wolfgang,
> >>> 
> >>> Le Thursday 18 November 2010 20:59:15, Wolfgang Grandegger a écrit :
> >>>> Hello,
> >>>> 
> >>>> I just realized that the v2.6.37-rc2 kernel does not boot any more on
> >>>> the Alchemy GPR board. It works fine with v2.6.36. It hangs in the
> >>>> probe function of the au1000_eth driver when probing the second
> >>>> 
> >>>> ethernet port (eth1):
> >>>>   au1000_eth_mii: probed
> >>>>   au1000-eth au1000-eth.0: (unregistered net_device): attached PHY
> >>>>   driver
> >>>> 
> >>>> [Generic PHY] (mii_bus:phy_addr=0:00, irq=-1) au1000-eth au1000-eth.0:
> >>>> eth0: Au1xx0 Ethernet found at 0x10500000, irq 35 au1000_eth:
> >>>> au1000_eth version 1.7 Pete Popov <ppopov@embeddedalley.com> ...
> >>>> hangs ...
> >>>> 
> >>>> Similar messages should follow for eth1. I narrowed down (bisect'ed)
> >>>> the
> >>>> 
> >>>> problem to commit:
> >>>>   commit d0e7cb5d401695809ba8c980124ab1d8c66efc8b
> >>>>   Author: Florian Fainelli <florian@openwrt.org>
> >>>>   Date:   Wed Sep 8 11:15:13 2010 +0000
> >>>>   
> >>>>     au1000-eth: remove volatiles, switch to I/O accessors
> >>>>     
> >>>>     Remove all the volatile keywords where they were used, switch to
> >>>>     using
> >>>> 
> >>>> the proper readl/writel accessors.
> >>>> 
> >>>>     Signed-off-by: Florian Fainelli <florian@openwrt.org>
> >>>>     Signed-off-by: David S. Miller <davem@davemloft.net>
> >>>> 
> >>>> The kernel actually hangs when accessing "&aup->mac->mii_control" in
> >>>> au1000_mdio_read(), but only for eth1. Any idea what does go wrong?
> >>> 
> >>> I do not understand so far while it hangs only for eth1. My device only
> >>> has one ethernet MAC, so I could not notice the problem. Looking at
> >>> this close, there are a couple of u32 const* usages in
> >>> au1000_mdio_{read,write} which are looking wrong to me now. Can you try
> >>> to remove these?
> >> 
> >> That did not help.
> > 
> > I suspected it, but thanks for the confirmation.
> > 
> >>>> In principle, I do not want to access the MII regs of the MAC because
> >>>> eth0 and eth1 are connected to switches. But that's not possible, even
> >>>> with "aup->phy_static_config=1" and "aup->phy_addr=0".
> >>> 
> >>> If you think this is another issue, I will fix it in another patch.
> >> 
> >> Accessing the MII registers of the MAC should not hang the system even
> >> if I do not need to. First I want to  understand why. Looks like a wired
> >> optimizer issue.
> > 
> > I definitively agree, furthermore since there is a timeout for read and
> > write operations. I will look at the assembly and see if I can see
> > anything different.
> 
> The attached patch fixes the issue. It's caused by a simple porting
> error. I'm going to prepare a proper patch later today.

Nasty and simple enough not to be noticed at compile time. Thanks for 
debugging this. Feel free to add my:

Acked-by: Florian Fainelli <florian@openwrt.org>
--
Florian
