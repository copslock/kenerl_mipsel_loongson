Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2016 17:26:01 +0100 (CET)
Received: from resqmta-ch2-09v.sys.comcast.net ([69.252.207.41]:33300 "EHLO
        resqmta-ch2-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010127AbcA3QZ7rd0mN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jan 2016 17:25:59 +0100
Received: from resomta-ch2-01v.sys.comcast.net ([69.252.207.97])
        by resqmta-ch2-09v.sys.comcast.net with comcast
        id CGPa1s00426dK1R01GRtfB; Sat, 30 Jan 2016 16:25:53 +0000
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-ch2-01v.sys.comcast.net with comcast
        id CGRr1s00C0w5D3801GRshC; Sat, 30 Jan 2016 16:25:53 +0000
Subject: Re: [PATCH 1/3] MIPS: R6: Use lightweight SYNC instruction in smp_*
 memory barriers
To:     "Maciej W. Rozycki" <macro@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <20150602000818.6668.76632.stgit@ubuntu-yegoshin>
 <20150602000934.6668.43645.stgit@ubuntu-yegoshin>
 <20150605131046.GD26432@linux-mips.org> <56A97CE1.5090004@gentoo.org>
 <alpine.LFD.2.20.1601291006420.18566@eddie.linux-mips.org>
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, benh@kernel.crashing.org,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        markos.chandras@imgtec.com, Steven.Hill@imgtec.com,
        alexander.h.duyck@redhat.com,
        "David S. Miller" <davem@davemloft.net>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
From:   Joshua Kinard <kumba@gentoo.org>
X-Enigmail-Draft-Status: N1110
Message-ID: <56ACE3F9.4080609@gentoo.org>
Date:   Sat, 30 Jan 2016 11:25:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:42.0) Gecko/20100101
 Thunderbird/42.0
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.20.1601291006420.18566@eddie.linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1454171153;
        bh=gEQicH10x2WbOZjG8MQ9AYC3So9iKhIgcQpAU5sFZks=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=n0wvqvQOwo6NkEhxfypTiBVAhQfzNSNqhL11Ilyvw7fJZvgegLhw4Sspc5jVXibH8
         eKxJ74VdtqV77ZmCIVKJcLn/CFR+jNJTZr2QmKB4CmJTJ8yjHtNGWb4GrxGUtNJGdD
         h1/rXSbTm84tOTjVg5hxI8+RPQlSyuZ2Dr72ONSx76zCXG/uqsbr9dlUbXyS1Uz/Gm
         Rpb3tjVIYTweuujwZdngtBhz1LL82PG/yWXnEpcC/pu8GOmgceIxPW4hpYXvGJ/mv3
         pSWTlEobgBgxDorTzxjdiUFXtWkil4z+WF3uYoYotnmtpkfwYfkA9yaYSPpenwjNll
         TN6dpPewX+mow==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51550
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

On 01/29/2016 08:32, Maciej W. Rozycki wrote:
> On Wed, 27 Jan 2016, Joshua Kinard wrote:
> 
>> On 06/05/2015 09:10, Ralf Baechle wrote:
>>>
>>> Maciej,
>>>
>>> do you have an R4000 / R4600 / R5000 / R7000 / SiByte system at hand to
>>> test this?  I think we don't need to test that SYNC actually works as
>>> intended but the simpler test that SYNC <stype != 0> is not causing a
>>> illegal instruction exception is sufficient, that is if something like
>>>
>>> int main(int argc, charg *argv[])
>>> {
>>> 	asm("	.set	mips2		\n"
>>> 	"	sync	0x10		\n"
>>> 	"	sync	0x13		\n"
>>> 	"	sync	0x04		\n"
>>> 	"	.set	mips 0		\n");
>>>
>>> 	return 0;
>>> }
>>>
>>> doesn't crash we should be ok.
> 
>  No anomalies observed with these processors:
> 
> CPU0 revision is: 00000440 (R4400SC)
> CPU0 revision is: 01040102 (SiByte SB1)
> 
>> I tried just compiling this on my SGI O2, which has an RM7000 CPU, and it is
>> refusing to even compile (after fixing typos):
>>
>> # gcc -O2 -pipe sync_test.c -o sync_test
>> {standard input}: Assembler messages:
>> {standard input}:19: Error: invalid operands `sync 0x10'
>> {standard input}:20: Error: invalid operands `sync 0x13'
>> {standard input}:21: Error: invalid operands `sync 0x04'
> 
>  Yeah, there is another typo there: you need to use `.set mips32' or 
> suchlike rather than `.set mips2' to be able to specify an operand.  That 
> probably counts as a bug in binutils, as -- according to what I have 
> observed in the other thread -- the `stype' field has been defined at 
> least since the MIPS IV ISA.
> 
>> And the program compiles successfully and executes with no noticeable oddities
>> or errors.  Nothing in dmesg, no crashes, booms, or disappearance of small
> 
>  You did disable SYNC emulation in the kernel though with a change like 
> below, did you?
> 

