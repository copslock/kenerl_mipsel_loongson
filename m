Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Sep 2004 08:50:45 +0100 (BST)
Received: from adsl-68-124-224-226.dsl.snfc21.pacbell.net ([IPv6:::ffff:68.124.224.226]:48140
	"EHLO goobz.com") by linux-mips.org with ESMTP id <S8224989AbUIPHuk>;
	Thu, 16 Sep 2004 08:50:40 +0100
Received: from [10.2.2.70] (adsl-63-194-214-47.dsl.snfc21.pacbell.net [63.194.214.47])
	by goobz.com (8.10.1/8.10.1) with ESMTP id i8G7obH32616;
	Thu, 16 Sep 2004 00:50:37 -0700
Message-ID: <414945BE.8010306@embeddedalley.com>
Date: Thu, 16 Sep 2004 00:50:22 -0700
From: Pete Popov <ppopov@embeddedalley.com>
Organization: Embedded Alley Solutions, Inc
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexey Shinkin <alexshinkin@hotmail.com>
CC: linux-mips@linux-mips.org
Subject: Re: Au1550 -  Problem access Shared memory from PCI card
References: <BAY15-F40hAOylhgnFZ0009083e@hotmail.com>
In-Reply-To: <BAY15-F40hAOylhgnFZ0009083e@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


>
> After I recompiled the driver and the application for MIPS platform I 
> got the following:
> 1. The driver on the MIPS board (host) finds the PCI card (target)
> 2. I download an executable code into target and start target 
> application (application starts, debug info is written to target memory).
> 3. Target starts to communicate with host using shared 
> memory,allocated on host, (target accesses the memory through PCI).
>
> After that I get the following problem:
>
> 4. Target writes some values into Host's shared memory and generates 
> interrupt on Host.
> 5. Host catches the interrupt and in interrupt handler reads the 
> values, written by target.

So the host at this point reads the correct values written by the target?

> 6. Host writes some replay to the shared memory, generates PCI 
> interrupt on Target.

When you say "host", is this the user application that is writing to the 
shared memory after remmaping it, or is the host driver itself writing 
to the shared memory from kernel space?

> 7. Target gets interrupt but can not see the latest values, written by 
> Host. Reading the shared memory several times doesn' t help.
>
> Looks like target reads values that are cached somewhere . I tried to 
> insert au_sync(), au_sync_delay(), flush_cache_all() on Host side 
> after writting values - nothing helps.

>
> On x86 this approach works fine.
>
> What could be the reason? Could this be hardware problem or can be 
> fixed by fine-tuning 

> of caching parameters or PCI controller ?

There's no reason why this shouldn't work and it doesn't smell like a 
hardware problem.

Pete
