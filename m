Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Dec 2004 01:05:56 +0000 (GMT)
Received: from smtp105.rog.mail.re2.yahoo.com ([IPv6:::ffff:206.190.36.83]:5244
	"HELO smtp105.rog.mail.re2.yahoo.com") by linux-mips.org with SMTP
	id <S8225346AbULIBFu>; Thu, 9 Dec 2004 01:05:50 +0000
Received: from unknown (HELO ?192.168.1.100?) (charles.eidsness@rogers.com@24.157.59.167 with plain)
  by smtp105.rog.mail.re2.yahoo.com with SMTP; 9 Dec 2004 01:05:43 -0000
Message-ID: <41B7A4CF.7090203@ieee.org>
Date: Wed, 08 Dec 2004 20:05:19 -0500
From: Charles Eidsness <charles.eidsness@ieee.org>
Reply-To: charles.eidsness@ieee.org
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ppopov@embeddedalley.com
CC: linux-mips@linux-mips.org
Subject: Re: Au1000 Ethernet Driver using NAPI
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <charles.eidsness@ieee.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: charles.eidsness@ieee.org
Precedence: bulk
X-list: linux-mips

Pete Popov wrote:
 >
 >Very cool, thanks. Is the patch for 2.4 or 2.6?
 >
 >Pete

Hi Pete,

It's for 2.6, I'm not sure if it will work on 2.4.

There are a couple of possible issues with this method that I probably 
should have mentioned in my first email. Since the Au1000 shares an 
interrupt for the TX and RX streams I had to lump the two together and 
as a result there may be an increase in TX latency. Also, the MAC's DMA 
can only queue up a maximum of 4 packets at a time so depending on how 
long the processor spends clearing out the queue there may be some 
buffer overruns. I've experienced neither of these issues but my testing 
so far has been pretty application specific.

Cheers,
Charles

Charles Eidsness wrote:
 > Hi All,
 >
 > I was having a problem running a streaming audio application on my
 > Au1000 processor when the Ethernet port was being bombarded with
 > packets. All of the interrupt servicing was hogging my precious
 > processing power and there was nothing left for my app. There's a new
 > method for writing Ethernet drivers called NAPI which resolves this
 > issue (somewhat). I converted the au1000's Ethernet driver to use
this
 > method. If you're interested you can find a patch that applys my
changes
 > to the most recent kernel here:
 >
 >
http://members.rogers.com/charles.eidsness/linux-au1000_eth.napi.patch
 >
 > Cheers,
 > Charles
 >
 >
