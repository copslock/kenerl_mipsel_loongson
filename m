Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Aug 2003 12:00:55 +0100 (BST)
Received: from [IPv6:::ffff:159.226.39.4] ([IPv6:::ffff:159.226.39.4]:15025
	"HELO mail.ict.ac.cn") by linux-mips.org with SMTP
	id <S8225280AbTHFLAw>; Wed, 6 Aug 2003 12:00:52 +0100
Received: (qmail 15961 invoked from network); 6 Aug 2003 10:55:17 -0000
Received: from unknown (HELO ict.ac.cn) (159.226.40.150)
  by mail.ict.ac.cn with SMTP; 6 Aug 2003 10:55:17 -0000
Message-ID: <3F30DFB7.8030304@ict.ac.cn>
Date: Wed, 06 Aug 2003 19:00:07 +0800
From: Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: zh-cn, en-us, en
MIME-Version: 1.0
To: Adam Kiepul <Adam_Kiepul@pmc-sierra.com>
CC: Ralf Baechle <ralf@linux-mips.org>,
	MAKE FUN PRANK CALLS <linux-mips@linux-mips.org>
Subject: Re: RM7k cache_flush_sigtramp
References: <9DFF23E1E33391449FDC324526D1F259017DF091@SJC1EXM02>
In-Reply-To: <9DFF23E1E33391449FDC324526D1F259017DF091@SJC1EXM02>
Content-Type: multipart/mixed;
 boundary="------------070804020907010709090500"
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------070804020907010709090500
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 7bit

hi,
   These days I have performed more experiments on our ev64240 board.

   Now it seems I get at least two problems: sigtramp flush and L3 cache.

   Let me descripe the phenomemena first.
      1.  fsck /dev/hda4(a 10G partition of 40G ide disk on a pci add-on 
card use
            intel piix4 chip) frequently fail with oops in various place:
                __remove_inode_queue, free_buffers, vmscan:359 etc.
       2. occasionally other apps may fail with segmentation fault or 
bus error.
       3. xwindow system is extremely unstable,both the applications and 
the
           Xserver may fail with sigill/sigsegv/sigbus etc.

   To address the problems, I modified arch/mips/signal.c to let kernel 
dump core
unconditionally(even if there are use handler installed) for 
sigill/sigsegv/sigbus.
By this way I get many core files for XFree86,then I find that they all 
look quite
similiar--all around the point of kernel generated sigreturn code(Two 
example are
 attached). Days ago i added a 'sync' after writeback and the situation 
was much better.
But then i still see this kinds of failure even with the 'sync'.  I have 
to go further back
to use 'Writeback_SD', so far no more such fault. But just as Adam 
pointed out,it may
just mask over another error.  I have tried to add code in 
r4k_flush_sigtramp and
sigreturn,and when xserver fails,I do observe that there are flush for 
the faulting point,
but no sigreturn executed. So it is at my wit's end:(. Maybe some 
complex schedule or
reentry problem? Or even a potential bug of context management(e.g.,we 
are using the
other's stack)?

   Using Writeback_SD only help xserver problem, the other problems look 
like
cache related. So I try to run with L3 cache disabled. That helps 
greatly, no oops
now. With a little tweak on ide code,the 'lost interrupt' problem seems 
gone too.
But with only L3 disabled, the Xserver problem remains.

  I am doing stress test now. Hope it won't give me more surprise.

  And here I have a question for Mr. Adam: original linux code use 
'Writeback_Inv_D"
and "Hit_Invalidate_I",not "Writeback_D" and "Hit_Invalidate_I",could it 
lead to the
problem?

 BTW:
   a silly question: how can i make my email show up pretier? I find 
that the mailing list
often break my lines very badly. I feel guilty for that:) I am using 
mozilla composer,the
original linebreaks are manually inserted(hit enter when i feel it is 
long enough).

Thank you for any help.
 
Adam Kiepul wrote:

