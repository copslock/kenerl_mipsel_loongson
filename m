Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jul 2010 23:11:52 +0200 (CEST)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:43733
        "EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491996Ab0GVVLs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Jul 2010 23:11:48 +0200
Received: from localhost (localhost [127.0.0.1])
        by sunset.davemloft.net (Postfix) with ESMTP id A880A24C112;
        Thu, 22 Jul 2010 14:12:01 -0700 (PDT)
Date:   Thu, 22 Jul 2010 14:12:01 -0700 (PDT)
Message-Id: <20100722.141201.16642235.davem@davemloft.net>
To:     manuel.lauss@googlemail.com
Cc:     linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH] au1000_eth: get ethernet address from platform_data
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1279715450-28762-1-git-send-email-manuel.lauss@googlemail.com>
References: <1279715450-28762-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: Mew version 6.3 on Emacs 23.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: Manuel Lauss <manuel.lauss@googlemail.com>
Date: Wed, 21 Jul 2010 14:30:50 +0200

> au1000_eth uses firmware calls to get a valid MAC address, and changes
> it depending on platform device id.  This patch moves this logic out
> of the driver into the platform device registration part, where boards
> with supported chips can use whatever firmware interface they need;
> the default implementation maintains compatibility with existing,
> YAMON-based firmware.
> 
> Tested-by: Wolfgang Grandegger <wg@denx.de>
> Acked-by: Florian Fainelli <florian@openwrt.org>
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> ---
> This patch depends on another patch to the MIPS tree to
> apply cleanly, so I'd prefer if it went in through it as well.

Ok, feel free:

Acked-by: David S. Miller <davem@davemloft.net>
