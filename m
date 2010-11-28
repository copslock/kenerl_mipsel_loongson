Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Nov 2010 20:31:16 +0100 (CET)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:51135
        "EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492418Ab0K1TbN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Nov 2010 20:31:13 +0100
Received: from localhost (localhost [127.0.0.1])
        by sunset.davemloft.net (Postfix) with ESMTP id 0268924C088;
        Sun, 28 Nov 2010 11:31:36 -0800 (PST)
Date:   Sun, 28 Nov 2010 11:31:35 -0800 (PST)
Message-Id: <20101128.113135.242124850.davem@davemloft.net>
To:     wg@grandegger.com
Cc:     Netdev@vger.kernel.org, linux-mips@linux-mips.org,
        florian@openwrt.org
Subject: Re: [PATCH] au1000_eth: fix invalid address accessing the MAC
 enable register
From:   David Miller <davem@davemloft.net>
In-Reply-To: <4CEBEE79.8040507@grandegger.com>
References: <4CEBEE79.8040507@grandegger.com>
X-Mailer: Mew version 6.3 on Emacs 23.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: Wolfgang Grandegger <wg@grandegger.com>
Date: Tue, 23 Nov 2010 17:40:25 +0100

> "aup->enable" holds already the address pointing to the MAC enable
> register. The bug was introduced by commit d0e7cb:
> 
> "au1000-eth: remove volatiles, switch to I/O accessors".
> 
> CC: Florian Fainelli <florian@openwrt.org>
> Signed-off-by: Wolfgang Grandegger <wg@denx.de>
> Acked-by: Florian Fainelli <florian@openwrt.org>

Applied, thanks.
