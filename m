Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Oct 2008 05:03:35 +0100 (BST)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:59308
	"EHLO sunset.davemloft.net") by ftp.linux-mips.org with ESMTP
	id S21324483AbYJMEDc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Oct 2008 05:03:32 +0100
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 30FE6C8C196;
	Sun, 12 Oct 2008 21:03:07 -0700 (PDT)
Date:	Sun, 12 Oct 2008 21:03:06 -0700 (PDT)
Message-Id: <20081012.210306.222286255.davem@davemloft.net>
To:	bunk@kernel.org
Cc:	buytenh@marvell.com, jgarzik@pobox.com, ralf@linux-mips.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [2.6 patch] net/au1000_eth.c MDIO namespace fixes
From:	David Miller <davem@davemloft.net>
In-Reply-To: <20081012124939.GI31153@cs181140183.pp.htv.fi>
References: <20081012124939.GI31153@cs181140183.pp.htv.fi>
X-Mailer: Mew version 6.1 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: Adrian Bunk <bunk@kernel.org>
Date: Sun, 12 Oct 2008 15:49:39 +0300

> Commit 2e888103295f47b8fcbf7e9bb8c5da97dd2ecd76
> (phylib: add mdiobus_{read,write}) causes the
> following compile error:
 ...
> This patch prefixes the driver functions with au1000_ 
> 
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

Also applied, thanks a lot.