>Hi Fuxin,
>
>Could you please provide me with the _original_ Kernel code disassembly snippet around the point where your SYNC patch applies?
>Also, can you check what RM7000 part revision is on your board? You can find it out by reading the PrID register.
>
>I will check if there is an erratum that the code could trigger.
>
>By the way, are you aware of any other ev64240 board that would exhibit the same behavior?
>
>I would be quite careful drawing any conclusions at the moment since we can not preclude the possibility that it is simply a "bad CPU on the board" case. Please note that the SYNC instruction changes a lot in the manner things physically happen in the CPU so it can often mask off various problems, such as a bad part.
>
>Thank you,
>
>Adam
>
>
>-----Original Message-----
>From: Fuxin Zhang [mailto:fxzhang@ict.ac.cn]
>Sent: Thursday, July 31, 2003 9:59 PM
>To: Ralf Baechle
>Cc: Adam Kiepul; MAKE FUN PRANK CALLS
>Subject: Re: RM7k cache_flush_sigtramp
>
>
>I am using a slightly modified 2.4.21-pre4,based on cvs of early this 
>month(?).
>We have merged with latest cvs, I will run it and report the result tonight.
>
>
>Ralf Baechle wrote:
>
>  
>
>>Adam,
>>
>>On Fri, Aug 01, 2003 at 08:40:14AM +0800, Fuxin Zhang wrote:
>>
>> 
>>
>>    
>>
>>>Current linux code does exactly this. But I was seeing all kinds of 
>>>faults occuring around the
>>>sigreturn point on the stack without a sync? And a sync does greatly 
>>>improve the stablity.
>>>
>>>   
>>>
>>>      
>>>
>>>>The ordering does matter however since the Hit_Invalidate_I makes sure the 
>>>>write buffer is flushed.
>>>>     
>>>>
>>>>        
>>>>
>>could there be an errata explaining Fuxin's findings?
>>
>>Fuxin, what version are you running?
>>
>> Ralf
>>
>>
>> 
>>
>>    
>>
>
>
>
>  
>

--------------070804020907010709090500
Content-Type: text/plain;
 name="out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="out"

