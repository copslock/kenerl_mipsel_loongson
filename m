Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jun 2007 14:44:42 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:62175 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20023166AbXF2Noh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 Jun 2007 14:44:37 +0100
Received: from cpe-065-190-165-210.nc.res.rr.com ([65.190.165.210] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1I4Giy-0006g9-Rx; Fri, 29 Jun 2007 13:41:26 +0000
Message-ID: <46850C03.9030904@garzik.org>
Date:	Fri, 29 Jun 2007 09:41:23 -0400
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.12 (X11/20070530)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org
CC:	linux-mips@linux-mips.org, sshtylyov@ru.mvista.com,
	mlachwani@mvista.com
Subject: Re: [PATCH] tc35815: Load MAC address via platform_device
References: <20070629.223453.106262827.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070629.223453.106262827.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> TX49XX SoCs include PCI NIC (TC35815 compatible) connected via its
> internal PCI bus, but the NIC's PROM interface is not connected to
> SEEPROM.  So we must provide its ethernet address by another way.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> A platform side of this patch is:
> "[PATCH] rbtx4938: Fix secondary PCIC and glue internal NICs"
> 
>  drivers/net/tc35815.c |   50 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 files changed, 45 insertions(+), 5 deletions(-)

ACK.

Due to platform dependency, I would prefer that Ralf push this upstream, 
when he pushes the associated rbtx4938 patch.

	Jeff
