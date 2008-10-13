Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Oct 2008 05:03:15 +0100 (BST)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:57772
	"EHLO sunset.davemloft.net") by ftp.linux-mips.org with ESMTP
	id S21324477AbYJMEDN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Oct 2008 05:03:13 +0100
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 91492C8C1A7;
	Sun, 12 Oct 2008 21:02:47 -0700 (PDT)
Date:	Sun, 12 Oct 2008 21:02:47 -0700 (PDT)
Message-Id: <20081012.210247.06669920.davem@davemloft.net>
To:	bunk@kernel.org
Cc:	buytenh@marvell.com, jgarzik@pobox.com, ralf@linux-mips.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [2.6 patch] net/tc35815.c: fix compilation
From:	David Miller <davem@davemloft.net>
In-Reply-To: <20081012124934.GH31153@cs181140183.pp.htv.fi>
References: <20081012124934.GH31153@cs181140183.pp.htv.fi>
X-Mailer: Mew version 6.1 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: Adrian Bunk <bunk@kernel.org>
Date: Sun, 12 Oct 2008 15:49:34 +0300

> Fix an obvious typo introduced by
> commit 298cf9beb9679522de995e249eccbd82f7c51999
> (phylib: move to dynamic allocation of struct mii_bus).
...
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

Applied, thanks Adrian.
