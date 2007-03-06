Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2007 11:23:22 +0000 (GMT)
Received: from srv5.dvmed.net ([207.36.208.214]:48592 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20021358AbXCFLXT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 6 Mar 2007 11:23:19 +0000
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HOXi8-0002Ma-SC; Tue, 06 Mar 2007 11:20:05 +0000
Message-ID: <45ED4E64.5030404@garzik.org>
Date:	Tue, 06 Mar 2007 06:20:04 -0500
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	netdev@vger.kernel.org, sshtylyov@ru.mvista.com
Subject: Re: [PATCH] tc35815 driver update (take 2)
References: <20070303.235459.25478204.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070303.235459.25478204.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> Current tc35815 driver is very obsolete and less maintained for a long
> time.  Replace it with a new driver based on one from CELF patch
> archive.
> 
> Major advantages of CELF version (version 1.23, for kernel 2.6.10) are:
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
> And improvoments since version 1.23 are:
> 
> * TX4939 support.
> * NETPOLL support.
> * NAPI support. (disabled by default)
> * Reduce memcpy on receiving.
> * PM support.
> * Many cleanups and bugfixes.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
>  drivers/net/Kconfig     |    3 
>  drivers/net/tc35815.c   | 2587 ++++++++++++++++++++++++++++++++++------------
>  include/linux/pci_ids.h |    2 
>  3 files changed, 1917 insertions(+), 675 deletions(-)

applied to #upstream, let's give it a good review while it hangs out in 
libata-dev.git#ALL and -mm
