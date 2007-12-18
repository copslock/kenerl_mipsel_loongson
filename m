Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Dec 2007 01:18:52 +0000 (GMT)
Received: from srv5.dvmed.net ([207.36.208.214]:4571 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20036299AbXLRBSo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 18 Dec 2007 01:18:44 +0000
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1J4R6W-0003rx-4a; Tue, 18 Dec 2007 01:18:40 +0000
Message-ID: <47671FEE.90103@pobox.com>
Date:	Mon, 17 Dec 2007 20:18:38 -0500
From:	Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
MIME-Version: 1.0
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:	netdev@vger.kernel.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [UPDATED PATCH] SGISEEQ: use cached memory access to make driver
 work on IP28
References: <20071202103312.75E51C2EB5@solo.franken.de>
In-Reply-To: <20071202103312.75E51C2EB5@solo.franken.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jgarzik@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgarzik@pobox.com
Precedence: bulk
X-list: linux-mips

Thomas Bogendoerfer wrote:
> SGI IP28 machines would need special treatment (enable adding addtional
> wait states) when accessing memory uncached. To avoid this pain I changed
> the driver to use only cached access to memory.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
> 
> Changes to last version:
> - Use inline functions for dma_sync_* instead of macros (suggested by Ralf)
> - added Kconfig change to make selection for similair SGI boxes easier

hrm, could you rediff?  it doesn't seem to apply
