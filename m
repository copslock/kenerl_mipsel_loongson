Received:  by oss.sgi.com id <S553661AbRAEBuS>;
	Thu, 4 Jan 2001 17:50:18 -0800
Received: from mailhost.taec.com ([209.243.128.33]:978 "EHLO
        mailhost.taec.toshiba.com") by oss.sgi.com with ESMTP
	id <S553655AbRAEBuC>; Thu, 4 Jan 2001 17:50:02 -0800
Received: from hdqmta.taec.toshiba.com (hdqmta [209.243.180.59])
	by mailhost.taec.toshiba.com (8.8.8+Sun/8.8.8) with ESMTP id RAA15176
	for <linux-mips@oss.sgi.com>; Thu, 4 Jan 2001 17:49:55 -0800 (PST)
Subject: questions on the cross-compiler
To:     linux-mips@oss.sgi.com
X-Mailer: Lotus Notes Release 5.0.3  March 21, 2000
Message-ID: <OF18BF3A5F.CC36E93C-ON882569CB.00031ABE@taec.toshiba.com>
From:   Lisa.Hsu@taec.toshiba.com
Date:   Thu, 4 Jan 2001 17:44:36 -0800
X-MIMETrack: Serialize by Router on HDQMTA/TOSHIBA_TAEC(Release 5.0.5 |September 22, 2000) at
 01/04/2001 05:48:41 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Dear All,

I am working on our TX39xx(32-bit MIPS) reference board .  The problem
occurs in the assembly code generation for "la" instruction.

The line,  "la t3, mips_cputype" ,  generated the following two assembly
codes:

     lui          $t3,0x8019
     daddiu   $t3,$t3,14712    <---- my system crashed at this 64-bit
instruction

I would like to know why the "daddiu" instruction is generated instead of
"addiu" for MIP1 code.

The following lists my development environment:
1. Cross compiler:  binutils-mips-linux-2.8.1-1.i386 and
egcs-mips-linux-1.0.3a-2.i386
2. Linux Kernel source:  linux-2.2.13-20000211
3. The gcc command line display by specify -v option:

gcc version egcs-2.90.29 980515 (egcs-1.0.3 release)
/usr/lib/gcc-lib/mips-linux/egcs-2.90.29/cpp -lang-asm -v
-I/work/adhawk/linux-2.2.13-20000211/include -undef -$ -D__ELF__ -D__PIC__
-D__pic__ -Dunix -Dmips -DR3000 -DMIPSEB -Dlinux -D__ELF__ -D__PIC__
-D__pic__ -D__unix__ -D__mips__ -D__R3000__ -D__MIPSEB__ -D__linux__
-D__unix -D__mips -D__R3000 -D__MIPSEB -D__linux -Asystem(linux)
-Asystem(posix) -Acpu(mips) -Amachine(mips) -D__ASSEMBLER__ -D__OPTIMIZE__
-Wall -Wstrict-prototypes -D__LANGUAGE_ASSEMBLY -D_LANGUAGE_ASSEMBLY
-DLANGUAGE_ASSEMBLY -D__SIZE_TYPE__=unsigned int -D__PTRDIFF_TYPE__=int
-D_MIPS_FPSET=16 -D_MIPS_ISA=_MIPS_ISA_MIPS1 -D_MIPS_SIM=_MIPS_SIM_ABI32
-D_MIPS_SZINT=32 -D__SIZE_TYPE__=unsigned int -D__SSIZE_TYPE__=int
-D__PTRDIFF_TYPE__=int -D_MIPS_SZLONG=32 -D_MIPS_SZPTR=32 -D_MIPS_SZLONG=32
-D_MIPS_SZPTR=32 -U__mips64 -U__PIC__ -U__pic__ -D__KERNEL__ -DADHAWK
head.S

I am quite new to the Linux world.  There are definitely something that I
did not setup properly.  If anyone know the reason, your help is highly
appreciated.  Also, what are the latest and stable tool-chain for MIP1
big-endian development?

Thanks,

Lisa Hsu

Multimedia Application Group
TAEC, Toshiba
408-526-2771
lisa.hsu@taec.toshiba.com
