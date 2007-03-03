Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Mar 2007 01:11:25 +0000 (GMT)
Received: from srv5.dvmed.net ([207.36.208.214]:47576 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S28573849AbXCCBLT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 3 Mar 2007 01:11:19 +0000
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HNImI-0001Cw-Sy; Sat, 03 Mar 2007 01:11:15 +0000
Message-ID: <45E8CB32.5060008@garzik.org>
Date:	Fri, 02 Mar 2007 20:11:14 -0500
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20070212)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	netdev@vger.kernel.org, sshtylyov@ru.mvista.com
Subject: Re: [PATCH 1/2] tc35815 driver update (part 1)
References: <20070302.232407.05600700.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070302.232407.05600700.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> Current tc35815 driver is very obsolete and less maintained for a long
> time.  Replace it with a new driver based on one from CELF patch
> archive.  It was for 2.6.10 kernel so some adjustment and cleanup are
> added. (remove config.h, SA_ to IRQF_ conversion, etc.)
> 
> Major advantages are:
> 
> * Independent of JMR3927.
>   (Actually independent of MIPS, but AFAIK the chip is used only on
>    MIPS platforms)
> * TX4938 support.
> * 64-bit proof.
> * Asynchronous and on-demand auto negotiation.
> * High performance on non-coherent architecture.
> * ethtool support.
> * Many bugfixes and cleanups.
> 
> And next patch add further improvements/bugfixes/cleanups.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> This is a patch against current linux-mips.org git-tree.
> 
>  drivers/net/Kconfig     |    3 
>  drivers/net/tc35815.c   | 2070 +++++++++++++++++++++++++++++++---------------
>  include/linux/pci_ids.h |    1 
>  3 files changed, 1440 insertions(+), 634 deletions(-)

Would you be kind enough to

a) provide a URL to a .c file (or post it, if it's under 100K) so that 
we may more easily review this

b) combine both patches into a single patch.  might as well, since it's 
a rewrite.

c) rediff your patch against linux-2.6.git + Ralf's killall removal 
patch, and resend.  There were some minor conflicting changes that 
appeared, though these changes will certainly become irrelevant once 
your new driver is merged.
