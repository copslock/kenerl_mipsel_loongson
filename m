Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2004 19:08:52 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:22004 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225204AbUJUSIh>; Thu, 21 Oct 2004 19:08:37 +0100
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id B62DE18479; Thu, 21 Oct 2004 11:08:35 -0700 (PDT)
Message-ID: <4177FB23.8000203@mvista.com>
Date: Thu, 21 Oct 2004 11:08:35 -0700
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: linux-mips@linux-mips.org
Subject: Re: yosemite interrupt setup
References: <200410201952.29205.thomas.koeller@baslerweb.com> <200410211149.35300.thomas.koeller@baslerweb.com> <4177E5F6.3010100@mvista.com> <200410211958.24269.thomas.koeller@baslerweb.com>
In-Reply-To: <200410211958.24269.thomas.koeller@baslerweb.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6167
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Hi Thomas,

Thomas Koeller wrote:
> On Thursday 21 October 2004 18:38, Manish Lachwani wrote:
> 
>>Hi Thomas
>>
>>No, these should remain in the Ethernet driver. Thats because no other
>>driver depends on these. Those registers are MAC subsystem registers
>>only. The ethernet driver does not do any interrupt setup for other
>>devices.
> 
> 
> Hi Manish,
> 
> first of all, forget about the yosemite, as I am no longer using it. I
> am currently working on our own platform port.

I did not know abt this. I have referred to Yosemite in the past posts

> 
> All the components of the Ethernet/GPI subsystem interrupt the CPU
> through the interrupt vector established by writing to the CPCFG0 and
> CPCFG1 registers. So if I want to write a driver that uses one of
> the GPIs, or the DUART, or a watchdog counter, or the two-bit interface,
> or any other component of the subsystem, then this driver will be
> dependent of the ethernet driver. Have a look at the manual if
> you do not believe me. The titan ethernet driver is the only one to
> use this interrupt _on_the_yosemite_, but this is only because all the
> other components are not used at all.

I will check the manual and get back. In case of Yosemite, the GE unit 
is the only one using this vector register.

> 
> The interrupt setup should definitly be in the platform - please reconsider
> your position.
> 
> thanks,
> Thomas
> 

Thanks
Manish Lachwani
