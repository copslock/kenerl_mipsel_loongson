Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 May 2015 00:53:09 +0200 (CEST)
Received: from resqmta-ch2-09v.sys.comcast.net ([69.252.207.41]:36677 "EHLO
        resqmta-ch2-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006857AbbEWWxFzzCd7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 May 2015 00:53:05 +0200
Received: from resomta-ch2-01v.sys.comcast.net ([69.252.207.97])
        by resqmta-ch2-09v.sys.comcast.net with comcast
        id Xat11q00126dK1R01at1k3; Sat, 23 May 2015 22:53:01 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-01v.sys.comcast.net with comcast
        id Xat01q00742s2jH01at0rQ; Sat, 23 May 2015 22:53:01 +0000
Message-ID: <556104B7.8070504@gentoo.org>
Date:   Sat, 23 May 2015 18:52:39 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: IP30: SMP, Almost there?
References: <55597B21.4010704@gentoo.org> <5559D483.905@gentoo.org> <555C1A53.9010803@gentoo.org> <555D7469.7090806@gentoo.org> <alpine.LFD.2.11.1505220341220.4923@eddie.linux-mips.org> <20150522171113.GC6467@linux-mips.org>
In-Reply-To: <20150522171113.GC6467@linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1432421581;
        bh=RuU0BarJCwgrxTNUgUMI4UiwKKa2ZpDc2Nv676RUMTQ=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=hFnP2rjePIGbKvwNf/liITo2GC98KCLhIWomoCA4QxxHdKOiwF3c2yixi5fiv52NY
         DN1qtfxx6ZBeI7wAtAjuqvWQE2Eh7VKxFaqIPl6edH2f0psPpaNc0nigKkBJ065i4b
         46RwK9C5CsazXlbUmBiuauz2U+zSwMqJDr6wbrkmiI2SEG1v2JXrYGk6xx+79F0NIa
         988o5oJf+y/5Pfh4CFB2Kly/Ln+slCo4Tjg3SN24ZW1biihl9YqLo7TEvPv73x3Tmu
         8TcCT2ZcsTZd1ILeirMZ9GSJskloXWLgehGMsIQxm7quiRvjZN+gLYs1gJdID0kRtT
         OD4X1BOsbIIsQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47593
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

On 05/22/2015 13:11, Ralf Baechle wrote:
> On Fri, May 22, 2015 at 01:01:01PM +0100, Maciej W. Rozycki wrote:
> 
>>> Where I am lost is, though, why would I get an IBE on a 'beqz' instruction?
>>
>>  A bus error is an external event, a signal asserted to the CPU by bus 
>> logic on a failed read cycle.  Whether you get a Data or Instruction Bus 
>> Error exception (DBE vs IBE) merely depends on whether it was a data read 
>> or an instruction fetch cycle.  The class of the error is only resolved by 
>> the CPU internally as obviously any external logic does not know the 
>> reason the CPU put the read cycle on the bus for that failed.  Note that 
>> the read cycle might well be a part of a cache fill.
>>
>>  As it is a failure of a read that causes a bus error, it does not matter 
>> whether the instruction that was supposed to be fetched is valid or not.  
>> It has never been successfully fetched let alone decoded.  For an invalid 
>> instruction that has been fetched and decoded you'd get a Reserved 
>> Instruction exception instead.
>>
>>  A typical reason for a bus error is a bus timeout, where no target on the 
>> bus responded to a cycle, a parity error of data presented on the bus or 
>> an uncorrected (multi-bit) memory access ECC error, driven by the memory 
>> controller in parallel to data presented.
>>
>>  NB bus errors on write cycles, such as a bus timeout or an ECC error on a 
>> partial memory update (e.g. an uncached byte write), are asynchronous and 
>> normally do not cause a Bus Error exception.  A hardware interrupt is 
>> typically issued instead.
>>
>>> My guess is there's still something not kosher with icache flushing somewhere.
>>
>>  That would be odd.  Even if the state of the cache was inconsistent, I'd 
>> expect a Cache Error exception at worst, and rubbish returned typically, 
>> rather than a Bus Error exception.
>>
>>> Anyone got ideas?  Is there some way to dump the contents of the icache and/or
>>> dcache for debugging?
>>
>>  I'd rather expect an uncorrected ECC error being the cause here, maybe 
>> you need to clean the contacts of your memory modules.  From user 
>> documentation, such as a maintenance manual that should be available for 
>> your system, you might be able to infer which memory module the physical 
>> address of 0x200ff12c corresponds to and start by cleaning that module 
>> first.  Try to strip the system as much as possible and e.g. run with a 
>> single known-good memory module only (or whatever number of modules is the 
>> minimum).  Run any extra system diagnostics if provided by the firmware.
>>
>>  It's interesting to note in the log you provided:
>>
>>> [     1.169048] Instruction bus error, epc == 00000000004289ac, ra == 000000000047d054
>>> [     1.183979] Instruction bus error, epc == 00000000004289ac, ra == 000000000047d054
>>> [     1.195707] Instruction bus error, epc == 000000000040448c, ra == 0000000000404440
>>> [     1.206829] Instruction bus error, epc == a8000000200ff12c, ra == a800000020104fec
>>
>> that the error always happens in the same 4th word (address ending with 
>> 0xc) of a 16-byte span.  Which may indeed mean there's an issue with a 
>> particular memory module that supplies data for this word (assuming your 
>> system has a 128-bit memory controller data bus with 64-bit DRAM modules 
>> arranged in pairs and individually supplying data for each half of the bus 
>> or suchlike).
>>
>>  Then checking and possibly tightening the power supply connection might 
>> be a good idea too.  Other connections may be worth checking, e.g. the CPU 
>> daughtercard(s) if applicable.  Also any problems with overheating like a 
>> loose heatsink, a blocked ventilation shaft and suchlike.  I'd definitely 
>> double-check memory first though.
>>
>>  If that did not help, then I'd start suspecting your system is faulty. :(
> 
> He might run IRIX on it for testing.  Also I think one of the BSDs has
> support.
> 
> Octane is a close relative of the IP27 which does ECC anything an all,
> all addresses fully decoded.  So if software does something stupid,
> hardware will notice, quickly though not necessarily in very obvious
> ways.

Probably can't hurt to boot IRIX on it and run the hardware diagnostics,
especially on the R14K module.  Doubtful that it's hardware, though.  UP kernel
boots normally, and even an SMP kernel boots normally if I disable one of the
CPUs in ARCS.  It's only when booting both CPUs, CPU1 is the one generating the
IBE's.

And yeah, OpenBSD supports IP30 (along with a few others).  I talk to Miod, the
main OpenBsd/sgi developer, sometimes.


> Some of IP27's reactions are a bit unobvious though.  First, the uncached
> addres space (CCA 2) works differently that one might think.  IP27 uses
> the R10000's uncached attribute feature which subdivides the CPUs
> uncached XKPHYS address space into four addres spaces with the highest
> address byte being 0x90, 0x92, 0x94 or 0x96.  The classic uncached
> memory access happens with UC=3, that is the top address byte being
> 0x96.

I was reading the IRIX Device Driver Programming Guide (007-0911-210), Chapter
1, and saw the explanation for this.  Also the bit on how the memory addresses
are coded so that a reference to the specific node number can be encoded as
well to assist the CPUs in accessing the memory closest to them.  Definitely
interesting, but apparently Octane doesn't appear to use any of this.  As far
as I can tell, it's main UNCAC_BASE and IO_BASE is classic 0x9000000000000000,
CAC_BASE is 0xa800000000000000, and MAP_BASE is 0xc000000000000000.  These are
all the defaults in mach-generic/spaces.h, so IP30 has never had to define a
local spaces.h override.

It DOES look like I need to hardcode the 'cca=5' bit, somewhere, though.
Whatever the Octane is booting up with does not work for SMP.


> Do not use that.  EVER.  It entirely bypasses the CPU's cache coherency
> logic.  Due to all the consistency checking between the directory
> caches and other involved agents the memory controller might detect the
> inconsistency between cache and memory and send guess what, a bus
> error.
> 
> For I/O purpose UC attribute value 1 is used, that is top byte 0x92.
> UC values 0 and 2 allow direct manipulation of the directory caches
> and atomic operations without the need to read the line into the CPU.
> 
> So that's what IP27 does.  Not sure how much of this behavious its
> little brother IP30 has copied.

About the only thing that I can determine that Octane uses from IP27 are the
CPUs, SCSI chips, and dreaded IOC3.  HEART seems to have the same logical
circuitry as HUB for the count/compare timers, but that seems to be where the
similarities end.  Unlike IP27, which doesn't hardwire the interrupt vectors,
due to the distributed model of its design, Octane's HEART has 64 fixed
interrupts in HEART for controlling access to hardware (one bit in HEART_ISR
for each interrupt).

IRIX headers imply that there might be a WAR for HEART, too, given several
references to HEART_COHERENCY_WAR.  If that macro is defined, then several
dcache_wb_inval functions become available for HEART, so I wonder if I might
have a screwy revision of HEART.  Though I have a Rev F HEART, so that WAR
might be for a much older rev.  Hard to tell w/o the HEART ASIC documentation.

--J