I did not...wasn't aware that the kernel emulates a lot of non-compatible
instructions in traps.c.  I applied the patch to both my IP30 and IP32 kernels,
rebooted, and tested both forms of the test program (using the '.word' form and
'.set mips32' variants with operands to 'sync'), and the binary appears to run
w/o incident, as far as I can tell.  Looks like at least the RM7K and R1x000
families handle operands to 'sync' w/o issue.

I might be able to test an RM5200 box out within the next two weeks, once I
finish building a netboot image to boot up a spare O2.


>> kittens.  I did a quick disassembly to make sure all three got emitted:
>>
>> 004005e0 <main>:
>>   4005e0:       27bdfff8        addiu   sp,sp,-8
>>   4005e4:       afbe0004        sw      s8,4(sp)
>>   4005e8:       03a0f021        move    s8,sp
>>   4005ec:       afc40008        sw      a0,8(s8)
>>   4005f0:       afc5000c        sw      a1,12(s8)
>>> 4005f4:       0000040f        sync.p
>>> 4005f8:       0000050f        0x50f
>>> 4005fc:       0000010f        0x10f
>>   400600:       00001021        move    v0,zero
> 
>  You could have used the -m switch to override the architecture embedded 
> with the ELF file, to have the instructions disassembled correctly, e.g.:
> 
> $ objdump -m mips:isa64 -d sync
> [...]
> 00000001200008f0 <main>:
>    1200008f0:	0000040f 	sync	0x10
>    1200008f4:	000004cf 	sync	0x13
>    1200008f8:	0000010f 	sync	0x4
>    1200008fc:	03e00008 	jr	ra
>    120000900:	0000102d 	move	v0,zero
> 	...
> [...]
> 
>  What's interesting to note is that rev. 2.60 of the architecture did 
> actually change the semantics of plain SYNC (aka SYNC 0) from an ordering 
> barrier to a completion barrier.  Previous architectural requirements for 
> plain SYNC were equivalent to rev. 2.60's SYNC_MB, and to implement a 
> completion barrier a dummy load had to follow.
> 
>  Some implementers of the old plain SYNC did actually make it a completion 
> rather than ordering barrier and people even argued this was an 
> architectural requirement, as I recall from discussions in early 2000s.  
> On the other hand the implementations affected were UP-only processors 
> where about the only use for SYNC was to drain any write buffers of data 
> intended for MMIO accesses and such an implementation did conform even if 
> it was too heavyweight for architectural requirements.  So I think it was 
> a reasonable implementation decision, saving 1-2 instructions where a 
> completion barrier was required.  The only downside of this decision was 
> some programmers assumed such semantics was universally guaranteed, while 
> indeed it was not (before rev. 2.60).
> 
>  Overall where backwards compatibility is required it looks to me like we 
> need to keep the implementation of any completion barriers (e.g. `iob') as 
> a SYNC followed by a dummy load.
> 
>   Maciej
> 
> linux-mips-no-sync.diff
> Index: linux/arch/mips/kernel/traps.c
> ===================================================================
> --- linux.orig/arch/mips/kernel/traps.c
> +++ linux/arch/mips/kernel/traps.c
> @@ -672,6 +672,7 @@ static int simulate_rdhwr_mm(struct pt_r
>  	return -1;
>  }
>  
> +#if 0
>  static int simulate_sync(struct pt_regs *regs, unsigned int opcode)
>  {
>  	if ((opcode & OPCODE) == SPEC0 && (opcode & FUNC) == SYNC) {
> @@ -682,6 +683,7 @@ static int simulate_sync(struct pt_regs 
>  
>  	return -1;			/* Must be something else ... */
>  }
> +#endif
>  
>  asmlinkage void do_ov(struct pt_regs *regs)
>  {
> @@ -1117,8 +1119,10 @@ asmlinkage void do_ri(struct pt_regs *re
>  		if (status < 0)
>  			status = simulate_rdhwr_normal(regs, opcode);
>  
> +#if 0
>  		if (status < 0)
>  			status = simulate_sync(regs, opcode);
> +#endif
>  
>  		if (status < 0)
>  			status = simulate_fp(regs, opcode, old_epc, old31);
> 
> 

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
