Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2005 19:24:03 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([IPv6:::ffff:67.116.42.147]:3865
	"EHLO avtrex.com") by linux-mips.org with ESMTP id <S8226101AbVF3SXp>;
	Thu, 30 Jun 2005 19:23:45 +0100
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 30 Jun 2005 11:24:55 -0700
Message-ID: <42C438A1.7050904@avtrex.com>
Date:	Thu, 30 Jun 2005 11:23:29 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Michael Stickel <michael@cubic.org>
CC:	linux-mips@linux-mips.org
Subject: Re: Problems with Intel e100 driver on new MIPS port, was: Advice
 needed WRT very slow nfs in new port...
References: <42C34C4D.9020902@avtrex.com>	<20050629.195743.48512936.imp@bsdimp.com>	<42C359F8.4060000@avtrex.com> <20050629.204246.102671266.imp@bsdimp.com> <42C39066.2060406@cubic.org>
In-Reply-To: <42C39066.2060406@cubic.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jun 2005 18:24:55.0765 (UTC) FILETIME=[03D87050:01C57DA1]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Michael Stickel wrote:
> M. Warner Losh wrote:
> 
>> In message: <42C359F8.4060000@avtrex.com>
>>            David Daney <ddaney@avtrex.com> writes:
>> : M. Warner Losh wrote:
>> : > In message: <42C34C4D.9020902@avtrex.com>
>> : >             David Daney <ddaney@avtrex.com> writes:
>> : > : Does anyone have any idea what would cause 1000mS delay?
>> : > : > That's remarkably close to 1s.  This often indicates that the 
>> transmit
>> : > of your next packet is causing the receive buffer to empty.  This is
>> : > usually due to blocked interrupts, or a failure to enable interrupts.
>> : > : : But I observe ever increasing counts for the device in 
>> /proc/interrupts. :   So the interrupts are working somewhat.
>>
>> Are you sure that you've routed the interrupts correctly?  Maybe those
>> interrupts are 'really' for a different device....
>>  
>>
> Add some debugging to the interrupt routine of the e100 and see what 
> happens.

The interrupt routine is getting called each time a packet is received.

It looks like packets are not being transmitted until the interrupt for 
the the received packet is received.

If I ping the board at different intervals the round trip time is always 
almost exactly equal to the ping interval.  So if I ping every 50mS the 
round trip time is 50mS, ping every 200mS gives a RTT of 200mS, etc.

Any more ideas?

I am thinking that perhaps the CPU write-back-queue is interfearing with 
writes to the NIC's registers.  Perhaps I will try to disable it.

David Daney.
