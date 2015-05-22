Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 14:01:03 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27006608AbbEVMBB2-6FQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 14:01:01 +0200
Date:   Fri, 22 May 2015 13:01:01 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
cc:     linux-mips@linux-mips.org
Subject: Re: IP30: SMP, Almost there?
In-Reply-To: <555D7469.7090806@gentoo.org>
Message-ID: <alpine.LFD.2.11.1505220341220.4923@eddie.linux-mips.org>
References: <55597B21.4010704@gentoo.org> <5559D483.905@gentoo.org> <555C1A53.9010803@gentoo.org> <555D7469.7090806@gentoo.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Thu, 21 May 2015, Joshua Kinard wrote:

> Where I am lost is, though, why would I get an IBE on a 'beqz' instruction?

 A bus error is an external event, a signal asserted to the CPU by bus 
logic on a failed read cycle.  Whether you get a Data or Instruction Bus 
Error exception (DBE vs IBE) merely depends on whether it was a data read 
or an instruction fetch cycle.  The class of the error is only resolved by 
the CPU internally as obviously any external logic does not know the 
reason the CPU put the read cycle on the bus for that failed.  Note that 
the read cycle might well be a part of a cache fill.

 As it is a failure of a read that causes a bus error, it does not matter 
whether the instruction that was supposed to be fetched is valid or not.  
It has never been successfully fetched let alone decoded.  For an invalid 
instruction that has been fetched and decoded you'd get a Reserved 
Instruction exception instead.

 A typical reason for a bus error is a bus timeout, where no target on the 
bus responded to a cycle, a parity error of data presented on the bus or 
an uncorrected (multi-bit) memory access ECC error, driven by the memory 
controller in parallel to data presented.

 NB bus errors on write cycles, such as a bus timeout or an ECC error on a 
partial memory update (e.g. an uncached byte write), are asynchronous and 
normally do not cause a Bus Error exception.  A hardware interrupt is 
typically issued instead.

> My guess is there's still something not kosher with icache flushing somewhere.

 That would be odd.  Even if the state of the cache was inconsistent, I'd 
expect a Cache Error exception at worst, and rubbish returned typically, 
rather than a Bus Error exception.

> Anyone got ideas?  Is there some way to dump the contents of the icache and/or
> dcache for debugging?

 I'd rather expect an uncorrected ECC error being the cause here, maybe 
you need to clean the contacts of your memory modules.  From user 
documentation, such as a maintenance manual that should be available for 
your system, you might be able to infer which memory module the physical 
address of 0x200ff12c corresponds to and start by cleaning that module 
first.  Try to strip the system as much as possible and e.g. run with a 
single known-good memory module only (or whatever number of modules is the 
minimum).  Run any extra system diagnostics if provided by the firmware.

 It's interesting to note in the log you provided:

> [     1.169048] Instruction bus error, epc == 00000000004289ac, ra == 000000000047d054
> [     1.183979] Instruction bus error, epc == 00000000004289ac, ra == 000000000047d054
> [     1.195707] Instruction bus error, epc == 000000000040448c, ra == 0000000000404440
> [     1.206829] Instruction bus error, epc == a8000000200ff12c, ra == a800000020104fec

that the error always happens in the same 4th word (address ending with 
0xc) of a 16-byte span.  Which may indeed mean there's an issue with a 
particular memory module that supplies data for this word (assuming your 
system has a 128-bit memory controller data bus with 64-bit DRAM modules 
arranged in pairs and individually supplying data for each half of the bus 
or suchlike).

 Then checking and possibly tightening the power supply connection might 
be a good idea too.  Other connections may be worth checking, e.g. the CPU 
daughtercard(s) if applicable.  Also any problems with overheating like a 
loose heatsink, a blocked ventilation shaft and suchlike.  I'd definitely 
double-check memory first though.

 If that did not help, then I'd start suspecting your system is faulty. :(

  Maciej
