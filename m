Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Nov 2008 08:33:26 +0000 (GMT)
Received: from srv5.dvmed.net ([207.36.208.214]:62432 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S22783571AbYJaE4N (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 31 Oct 2008 04:56:13 +0000
Received: from cpe-069-134-158-197.nc.res.rr.com ([69.134.158.197] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1Kvm3K-0003w4-Ps; Fri, 31 Oct 2008 04:56:08 +0000
Message-ID: <490A8FE6.8040405@garzik.org>
Date:	Fri, 31 Oct 2008 00:56:06 -0400
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH] tc35815: Define more Rx status bits
References: <20081028.223023.93205850.anemo@mba.ocn.ne.jp>
In-Reply-To: <20081028.223023.93205850.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> This change does not change driver's behaviour, just make its debug
> output a bit meaningful.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
>  drivers/net/tc35815.c |    5 +++--

applied
