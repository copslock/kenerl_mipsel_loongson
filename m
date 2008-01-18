Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jan 2008 20:02:49 +0000 (GMT)
Received: from srv5.dvmed.net ([207.36.208.214]:1664 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20032439AbYARUCl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 18 Jan 2008 20:02:41 +0000
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.66 #1 (Red Hat Linux))
	id 1JFxQE-0007VK-Tk; Fri, 18 Jan 2008 20:02:39 +0000
Message-ID: <479105DE.4040407@garzik.org>
Date:	Fri, 18 Jan 2008 15:02:38 -0500
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] tc35815: Use irq number for tc35815-mac platform device
 id
References: <20080119.011552.41196389.anemo@mba.ocn.ne.jp>
In-Reply-To: <20080119.011552.41196389.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> The tc35815-mac platform device used a pci bus number and a devfn to
> identify its target device, but the pci bus number may vary if some
> bus-bridges are found.  Use irq number which is be unique for embedded
> controllers.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
>  arch/mips/tx4938/toshiba_rbtx4938/setup.c |    4 ++--
>  drivers/net/tc35815.c                     |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

ACK, Ralf please apply through your tree...
