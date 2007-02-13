Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2007 07:52:58 +0000 (GMT)
Received: from roasted.cubic.org ([193.108.181.130]:21670 "EHLO
	roasted.cubic.org") by ftp.linux-mips.org with ESMTP
	id S20038718AbXBMHwu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Feb 2007 07:52:50 +0000
Received: from c145138.adsl.hansenet.de ([213.39.145.138] helo=cubic.org)
	by roasted.cubic.org with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.36 #1)
	id 1HGsPw-0005gA-00
	for linux-mips@linux-mips.org; Tue, 13 Feb 2007 08:49:36 +0100
Message-ID: <45D16D8B.40401@cubic.org>
Date:	Tue, 13 Feb 2007 08:49:31 +0100
From:	Michael Stickel <michael@cubic.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: AU1100 Ethernet problems
References: <45D154C2.9030809@tin.it>
In-Reply-To: <45D154C2.9030809@tin.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <michael@cubic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael@cubic.org
Precedence: bulk
X-list: linux-mips

Lucio Dona' wrote:

> When the boards are powered up without Ethernet cable plugged-in, and 
> the Ethernet is initialized, it seems that the system gets a lot of 
> 'rx interrupts' and stays almost all the time inside the Ethernet rx 
> interrupt service routine.
> This horribly slows down everything and causes the watchdog to come up 
> resetting the board.
>
> Tried to make some debugging, but don't understand why there are all 
> those interrupts.
>
> If the system is powered up with the Ethernet cable connected to a 
> simple hub (hub only, no other computers connected to the net) the 
> problem does not occur.
>
> I have this problem on about 10% boards.
> The design is based on AMD Syrah reference schematics, the kernel is 
> 2.4.21-pre4. Searching with oscilloscope there is no apparent 
> 'hardware' difference between a 'bad' board and a good one.

If this is on 10% of the boards I would say it is a production problem.

What PHY do you use and is it properly reseted?
Is there any soldering problem with the PHY. Does it have a ground pad 
under the case and is this pad well soldered?

Regards,
Michael
