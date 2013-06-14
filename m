Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jun 2013 02:22:44 +0200 (CEST)
Received: from shards.monkeyblade.net ([149.20.54.216]:42974 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835278Ab3FNAWlX9AeG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Jun 2013 02:22:41 +0200
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5D440583AB6;
        Thu, 13 Jun 2013 17:22:38 -0700 (PDT)
Date:   Thu, 13 Jun 2013 17:22:37 -0700 (PDT)
Message-Id: <20130613.172237.1405190894345298627.davem@davemloft.net>
To:     ralf@linux-mips.org
Cc:     florian@openwrt.org, netdev@vger.kernel.org, blogic@openwrt.org,
        linux-mips@linux-mips.org, mbizon@freebox.fr, jogo@openwrt.org,
        cernekee@gmail.com
Subject: Re: [PATCH net-next] bcm63xx_enet: add support Broadcom BCM6345
 Ethernet
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20130613135921.GA22906@linux-mips.org>
References: <CAGVrzcaqbdLPcuL0m56aBLuG9ruaQ1p4JfTWZV9DJ4zSrNcXtg@mail.gmail.com>
        <20130613.025619.2170890039313059326.davem@davemloft.net>
        <20130613135921.GA22906@linux-mips.org>
X-Mailer: Mew version 6.5 on Emacs 24.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36867
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

From: Ralf Baechle <ralf@linux-mips.org>
Date: Thu, 13 Jun 2013 15:59:21 +0200

> On Thu, Jun 13, 2013 at 02:56:19AM -0700, David Miller wrote:
> 
>> From: Florian Fainelli <florian@openwrt.org>
>> Date: Thu, 13 Jun 2013 10:49:18 +0100
>> 
>> > We are in the slow process to switch to Device Tree to precisely
>> > eliminate all of this (although not everyone agrees yet on the
>> > details). Hopefully you should not see such things in the future.
>> 
>> Fair enough, I'll put this patch back into my TODO queue.
> 
> David is right, one pair of welding goggles isn't enough to cope with the
> uglyness of this but as a temporary thing I can live with it, so
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
> 
> Dave, feel free to merge this through next-next.  I'm going to drop
> this patch from the MIPS patchwork then.

Applied to net-next, thanks everyone.
