Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Nov 2010 11:46:16 +0100 (CET)
Received: from mail-ww0-f54.google.com ([74.125.82.54]:51232 "EHLO
        mail-ww0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491178Ab0KSKqJ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Nov 2010 11:46:09 +0100
Received: by wwi17 with SMTP id 17so2633125wwi.23
        for <linux-mips@linux-mips.org>; Fri, 19 Nov 2010 02:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=uU/hejWilqltcIzXSySkrUmHUf2URpsr1qAzd3Dl7dk=;
        b=arrkkZfmbqGC6O8YShacjCXffaz/RcVbm3/e8HkNJ5ia3ppcqpGrT65b2Ta1elMuzZ
         dtb8EKYctlZOMSq+i3fQ0EqPsxM92fsMBkXHBsIs8To8JEu2RVPtMHstdlXvjN0uTWoV
         23jiL6NtV6H13UyG+KlixZjmdXX2f/B1u0bAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=o8r47LKOcNVfLFqa28BJLgeUb+n1ZPVokbsjYAi3/iBBMgV36N/63I/EpQAhn+9IeS
         kTE6NZW0/t3DAByBNfweEGf1iR4oym5Oj05D8OomAhnIdVGUtBEetBeTj740V8RIMDNh
         ItLXyYebXQZeGFFVhegyUCdnf7QfU3sVvAB0M=
Received: by 10.216.164.137 with SMTP id c9mr4258985wel.19.1290163564185;
        Fri, 19 Nov 2010 02:46:04 -0800 (PST)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id w41sm708312weq.32.2010.11.19.02.46.02
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 02:46:02 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: alchemy/gpr: au1000_eth regression with v2.6.37rc2
Date:   Fri, 19 Nov 2010 11:46:01 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.35-22-server; KDE/4.5.1; x86_64; ; )
Cc:     "Linux-MIPS" <linux-mips@linux-mips.org>, Netdev@vger.kernel.org
References: <4CE58593.50509@grandegger.com> <201011182330.08488.florian@openwrt.org> <4CE65199.7030007@grandegger.com>
In-Reply-To: <4CE65199.7030007@grandegger.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <201011191146.01454.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hello Wolfgang,

On Friday 19 November 2010 11:29:45 Wolfgang Grandegger wrote:
> Hello Florian,
> 
> On 11/18/2010 11:30 PM, Florian Fainelli wrote:
> > Hello Wolfgang,
> > 
> > Le Thursday 18 November 2010 20:59:15, Wolfgang Grandegger a écrit :
> >> Hello,
> >> 
> >> I just realized that the v2.6.37-rc2 kernel does not boot any more on
> >> the Alchemy GPR board. It works fine with v2.6.36. It hangs in the
> >> probe function of the au1000_eth driver when probing the second
> >> 
> >> ethernet port (eth1):
> >>   au1000_eth_mii: probed
> >>   au1000-eth au1000-eth.0: (unregistered net_device): attached PHY
> >>   driver
> >> 
> >> [Generic PHY] (mii_bus:phy_addr=0:00, irq=-1) au1000-eth au1000-eth.0:
> >> eth0: Au1xx0 Ethernet found at 0x10500000, irq 35 au1000_eth: au1000_eth
> >> version 1.7 Pete Popov <ppopov@embeddedalley.com> ... hangs ...
> >> 
> >> Similar messages should follow for eth1. I narrowed down (bisect'ed) the
> >> 
> >> problem to commit:
> >>   commit d0e7cb5d401695809ba8c980124ab1d8c66efc8b
> >>   Author: Florian Fainelli <florian@openwrt.org>
> >>   Date:   Wed Sep 8 11:15:13 2010 +0000
> >>   
> >>     au1000-eth: remove volatiles, switch to I/O accessors
> >>     
> >>     Remove all the volatile keywords where they were used, switch to
> >>     using
> >> 
> >> the proper readl/writel accessors.
> >> 
> >>     Signed-off-by: Florian Fainelli <florian@openwrt.org>
> >>     Signed-off-by: David S. Miller <davem@davemloft.net>
> >> 
> >> The kernel actually hangs when accessing "&aup->mac->mii_control" in
> >> au1000_mdio_read(), but only for eth1. Any idea what does go wrong?
> > 
> > I do not understand so far while it hangs only for eth1. My device only
> > has one ethernet MAC, so I could not notice the problem. Looking at this
> > close, there are a couple of u32 const* usages in
> > au1000_mdio_{read,write} which are looking wrong to me now. Can you try
> > to remove these?
> 
> That did not help.

I suspected it, but thanks for the confirmation.

> 
> >> In principle, I do not want to access the MII regs of the MAC because
> >> eth0 and eth1 are connected to switches. But that's not possible, even
> >> with "aup->phy_static_config=1" and "aup->phy_addr=0".
> > 
> > If you think this is another issue, I will fix it in another patch.
> 
> Accessing the MII registers of the MAC should not hang the system even
> if I do not need to. First I want to  understand why. Looks like a wired
> optimizer issue.

I definitively agree, furthermore since there is a timeout for read and write 
operations. I will look at the assembly and see if I can see anything 
different.

> 
> BTW: why do you use readl() and writel() instead of the usual au_readl()
> and au_writel() to access memory mapped cpu registers? It did not help,
> anyway.

This is just because they are generic accessors, and the au_{readl,writel} 
variants were not different.
--
Florian
