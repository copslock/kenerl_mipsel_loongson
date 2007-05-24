Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 May 2007 22:24:51 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:52155 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20022040AbXEXVYt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 24 May 2007 22:24:49 +0100
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HrKkX-0007kc-HR; Thu, 24 May 2007 21:21:34 +0000
Message-ID: <465601DC.80908@garzik.org>
Date:	Thu, 24 May 2007 17:21:32 -0400
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org,
	Shane McDonald <Shane_McDonald@pmc-sierra.com>
Subject: Re: [NET] meth driver renovation
References: <20070524115404.GC27073@linux-mips.org>
In-Reply-To: <20070524115404.GC27073@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> The meth ethernet driver for the SGI IP32 aka O2 is so far still an old
> style driver which does not use the device driver model.  This is now
> causing issues with some udev based gadgetry in debian-stable.  Fixed by
> converting the meth driver to a platform device.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> --
> Fixes since previous patch:
> 
>   o Fixed typo in meth_exit_module()

applied
