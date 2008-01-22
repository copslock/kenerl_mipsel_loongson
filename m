Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jan 2008 22:34:36 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:20670 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28590996AbYAVWe2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 Jan 2008 22:34:28 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JHRhL-0000s8-00; Tue, 22 Jan 2008 23:34:27 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 6026EC2F86; Tue, 22 Jan 2008 23:33:32 +0100 (CET)
Date:	Tue, 22 Jan 2008 23:33:32 +0100
To:	gigo@poczta.ibb.waw.pl
Cc:	linux-mips@linux-mips.org
Subject: Re: Old Indy, 64-bit setup
Message-ID: <20080122223332.GA11444@alpha.franken.de>
References: <Pine.LNX.4.64.0801222106460.31014@poczta.ibb.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0801222106460.31014@poczta.ibb.waw.pl>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Tue, Jan 22, 2008 at 10:10:37PM +0100, gigo@poczta.ibb.waw.pl wrote:
> Just a silly question. Is there any working 64-bit kernel configuration 
> for my r4k 100MHz Indy? From time to time i compile another new kernel for 
> 64-bit... and see the thing dying. Recently it looked pretty well like 

your CPU needs a special gcc to avoid triggering 64bit CPU bugs. There
are also some kernel workarounds missing, which are scheduled for 2.6.25.
No idea about the gcc part.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
