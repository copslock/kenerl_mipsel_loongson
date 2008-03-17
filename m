Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Mar 2008 12:13:32 +0000 (GMT)
Received: from srv5.dvmed.net ([207.36.208.214]:18920 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S28599971AbYCQMNa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 17 Mar 2008 12:13:30 +0000
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1JbEDY-0006Mp-2o; Mon, 17 Mar 2008 12:13:28 +0000
Message-ID: <47DE6067.6070500@garzik.org>
Date:	Mon, 17 Mar 2008 08:13:27 -0400
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [IOC3] Fix section missmatch
References: <20080308165833.GA8625@linux-mips.org>
In-Reply-To: <20080308165833.GA8625@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
>   LD      drivers/net/built-in.o
> WARNING: drivers/net/built-in.o(.text+0x3468): Section mismatch in reference fro
> m the function ioc3_probe() to the function .devinit.text:ioc3_serial_probe()
> The function ioc3_probe() references
> the function __devinit ioc3_serial_probe().
> This is often because ioc3_probe lacks a __devinit 
> annotation or the annotation of ioc3_serial_probe is wrong.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> ---
> Resend, this time with Jeff's address corrected.

applied
