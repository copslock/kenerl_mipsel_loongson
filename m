Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Sep 2004 05:12:12 +0100 (BST)
Received: from mail04.syd.optusnet.com.au ([IPv6:::ffff:211.29.132.185]:2432
	"EHLO mail04.syd.optusnet.com.au") by linux-mips.org with ESMTP
	id <S8224907AbUIHEMH>; Wed, 8 Sep 2004 05:12:07 +0100
Received: from [10.1.1.3] (d211-31-77-55.dsl.nsw.optusnet.com.au [211.31.77.55] (may be forged))
	(authenticated bits=0)
	by mail04.syd.optusnet.com.au (8.12.11/8.12.11) with ESMTP id i884BwrX005988
	for <linux-mips@linux-mips.org>; Wed, 8 Sep 2004 14:11:58 +1000
Message-ID: <413E84E2.4060401@optusnet.com.au>
Date: Wed, 08 Sep 2004 14:04:50 +1000
From: Glenn Barry <glennrbarry@optusnet.com.au>
Reply-To: glennrbarry@optusnet.com.au
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: SGI O2 Prom modification
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <glennrbarry@optusnet.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: glennrbarry@optusnet.com.au
Precedence: bulk
X-list: linux-mips

Hi There,

I have two questions related to MIPS which someone may be able to help 
with. Sorry for the long post.

Firstly I don't know if you've heard about the upgrading of the RM5200 
300MHz CPU modules in SGI O2's with RM7000C 600MHz chips.

You can read about it at www.nekochan.net.

My question is about the possibility of someone helping out with 
modifying the O2's PROM to recognise the RM7900 CPU from PMC-Sierra.

Currently the RM7000C running at 600Mhz is a working modification. The 
RM7900 runs at up to 900Mhz and would breathe new life into the little O2's.

Details from a post on nekochan.net as to what needs to be done:

http://forums.nekochan.net/viewtopic.php?t=3314

This guy was the one who has pioneered all of the CPU upgrades currently 
going on with SGI machines.

"For the O2, when you start the computer the CPU board reads the data 
from the boot-mode PROM chip (the Xilinx chip) into specific registers 
on the CPU chip and does a Power On Self Test (POST). If the POST 
passes, the ip32PROM then reads that data from the specific CPU chip 
registers and checks that the CPU module is returning data values the 
ip32PROM recognizes and passes those data values on to IRIX for the 
system. The problem is that the data is in different registers and has 
different values for the RM7900 series of chips than the RM7000 series 
of chips. The RM7000 chips and the RM5270 chips use the same data 
registers so the ip32PROM sees the RM7000 chips just fine, not so with 
the RM7900 chips. When ip32PROM does not see a data value it recognizes 
(for whatever reason), it halts the system at that point.
So at least three things need to be done to get this project back on track:
1.) a way needs to be found to tell the ip32PROM the correct registers 
to look in for the data on the RM7900 CPU chip
2.) new values need to be added to the ip32PROM's list of possibe data 
values for a couple of items
3.) the setup for the L2 cache in the ip32PROM needs to be changed as 
the RM7900 chips start the cache memory at a different memory location 
than the RM7000 chips
If there is someone out there who understands the ip32PROM and how to 
modify the bin file, I will help them any way I can but the software 
part of this is beyond my understanding."

If anyone can help out with this, or know someone who can help, it would 
be much apreciated.

Secondly.

Not having played with Linux on my O2, I don't know the details, but are 
you able to run dual monitors with a second video card in the PCI slot?

If so does anyone think it would be possible to port a video card driver 
to Irix to be able run a second screen. Unfortunately the dualhead 
monitor adaptor isn't really an option as they are very difficult to 
find and expensive.

Thanks

Glenn