GNU gdb 2002-04-01-cvs
Copyright 2002 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "mipsel-linux"...(no debugging symbols found)...
Core was generated by `/usr/bin/X11/X -dpi 100 -nolisten tcp'.
Program terminated with signal 4, Illegal instruction.
Reading symbols from /usr/lib/libz.so.1...(no debugging symbols found)...done.
Loaded symbols for /usr/lib/libz.so.1
Reading symbols from /lib/libm.so.6...(no debugging symbols found)...done.
Loaded symbols for /lib/libm.so.6
Reading symbols from /lib/libc.so.6...(no debugging symbols found)...done.
Loaded symbols for /lib/libc.so.6
Reading symbols from /lib/ld.so.1...(no debugging symbols found)...done.
Loaded symbols for /lib/ld.so.1
Reading symbols from /lib/libnss_files.so.2...(no debugging symbols found)...
done.
Loaded symbols for /lib/libnss_files.so.2

    GDB is unable to find the start of the function at 0x7fff7600
and thus can't determine the size of that function's stack frame.
This means that GDB may be unable to access that stack frame, or
the frames below it.
    This problem is most likely caused by an invalid program counter or
stack pointer.
    However, if you think GDB should simply search farther back
from 0x7fff7600 for code which looks like the beginning of a
function, you can increase the range of the search using the `set
heuristic-fence-post' command.
#0  0x7fff7600 in ?? ()
(gdb) where
#0  0x7fff7600 in ?? ()
(gdb) disass 0x7fff7580 0x7fff7680
Dump of assembler code from 0x7fff7580 to 0x7fff7680:
0x7fff7580:	nop
0x7fff7584:	nop
0x7fff7588:	nop
0x7fff758c:	nop
0x7fff7590:	nop
0x7fff7594:	nop
0x7fff7598:	nop
0x7fff759c:	nop
0x7fff75a0:	nop
0x7fff75a4:	nop
0x7fff75a8:	nop
0x7fff75ac:	nop
0x7fff75b0:	nop
0x7fff75b4:	nop
0x7fff75b8:	nop
0x7fff75bc:	nop
0x7fff75c0:	nop
0x7fff75c4:	nop
0x7fff75c8:	nop
0x7fff75cc:	nop
0x7fff75d0:	nop
0x7fff75d4:	beq	at,t3,0x80003ef8
0x7fff75d8:	sllv	zero,zero,zero
0x7fff75dc:	0xe
0x7fff75e0:	beq	zero,gp,0x7ffef244
0x7fff75e4:	beq	zero,t0,0x800012e8
0x7fff75e8:	0x7fff7600
0x7fff75ec:	beq	zero,t2,0x7ffd98b0
0x7fff75f0:	sd	ra,-1(ra)
0x7fff75f4:	sd	ra,-1(ra)
0x7fff75f8:	slti	sp,s6,-25040
0x7fff75fc:	beq	zero,t2,0x7ffd9cc0
0x7fff7600:	li	v0,4119
0x7fff7604:	syscall
0x7fff7608:	0x12c
0x7fff760c:	lb	a0,-19437(zero)
0x7fff7610:	slti	s1,s6,17812
0x7fff7614:	nop
0x7fff7618:	nop
0x7fff761c:	nop
0x7fff7620:	0xcf9210
0x7fff7624:	nop
0x7fff7628:	mfhi	zero
0x7fff762c:	nop
0x7fff7630:	beq	zero,at,0x8000caa4
0x7fff7634:	nop
0x7fff7638:	0xe
0x7fff763c:	nop
0x7fff7640:	slti	v0,k1,28680
0x7fff7644:	nop
0x7fff7648:	0x1228
0x7fff764c:	nop
0x7fff7650:	nop
0x7fff7654:	nop
0x7fff7658:	multu	zero,zero
0x7fff765c:	nop
0x7fff7660:	nop
0x7fff7664:	nop
0x7fff7668:	slti	t9,s7,17756
0x7fff766c:	nop
0x7fff7670:	beq	at,t3,0x7fff6f04
0x7fff7674:	nop
0x7fff7678:	0x12c
0x7fff767c:	nop
End of assembler dump.
(gdb) info regs
(gdb) info regs 
          zero       at       v0       v1       a0       a1       a2       a3
 R0   00000000 b004b400 ffffffff ffffffff 00000001 7fff73f8 00000000 00000000 
            t0       t1       t2       t3       t4       t5       t6       t7
 R8   0000b400 00000000 00000000 00000000 00000000 822b2880 822b2900 00000000 
            s0       s1       s2       s3       s4       s5       s6       s7
 R16  00000000 102b3248 00000004 0000000e 101cdf18 102b1820 00000001 00000000 
            t8       t9       k0       k1       gp       sp       s8       ra
 R24  00000000 006c86ec 00000000 00000000 10082740 7fff75f0 7fff7d08 7fff7600 
            sr       lo       hi      bad    cause       pc
      a004b413 00000002 00000000 8009c6a0 00000028 7fff7600 
           fsr      fir       fp
      00800004 00000000 00000000 
(gdb) quit

--------------070804020907010709090500
Content-Type: text/plain;
 name="out1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="out1"

