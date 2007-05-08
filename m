Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2007 06:23:27 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:40916 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20021702AbXEHFXZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 8 May 2007 06:23:25 +0100
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HlIAT-0002fy-79; Tue, 08 May 2007 05:23:21 +0000
Message-ID: <46400948.9060007@garzik.org>
Date:	Tue, 08 May 2007 01:23:20 -0400
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, netdev@vger.kernel.org,
	ralf@linux-mips.org, sshtylyov@ru.mvista.com,
	akpm@linux-foundation.org
Subject: Re: [PATCH 1/5] ne: Add platform_driver
References: <20070501.002731.104031408.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070501.002731.104031408.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> Add a platform_driver interface to ne driver.
> (Existing legacy ports did not covered by this ne_driver for now)
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
>  drivers/net/ne.c |   91 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 89 insertions(+), 2 deletions(-)

applied 1-5
