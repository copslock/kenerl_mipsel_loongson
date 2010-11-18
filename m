Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Nov 2010 23:28:08 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:48685 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490979Ab0KRW2F convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Nov 2010 23:28:05 +0100
Received: by wyf22 with SMTP id 22so3828452wyf.36
        for <linux-mips@linux-mips.org>; Thu, 18 Nov 2010 14:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=eaF+hH9d4AqKT9AZZdB4z0IVuVxwWNp1wfWdGIKkc3A=;
        b=fH/AY23GeWRVKUstdPkGuGRAHUOdvouJ3PdFNfJnf9w+7aVjW/x4vtNN9m9UCzgR4R
         PpGD5EalmM9UXIelCfHypynBXMRzCf3gxPdOuzM0tOrIOD7wG4x1iOxxIEL252SaDbrE
         71+XiJKgxFnCrmOVbhAwGoL3Aefr7fKQuODk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=Ob5ptQqLciYNdiP0hTvEOzIh3DXESZvUeFdeHnMSqcs+kLrB/n5b6AtL2P3KdYUsbz
         O/E3ZP52G2i5jitPH4R/CZLhscHyItvJUafVgw5EgHkWfLn/VpSPd81y09yos9WDJDGZ
         CeIrOZKnbhV9IA4j/JKATvrj4q0Fcvmsn5D1g=
Received: by 10.216.30.67 with SMTP id j45mr176320wea.99.1290119279796;
        Thu, 18 Nov 2010 14:27:59 -0800 (PST)
Received: from lenovo.localnet (fbx.mimichou.net [82.236.225.16])
        by mx.google.com with ESMTPS id x59sm480564weq.38.2010.11.18.14.27.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Nov 2010 14:27:58 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Reply-To: Florian Fainelli <florian@openwrt.org>
To:     Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: alchemy/gpr: au1000_eth regression with v2.6.37rc2
Date:   Thu, 18 Nov 2010 23:30:07 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.36-trunk-amd64; KDE/4.4.5; x86_64; ; )
Cc:     "Linux-MIPS" <linux-mips@linux-mips.org>, Netdev@vger.kernel.org
References: <4CE58593.50509@grandegger.com>
In-Reply-To: <4CE58593.50509@grandegger.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <201011182330.08488.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hello Wolfgang,

Le Thursday 18 November 2010 20:59:15, Wolfgang Grandegger a écrit :
> Hello,
> 
> I just realized that the v2.6.37-rc2 kernel does not boot any more on
> the Alchemy GPR board. It works fine with v2.6.36. It hangs in the
> probe function of the au1000_eth driver when probing the second
> ethernet port (eth1):
> 
>   au1000_eth_mii: probed
>   au1000-eth au1000-eth.0: (unregistered net_device): attached PHY driver
> [Generic PHY] (mii_bus:phy_addr=0:00, irq=-1) au1000-eth au1000-eth.0:
> eth0: Au1xx0 Ethernet found at 0x10500000, irq 35 au1000_eth: au1000_eth
> version 1.7 Pete Popov <ppopov@embeddedalley.com> ... hangs ...
> 
> Similar messages should follow for eth1. I narrowed down (bisect'ed) the
> problem to commit:
> 
>   commit d0e7cb5d401695809ba8c980124ab1d8c66efc8b
>   Author: Florian Fainelli <florian@openwrt.org>
>   Date:   Wed Sep 8 11:15:13 2010 +0000
> 
>     au1000-eth: remove volatiles, switch to I/O accessors
> 
>     Remove all the volatile keywords where they were used, switch to using
> the proper readl/writel accessors.
> 
>     Signed-off-by: Florian Fainelli <florian@openwrt.org>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> The kernel actually hangs when accessing "&aup->mac->mii_control" in
> au1000_mdio_read(), but only for eth1. Any idea what does go wrong?

I do not understand so far while it hangs only for eth1. My device only has 
one ethernet MAC, so I could not notice the problem. Looking at this close, 
there are a couple of u32 const* usages in au1000_mdio_{read,write} which are 
looking wrong to me now. Can you try to remove these?

> 
> In principle, I do not want to access the MII regs of the MAC because
> eth0 and eth1 are connected to switches. But that's not possible, even
> with "aup->phy_static_config=1" and "aup->phy_addr=0".

If you think this is another issue, I will fix it in another patch.
--
Florian
