Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9CGQYo24774
	for linux-mips-outgoing; Fri, 12 Oct 2001 09:26:34 -0700
Received: from quicklogic.com (quick1.quicklogic.com [206.184.225.224])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9CGQGD24767
	for <linux-mips@oss.sgi.com>; Fri, 12 Oct 2001 09:26:16 -0700
Received: from enghanks
	([207.81.96.51])
	by quicklogic.com; Fri, 12 Oct 2001 09:26:03 -0700
From: "Hanks Li" <hli@quicklogic.com>
To: <linux-mips@oss.sgi.com>
Subject: Big endian problem
Date: Fri, 12 Oct 2001 12:26:07 -0400
Message-ID: <APEOLACBIPNAFKJDDFIIIEBLCBAA.hli@quicklogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

Has anyone tried to compile in Big Endian mode? When I compile the code in
big endian, I got the following message. Does anybody know how to solve this
problem? The assembler I'm using is "GNU assembler 2.11.90.0.27". I have no
problem compiling the code in little endian at all.

Thanks

Hanshi Li

----------------------------------------------------------------------------
------------------------------------
mips-linux-gcc -I
/home/hli/linux/include/asm/gcc -D__KERNEL__ -I/home/hli/linux/include -Wall
 -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-ali
asing -fno-common -G
0 -mno-abicalls -fno-pic -mcpu=r5000 -mips2 -Wa,--trap -pipe -DEXPORT_SYMTAB
 -c time.c
Assembler messages:
Warning: The -mcpu option is deprecated. Please use -march and -mtune
instead.
time.c: In function `calibrate_div32_gettimeoffset':
time.c:225: Unrecognizable insn:
(insn 60 144 66 (parallel[
(set (reg:SI 8 t0)
(asm_operands (".set push
.set noat
.set noreorder
b 1f
li %4,0x21
0:
sll $1,%0,0x1
srl %3,%0,0x1f
or %0,$1,$2
sll %1,%1,0x1
sll %2,%2,0x1
1:
bnez %3,2f
sltu $2,%0,%z5
bnez $2,3f
2:
addiu %4,%4,-1
subu %0,%0,%z5
addiu %2,%2,1
3:
bnez %4,0b
srl $2,%1,0x1f
.set pop") ("=&r") 0[
(reg/v:SI 4 a0)
(reg:SI 8 t0)
(reg:DI 6 a2)
(reg/v:SI 5 a1)
(reg:SI 9 t1)
]
[
(asm_input:SI ("Jr"))
(asm_input:SI ("0"))
(asm_input:DI ("1"))
(asm_input:SI ("2"))
(asm_input:SI ("3"))
] ("time.c") 201))
(set (reg:SI 6 a2)
(asm_operands (".set push
.set noat
.set noreorder
b 1f
li %4,0x21
0:
sll $1,%0,0x1
srl %3,%0,0x1f
or %0,$1,$2
sll %1,%1,0x1
sll %2,%2,0x1
1:
bnez %3,2f
sltu $2,%0,%z5
bnez $2,3f
2:
addiu %4,%4,-1
subu %0,%0,%z5
addiu %2,%2,1
3:
bnez %4,0b
srl $2,%1,0x1f
.set pop") ("=&r") 1[
(reg/v:SI 4 a0)
(reg:SI 8 t0)
(reg:DI 6 a2)
(reg/v:SI 5 a1)
(reg:SI 9 t1)
]
[
(asm_input:SI ("Jr"))
(asm_input:SI ("0"))
(asm_input:DI ("1"))
(asm_input:SI ("2"))
(asm_input:SI ("3"))
] ("time.c") 201))
(set (reg/v:SI 5 a1)
(asm_operands (".set push
.set noat
.set noreorder
b 1f
li %4,0x21
0:
sll $1,%0,0x1
srl %3,%0,0x1f
or %0,$1,$2
sll %1,%1,0x1
sll %2,%2,0x1
1:
bnez %3,2f
sltu $2,%0,%z5
bnez $2,3f
2:
addiu %4,%4,-1
subu %0,%0,%z5
addiu %2,%2,1
3:
bnez %4,0b
srl $2,%1,0x1f
.set pop") ("=&r") 2[
(reg/v:SI 4 a0)
(reg:SI 8 t0)
(reg:DI 6 a2)
(reg/v:SI 5 a1)
(reg:SI 9 t1)
]
[
(asm_input:SI ("Jr"))
(asm_input:SI ("0"))
(asm_input:DI ("1"))
(asm_input:SI ("2"))
(asm_input:SI ("3"))
] ("time.c") 201))
(set (reg:SI 9 t1)
(asm_operands (".set push
.set noat
.set noreorder
b 1f
li %4,0x21
0:
sll $1,%0,0x1
srl %3,%0,0x1f
or %0,$1,$2
sll %1,%1,0x1
sll %2,%2,0x1
1:
bnez %3,2f
sltu $2,%0,%z5
bnez $2,3f
2:
addiu %4,%4,-1
subu %0,%0,%z5
addiu %2,%2,1
3:
bnez %4,0b
srl $2,%1,0x1f
.set pop") ("=&r") 3[
(reg/v:SI 4 a0)
(reg:SI 8 t0)
(reg:DI 6 a2)
(reg/v:SI 5 a1)
(reg:SI 9 t1)
]
[
(asm_input:SI ("Jr"))
(asm_input:SI ("0"))
(asm_input:DI ("1"))
(asm_input:SI ("2"))
(asm_input:SI ("3"))
] ("time.c") 201))
(set (reg:SI 14 t6)
(asm_operands (".set push
.set noat
.set noreorder
b 1f
li %4,0x21
0:
sll $1,%0,0x1
srl %3,%0,0x1f
or %0,$1,$2
sll %1,%1,0x1
sll %2,%2,0x1
1:
bnez %3,2f
sltu $2,%0,%z5
bnez $2,3f
2:
addiu %4,%4,-1
subu %0,%0,%z5
addiu %2,%2,1
3:
bnez %4,0b
srl $2,%1,0x1f
.set pop") ("=&r") 4[
(reg/v:SI 4 a0)
(reg:SI 8 t0)
(reg:DI 6 a2)
(reg/v:SI 5 a1)
(reg:SI 9 t1)
]
[
(asm_input:SI ("Jr"))
(asm_input:SI ("0"))
(asm_input:DI ("1"))
(asm_input:SI ("2"))
(asm_input:SI ("3"))
] ("time.c") 201))
(clobber (reg:QI 2 v0))
(clobber (reg:QI 1 at))
] ) -1 (insn_list:REG_DEP_OUTPUT 13 (insn_list 38 (insn_list 53 (insn_list
51 (insn_list 41 (nil))))))
(nil))
time.c:225: confused by earlier errors, bailing out
make[1]: *** [time.o] Error 1
make[1]: Leaving directory `/home/hli/linux/arch/mips/kernel'
make: *** [_dir_arch/mips/kernel] Error 2
----------------------------------------------------------------------------
---------------------------------
