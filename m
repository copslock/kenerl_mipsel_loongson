Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9CHmLI26511
	for linux-mips-outgoing; Fri, 12 Oct 2001 10:48:21 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9CHm2D26505
	for <linux-mips@oss.sgi.com>; Fri, 12 Oct 2001 10:48:02 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f9CHoWB05316;
	Fri, 12 Oct 2001 10:50:32 -0700
Message-ID: <3BC72CCC.3604FEC8@mvista.com>
Date: Fri, 12 Oct 2001 10:47:56 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hanks Li <hli@quicklogic.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Big endian problem
References: <APEOLACBIPNAFKJDDFIIIEBLCBAA.hli@quicklogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Which time.c is this?  I have seen this problem caused by mis-defined
USECS_PER_JIFFY_FRAC macro.  Look at other time.c files for the right one.  

Or better yet, upgrade your port to use the common time.c.  See
Documantation/mips/time.README file.

Jun

Hanks Li wrote:
> 
> Hi,
> 
> Has anyone tried to compile in Big Endian mode? When I compile the code in
> big endian, I got the following message. Does anybody know how to solve this
> problem? The assembler I'm using is "GNU assembler 2.11.90.0.27". I have no
> problem compiling the code in little endian at all.
> 
> Thanks
> 
> Hanshi Li
> 
> ----------------------------------------------------------------------------
> ------------------------------------
> mips-linux-gcc -I
> /home/hli/linux/include/asm/gcc -D__KERNEL__ -I/home/hli/linux/include -Wall
>  -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-ali
> asing -fno-common -G
> 0 -mno-abicalls -fno-pic -mcpu=r5000 -mips2 -Wa,--trap -pipe -DEXPORT_SYMTAB
>  -c time.c
> Assembler messages:
> Warning: The -mcpu option is deprecated. Please use -march and -mtune
> instead.
> time.c: In function `calibrate_div32_gettimeoffset':
> time.c:225: Unrecognizable insn:
> (insn 60 144 66 (parallel[
> (set (reg:SI 8 t0)
> (asm_operands (".set push
> .set noat
> .set noreorder
> b 1f
> li %4,0x21
> 0:
> sll $1,%0,0x1
> srl %3,%0,0x1f
> or %0,$1,$2
> sll %1,%1,0x1
> sll %2,%2,0x1
> 1:
> bnez %3,2f
> sltu $2,%0,%z5
> bnez $2,3f
> 2:
> addiu %4,%4,-1
> subu %0,%0,%z5
> addiu %2,%2,1
> 3:
> bnez %4,0b
> srl $2,%1,0x1f
> .set pop") ("=&r") 0[
> (reg/v:SI 4 a0)
> (reg:SI 8 t0)
> (reg:DI 6 a2)
> (reg/v:SI 5 a1)
> (reg:SI 9 t1)
> ]
> [
> (asm_input:SI ("Jr"))
> (asm_input:SI ("0"))
> (asm_input:DI ("1"))
> (asm_input:SI ("2"))
> (asm_input:SI ("3"))
> ] ("time.c") 201))
> (set (reg:SI 6 a2)
> (asm_operands (".set push
> .set noat
> .set noreorder
> b 1f
> li %4,0x21
> 0:
> sll $1,%0,0x1
> srl %3,%0,0x1f
> or %0,$1,$2
> sll %1,%1,0x1
> sll %2,%2,0x1
> 1:
> bnez %3,2f
> sltu $2,%0,%z5
> bnez $2,3f
> 2:
> addiu %4,%4,-1
> subu %0,%0,%z5
> addiu %2,%2,1
> 3:
> bnez %4,0b
> srl $2,%1,0x1f
> .set pop") ("=&r") 1[
> (reg/v:SI 4 a0)
> (reg:SI 8 t0)
> (reg:DI 6 a2)
> (reg/v:SI 5 a1)
> (reg:SI 9 t1)
> ]
> [
> (asm_input:SI ("Jr"))
> (asm_input:SI ("0"))
> (asm_input:DI ("1"))
> (asm_input:SI ("2"))
> (asm_input:SI ("3"))
> ] ("time.c") 201))
> (set (reg/v:SI 5 a1)
> (asm_operands (".set push
> .set noat
> .set noreorder
> b 1f
> li %4,0x21
> 0:
> sll $1,%0,0x1
> srl %3,%0,0x1f
> or %0,$1,$2
> sll %1,%1,0x1
> sll %2,%2,0x1
> 1:
> bnez %3,2f
> sltu $2,%0,%z5
> bnez $2,3f
> 2:
> addiu %4,%4,-1
> subu %0,%0,%z5
> addiu %2,%2,1
> 3:
> bnez %4,0b
> srl $2,%1,0x1f
> .set pop") ("=&r") 2[
> (reg/v:SI 4 a0)
> (reg:SI 8 t0)
> (reg:DI 6 a2)
> (reg/v:SI 5 a1)
> (reg:SI 9 t1)
> ]
> [
> (asm_input:SI ("Jr"))
> (asm_input:SI ("0"))
> (asm_input:DI ("1"))
> (asm_input:SI ("2"))
> (asm_input:SI ("3"))
> ] ("time.c") 201))
> (set (reg:SI 9 t1)
> (asm_operands (".set push
> .set noat
> .set noreorder
> b 1f
> li %4,0x21
> 0:
> sll $1,%0,0x1
> srl %3,%0,0x1f
> or %0,$1,$2
> sll %1,%1,0x1
> sll %2,%2,0x1
> 1:
> bnez %3,2f
> sltu $2,%0,%z5
> bnez $2,3f
> 2:
> addiu %4,%4,-1
> subu %0,%0,%z5
> addiu %2,%2,1
> 3:
> bnez %4,0b
> srl $2,%1,0x1f
> .set pop") ("=&r") 3[
> (reg/v:SI 4 a0)
> (reg:SI 8 t0)
> (reg:DI 6 a2)
> (reg/v:SI 5 a1)
> (reg:SI 9 t1)
> ]
> [
> (asm_input:SI ("Jr"))
> (asm_input:SI ("0"))
> (asm_input:DI ("1"))
> (asm_input:SI ("2"))
> (asm_input:SI ("3"))
> ] ("time.c") 201))
> (set (reg:SI 14 t6)
> (asm_operands (".set push
> .set noat
> .set noreorder
> b 1f
> li %4,0x21
> 0:
> sll $1,%0,0x1
> srl %3,%0,0x1f
> or %0,$1,$2
> sll %1,%1,0x1
> sll %2,%2,0x1
> 1:
> bnez %3,2f
> sltu $2,%0,%z5
> bnez $2,3f
> 2:
> addiu %4,%4,-1
> subu %0,%0,%z5
> addiu %2,%2,1
> 3:
> bnez %4,0b
> srl $2,%1,0x1f
> .set pop") ("=&r") 4[
> (reg/v:SI 4 a0)
> (reg:SI 8 t0)
> (reg:DI 6 a2)
> (reg/v:SI 5 a1)
> (reg:SI 9 t1)
> ]
> [
> (asm_input:SI ("Jr"))
> (asm_input:SI ("0"))
> (asm_input:DI ("1"))
> (asm_input:SI ("2"))
> (asm_input:SI ("3"))
> ] ("time.c") 201))
> (clobber (reg:QI 2 v0))
> (clobber (reg:QI 1 at))
> ] ) -1 (insn_list:REG_DEP_OUTPUT 13 (insn_list 38 (insn_list 53 (insn_list
> 51 (insn_list 41 (nil))))))
> (nil))
> time.c:225: confused by earlier errors, bailing out
> make[1]: *** [time.o] Error 1
> make[1]: Leaving directory `/home/hli/linux/arch/mips/kernel'
> make: *** [_dir_arch/mips/kernel] Error 2
> ----------------------------------------------------------------------------
> ---------------------------------
