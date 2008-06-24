Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2008 18:48:47 +0100 (BST)
Received: from mx.mips.com ([63.167.95.198]:16104 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20038834AbYFXRsj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Jun 2008 18:48:39 +0100
Received: from MTVEXCHANGE.mips.com (mtvexchange.mips.com [192.168.36.60])
	by dns0.mips.com (8.12.11/8.12.11) with SMTP id m5OHkp5N025270;
	Tue, 24 Jun 2008 10:46:52 -0700 (PDT)
Received: from mercury.mips.com ([192.168.64.101]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 24 Jun 2008 10:48:18 -0700
Received: from [192.168.65.41] (linux-chris2 [192.168.65.41])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id m5OHmHdj018048;
	Tue, 24 Jun 2008 10:48:17 -0700 (PDT)
Message-ID: <48613361.3090608@mips.com>
Date:	Tue, 24 Jun 2008 10:48:17 -0700
From:	Chris Dearman <chris@mips.com>
User-Agent: Icedove 1.5.0.14eol (X11/20080509)
MIME-Version: 1.0
To:	Harald Krapfenbauer <krapfenbauer@ict.tuwien.ac.at>
CC:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: function call on MIPS (newbie question)
References: <4860C9FD.60103@ict.tuwien.ac.at>
In-Reply-To: <4860C9FD.60103@ict.tuwien.ac.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jun 2008 17:48:18.0797 (UTC) FILETIME=[7C9D39D0:01C8D622]
Return-Path: <chris@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19615
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@mips.com
Precedence: bulk
X-list: linux-mips

Harald Krapfenbauer wrote:
> Hi!
> 
> I'm a newbie to the MIPS architecture and I want to port some program to
> MIPS.
> I must call a function within the .text segment with 2 simple
> parameters. So I figured out the following code which
> *) loads arg1 into register $4
> *) loads arg2 into register $5
> *) loads the address into $15
> *) executes a jalr
> *) breaks afterwards
> 
> 
> 	*((guint32 *)(code)) = ((method_argument1 >> 16) & 0xffff) |
> 0x3c040000;    /* arg 1 upper half word */
> 	*((guint32 *)(code+4)) = (method_argument1 & 0xffff) | 0x24040000;
>      /* arg 1 lower half word */
> 	*((guint32 *)(code+8)) = ((method_argument2 >> 16) & 0xffff) |
> 0x3c050000;  /* arg 2 upper half word */
> 	*((guint32 *)(code+12)) = (method_argument2 & 0xffff) | 0x24050000;
>      /* arg 2 lower half word */
> 	*((guint32 *)(code+16)) = ((method_address >> 16) & 0xffff) |
> 0x3c0f0000;   /* address upper half word */
> 	*((guint32 *)(code+20)) = (method_address & 0xffff) | 0x240f0000;
>      /* address lower half word */
> 	*((guint32 *)(code+24)) = 0x01e0f809;
>      /* jalr */
> 	*((guint32 *)(code+28)) = 0x0;
>      /* branch delay slot */
> 	edit *((guint32 *)(code+32)) = 0x0d;
>      /* breakpoint */
> 
> 
> 
> The code is written to the stack, the SP and the PC are then set to the
> beginning of the code on the stack.
> 
> Something must be going wrong because after the program stops again, the
> PC is 0xffffcb38 (The method address is 0x53cb38) and my program
> receives signal 10.
> 
> Did I miss something or is my code wrong?
> Any help appreciated!

The code you generate for the function address is
3C0F0053  lui         t7,0x53
240FCB38  addiu       t7,zero,-13512

   There are 2 problems here... the second instruction should be "addiu 
t7,t7,-13512" and addiu sign-extends the immediate value so you have to 
deal with this by adjusting the lui if bit 15 of the address is set. 
It's simpler to use ori which does not sign-extend the immediate value:

3C0F0053  lui         t7,0x53
35EFEB37  ori         t7,t7,0xeb37

   You will need to modify the instructions that load a0 and a1 in the 
same way.

   The next issue will be cache maintenance which you have to do 
explicitly. Most MIPS CPUs use writeback caches, so you need to flush 
this data from the dcache into memory and then invalidate the icache to 
make sure the CPU does not execute stale data. MIPS32 processors support 
synci to accomplish this.  If the processor you're using doesn't have 
synci, there is a cachectl syscall which does the required cache 
writeback/invalidation

   One final point is calling conventions. If you are calling other JIT 
code you will know what assumptions it makes about register/stack usage, 
but if you are calling normal code (eg a library function) then you have 
to use the normal calling conventions.  The caller is required to 
allocate 4 words at $sp where the callee can store $a0..$a3. PIC code 
requires that the call is made using "jalr $t9" etc.

If you're new to the MIPS world I'd strongly recommend "See MIPS Run 
Linux" by Dominic Sweetman which covers a lot of this stuff and is very 
readable.

Chris

-- 
Chris Dearman                 Desk:+1 650 567 5092  Cell:+1 650 224 8603
MIPS Technologies Inc         1225 Charleston Rd, Mountain View CA 94043
