Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9CKCLu29707
	for linux-mips-outgoing; Fri, 12 Oct 2001 13:12:21 -0700
Received: from mail.vcubed.com ([207.81.96.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9CKC1D29698
	for <linux-mips@oss.sgi.com>; Fri, 12 Oct 2001 13:12:01 -0700
Received: from quicklogic.com ([207.81.96.153])
	by mail.vcubed.com (8.9.3/8.9.3) with ESMTP id QAA28419;
	Fri, 12 Oct 2001 16:47:38 -0400
Message-ID: <3BC74EFE.9020109@quicklogic.com>
Date: Fri, 12 Oct 2001 16:13:50 -0400
From: Dan Aizenstros <dan@quicklogic.com>
Organization: QuickLogic Canada
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: Hanks Li <hli@quicklogic.com>, linux-mips@oss.sgi.com
Subject: Re: Big endian problem
References: <APEOLACBIPNAFKJDDFIIIEBLCBAA.hli@quicklogic.com> <3BC72CCC.3604FEC8@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello Jun,

The file is the common time.c from linux/arch/mips/kernel as you
can see from the third to last line of Hanshi's email.  The tools
he is using are from H. J. Lu's RedHat 7.1 RPMs on the oss.sgi.com
ftp site.  The file compiles just fine with the little endian version
of the same tools from the same place.

Hanshi and I will look at the USECS_PER_JIFFY_FRAC macro.  Thanks for
the pointer.

-- Dan A.


Jun Sun wrote:
> Which time.c is this?  I have seen this problem caused by mis-defined
> USECS_PER_JIFFY_FRAC macro.  Look at other time.c files for the right one.  
> 
> Or better yet, upgrade your port to use the common time.c.  See
> Documantation/mips/time.README file.
> 
> Jun
> 
> Hanks Li wrote:
> 
>>Hi,
>>
>>Has anyone tried to compile in Big Endian mode? When I compile the code in
>>big endian, I got the following message. Does anybody know how to solve this
>>problem? The assembler I'm using is "GNU assembler 2.11.90.0.27". I have no
>>problem compiling the code in little endian at all.
>>
>>Thanks
>>
>>Hanshi Li
>>
>>----------------------------------------------------------------------------
>>------------------------------------
>>mips-linux-gcc -I
>>/home/hli/linux/include/asm/gcc -D__KERNEL__ -I/home/hli/linux/include -Wall
>> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-ali
>>asing -fno-common -G
>>0 -mno-abicalls -fno-pic -mcpu=r5000 -mips2 -Wa,--trap -pipe -DEXPORT_SYMTAB
>> -c time.c
>>Assembler messages:
>>Warning: The -mcpu option is deprecated. Please use -march and -mtune
>>instead.
>>time.c: In function `calibrate_div32_gettimeoffset':
>>time.c:225: Unrecognizable insn:
>>(insn 60 144 66 (parallel[
>>(set (reg:SI 8 t0)
>>(asm_operands (".set push
>>.set noat
>>.set noreorder
>>b 1f
>>li %4,0x21
>>0:
>>sll $1,%0,0x1
>>srl %3,%0,0x1f
>>or %0,$1,$2
>>sll %1,%1,0x1
>>sll %2,%2,0x1
>>1:
>>bnez %3,2f
>>sltu $2,%0,%z5
>>bnez $2,3f
>>2:
>>addiu %4,%4,-1
>>subu %0,%0,%z5
>>addiu %2,%2,1
>>3:
>>bnez %4,0b
>>srl $2,%1,0x1f
>>.set pop") ("=&r") 0[
>>(reg/v:SI 4 a0)
>>(reg:SI 8 t0)
>>(reg:DI 6 a2)
>>(reg/v:SI 5 a1)
>>(reg:SI 9 t1)
>>]
>>[
>>(asm_input:SI ("Jr"))
>>(asm_input:SI ("0"))
>>(asm_input:DI ("1"))
>>(asm_input:SI ("2"))
>>(asm_input:SI ("3"))
>>] ("time.c") 201))
>>(set (reg:SI 6 a2)
>>(asm_operands (".set push
>>.set noat
>>.set noreorder
>>b 1f
>>li %4,0x21
>>0:
>>sll $1,%0,0x1
>>srl %3,%0,0x1f
>>or %0,$1,$2
>>sll %1,%1,0x1
>>sll %2,%2,0x1
>>1:
>>bnez %3,2f
>>sltu $2,%0,%z5
>>bnez $2,3f
>>2:
>>addiu %4,%4,-1
>>subu %0,%0,%z5
>>addiu %2,%2,1
>>3:
>>bnez %4,0b
>>srl $2,%1,0x1f
>>.set pop") ("=&r") 1[
>>(reg/v:SI 4 a0)
>>(reg:SI 8 t0)
>>(reg:DI 6 a2)
>>(reg/v:SI 5 a1)
>>(reg:SI 9 t1)
>>]
>>[
>>(asm_input:SI ("Jr"))
>>(asm_input:SI ("0"))
>>(asm_input:DI ("1"))
>>(asm_input:SI ("2"))
>>(asm_input:SI ("3"))
>>] ("time.c") 201))
>>(set (reg/v:SI 5 a1)
>>(asm_operands (".set push
>>.set noat
>>.set noreorder
>>b 1f
>>li %4,0x21
>>0:
>>sll $1,%0,0x1
>>srl %3,%0,0x1f
>>or %0,$1,$2
>>sll %1,%1,0x1
>>sll %2,%2,0x1
>>1:
>>bnez %3,2f
>>sltu $2,%0,%z5
>>bnez $2,3f
>>2:
>>addiu %4,%4,-1
>>subu %0,%0,%z5
>>addiu %2,%2,1
>>3:
>>bnez %4,0b
>>srl $2,%1,0x1f
>>.set pop") ("=&r") 2[
>>(reg/v:SI 4 a0)
>>(reg:SI 8 t0)
>>(reg:DI 6 a2)
>>(reg/v:SI 5 a1)
>>(reg:SI 9 t1)
>>]
>>[
>>(asm_input:SI ("Jr"))
>>(asm_input:SI ("0"))
>>(asm_input:DI ("1"))
>>(asm_input:SI ("2"))
>>(asm_input:SI ("3"))
>>] ("time.c") 201))
>>(set (reg:SI 9 t1)
>>(asm_operands (".set push
>>.set noat
>>.set noreorder
>>b 1f
>>li %4,0x21
>>0:
>>sll $1,%0,0x1
>>srl %3,%0,0x1f
>>or %0,$1,$2
>>sll %1,%1,0x1
>>sll %2,%2,0x1
>>1:
>>bnez %3,2f
>>sltu $2,%0,%z5
>>bnez $2,3f
>>2:
>>addiu %4,%4,-1
>>subu %0,%0,%z5
>>addiu %2,%2,1
>>3:
>>bnez %4,0b
>>srl $2,%1,0x1f
>>.set pop") ("=&r") 3[
>>(reg/v:SI 4 a0)
>>(reg:SI 8 t0)
>>(reg:DI 6 a2)
>>(reg/v:SI 5 a1)
>>(reg:SI 9 t1)
>>]
>>[
>>(asm_input:SI ("Jr"))
>>(asm_input:SI ("0"))
>>(asm_input:DI ("1"))
>>(asm_input:SI ("2"))
>>(asm_input:SI ("3"))
>>] ("time.c") 201))
>>(set (reg:SI 14 t6)
>>(asm_operands (".set push
>>.set noat
>>.set noreorder
>>b 1f
>>li %4,0x21
>>0:
>>sll $1,%0,0x1
>>srl %3,%0,0x1f
>>or %0,$1,$2
>>sll %1,%1,0x1
>>sll %2,%2,0x1
>>1:
>>bnez %3,2f
>>sltu $2,%0,%z5
>>bnez $2,3f
>>2:
>>addiu %4,%4,-1
>>subu %0,%0,%z5
>>addiu %2,%2,1
>>3:
>>bnez %4,0b
>>srl $2,%1,0x1f
>>.set pop") ("=&r") 4[
>>(reg/v:SI 4 a0)
>>(reg:SI 8 t0)
>>(reg:DI 6 a2)
>>(reg/v:SI 5 a1)
>>(reg:SI 9 t1)
>>]
>>[
>>(asm_input:SI ("Jr"))
>>(asm_input:SI ("0"))
>>(asm_input:DI ("1"))
>>(asm_input:SI ("2"))
>>(asm_input:SI ("3"))
>>] ("time.c") 201))
>>(clobber (reg:QI 2 v0))
>>(clobber (reg:QI 1 at))
>>] ) -1 (insn_list:REG_DEP_OUTPUT 13 (insn_list 38 (insn_list 53 (insn_list
>>51 (insn_list 41 (nil))))))
>>(nil))
>>time.c:225: confused by earlier errors, bailing out
>>make[1]: *** [time.o] Error 1
>>make[1]: Leaving directory `/home/hli/linux/arch/mips/kernel'
>>make: *** [_dir_arch/mips/kernel] Error 2
>>----------------------------------------------------------------------------
>>---------------------------------
>>
