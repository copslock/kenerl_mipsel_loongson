Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Mar 2008 18:25:29 +0000 (GMT)
Received: from mail.gmx.net ([213.165.64.20]:45504 "HELO mail.gmx.net")
	by ftp.linux-mips.org with SMTP id S28603017AbYCESZ0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 5 Mar 2008 18:25:26 +0000
Received: (qmail invoked by alias); 05 Mar 2008 18:25:20 -0000
Received: from vpn27.rz.tu-ilmenau.de (EHLO [192.168.1.100]) [141.24.172.27]
  by mail.gmx.net (mp047) with SMTP; 05 Mar 2008 19:25:20 +0100
X-Authenticated: #44099387
X-Provags-ID: V01U2FsdGVkX18ywJsmrzYydDPYR/YZLIVkeDgiCCg7zLKa3icl4n
	Z0AsugO2yLUOZ6
Message-ID: <47CEE58C.7020507@gmx.net>
Date:	Wed, 05 Mar 2008 19:25:16 +0100
From:	Andi <opencode@gmx.net>
User-Agent: Thunderbird 2.0.0.12 (X11/20080227)
MIME-Version: 1.0
To:	David Daney <ddaney@avtrex.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Problems booting Linux kernel on Sigma SMP8634 #2
References: <47CE9388.9050808@gmx.net> <47CED252.20800@avtrex.com>
In-Reply-To: <47CED252.20800@avtrex.com>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Return-Path: <opencode@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: opencode@gmx.net
Precedence: bulk
X-list: linux-mips

Hi,

> I build and successfully run kernels on the 8634 every day, so I don't
> think it is a problem with the 8634 port in general.
> 
> You should probably ask for technical support from whomever supplied
> your hardware.  They would know the technical details about how to
> configure the memory controller, the amount and location of the RAM on
> the board, etc.

Thats right. And I would really like to do so. But unfortunately there
is not much information around about the hardware. Since the box
originally runs a wince system, this project is more like a _free time_
projects of some Linux enthusiasts.

You can get a overview about this here: http://www.t-hack.com/wiki/
There is also a forum, but unfortunately most posts are in German ..

>> I am sure there some more guys around using the smp8634.
> 
> Likely there are.  It is used in many blu-ray disk players, among other
> things.

Ok, there is not much information about the smp8634 out there, which is
really a pity. I know that Sigma is not really interested in publishing
there specifications. Even the gpl part is not published, but I am sure
you already know this :-)

Do you know how to get some more detailed information about the smp8634?

Ok, there are some parts that are not equal, like memory and flash! But
this is a SoC, so most parts are the same.


> N/A, the kernel does not rely on any microcode.

Ok, thanks, so we can cancel this on our todo-list ..



Regards,
	Andi
