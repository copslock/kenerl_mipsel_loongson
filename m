Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Aug 2009 21:24:23 +0200 (CEST)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:54108
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493437AbZHETXg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 5 Aug 2009 21:23:36 +0200
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id A8837C8C4B1;
	Wed,  5 Aug 2009 12:23:42 -0700 (PDT)
Date:	Wed, 05 Aug 2009 12:23:42 -0700 (PDT)
Message-Id: <20090805.122342.222976829.davem@davemloft.net>
To:	florian@openwrt.org
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 3/5] cpmac: add support for fixed PHY
From:	David Miller <davem@davemloft.net>
In-Reply-To: <200908042252.53068.florian@openwrt.org>
References: <200908042252.53068.florian@openwrt.org>
X-Mailer: Mew version 6.2.51 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: Florian Fainelli <florian@openwrt.org>
Date: Tue, 4 Aug 2009 22:52:52 +0200

> This patch adds support for fixed PHY connected in MII mode
> to cpmac. We allow external and dumb_switch module parameters
> to override the PHY detection process since they are always connected
> with MDIO bus identifier 0. This lets fixed PHYs to be detected
> correctly and be connected to the their corresponding MDIO
> bus identifier.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>

Applied to net-next-2.6
