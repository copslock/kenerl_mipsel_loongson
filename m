Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Mar 2006 02:13:10 +0000 (GMT)
Received: from 67-129-173-13.dia.static.qwest.net ([67.129.173.13]:27548 "EHLO
	alfalfa.fortresstech.com") by ftp.linux-mips.org with ESMTP
	id S8133544AbWCQCNA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 17 Mar 2006 02:13:00 +0000
Received: from [172.26.52.4] ([172.26.52.4]) by alfalfa.fortresstech.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 16 Mar 2006 21:22:16 -0500
Message-ID: <441A1D53.6080305@fortresstech.com>
Date:	Thu, 16 Mar 2006 21:22:11 -0500
From:	Steve Lazaridis <slaz@fortresstech.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To:	oprofile-list@lists.sourceforge.net
CC:	linux-mips@linux-mips.org
Subject: au1550 oprofile
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Mar 2006 02:22:16.0806 (UTC) FILETIME=[9C39B860:01C64969]
Return-Path: <SLaz@fortresstech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: slaz@fortresstech.com
Precedence: bulk
X-list: linux-mips

Has anyone successfully ran oprofile on an au1550?
If so, was it in BigEndian mode?

Are there any known issues with oprofile on au1xxx platforms?


Here's some information on what I'm currently running.
Oprofile version:  oprofile 0.9.2cvs
Oprofile kernel:   driver: 2.6.15
Kernel version:    2.6.13rc7 ~ from linux-mips
Endianess:  	   Big

I'm running in __timer mode__, I can't use performance counters.

What I did was take the latest version of the oprofile kernel driver 
from 2.6.15 and backport all the changes.  I also merged in the latest 
changes for the arch/mips/oprofile stuff too.

That finally got the driver to compile and load on the target.

I then attempted the following:
opcontrol --no-vmlinux
opcontrol --start
/usr/bin/app_that_Uses_up_CPU
opcontrol --shutdown

opcontrol --dump   <--- returns nothing

opreport -l 	   <--- returns the following:
opreport error: No sample file found: try running opcontrol --dump
or specify a session containing sample files


I then realized that the timer_interupt handler wasn't being called.  I 
fixed that, so now I can actually see the 
/dev/oprofile/stats/cpu0/sample_received  being increased.
__but__ I still have no output from the opreport or opcontrol --dump


At this point I'm asking for help, any tips or hints are much appreciated.


Cheers,
Steve
