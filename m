Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Feb 2005 01:35:15 +0000 (GMT)
Received: from alg138.algor.co.uk ([IPv6:::ffff:62.254.210.138]:62939 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225228AbVBHBfA>; Tue, 8 Feb 2005 01:35:00 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j181U0mY027116;
	Tue, 8 Feb 2005 01:30:00 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j181U0hH027115;
	Tue, 8 Feb 2005 01:30:00 GMT
Date:	Tue, 8 Feb 2005 01:30:00 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	TheNop <TheNop@gmx.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: Kernel crash on yosemite
Message-ID: <20050208013000.GA6131@linux-mips.org>
References: <4207F163.4010605@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4207F163.4010605@gmx.net>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7194
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 07, 2005 at 11:53:23PM +0100, TheNop wrote:

> This is my configuration:
> ~ yosemite board with RM9000 chip revision 1.1
> ~ BusyBox 1.0
> ~ Kernel 2.6.8.1
> 
> When I try to copy a large file (~ 3,5 Mb) within the NFS file system 
> the kernel crashs without any output on the console.
> It could be a problem with the titan_ge driver, but I have no idee how 
> to solve the problem.
> 
> What can I do?

There have been various fixes to the network driver since then so I
recommend you upgrade your kernel.  One problem you're going to encounter
with recent kernels is that they only support the Titan 1.2 part which I
think are the ones in volume production.

  Ralf
