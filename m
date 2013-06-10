Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 23:28:46 +0200 (CEST)
Received: from shards.monkeyblade.net ([149.20.54.216]:54942 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835129Ab3FJV2pMU2J0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Jun 2013 23:28:45 +0200
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2DE03595212;
        Mon, 10 Jun 2013 14:28:42 -0700 (PDT)
Date:   Mon, 10 Jun 2013 14:28:41 -0700 (PDT)
Message-Id: <20130610.142841.1096307411403059978.davem@davemloft.net>
To:     florian@openwrt.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, linux-mips@linux-mips.org,
        cernekee@gmail.com, mbizon@freebox.fr, jogo@openwrt.org
Subject: Re: [PATCH 0/3 net-next] bcm63xx_enet: add support for BCM63xx
 gigabit integrated switch
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1370382094-17821-1-git-send-email-florian@openwrt.org>
References: <1370382094-17821-1-git-send-email-florian@openwrt.org>
X-Mailer: Mew version 6.5 on Emacs 24.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36820
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
Date: Tue,  4 Jun 2013 22:41:31 +0100

> This patchset contains changes to enable the BCM63xx gitabit integrated switch
> found on BCM6328, BCM6362 and BCM6368 SoCs. It contains changes both to
> arch/mips/bcm63xx and drivers/net/ethernet/bcm63xx_enet.c. The changes are
> pretty difficult to split so I would rather see these merged via the net-tree.

Applied to net-next.
