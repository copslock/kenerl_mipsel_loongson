Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jan 2005 16:32:08 +0000 (GMT)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:50823 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225410AbVAGQcD>; Fri, 7 Jan 2005 16:32:03 +0000
Received: from sjhill by real.realitydiluted.com with local (Exim 4.34 #1 (Debian))
	id 1Cmx1s-0002Tz-2d; Fri, 07 Jan 2005 10:32:00 -0600
Subject: Re: Problem with MV64340 serial driver
In-Reply-To: <41DEB874.8000809@enix.org>
To: Thomas Petazzoni <thomas.petazzoni@enix.org>
Date: Fri, 7 Jan 2005 10:32:00 -0600 (CST)
CC: linux-mips@linux-mips.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E1Cmx1s-0002Tz-2d@real.realitydiluted.com>
From: sjhill@realitydiluted.com
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

> 
> Thanks for the information. I have been inside linux-2.5-marvell BK 
> tree, but I couldn't find the drivers/serial/mpsc directory, nor to find 
> the driver for the 64340 serial port.
> 
That driver is for the 64360, but my point is that it should work with
minor modifications on the 64340. I apologize if I was not clear.

-Steve
