Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 04:23:15 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:50442 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491780AbZKWDXH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Nov 2009 04:23:07 +0100
Received: by pzk35 with SMTP id 35so3701068pzk.22
        for <linux-mips@linux-mips.org>; Sun, 22 Nov 2009 19:22:58 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:cc:content-type
         :content-transfer-encoding;
        bh=uspWXEk4iGOz8b37b9axk0o0oTjTB71ezTkFmCfxPXU=;
        b=bThxn9uCxcs96d08ipoeiPxZrD/6+idr/ZanJaFxveOzXPmbG6eATRCLmBvFAMOTQo
         TMX/AE0CIudOeeoepG1NFLBeSDiCiGKYkeLoynD7TcqGORI8O7hNZagFP2eDvAxSoPXL
         GuQu6GjVZeIJ+RoktPpznAzutWrm2ybjz5tcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:cc
         :content-type:content-transfer-encoding;
        b=xQtPTYH2YSSGB2SLjd1u1lMfKLiMUO3aKNTJOGhw2RNFUv+kMs2n5fwO2B8+iDqOaL
         E2I9c6VTZReMH0zBX7SbQ/44aF0eAbeQhnUXFPH1Kf63XTzAUQ5BuNPAVsb1ondiZGzL
         8YmMnR1ql5c3hJ3JDXXy3UzJg0vViEDrtm7Ww=
MIME-Version: 1.0
Received: by 10.142.249.6 with SMTP id w6mt564626wfh.346.1258946578158; Sun, 
	22 Nov 2009 19:22:58 -0800 (PST)
In-Reply-To: <3a665c760911220846n5fcc8130p79967f4d20e8d13d@mail.gmail.com>
References: <3a665c760911190746ke7ef6bfx978d8435e447c466@mail.gmail.com>
	 <4B0697E8.7000400@redhat.com>
	 <3a665c760911220846n5fcc8130p79967f4d20e8d13d@mail.gmail.com>
Date:	Mon, 23 Nov 2009 11:22:58 +0800
Message-ID: <3a665c760911221922o1189356dxdeb7c9f3e3e44c0a@mail.gmail.com>
Subject: Re: some questions about ld conection?
From:	loody <miloody@gmail.com>
Cc:	binutils@sourceware.org,
	Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
To:	unlisted-recipients:; (no To-header on input)
Return-Path: <miloody@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25045
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Nick:
Hi all:

