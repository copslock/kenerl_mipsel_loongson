Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Mar 2007 15:06:37 +0000 (GMT)
Received: from srv5.dvmed.net ([207.36.208.214]:13764 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20021817AbXCOPGc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Mar 2007 15:06:32 +0000
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HRrU6-0001bB-44; Thu, 15 Mar 2007 15:03:18 +0000
Message-ID: <45F96035.2040403@garzik.org>
Date:	Thu, 15 Mar 2007 11:03:17 -0400
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	netdev@vger.kernel.org, sshtylyov@ru.mvista.com,
	akpm@linux-foundation.org
Subject: Re: [PATCH] tc35815: Fix an usage of streaming DMA API.
References: <20070303.235459.25478204.anemo@mba.ocn.ne.jp> <20070314.010220.65192616.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070314.010220.65192616.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> The tc35815 driver lacks a call to pci_dma_sync_single_for_device() on
> receiving.  Recent fix of MIPS dma_sync_single_for_cpu() reveal this
> bug.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> This patch can be applied to netdev-2.6 tree or 2.6.21-rc3-mm2.

applied to #upstream
