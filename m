Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2007 16:07:38 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:59850 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20021884AbXD1PHf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 28 Apr 2007 16:07:35 +0100
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HhoWI-000542-1G; Sat, 28 Apr 2007 15:07:30 +0000
Message-ID: <4633632E.5030607@garzik.org>
Date:	Sat, 28 Apr 2007 11:07:26 -0400
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, netdev@vger.kernel.org,
	ralf@linux-mips.org, sshtylyov@ru.mvista.com,
	akpm@linux-foundation.org
Subject: Re: [PATCH 1/3] ne: Add platform_driver
References: <20070425.015450.25909765.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070425.015450.25909765.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> * Add platform_driver interface to ne driver.
>   (Existing legacy ports did not covered by this ne_driver for now)
> * Make ioaddr 'unsigned long'.
> * Move a printk down to show dev->name assigned in register_netdev.


Please split this patch into two patches: one patch does platform_driver 
conversion, and the other patch is the other two items you describe above.
