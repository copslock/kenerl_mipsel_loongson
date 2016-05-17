Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2016 20:30:38 +0200 (CEST)
Received: from shards.monkeyblade.net ([149.20.54.216]:52508 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27029746AbcEQSaeaNEWr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 May 2016 20:30:34 +0200
Received: from localhost (unknown [38.140.131.194])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 427D85B5C51;
        Tue, 17 May 2016 11:30:31 -0700 (PDT)
Date:   Tue, 17 May 2016 14:30:30 -0400 (EDT)
Message-Id: <20160517.143030.176679255082144481.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     rabin.vincent@axis.com, andrew@lunn.ch, netdev@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, rabinv@axis.com
Subject: Re: [PATCH] phy: remove irq param to fix crash in fixed_phy_add()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <573B6280.3030405@gmail.com>
References: <1463397356-5656-1-git-send-email-rabin.vincent@axis.com>
        <20160517.142034.611823602956859056.davem@davemloft.net>
        <573B6280.3030405@gmail.com>
X-Mailer: Mew version 6.6 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 17 May 2016 11:30:31 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 17 May 2016 11:27:12 -0700

> On 05/17/2016 11:20 AM, David Miller wrote:
>> From: Rabin Vincent <rabin.vincent@axis.com>
>> Date: Mon, 16 May 2016 13:15:56 +0200
>> 
>>> From: Rabin Vincent <rabinv@axis.com>
>>>
>>> Since e7f4dc3536a ("mdio: Move allocation of interrupts into core"),
>>> platforms which call fixed_phy_add() before fixed_mdio_bus_init() is
>>> called (for example, because the platform code and the fixed_phy driver
>>> use the same initcall level) crash in fixed_phy_add() since the
>>> ->mii_bus is not allocated.
>>>
>>> Also since e7f4dc3536a, these interrupts are initalized to polling by
>>> default.  All callers of both fixed_phy_register() and fixed_phy_add()
>>> pass PHY_POLL for the irq argument, so we can fix these crashes by
>>> simply removing the irq parameter, since the default is correct for all
>>> users.
>>>
>>> Fixes: e7f4dc3536a400 ("mdio: Move allocation of interrupts into core")
>>> Signed-off-by: Rabin Vincent <rabinv@axis.com>
>> 
>> Applied.
> 
> David, there was a v2 sent just earlier this morning here:
> 
> http://patchwork.ozlabs.org/patch/622967/
> 
> which was appropriately marked with Changes Requested, so why would we
> apply v1?

And that v2 needs changes still.

My bad I'll revert v1, sorry.
