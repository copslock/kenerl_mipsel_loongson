Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2009 00:24:47 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9930 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493847AbZJVWYl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2009 00:24:41 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ae0dba50001>; Thu, 22 Oct 2009 15:24:37 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 22 Oct 2009 15:24:24 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 22 Oct 2009 15:24:24 -0700
Message-ID: <4AE0DB98.1000101@caviumnetworks.com>
Date:	Thu, 22 Oct 2009 15:24:24 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Chris Friesen <cfriesen@nortel.com>
CC:	netdev@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Irq architecture for multi-core network driver.
References: <4AE0D14B.1070307@caviumnetworks.com> <4AE0D72A.4090607@nortel.com>
In-Reply-To: <4AE0D72A.4090607@nortel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2009 22:24:24.0781 (UTC) FILETIME=[690E87D0:01CA5366]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Chris Friesen wrote:
> On 10/22/2009 03:40 PM, David Daney wrote:
> 
>> The main problem I have encountered is how to fit the interrupt
>> management into the kernel framework.  Currently the interrupt source
>> is connected to a single irq number.  I request_irq, and then manage
>> the masking and unmasking on a per cpu basis by directly manipulating
>> the interrupt controller's affinity/routing registers.  This goes
>> behind the back of all the kernel's standard interrupt management
>> routines.  I am looking for a better approach.
>>
>> One thing that comes to mind is that I could assign a different
>> interrupt number per cpu to the interrupt signal.  So instead of
>> having one irq I would have 32 of them.  The driver would then do
>> request_irq for all 32 irqs, and could call enable_irq and disable_irq
>> to enable and disable them.  The problem with this is that there isn't
>> really a single packets-ready signal, but instead 16 of them.  So If I
>> go this route I would have 16(lines) x 32(cpus) = 512 interrupt
>> numbers just for the networking hardware, which seems a bit excessive.
> 
> Does your hardware do flow-based queues?  In this model you have
> multiple rx queues and the hardware hashes incoming packets to a single
> queue based on the addresses, ports, etc. This ensures that all the
> packets of a single connection always get processed in the order they
> arrived at the net device.
> 

Indeed, this is exactly what we have.


> Typically in this model you have as many interrupts as queues
> (presumably 16 in your case).  Each queue is assigned an interrupt and
> that interrupt is affined to a single core.

Certainly this is one mode of operation that should be supported, but I 
would also like to be able to go for raw throughput and have as many 
cores as possible reading from a single queue (like I currently have).

> 
> The intel igb driver is an example of one that uses this sort of design.
> 

Thanks, I will look at that driver.

David Daney
