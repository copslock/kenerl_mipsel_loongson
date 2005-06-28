Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jun 2005 22:54:31 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([IPv6:::ffff:67.116.42.147]:46875
	"EHLO avtrex.com") by linux-mips.org with ESMTP id <S8226073AbVF1VyO>;
	Tue, 28 Jun 2005 22:54:14 +0100
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 28 Jun 2005 14:55:10 -0700
Message-ID: <42C1C6EA.5080709@avtrex.com>
Date:	Tue, 28 Jun 2005 14:53:46 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Advice needed WRT very slow nfs in new port...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jun 2005 21:55:10.0796 (UTC) FILETIME=[0E29E8C0:01C57C2C]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

I am trying to port 2.6.12 to a 32 bit SOC (ATI Xilleon).  The same 
system is current running 2.4.29 with no problems.

I have an Intel Pro/100M Ethernet adapter on the PCI bus that I use to 
mount the root file system via nfs.  There is also an ohci usb adapter 
on the bus.

My problem is that with my new 2.6.12 port the NFS is very slow.  It 
takes about 10 minutes to mount the root filesystem, run init and 
finally run a shell on the serial port and present the shell prompt. 
Running commands like 'ls' works but can take 15 seconds in a small 
directory.

On the same hardware running 2.4.29 the system boots in 15 seconds and 
there is no delay for the 'ls'.

One theory I have is that there is a problem in either the interrupt or 
timer code somewhere.  My evidence for this is that if I repeatedly plug 
and unplug a usb memory device things run more quickly.  I think the 
interrupts from the USB may be kicking things into action.

Any pointers about where to look would be most appreciated.

Thanks
David Daney
