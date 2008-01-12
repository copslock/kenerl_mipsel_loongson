Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jan 2008 22:23:57 +0000 (GMT)
Received: from srv5.dvmed.net ([207.36.208.214]:44701 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20034637AbYALWXs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 12 Jan 2008 22:23:48 +0000
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.66 #1 (Red Hat Linux))
	id 1JDolU-00034I-A0; Sat, 12 Jan 2008 22:23:44 +0000
Message-ID: <47893DEE.1050807@pobox.com>
Date:	Sat, 12 Jan 2008 17:23:42 -0500
From:	Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
MIME-Version: 1.0
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:	netdev@vger.kernel.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [UPDATED PATCH] SGISEEQ: use cached memory access to make driver
 work on IP28
References: <20071202103312.75E51C2EB5@solo.franken.de> <47671FEE.90103@pobox.com> <20071218103006.GA18598@alpha.franken.de> <476867F5.3070006@pobox.com> <20071219124235.GA7550@alpha.franken.de>
In-Reply-To: <20071219124235.GA7550@alpha.franken.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jgarzik@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgarzik@pobox.com
Precedence: bulk
X-list: linux-mips

Thomas Bogendoerfer wrote:
> - Use inline functions for dma_sync_* instead of macros 
> - added Kconfig change to make selection for similair SGI boxes easier
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
> 
>  drivers/net/Kconfig   |    2 +-
>  drivers/net/sgiseeq.c |   64 ++++++++++++++++++++++++++-----------------------
>  2 files changed, 35 insertions(+), 31 deletions(-)

applied
