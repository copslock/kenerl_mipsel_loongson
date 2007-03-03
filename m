Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Mar 2007 01:17:55 +0000 (GMT)
Received: from srv5.dvmed.net ([207.36.208.214]:473 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S28575407AbXCCBRf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 3 Mar 2007 01:17:35 +0000
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HNIsP-0001Ej-8F; Sat, 03 Mar 2007 01:17:33 +0000
Message-ID: <45E8CCAC.7040304@garzik.org>
Date:	Fri, 02 Mar 2007 20:17:32 -0500
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20070212)
MIME-Version: 1.0
To:	Dale Farnsworth <dale@farnsworth.org>
CC:	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 2/2] mv643xx_eth: Place explicit port number in mv643xx_eth_platform_data
References: <20070301233148.GA19550@xyzzy.farnsworth.org> <20070301233324.GA20193@xyzzy.farnsworth.org>
In-Reply-To: <20070301233324.GA20193@xyzzy.farnsworth.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Dale Farnsworth wrote:
> We were using the platform_device.id field to identify which ethernet
> port is used for mv643xx_eth device.  This is not generally correct.
> It will be incorrect, for example, if a hardware platform uses a single
> port but not the first port.  Here, we add an explicit port_number field
> to struct mv643xx_eth_platform_data.
> 
> This makes the mv643xx_eth_platform_data structure required, but that
> isn't an issue since all users currently provide it already.
> 
> Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
> 
> ---
> 
>  arch/mips/momentum/jaguar_atx/platform.c  |    8 ++
>  arch/mips/momentum/ocelot_3/platform.c    |    8 ++
>  arch/mips/momentum/ocelot_c/platform.c    |    4 +
>  arch/powerpc/platforms/chrp/pegasos_eth.c |    2 
>  arch/ppc/syslib/mv64x60.c                 |   12 +++-
>  drivers/net/mv643xx_eth.c                 |   59 ++++++++++----------
>  include/linux/mv643xx.h                   |    1 
>  7 files changed, 62 insertions(+), 32 deletions(-)

ACK but not applied, patch corrupted
