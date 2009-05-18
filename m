Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 May 2009 05:12:09 +0100 (BST)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:40455
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20021949AbZEREMA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 18 May 2009 05:12:00 +0100
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 7D01035C02F;
	Sun, 17 May 2009 21:11:54 -0700 (PDT)
Date:	Sun, 17 May 2009 21:11:54 -0700 (PDT)
Message-Id: <20090517.211154.135580965.davem@davemloft.net>
To:	ralf@linux-mips.org
Cc:	jeff@garzik.org, netdev@vger.kernel.org, linux-mips@linux-mips.org,
	randrik_a@yahoo.com
Subject: Re: [PATCH] NET: Meth: Fix unsafe mix of irq and non-irq spinlocks.
From:	David Miller <davem@davemloft.net>
In-Reply-To: <20090516112158.GA13140@linux-mips.org>
References: <20090516112158.GA13140@linux-mips.org>
X-Mailer: Mew version 6.2.51 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: Ralf Baechle <ralf@linux-mips.org>
Date: Sat, 16 May 2009 12:21:58 +0100

> Mixing of normal and irq spinlocks results in the following lockdep messages
> on bootup on IP32:
  ...
> Fixed by converting all locks to irq locks.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> Tested-by: Andrew Randrianasulu <randrik_a@yahoo.com>

Applied, thanks!