2009/11/23 loody <miloody@gmail.com>:
> Hi Nick:
> Hi all:
>
> thanks for your kind reply ^^
> 2009/11/20 Nick Clifton <nickc@redhat.com>:
>> Hi miloody,
>>
>>> 1. How gcc know where ld is?
>>
>> Check out the "Directory Options" part of the gcc documentation (under the
>> "Invoking GCC" section).
>>
>> If you add "-v" to your gcc command line you will see the path that gcc has
>> found to the linker executable.  (Actually you are more likely to see it
>> executing a program called "collect2" which will then go on to invoke the
>> linker).
>>
>>> As far as I know, gcc and binutils are 2 independent packages, so
>>> there must be some setting let gcc know where the ld is, right?
>>
>> They are separate packages yes, and in theory they are independent but often
>> there are quite close ties between them.  For example some features of gcc
>> might only be enabled if it is known that the assembler is gas or that the
>> linker is the binutils linker.
>>
>> Plus it is common for toolchain builders to use a combined source tree that
>> contains both the gcc and the binutils sources.  (And often sources for
>> other projects as well such as gdb or newlib).  With a combined source tree
>> it is possible to use a single configure command line to configure both gcc
>> and binutils at the same time.  In this way they are built with the same
>> expectations about where sources will be located.
>>
>>> But I cannot see the connection in my configures of binutils and gcc as
>>> below:
>>> binutils configure:
>>
>>> --prefix=/root/bare_metal/x-tools/mipsel-unknown-elf
>>
>> This option is key - it is telling gcc (the compiler driver program) the
>> root of the path it should use when trying to locate executables such as cc1
>> or the linker.
>>
>>
>>> 2. what are the difference of elf32-littlemips and elf32-tradlittlemips?
>>
>> I'll leave that one to a MIPS expert to answer.
> I have something wired and I have no idea whether it comes with these
> 2 different mips link format.
>
> 1. I have 2 mips-toolchains, tool A, one support elf32-tradlittlemips
> with gcc 3.4.4, and, tool B, another support elf32-littlemips with
> gcc4.2.1.
> 2. I compile my test program with these 2 toolchain with "-c -g "
> option, and i can see source codes embedded in *.o, the elf output I
> build.
> 3. but after I use linker to link them together, I can see the source
> codes embedded in the final ELF output with tool A build, but tool B
> cannot.
>
> I know the version of these toolchains is quite different, 4.2.1 vs 3.4.4.
> But everything seems fine before final linking, and the parameters i
> pass to ld are the same, except the output format they support.
>
> Is there any document or steps can tell me how to generate binutils
> which supports elf32-tradlittlemips such that I can do the comparison?
>
> BTW, the reason why I want to see source code is I want to debug my
> test program with ddd or cgdb such tools.
> If I cannot see the source code content but I can see the function
> name, can i sill use the above tools to debug.
> If I can do the source level debug, is there any setting or file I
> have to generate?
>
> I attach my result and commands at the end of letter for your reference.
> appreciate your help,
> miloody
>
>
> /* source codes not embedded in the elf*/
> 80000298 <main>:
> 80000298:       27bdffd8        addiu   sp,sp,-40
> 8000029c:       afbf0024        sw      ra,36(sp)
> 800002a0:       afbe0020        sw      s8,32(sp)
> 800002a4:       03a0f021        move    s8,sp
> 800002a8:       24020017        li      v0,23
> 800002ac:       afc20018        sw      v0,24(s8)
> 800002b0:       24020020        li      v0,32
> 800002b4:       afc20014        sw      v0,20(s8)
> 800002b8:       2402002c        li      v0,44
> 800002bc:       afc20010        sw      v0,16(s8)
> 800002c0:       8fc30018        lw      v1,24(s8)
> 800002c4:       8fc20014        lw      v0,20(s8)
> 800002c8:       00621821        addu    v1,v1,v0
> 800002cc:       8fc20010        lw      v0,16(s8)
> 800002d0:       00621021        addu    v0,v1,v0
> 800002d4:       afc20018        sw      v0,24(s8)
> 800002d8:       24040100        li      a0,256
> 800002dc:       0c0000d8        jal     80000360 <malloc>
> 800002e0:       00000000        nop
> 800002e4:       afc2001c        sw      v0,28(s8)
> 800002e8:       0c00009e        jal     80000278 <newline>
> 800002ec:       00000000        nop
> 800002f0:       03c0e821        move    sp,s8
> 800002f4:       8fbf0024        lw      ra,36(sp)
> 800002f8:       8fbe0020        lw      s8,32(sp)
> 800002fc:       27bd0028        addiu   sp,sp,40
>
> /*source code is embedded in elf*/
> int main()
> //int c_entry()
> {
>  90:   27bdffd8        addiu   sp,sp,-40
>  94:   afbf0024        sw      ra,36(sp)
>  98:   afbe0020        sw      s8,32(sp)
>  9c:   03a0f021        move    s8,sp
> char * point;
> int a,b,c;
> a =23;
>  a0:   24020017        li      v0,23
>  a4:   afc20018        sw      v0,24(s8)
> b = 32;
>  a8:   24020020        li      v0,32
>  ac:   afc20014        sw      v0,20(s8)
> c = 44;
>  b0:   2402002c        li      v0,44
>  b4:   afc20010        sw      v0,16(s8)
> a = a+b+c;
>  b8:   8fc30018        lw      v1,24(s8)
>  bc:   8fc20014        lw      v0,20(s8)
>  c0:   00621821        addu    v1,v1,v0
>  c4:   8fc20010        lw      v0,16(s8)
>  c8:   00621021        addu    v0,v1,v0
>  cc:   afc20018        sw      v0,24(s8)
>
> /*my commands that I can see source */
> mipsel-unknown-elf-gcc  -g -G 0 -mips32r2 -fno-omit-frame-pointer
> -fno-optimize-sibling-calls -I./include -I./device/display
> -I./device/fatfs -I./device/misc -I./device/ntstrg -I./device/ntuart
> -I./device/ntxsub -I./device/vpu
> -I/media/sdb1/newlib-1.17.0/build/mipsel/include -D_ASSEMBLER_  -c
> init.S
> mipsel-unknown-elf-gcc  -g -G 0 -mips32r2 -fno-omit-frame-pointer
> -fno-optimize-sibling-calls -I./include -I./device/display
> -I./device/fatfs -I./device/misc -I./device/ntstrg -I./device/ntuart
> -I./device/ntxsub -I./device/vpu
> -I/media/sdb1/newlib-1.17.0/build/mipsel/include -D_ASSEMBLER_  -c
> reset.S
> mipsel-unknown-elf-gcc  -g -G 0 -mips32r2 -fno-omit-frame-pointer
> -fno-optimize-sibling-calls -I./include -I./device/display
> -I./device/fatfs -I./device/misc -I./device/ntstrg -I./device/ntuart
> -I./device/ntxsub -I./device/vpu
> -I/media/sdb1/newlib-1.17.0/build/mipsel/include -c atexit.c
> mipsel-unknown-elf-gcc  -g -G 0 -mips32r2 -fno-omit-frame-pointer
> -fno-optimize-sibling-calls -I./include -I./device/display
> -I./device/fatfs -I./device/misc -I./device/ntstrg -I./device/ntuart
> -I./device/ntxsub -I./device/vpu
> -I/media/sdb1/newlib-1.17.0/build/mipsel/include -c main.c
> mipsel-unknown-elf-ld -T ./link.xn -o TestCode.elf -Map TestCode.map
> --oformat elf32-littlemips  init.o reset.o atexit.o main.o -static
> -nostdlib -L/media/sdb1/newlib-1.17.0/build/mipsel/lib
> -L/root/bare_metal/x-tools/mipsel-unknown-elf/lib/gcc/mipsel-unknown-elf/4.2.4
>  -lc -lnullmon -lgcc
> rm -f TestCode.dla
> rm -f TestCode.dnm
>
> /* commands that I cannot see source
> sde-gcc  -g -G 0 -mips32r2 -fno-omit-frame-pointer
> -fno-optimize-sibling-calls -I./include -I./device/display
> -I./device/fatfs -I./device/misc -I./device/ntstrg -I./device/ntuart
> -I./device/ntxsub -I./device/vpu
> -I/media/sdb1/newlib-1.17.0/build/mipsel/include -D_ASSEMBLER_  -c
> init.S
> sde-gcc  -g -G 0 -mips32r2 -fno-omit-frame-pointer
> -fno-optimize-sibling-calls -I./include -I./device/display
> -I./device/fatfs -I./device/misc -I./device/ntstrg -I./device/ntuart
> -I./device/ntxsub -I./device/vpu
> -I/media/sdb1/newlib-1.17.0/build/mipsel/include -D_ASSEMBLER_  -c
> reset.S
> sde-gcc  -g -G 0 -mips32r2 -fno-omit-frame-pointer
> -fno-optimize-sibling-calls -I./include -I./device/display
> -I./device/fatfs -I./device/misc -I./device/ntstrg -I./device/ntuart
> -I./device/ntxsub -I./device/vpu
> -I/media/sdb1/newlib-1.17.0/build/mipsel/include -c atexit.c
> sde-gcc  -g -G 0 -mips32r2 -fno-omit-frame-pointer
> -fno-optimize-sibling-calls -I./include -I./device/display
> -I./device/fatfs -I./device/misc -I./device/ntstrg -I./device/ntuart
> -I./device/ntxsub -I./device/vpu
> -I/media/sdb1/newlib-1.17.0/build/mipsel/include -c main.c
> sde-ld -T ./link.xn -o TestCode.elf -Map TestCode.map --oformat
> elf32-tradlittlemips  init.o reset.o atexit.o main.o -static -nostdlib
> -L/media/sdb1/newlib-1.17.0/build/mipsel/lib
> -L/root/bare_metal/x-tools/sde/lib/gcc/3.4.4/el  -lc -lnullmon -lgcc
> rm -f TestCode.dla

Below is the information I get from binutils 2.11.90 release note:
Changes from binutils 2.11.90.0.4:
1. Update from binutils 2001 0414.
2. Fix an ia64 assembler bug.
3. Change Linux/MIPS to use the SVR4 MIPS ABI instead of the IRIX ABI.
since there are no supports for the IRIX ABI in glibc. The current
Linux/MIPS targets are elf64-tradlittlemips for little endian MIPS
instead of elf32-littlemips and elf64-tradbigmips for big endian MIPS
instead of elf32-bigmips. Glibc, gcc and kernel may have to be modified
for this change.

it seems elf32-littlemips and elf32-bigmips are obsoleted.
but I still get my ld support elf32-littlemips/elf32-bigmips.
what config should I enable for support elf32-tradlittlemips/elf32-tradbigmips?
appreciate your help,
miloody
PS:
below are my configure and ld verbose
configure
/root/toolchain/targets/src/binutils-2.17/configure
--build=i486-build_pc-linux-gnu --host=i486-build_pc-linux-gnu
--target=mipsel-unknown-elf
--prefix=/root/bare_metal/x-tools/mipsel-unknown-elf --disable-nls
--disable-multilib --disable-werror --with-float=soft
--with-sysroot=/root/bare_metal/x-tools/mipsel-unknown-elf/mipsel-unknown-elf//sys-root

verbose
# ./bin/mipsel-unknown-elf-ld --verbose
GNU ld version 2.17
  Supported emulations:
   elf32elmip
using internal linker script:
==================================================
/* Script for -z combreloc: combine and sort reloc sections */
OUTPUT_FORMAT("elf32-littlemips", "elf32-bigmips",
	      "elf32-littlemips")
