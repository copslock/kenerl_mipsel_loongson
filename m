Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Apr 2005 17:27:46 +0100 (BST)
Received: from smtp002.bizmail.yahoo.com ([IPv6:::ffff:216.136.172.126]:46983
	"HELO smtp002.bizmail.yahoo.com") by linux-mips.org with SMTP
	id <S8225304AbVDEQ1a>; Tue, 5 Apr 2005 17:27:30 +0100
Received: from unknown (HELO ?192.168.1.101?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp002.bizmail.yahoo.com with SMTP; 5 Apr 2005 16:27:27 -0000
Message-ID: <4252BC7C.6060806@embeddedalley.com>
Date:	Tue, 05 Apr 2005 09:27:40 -0700
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To:  ppopov@embeddedalley.com
Organization: Embedded Alley Solutions, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Gill Robles-Thome <gill.robles@exterity.co.uk>
CC:	linux-mips@linux-mips.org
Subject: Re: No PCI memory response
References: <CEA5455795C8AA44AA1E18EF32379B2105CF93@exterity-serv1.Exterity.local>
In-Reply-To: <CEA5455795C8AA44AA1E18EF32379B2105CF93@exterity-serv1.Exterity.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Gill Robles-Thome wrote:
> ...we found the cause of the problem!  Need to select "Support for
> 64-bit physical address space" option!

That option should be in the defconfig already - was it not?

I should just hardcode that option and get it over with.

Pete

> 
> Gill
> 
> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Gill Robles-Thome
> Sent: 05 April 2005 09:11
> To: linux-mips@linux-mips.org
> Subject: RE: No PCI memory response
> 
> 
> Hi -
> 
> I'm certainly seeing what looks like random reads...however, is the
> static bus controller actually implicated in PCI bus operations?  The
> product brief for the Au1100 doesn't mention PCI, so I'm not sure that
> we're looking at the same problem.
> 
> Thanks,
> Gill
> 
> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Ulrich Eckhardt
> Sent: 04 April 2005 15:53
> To: linux-mips@linux-mips.org
> Subject: Re: No PCI memory response
> 
> 
> Gill wrote:
> 
>>Can anyone help?  We're trying to talk to a RealTek RTL8139 device
>>across the PCI bus, and, although linux can access configuration 
>>registers on the device, it does not access memory space correctly, 
>>and we are unable to read back any sensible values from the RTL8139 
>>registers.
>>
>>We are using the latest 2.6 linux on an Alchemy DB1550 board.
> 
> 
> Random reads, discarded data after writing? I had the same problem and
> solved 
> it by simply configuring the static bus controller of my Au1100 properly
> (of 
> which before I didn't even know it existed...).
> 
> hth
> 
> Uli
> 
> 
> 
> 
> 
> 
