Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Nov 2010 20:58:05 +0100 (CET)
Received: from mail-out.m-online.net ([212.18.0.10]:33660 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492002Ab0KRT6C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Nov 2010 20:58:02 +0100
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
        by mail-out.m-online.net (Postfix) with ESMTP id B4AF1188B584;
        Thu, 18 Nov 2010 20:58:01 +0100 (CET)
X-Auth-Info: nrImGtJdgx8Uo6j1nWM7d3eYPwqfzyuI5gYk7V3HdlE=
Received: from lancy.mylan.de (p4FE6480F.dip.t-dialin.net [79.230.72.15])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mnet-online.de (Postfix) with ESMTPSA id 0F0991C00173;
        Thu, 18 Nov 2010 20:58:00 +0100 (CET)
Message-ID: <4CE58593.50509@grandegger.com>
Date:   Thu, 18 Nov 2010 20:59:15 +0100
From:   Wolfgang Grandegger <wg@grandegger.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Linux-MIPS <linux-mips@linux-mips.org>
CC:     Netdev@vger.kernel.org, Florian Fainelli <florian@openwrt.org>
Subject: alchemy/gpr: au1000_eth regression with v2.6.37rc2
X-Enigmail-Version: 1.0.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <wg@grandegger.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wg@grandegger.com
Precedence: bulk
X-list: linux-mips

Hello,

I just realized that the v2.6.37-rc2 kernel does not boot any more on
the Alchemy GPR board. It works fine with v2.6.36. It hangs in the
probe function of the au1000_eth driver when probing the second
ethernet port (eth1):

  au1000_eth_mii: probed
  au1000-eth au1000-eth.0: (unregistered net_device): attached PHY driver [Generic PHY] (mii_bus:phy_addr=0:00, irq=-1)
  au1000-eth au1000-eth.0: eth0: Au1xx0 Ethernet found at 0x10500000, irq 35
  au1000_eth: au1000_eth version 1.7 Pete Popov <ppopov@embeddedalley.com>
  ... hangs ...

Similar messages should follow for eth1. I narrowed down (bisect'ed) the
problem to commit:

  commit d0e7cb5d401695809ba8c980124ab1d8c66efc8b
  Author: Florian Fainelli <florian@openwrt.org>
  Date:   Wed Sep 8 11:15:13 2010 +0000

    au1000-eth: remove volatiles, switch to I/O accessors
    
    Remove all the volatile keywords where they were used, switch to using the
    proper readl/writel accessors.
    
    Signed-off-by: Florian Fainelli <florian@openwrt.org>
    Signed-off-by: David S. Miller <davem@davemloft.net>

The kernel actually hangs when accessing "&aup->mac->mii_control" in
au1000_mdio_read(), but only for eth1. Any idea what does go wrong?

In principle, I do not want to access the MII regs of the MAC because
eth0 and eth1 are connected to switches. But that's not possible, even
with "aup->phy_static_config=1" and "aup->phy_addr=0".

TIA,

Wolfgang.
