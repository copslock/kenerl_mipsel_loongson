Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2014 13:38:04 +0100 (CET)
Received: from resqmta-po-11v.sys.comcast.net ([96.114.154.170]:35577 "EHLO
        resqmta-po-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013920AbaKRMiCfNQhW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Nov 2014 13:38:02 +0100
Received: from resomta-po-09v.sys.comcast.net ([96.114.154.233])
        by resqmta-po-11v.sys.comcast.net with comcast
        id H0dZ1p00552QWKC010dw12; Tue, 18 Nov 2014 12:37:56 +0000
Received: from [192.168.1.13] ([76.100.35.31])
        by resomta-po-09v.sys.comcast.net with comcast
        id H0du1p00L0gJalY010dvMQ; Tue, 18 Nov 2014 12:37:56 +0000
Message-ID: <546B3D9C.6000104@gentoo.org>
Date:   Tue, 18 Nov 2014 07:37:48 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: IP30: SMP Help
References: <5457187D.6030708@gentoo.org> <54607499.2070806@gentoo.org> <546B11C0.90805@gentoo.org> <alpine.LFD.2.11.1411180946130.4773@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1411180946130.4773@eddie.linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1416314276;
        bh=O+Y560jsWMG8BWdVKr2cL5RLNVLYQCTZWuMWXMCjNlU=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=aLlGg459vljyFDfrqHN6oke1x0Aw7xYdr0X4vobA7duRqlNcsFXEuXahLrYO9A4Up
         LfKDOSWakBQIP36dP1w5kPUH+ytWG+zEzUr/+h52sOOUxZoqWtYrHP/eASzxHa2c0P
         vSzxLDnVMW5vD7THovBbuWG7L7h3X7Wv0eDG700g+uWdvjYTzlG4m8/iVo9YWIEemL
         ipFod3Sz3Gh6zNKaTRx8FsMgPtg57+0I5yXuq+zxUUCGjr4qf5imS7Z2kOjJ3EuENG
         9vFP8h85Owy+RouTfEamGRYfVspmORTLFu2rDsNrIhQgHZLrx8NPodN7hPEqIoazyo
         Sips0G0ZL4lkQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44268
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 11/18/2014 05:05, Maciej W. Rozycki wrote:
> On Tue, 18 Nov 2014, Joshua Kinard wrote:
> 
>> What is wrong with these stack addresses?  This is the result of disabling CPU1
>> in the PROM and booting an SMP kernel.  It's like both the low 32-bits and high
>> 32-bits of the data in the CPU registers are getting merged together somehow
>> when they're added to the stack.
>>
>> I can't think of anything in Octane's code doing this.  Has anyone seen
>> something like this before?  This is likely the cause of the SIGSEGV/SIGBUS
>> signals I keep getting.
>>
>> CPU: 0 PID: 54 Comm: grep Not tainted 3.18.0-rc4 #194
>> task: a800000059b80000 ti: a8000000595c4000 task.ti: a8000000595c4000
>> $ 0   : 0000000000000000 ffffffff9004fce0 ffffffffffffffff ffffffffffffffff
>> $ 4   : 0000000077d809a0 0000000000000000 ffffffffffffffff ffffffffffffffff
>> $ 8   : 0000000000440f14 0000000000439bdc 0000000000000058 0000000000000000
>> $12   : 0000000000000000 a800000059b88aa0 a8000000200d22d0 001c450400000018
>> $16   : 0000000077d809a0 0000000077e3f000 0000000000000000 0000000000000000
>> $20   : 0000000077d803b4 0000000000000001 0000000077d82604 000000007ff808f8
>> $24   : 0018460400000000 0000000077c7aa90
>> $28   : 0000000077d88e10 000000007ff807c0 000000007ff807c0 0000000077c68bdc
>> Hi    : 0000000000061170
>> Lo    : 00000000000205d0
>> epc   : 0000000077c7ab00 0x77c7ab00
>>     Not tainted
>> ra    : 0000000077c68bdc 0x77c68bdc
>> Status: 8004fcf3    KX SX UX KERNEL EXL IE
>> Cause : 00000018
>> PrId  : 00000f24 (R14000)
>> Process grep (pid: 54, threadinfo=a8000000595c4000, task=a800000059b80000, tls=0000000077e46490)
>> Stack : 0000000000000000 77d88e1077d809a0 77d88e1077d809a0 77e3f00077d809a0
>>         7ff807e877c68bdc 0000000000000000 0000000000000009 77d88e1000000001
>>         0000000000000000 0000000200000000 7ff808700041e7a4 0000000000000000
>>         0000003d202fbf00 0043f0d07ff80830 0000003d00000003 00000004004134f4
>>         77d88e1000000000 0000000300000004 0000000200000000 0043f0d000000001
>>         0000000200000003 0000000477c34698 0043000000424fd0 000000027ff808f8
>>         77d88e1077c29488 000000007ff80ae4 0000000200000000 7ff80fc600430000
>>         00424fd000000002 7ff808b077c34748 000000027ff80fc6 0043000000424fd0
>>         77d88e107ff808f8 77d8012800403788 0000000077d5638c 0000000077e4028c
>>         000000007ff808e8 0000000000000000 0043f0d077e101dc 0000000100000000
>>         ...
>> Call Trace:
>>  (Bad stack address)
>>
>> Code: 30420040  5040000a  82020046  <03c0e821>  8f998750  00002821  8fbf0024  02002021  8fbe0020
> 
>  Is `grep' a 64-bit (n64 or n32) process?  If no then, there is nothing 
> wrong here, 32-bit (o32) processes will store registers on the stack as 
> 32-bit quantities.  I doubt that has anything to do with SIGSEGV/SIGBUS.
> 
>  There is definitely something wrong here though, the contents of 
> registers include pointers to the kernel-only XKPHYS memory segment ($13 
> and $14) that shouldn't have leaked from the kernel, so it looks to me 
> like the user context isn't handled correctly.  Of course any attempt to 
> dereference these pointers will cause an exception and in the response the 
> process will be treated with an appropriate signal, and, usually, killed.
> 
>   Maciej

This is an o32 userland.  So that means, given 64-bit wide registers, o32 is
going to stuff two 32-bit quantities into them?  I have an n32 chroot on a
different partition, but I haven't tried it w/ CONFIG_SMP yet.

Of the two XKPHYS addresses, a8000000200d22d0 points directly at SyS_munmap.
Couple other crashes pointed at compat_SyS_fcntl64, as well as a few other
addresses in XKPHYS that I couldn't find a specific function for in System.map.
 Seems to be random leakage.

I thought it might be improper use of spinlocks (w/ & w/o irqsave/irqrestore)
in the IRQ code, but I commented out all spinlocks in the core IP30 code, then
after still triggering fatal crashes, commented out all of the spinlocks in
IOC3 (evil driver) and Impact (video driver).  For a while, I couldn't crash
the kernel until I uncommented Impact's spinlocks, but it looks like that was a
fluke after subsequently commenting them out again and still crashing.  I'll
probably swap in the Odyssey board in the next day or so and see if that
exhibits similar problems, just to rule out the framebuffer code/drivers.  Then
pull more memory.  Then my hair...

--J