GNU gdb 2002-04-01-cvs
Copyright 2002 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "mipsel-linux"...(no debugging symbols found)...
Core was generated by `/bin/sh /usr/bin/X11/startx'.
Program terminated with signal 4, Illegal instruction.

    GDB is unable to find the start of the function at 0x7fff75b8
and thus can't determine the size of that function's stack frame.
This means that GDB may be unable to access that stack frame, or
the frames below it.
    This problem is most likely caused by an invalid program counter or
stack pointer.
    However, if you think GDB should simply search farther back
from 0x7fff75b8 for code which looks like the beginning of a
function, you can increase the range of the search using the `set
heuristic-fence-post' command.
#0  0x7fff75b8 in ?? ()
(gdb) info reg
          zero       at       v0       v1       a0       a1       a2       a3
 R0   00000000 2ad918f0 2ad918f0 0000000a 00000012 7fff7538 00000001 00000001 
            t0       t1       t2       t3       t4       t5       t6       t7
 R8   0000000a 2aca6394 00000000 00000004 00000000 00000000 00000000 07200720 
            s0       s1       s2       s3       s4       s5       s6       s7
 R16  00000000 00000004 00000080 7fff7878 00000003 ffffffff 1000f0f8 00000001 
            t8       t9       k0       k1       gp       sp       s8       ra
 R24  00000000 00000000 00000000 00000000 1000d880 7fff7590 00000003 7fff75a0 
            sr       lo       hi      bad    cause       pc
      a004f413 000001b0 00000000 8009c6a0 80000028 7fff75b8 
           fsr      fir       fp
      00000000 00000000 00000000 
(gdb) disass 0x7fff7500 0x7fff7600
Dump of assembler code from 0x7fff7500 to 0x7fff7600:
0x7fff7500:	0xc2009d
0x7fff7504:	0x10000e8
0x7fff7508:	0x11a0110
0x7fff750c:	0x990121
0x7fff7510:	slti	t9,s6,32304
0x7fff7514:	tltu	a0,t9,0x2
0x7fff7518:	slti	t9,s6,32304
0x7fff751c:	0x442c88
0x7fff7520:	nop
0x7fff7524:	nop
0x7fff7528:	nop
0x7fff752c:	nop
0x7fff7530:	b	0x7ffed734
0x7fff7534:	nop
0x7fff7538:	nop
0x7fff753c:	slti	t8,s6,-8108
0x7fff7540:	nop
0x7fff7544:	sllv	zero,zero,zero
0x7fff7548:	sll	zero,zero,0x2
0x7fff754c:	0x7fff7878
0x7fff7550:	sra	zero,zero,0x0
0x7fff7554:	sd	ra,-1(ra)
0x7fff7558:	b	0x7fff393c
0x7fff755c:	b	0x7ffed760
0x7fff7560:	teq	v0,a0,0xa9
0x7fff7564:	nop
0x7fff7568:	nop
0x7fff756c:	nop
0x7fff7570:	nop
0x7fff7574:	nop
0x7fff7578:	b	0x7ffed77c
0x7fff757c:	nop
0x7fff7580:	nop
0x7fff7584:	b	0x7ffed788
0x7fff7588:	0x7fff75a0
0x7fff758c:	0x1
0x7fff7590:	b	0x7fff2174
0x7fff7594:	0x7fff7804
0x7fff7598:	slti	t9,s6,32304
0x7fff759c:	0x475718
0x7fff75a0:	li	v0,4119
0x7fff75a4:	syscall
0x7fff75a8:	slti	t8,s6,-8108
0x7fff75ac:	lb	a0,-3053(zero)
0x7fff75b0:	slti	t5,s6,9620
0x7fff75b4:	nop
0x7fff75b8:	nop
0x7fff75bc:	nop
0x7fff75c0:	b	0x7fff8cb4
0x7fff75c4:	nop
0x7fff75c8:	sllv	zero,zero,zero
0x7fff75cc:	nop
0x7fff75d0:	nop
0x7fff75d4:	nop
0x7fff75d8:	sra	zero,zero,0x0
0x7fff75dc:	nop
0x7fff75e0:	0x7fff7878
0x7fff75e4:	nop
0x7fff75e8:	sll	zero,zero,0x2
0x7fff75ec:	nop
0x7fff75f0:	0x1
0x7fff75f4:	nop
0x7fff75f8:	mult	zero,zero
0x7fff75fc:	nop
End of assembler dump.
(gdb) quit

--------------070804020907010709090500--
