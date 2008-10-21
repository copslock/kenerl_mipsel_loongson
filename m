Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2008 06:15:32 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:205 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S21968465AbYJUFP3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2008 06:15:29 +0100
Received: from cpe-069-134-158-197.nc.res.rr.com ([69.134.158.197] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1Ks9aW-00070Y-62; Tue, 21 Oct 2008 05:15:26 +0000
Message-ID: <48FD656B.7040304@garzik.org>
Date:	Tue, 21 Oct 2008 01:15:23 -0400
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] net: Make SMC91X selectable on other MIPS boards
References: <1224514829-16163-1-git-send-email-anemo@mba.ocn.ne.jp>
In-Reply-To: <1224514829-16163-1-git-send-email-anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> RBTX4939 board has SMC91X chip and there can be other MIPS boards with
> that chip.  Make SMC91X selectable on all MIPS board would be better than
> enumerating each boards in Kconfig.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Cc: jeff@garzik.org
> ---
>  drivers/net/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 096735f..be3c4b2 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -888,7 +888,7 @@ config SMC91X
>  	select CRC32
>  	select MII
>  	depends on ARM || REDWOOD_5 || REDWOOD_6 || M32R || SUPERH || \
> -		SOC_AU1X00 || BLACKFIN || MN10300
> +		MIPS || BLACKFIN || MN10300

applied
