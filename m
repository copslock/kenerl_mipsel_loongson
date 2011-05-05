Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2011 00:11:30 +0200 (CEST)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:38137
        "EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490992Ab1EEWLY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 May 2011 00:11:24 +0200
Received: from localhost (localhost [127.0.0.1])
        by sunset.davemloft.net (Postfix) with ESMTP id 3AF0824C088;
        Thu,  5 May 2011 15:10:50 -0700 (PDT)
Date:   Thu, 05 May 2011 15:10:49 -0700 (PDT)
Message-Id: <20110505.151049.35056363.davem@davemloft.net>
To:     blogic@openwrt.org
Cc:     ralf@linux-mips.org, ralph.hempel@lantiq.com,
        linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH V2 2/3] MIPS: lantiq: add ethernet driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1304633402-24161-3-git-send-email-blogic@openwrt.org>
References: <1304633402-24161-1-git-send-email-blogic@openwrt.org>
        <1304633402-24161-3-git-send-email-blogic@openwrt.org>
X-Mailer: Mew version 6.3 on Emacs 23.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: John Crispin <blogic@openwrt.org>
Date: Fri,  6 May 2011 00:10:01 +0200

> This patch adds the driver for the ETOP Packet Processing Engine (PPE32) found
> inside the XWAY family of Lantiq MIPS SoCs. This driver makes 100MBit ethernet
> work. Support for all 8 dma channels, gbit and the embedded switch found on
> the ar9/vr9 still needs to be implemented.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Signed-off-by: Ralph Hempel <ralph.hempel@lantiq.com>

No objections from me and this can go via the MIPS tree:

Acked-by: David S. Miller <davem@davemloft.net>
