Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1N8xB202113
	for linux-mips-outgoing; Sat, 23 Feb 2002 00:59:11 -0800
Received: from ayrnetworks.com (earth.ayrnetworks.com [64.166.72.139])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1N8x8902110
	for <linux-mips@oss.sgi.com>; Sat, 23 Feb 2002 00:59:08 -0800
Received: from [192.168.1.5] (IDENT:root@localhost.localdomain [127.0.0.1])
	by  ayrnetworks.com (8.11.6/8.11.2) with ESMTP id g1N7w1e20005;
	Fri, 22 Feb 2002 23:58:01 -0800
Mime-Version: 1.0
X-Sender: kph@127.0.0.1
Message-Id: <a05100300b89cfbd22145@[192.168.1.5]>
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIMELICFAA.mdharm@momenco.com>
References: <NEBBLJGMNKKEEMNLHGAIMELICFAA.mdharm@momenco.com>
Date: Fri, 22 Feb 2002 23:59:34 -0800
To: "Matthew Dharm" <mdharm@momenco.com>,
   "Linux-MIPS" <linux-mips@oss.sgi.com>
From: Kevin Paul Herbert <kph@ayrnetworks.com>
Subject: Re: Anyone have the e1000.o driver working?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

At 4:22 PM -0800 2/22/02, Matthew Dharm wrote:
>Does anyone here have the e1000.o driver from Intel for their gigabit
>ethernet devices working on a MIPS?
>
>After overcoming the intitial CFLAGS problem, the darned thing just
>seems to keep crashing on me during initialization.  I'm looking for a
>datapoint to suggest that it's either (a) a problem with my linux
>port, or (b) a problem with their driver.
>
>Matt
>
>--
>Matthew D. Dharm                            Senior Software Designer
>Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
>(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
>Momentum Works For You                      www.momenco.com

I have the e1000 driver working... I've had 3.0 and 3.5 working. The 
only changes that I made were related to the specifics of the 
software defined I/O pins. Are you sure that you have ioremap() and 
your PCI subsystem working correctly? Have you tested any other 
devices that use registers in PCI memory space, or just PCI i/o space?

Kevin
-- 
