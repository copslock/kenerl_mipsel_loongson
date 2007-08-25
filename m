Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Aug 2007 05:40:51 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:11913 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20021857AbXHYEkj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 25 Aug 2007 05:40:39 +0100
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1IOnRs-0001zS-Cb; Sat, 25 Aug 2007 04:40:36 +0000
Message-ID: <46CFB2C3.6060403@garzik.org>
Date:	Sat, 25 Aug 2007 00:40:35 -0400
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [METH] Don't use GFP_DMA for zone allocation.
References: <20070815115316.GB5862@linux-mips.org>
In-Reply-To: <20070815115316.GB5862@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> IP32 doesn't even have a ZONE_DMA so no point in using GFP_DMA in any
> IP32-specific device driver.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

applied
