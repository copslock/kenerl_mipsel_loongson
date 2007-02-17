Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Feb 2007 20:39:00 +0000 (GMT)
Received: from srv5.dvmed.net ([207.36.208.214]:12219 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20038580AbXBQUiy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 17 Feb 2007 20:38:54 +0000
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HIWKb-0003Q1-0z; Sat, 17 Feb 2007 20:38:53 +0000
Message-ID: <45D767DC.7000902@garzik.org>
Date:	Sat, 17 Feb 2007 15:38:52 -0500
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20070212)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [IOC3] Fix link autonegotiation timer.
References: <20070217025115.GA20247@linux-mips.org>
In-Reply-To: <20070217025115.GA20247@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> Start link negotiation in the open method.  Previously it was started
> on driver initialialization and shutdown on close so an ifdown would
> have results in closing negotiation for good.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

applied
