Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2004 21:08:45 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:21750 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225365AbUAMVIn>;
	Tue, 13 Jan 2004 21:08:43 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id NAA03805;
	Tue, 13 Jan 2004 13:08:36 -0800
Subject: Re: How stable is 2.6 on a SB1250 processor?
From: Pete Popov <ppopov@mvista.com>
To: Kevin Paul Herbert <kph@cisco.com>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <1074027809.20636.91.camel@shakedown>
References: <1074027809.20636.91.camel@shakedown>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1074028164.21857.120.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 Jan 2004 13:09:25 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips


I think userland is still broken. Ralf was working on the access_ok
problem the last time I talked to him.

Pete

On Tue, 2004-01-13 at 13:03, Kevin Paul Herbert wrote:
> I'm working on bringing up the 2.6 kernel on a board using the SB1250
> processor, and I have a problem in userland that I'm wondering if anyone
> else has seen.
> 
> I built a simple test program for userland, which just uses the write()
> syscall to say hello world. This is statically linked, and it works
> under a 2.4 kernel. Under 2.6, I get no output. My guess is that an
> exception is occuring, the signal gets back to my test program, and it
> is looping.
> 
> I've written a simple assembly language hello world program which does
> the exact same thing... write() syscall and I get my hello world.
> 
> My next task is to get kgdb working on this board so I can do some
> better debugging, but I was wondering if anyone else has seen this
> problem, or for that matter whether the SB1 processor support is
> expected to work at all.
> 
> Thanks for any help,
> 
> Kevin
> 
