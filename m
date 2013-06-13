Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jun 2013 11:57:50 +0200 (CEST)
Received: from shards.monkeyblade.net ([149.20.54.216]:33629 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834961Ab3FMJ5RevmVu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Jun 2013 11:57:17 +0200
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E1730581EE2;
        Thu, 13 Jun 2013 02:56:19 -0700 (PDT)
Date:   Thu, 13 Jun 2013 02:56:19 -0700 (PDT)
Message-Id: <20130613.025619.2170890039313059326.davem@davemloft.net>
To:     florian@openwrt.org
Cc:     netdev@vger.kernel.org, ralf@linux-mips.org, blogic@openwrt.org,
        linux-mips@linux-mips.org, mbizon@freebox.fr, jogo@openwrt.org,
        cernekee@gmail.com
Subject: Re: [PATCH net-next] bcm63xx_enet: add support Broadcom BCM6345
 Ethernet
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAGVrzcaqbdLPcuL0m56aBLuG9ruaQ1p4JfTWZV9DJ4zSrNcXtg@mail.gmail.com>
References: <CAGVrzcYE4VDWtL_Uj1DrkZ6GqX6ghqPAXPpyLptc6PGwReixSQ@mail.gmail.com>
        <20130613.022524.568792627006552244.davem@davemloft.net>
        <CAGVrzcaqbdLPcuL0m56aBLuG9ruaQ1p4JfTWZV9DJ4zSrNcXtg@mail.gmail.com>
X-Mailer: Mew version 6.5 on Emacs 24.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36851
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

From: Florian Fainelli <florian@openwrt.org>
Date: Thu, 13 Jun 2013 10:49:18 +0100

> We are in the slow process to switch to Device Tree to precisely
> eliminate all of this (although not everyone agrees yet on the
> details). Hopefully you should not see such things in the future.

Fair enough, I'll put this patch back into my TODO queue.
