Received:  by oss.sgi.com id <S553712AbRAEPHM>;
	Fri, 5 Jan 2001 07:07:12 -0800
Received: from router.isratech.ro ([193.226.114.69]:14344 "EHLO
        router.isratech.ro") by oss.sgi.com with ESMTP id <S553688AbRAEPGv>;
	Fri, 5 Jan 2001 07:06:51 -0800
Received: from isratech.ro (calin.cs.tuiasi.ro [193.231.15.163])
	by router.isratech.ro (8.10.2/8.10.2) with ESMTP id f05ESRl08255
	for <linux-mips@oss.sgi.com>; Fri, 5 Jan 2001 16:28:28 +0200
Message-ID: <3A56483D.17B57BD5@isratech.ro>
Date:   Fri, 05 Jan 2001 17:18:37 -0500
From:   Nicu Popovici <octavp@isratech.ro>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.15-2.5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: Kernel compile error.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello to you all,

I have the folowing cross toolchain ( binutils-2.10.1, egcs-1.0.3a , and
glibc-2.0.6) and I can crosscompile some c c++ files on my intel machine
and run the executables on the mips. BUT I can not cross compile the
kernel for mips. I get the following error

=======================================================================
/crossdev/bin/mips-linux-gcc -D__KERNEL__
-I/home/nicu/JUNGO/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer  -mno-split-addresses -D__SMP__ -pipe  -c -o
init/main.o init/main.c
/home/nicu/JUNGO/linux/include/asm/io.h: In function `copro_timeout':
/home/nicu/JUNGO/linux/include/asm/io.h:87: `asm' operand requires
impossible reload
/home/nicu/JUNGO/linux/include/asm/io.h:87: `asm' operand requires
impossible reload
/home/nicu/JUNGO/linux/include/asm/bugs.h: In function `check_fpu':
In file included from init/main.c:34:
/home/nicu/JUNGO/linux/include/asm/bugs.h:137: internal error--insn does
not satisfy its constraints:
(insn 244 241 250 (set (reg:SI 66 accum)
        (reg:SI 6 a2)) 170 {movsi_internal2} (insn_list 241
(insn_list:REG_DEP_ANTI 98 (insn_list:REG_DEP_OUTPUT 138
(insn_list:REG_DEP_ANTI 247 (insn_list:REG_DEP_ANTI 150 (nil))))))
            (nil))
            mips-linux-gcc: Internal compiler error: program cc1 got
fatal signal 6
            make: *** [init/main.o] Error 1
            [nicu@ares linux]$ {standard input}: Assembler messages:
            {standard input}:47: Error: unrecognized opcode `movl
%cr0,$2'
            {standard input}:52: Error: unrecognized opcode `movl
$2,%cr0'
            {standard input}:100: Error: unrecognized opcode `andl
%esp,$5'
            {standard input}:108: Error: unrecognized opcode `outb
accum,$7'
            {standard input}:109: Error: unrecognized opcode `outb
%al,$0x80'
            {standard input}:114: Error: unrecognized opcode `outb
accum,$7'
=======================================================================

I have to mention that egcs and glibc are tested and I know for sure
that this one are good.

Does anyone know something related to this ?

Regards,
Octav
