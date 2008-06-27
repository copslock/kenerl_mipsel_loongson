Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2008 11:00:35 +0100 (BST)
Received: from mail2.ict.tuwien.ac.at ([128.131.81.21]:58312 "EHLO
	mail.ict.tuwien.ac.at") by ftp.linux-mips.org with ESMTP
	id S20027576AbYF0KA2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 27 Jun 2008 11:00:28 +0100
Received: from pc81-11.ict.tuwien.ac.at ([128.131.81.11])
	by mail.ict.tuwien.ac.at with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <krapfenbauer@ict.tuwien.ac.at>)
	id 1KCAkk-00032j-Ej; Fri, 27 Jun 2008 12:00:26 +0200
Message-ID: <4864BA3A.4060805@ict.tuwien.ac.at>
Date:	Fri, 27 Jun 2008 12:00:26 +0200
From:	Harald Krapfenbauer <krapfenbauer@ict.tuwien.ac.at>
Organization: Institute of Computer Technology, Vienna University of Technology
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
MIME-Version: 1.0
To:	Chris Dearman <chris@mips.com>
CC:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: function call on MIPS (newbie question)
References: <4860C9FD.60103@ict.tuwien.ac.at> <48613361.3090608@mips.com>
In-Reply-To: <48613361.3090608@mips.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 128.131.81.11
X-SA-Exim-Mail-From: krapfenbauer@ict.tuwien.ac.at
X-SA-Exim-Scanned: No (on mail.ict.tuwien.ac.at); SAEximRunCond expanded to false
Return-Path: <krapfenbauer@ict.tuwien.ac.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: krapfenbauer@ict.tuwien.ac.at
Precedence: bulk
X-list: linux-mips

Thanks for your detailed answer!
While I am waiting for the suggested book, I have another question
regarding cache maintenance:

If I read and write memory via ptrace() calls in MIPS Linux, is it
required to care about the cache? That would mean that I must flush (and
invalidate) the cache everytime before I access a process' memory via
ptrace()...

Best regards,
Harald


Chris Dearman wrote:
> Harald Krapfenbauer wrote:
>> Hi!
>>
>> I'm a newbie to the MIPS architecture and I want to port some program to
>> MIPS.
>> I must call a function within the .text segment with 2 simple
>> parameters. So I figured out the following code which
>> *) loads arg1 into register $4
>> *) loads arg2 into register $5
>> *) loads the address into $15
>> *) executes a jalr
>> *) breaks afterwards
>>
>>
>>       *((guint32 *)(code)) = ((method_argument1 >> 16) & 0xffff) |
>> 0x3c040000;    /* arg 1 upper half word */
>>       *((guint32 *)(code+4)) = (method_argument1 & 0xffff) | 0x24040000;
>>      /* arg 1 lower half word */
>>       *((guint32 *)(code+8)) = ((method_argument2 >> 16) & 0xffff) |
>> 0x3c050000;  /* arg 2 upper half word */
>>       *((guint32 *)(code+12)) = (method_argument2 & 0xffff) | 0x24050000;
>>      /* arg 2 lower half word */
>>       *((guint32 *)(code+16)) = ((method_address >> 16) & 0xffff) |
>> 0x3c0f0000;   /* address upper half word */
>>       *((guint32 *)(code+20)) = (method_address & 0xffff) | 0x240f0000;
>>      /* address lower half word */
>>       *((guint32 *)(code+24)) = 0x01e0f809;
>>      /* jalr */
>>       *((guint32 *)(code+28)) = 0x0;
>>      /* branch delay slot */
>>       edit *((guint32 *)(code+32)) = 0x0d;
>>      /* breakpoint */
>>
>>
>>
>> The code is written to the stack, the SP and the PC are then set to the
>> beginning of the code on the stack.
>>
>> Something must be going wrong because after the program stops again, the
>> PC is 0xffffcb38 (The method address is 0x53cb38) and my program
>> receives signal 10.
>>
>> Did I miss something or is my code wrong?
>> Any help appreciated!
> 
> The code you generate for the function address is
> 3C0F0053  lui         t7,0x53
> 240FCB38  addiu       t7,zero,-13512
> 
>    There are 2 problems here... the second instruction should be "addiu
> t7,t7,-13512" and addiu sign-extends the immediate value so you have to
> deal with this by adjusting the lui if bit 15 of the address is set.
> It's simpler to use ori which does not sign-extend the immediate value:
> 
> 3C0F0053  lui         t7,0x53
> 35EFEB37  ori         t7,t7,0xeb37
> 
>    You will need to modify the instructions that load a0 and a1 in the
> same way.
> 
>    The next issue will be cache maintenance which you have to do
> explicitly. Most MIPS CPUs use writeback caches, so you need to flush
> this data from the dcache into memory and then invalidate the icache to
> make sure the CPU does not execute stale data. MIPS32 processors support
> synci to accomplish this.  If the processor you're using doesn't have
> synci, there is a cachectl syscall which does the required cache
> writeback/invalidation
> 
>    One final point is calling conventions. If you are calling other JIT
> code you will know what assumptions it makes about register/stack usage,
> but if you are calling normal code (eg a library function) then you have
> to use the normal calling conventions.  The caller is required to
> allocate 4 words at $sp where the callee can store $a0..$a3. PIC code
> requires that the call is made using "jalr $t9" etc.
> 
> If you're new to the MIPS world I'd strongly recommend "See MIPS Run
> Linux" by Dominic Sweetman which covers a lot of this stuff and is very
> readable.
> 
> Chris
> 
> --
> Chris Dearman                 Desk:+1 650 567 5092  Cell:+1 650 224 8603
> MIPS Technologies Inc         1225 Charleston Rd, Mountain View CA 94043

-- 
Harald Krapfenbauer
Project assistant

Vienna University of Technology, Institute of Computer Technology
Gusshausstraﬂe 27-29, 1040 Vienna, Austria
Phone: +43-1-58801-38472, Fax: +43-1-58801-38499
Email: krapfenbauer@ict.tuwien.ac.at, WWW: http://www.ict.tuwien.ac.at
Skype: harald.krapfenbauer
