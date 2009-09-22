Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2009 07:38:30 +0200 (CEST)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:36409
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492209AbZIVFiW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2009 07:38:22 +0200
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id AFAB3C8C1EF;
	Mon, 21 Sep 2009 22:38:30 -0700 (PDT)
Date:	Mon, 21 Sep 2009 22:38:30 -0700 (PDT)
Message-Id: <20090921.223830.164776940.davem@davemloft.net>
To:	florian@openwrt.org
Cc:	netdev@vger.kernel.org, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] cpmac: fix compilation errors against undeclared
 BUS_ID_SIZE
From:	David Miller <davem@davemloft.net>
In-Reply-To: <200909191243.09166.florian@openwrt.org>
References: <200909160944.24265.florian@openwrt.org>
	<200909191243.09166.florian@openwrt.org>
X-Mailer: Mew version 6.2.51 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24066
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: Florian Fainelli <florian@openwrt.org>
Date: Sat, 19 Sep 2009 12:43:08 +0200

> David,
> 
> Ping ? This fixes a build failure. Thank you very much !

Applied, thanks.
