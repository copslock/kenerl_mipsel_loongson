Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2008 10:11:26 +0000 (GMT)
Received: from mail.gmx.net ([213.165.64.20]:43737 "HELO mail.gmx.net")
	by ftp.linux-mips.org with SMTP id S28582110AbYCMKLX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 13 Mar 2008 10:11:23 +0000
Received: (qmail invoked by alias); 13 Mar 2008 10:11:18 -0000
Received: from dslb-088-072-160-137.pools.arcor-ip.net (EHLO [192.168.1.100]) [88.72.160.137]
  by mail.gmx.net (mp031) with SMTP; 13 Mar 2008 11:11:18 +0100
X-Authenticated: #44099387
X-Provags-ID: V01U2FsdGVkX196R68d3fx6t1RXnlzPgA5daTNxwA4CTn0I3TElMe
	a5lwc0xVN3cImX
Message-ID: <47D8FDC5.6030601@gmx.net>
Date:	Thu, 13 Mar 2008 11:11:17 +0100
From:	Andi <opencode@gmx.net>
User-Agent: Thunderbird 2.0.0.12 (X11/20080227)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Problems booting Linux kernel on Sigma SMP8634 #2
References: <47CE9388.9050808@gmx.net> <47CED252.20800@avtrex.com> <47CEE58C.7020507@gmx.net>
In-Reply-To: <47CEE58C.7020507@gmx.net>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Return-Path: <opencode@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: opencode@gmx.net
Precedence: bulk
X-list: linux-mips

Hi,

in reply to myself, just in case its useful for somebody else ..
There seems to be a memory limitation for Linux running on the SMP8634!
While giving Linux access to not more than half of the total RAM minus
some (4?) MB the kernel works pretty well!

And even more interesting: one can download the smp8634 kernel sources
for Sony devices on their support pages.

Cheers,
	Andi



Andi wrote:
> Hi,
> 
>> I build and successfully run kernels on the 8634 every day, so I don't
>> think it is a problem with the 8634 port in general.
>>
>> You should probably ask for technical support from whomever supplied
>> your hardware.  They would know the technical details about how to
>> configure the memory controller, the amount and location of the RAM on
>> the board, etc.
> 
> Thats right. And I would really like to do so. But unfortunately there
> is not much information around about the hardware. Since the box
> originally runs a wince system, this project is more like a _free time_
> projects of some Linux enthusiasts.
> 
> You can get a overview about this here: http://www.t-hack.com/wiki/
> There is also a forum, but unfortunately most posts are in German ..
> 
>>> I am sure there some more guys around using the smp8634.
>> Likely there are.  It is used in many blu-ray disk players, among other
>> things.
> 
> Ok, there is not much information about the smp8634 out there, which is
> really a pity. I know that Sigma is not really interested in publishing
> there specifications. Even the gpl part is not published, but I am sure
> you already know this :-)
> 
> Do you know how to get some more detailed information about the smp8634?
> 
> Ok, there are some parts that are not equal, like memory and flash! But
> this is a SoC, so most parts are the same.
> 
> 
>> N/A, the kernel does not rely on any microcode.
> 
> Ok, thanks, so we can cancel this on our todo-list ..
> 
> 
> 
> Regards,
> 	Andi
> 
> 
> 
> 
