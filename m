Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Aug 2007 11:53:57 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:22750 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20022652AbXHaKxr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 31 Aug 2007 11:53:47 +0100
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1IR48G-0003nT-3o; Fri, 31 Aug 2007 10:53:44 +0000
Message-ID: <46D7F337.80608@garzik.org>
Date:	Fri, 31 Aug 2007 06:53:43 -0400
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] IOC3: Program UART predividers.
References: <20070826175122.GA16430@linux-mips.org>
In-Reply-To: <20070826175122.GA16430@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> The IOC3 driver's UART detection bits used to rely on the the firmware
> setting the UART pre-divider in a way that's apropriate for the 8250
> driver which doesn't currently program this register.  This happens
> to work for the console but not rarely for additional ports.
> 
> While at it, also program the UART to RS-232 PIO mode; it the UART might
> have been in mac-serial and/or DMA mode though that hasn't actually been
> observed in practice.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

applied
