Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Sep 2003 22:05:22 +0100 (BST)
Received: from p508B7C78.dip.t-dialin.net ([IPv6:::ffff:80.139.124.120]:57282
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225437AbTI2VFR>; Mon, 29 Sep 2003 22:05:17 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h8TL53NK026325;
	Mon, 29 Sep 2003 23:05:04 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h8TL51lg026324;
	Mon, 29 Sep 2003 23:05:01 +0200
Date: Mon, 29 Sep 2003 23:05:01 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Adeel Malik <AdeelM@avaznet.com>
Cc: Steffen Malmgaard Mortensen <smm@futarque.com>,
	linux-mips@linux-mips.org
Subject: Re: How to increase download speed for UART
Message-ID: <20030929210501.GA4231@linux-mips.org>
References: <10C6C1971DA00C4BB87AC0206E3CA38264ED84@1aurora.enabtech>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10C6C1971DA00C4BB87AC0206E3CA38264ED84@1aurora.enabtech>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 29, 2003 at 12:41:02PM +0500, Adeel Malik wrote:

>     The terminal emulator that you specified supports the max. baud rate of
> 115.2 kbps. And it is taking about 7 minutes to download the Kernel Image of
> 4.3 MB. Do you know some other Terminal Emulator that can support a higher
> baud rate ?.
> 
> The UART of the target processor supports the max. baud rate of 406 kbps. So
> I can use the terminal emulator that supports for example, 406kbps, then my
> download time may be further reduced.

115,200 bps is frequently the maximum supported rate of serial interfaces,
so it may be time to find some faster medium.  You may also want to
experiment with compressed kernels.

  Ralf
