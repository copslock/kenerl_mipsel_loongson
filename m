Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2005 02:35:45 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([IPv6:::ffff:67.116.42.147]:57108
	"EHLO avtrex.com") by linux-mips.org with ESMTP id <S8226078AbVF3Bf3>;
	Thu, 30 Jun 2005 02:35:29 +0100
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 29 Jun 2005 18:36:34 -0700
Message-ID: <42C34C4D.9020902@avtrex.com>
Date:	Wed, 29 Jun 2005 18:35:09 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org, Linux NICS <linux.nics@intel.com>
Subject: Problems with Intel e100 driver on new MIPS port, was: Advice needed
 WRT very slow nfs in new port...
References: <42C1C6EA.5080709@avtrex.com>
In-Reply-To: <42C1C6EA.5080709@avtrex.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jun 2005 01:36:34.0984 (UTC) FILETIME=[2691E280:01C57D14]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8250
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> I am trying to port 2.6.12 to a 32 bit SOC (ATI Xilleon).  The same 
> system is current running 2.4.29 with no problems.
> 
> I have an Intel Pro/100M Ethernet adapter on the PCI bus that I use to 
> mount the root file system via nfs.  There is also an ohci usb adapter 
> on the bus.
> 
> My problem is that with my new 2.6.12 port the NFS is very slow.  It 
> takes about 10 minutes to mount the root filesystem, run init and 
> finally run a shell on the serial port and present the shell prompt. 
> Running commands like 'ls' works but can take 15 seconds in a small 
> directory.
> 
> On the same hardware running 2.4.29 the system boots in 15 seconds and 
> there is no delay for the 'ls'.
> 
> One theory I have is that there is a problem in either the interrupt or 
> timer code somewhere.  My evidence for this is that if I repeatedly plug 
> and unplug a usb memory device things run more quickly.  I think the 
> interrupts from the USB may be kicking things into action.
> 
> Any pointers about where to look would be most appreciated.

Here is an update:

The CPU is a 32 bit MIPS 4Ke core (little endian).

My problem is only experienced with the drivers/net/e100.c driver.  When 
I use an RTL8100 with the 8139too driver the network seems to work fine.

The Intel driver reports to be:
e100: Intel(R) PRO/100 Network Driver, 3.4.8-k2-NAPI

I am just bringing the 2.6.12 kernel up on the board so it is quite 
possible that I have screwed something up in the board specific portion 
of the kernel.

When using the Intel Pro/100M NIC the network seems to work fine in all 
respects except for the speed issue.  If i run ping (either from the 
board or to the board from an external host) I get round trip times of 
almost exactly 1000mS.

With the same Intel NIC and the 2.4.29 kernel using the e100 driver I 
have no problems, so I don't think it is a hardware issue.

Does anyone have any idea what would cause 1000mS delay?

Thanks in advance for any insight,
David Daney
