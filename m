Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Mar 2007 01:17:26 +0000 (GMT)
Received: from srv5.dvmed.net ([207.36.208.214]:63704 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S28575383AbXCCBRV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 3 Mar 2007 01:17:21 +0000
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HNIs9-0001EP-Qp; Sat, 03 Mar 2007 01:17:18 +0000
Message-ID: <45E8CC9C.3080607@pobox.com>
Date:	Fri, 02 Mar 2007 20:17:16 -0500
From:	Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20070212)
MIME-Version: 1.0
To:	Dale Farnsworth <dale@farnsworth.org>
CC:	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/2] mv643xx_eth: move mac_addr inside mv643xx_eth_platform_data
References: <20070301233148.GA19550@xyzzy.farnsworth.org>
In-Reply-To: <20070301233148.GA19550@xyzzy.farnsworth.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jgarzik@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgarzik@pobox.com
Precedence: bulk
X-list: linux-mips

Dale Farnsworth wrote:
> The information contained within platform_data should be self-contained.
> Replace the pointer to a MAC address with the actual MAC address in
> struct mv643xx_eth_platform_data.
> 
> Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
> 
> ---
> 
> Replaced explicit mac address comparison with a call to is_valid_ether_addr(),
> as suggested by Stephen Hemminger <shemminger@linux-foundation.org>.
> 
>  arch/mips/momentum/jaguar_atx/platform.c |   20 ++++----------------
>  arch/mips/momentum/ocelot_3/platform.c   |   20 ++++----------------
>  arch/mips/momentum/ocelot_c/platform.c   |   12 ++----------
>  drivers/net/mv643xx_eth.c                |    2 +-
>  include/linux/mv643xx.h                  |    2 +-
>  5 files changed, 12 insertions(+), 44 deletions(-)

applied
