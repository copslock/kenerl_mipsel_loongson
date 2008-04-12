Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Apr 2008 19:40:45 +0100 (BST)
Received: from p549F61CF.dip.t-dialin.net ([84.159.97.207]:51393 "EHLO
	p549F61CF.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20021353AbYDMSkn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 13 Apr 2008 19:40:43 +0100
Received: from srv5.dvmed.net ([207.36.208.214]:48553 "EHLO mail.dvmed.net")
	by lappi.linux-mips.net with ESMTP id S1788220AbYDLJAz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 12 Apr 2008 11:00:55 +0200
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1JkbbO-0004BS-Ab; Sat, 12 Apr 2008 09:00:50 +0000
Message-ID: <48007A41.2000803@garzik.org>
Date:	Sat, 12 Apr 2008 05:00:49 -0400
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/6] tc35815: Statistics cleanup
References: <20080411.002412.03977557.anemo@mba.ocn.ne.jp>
In-Reply-To: <20080411.002412.03977557.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> Use struct net_device_stats embedded in struct net_device.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
>  drivers/net/tc35815.c |   61 +++++++++++++++++++++++++------------------------
>  1 files changed, 31 insertions(+), 30 deletions(-)

applied 1-6
