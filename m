Received:  by oss.sgi.com id <S553688AbRAEUhO>;
	Fri, 5 Jan 2001 12:37:14 -0800
Received: from mailhost.taec.com ([209.243.128.33]:11908 "EHLO
        mailhost.taec.toshiba.com") by oss.sgi.com with ESMTP
	id <S553669AbRAEUhB>; Fri, 5 Jan 2001 12:37:01 -0800
Received: from hdqmta.taec.toshiba.com (hdqmta [209.243.180.59])
	by mailhost.taec.toshiba.com (8.8.8+Sun/8.8.8) with ESMTP id MAA11598
	for <linux-mips@oss.sgi.com>; Fri, 5 Jan 2001 12:36:54 -0800 (PST)
Subject: Re: questions on the cross-compiler
To:     linux-mips@oss.sgi.com
X-Mailer: Lotus Notes Release 5.0.3  March 21, 2000
Message-ID: <OFA30D3318.A1194F94-ON882569CB.006FF5E7@taec.toshiba.com>
From:   Lisa.Hsu@taec.toshiba.com
Date:   Fri, 5 Jan 2001 12:31:31 -0800
X-MIMETrack: Serialize by Router on HDQMTA/TOSHIBA_TAEC(Release 5.0.5 |September 22, 2000) at
 01/05/2001 12:35:39 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing



With the help from Kevin Kissell,  I've found out that  the compilation
directives "set .mips3[4]" were turned on before cpu_probe() and cpu_probe
() functions in my head.S file.  This is the reason why I've got that wrong
code generated although I've specified mip1 in the gcc options.

I 've temporarily used #define to add "set .mips1" in the code to fix the
problem.   My question now,  is: how can we make the kernel code flexible
to free from the problem of the one that I've got?

Thanks,

Lisa



                                                                                                                   
                    "Kevin D.                                                                                      
                    Kissell"             To:     <Lisa.Hsu@taec.toshiba.com>                                       
                    <kevink@mips.        cc:                                                                       
                    com>                 Subject:     Re: questions on the cross-compiler                          
                                                                                                                   
                    01/05/01                                                                                       
                    11:14 AM                                                                                       
                                                                                                                   
                                                                                                                   




> Thanks so much for replying my email.   From the specs file, I did see
> -U__mips64 which means it was undefined.

But undefining the symbol __mips64 is not really the same
thing as setting the internal compiler state to generate mips1,
mips2, or whatever.  In assembler code, one can generally
control this with something like ".set mips1"  or "set .mips1"
(I forget the semantics), but I didn't think that the code generator
or assembler paid any attention to __mips64 or any other
compile-time symbol.

> We have another reference board uses the same processor but is running in
> little-endian.  I've checked the gcc -v output on it and compare with
mine.
> The options are the same but it correctly generated "addiu" instruction
> instead of the wrong "daddiu" instruction.   I've tried to configure to
> little-endian and re-compiled.  The result of the "la" instruction still
> the same.  So the tool chain is not the problem.

At some level, there is an option being fed to the tool
chain in one environment that is not being supplied in
the other.  The behavior you are seeing is completely
correct behavior for 64-bit code generation, but 64-bit
is not normally the default.  *Something* is turning it on,
either in the gcc specs, a makefile or make-include file,
or in the source code itself.  It's not out of the question,
by the way, that your source code is really doing this
to you.  Is there a "mips3" or "mips4" string anywhere
in the head.S file, or in anything it includes?  It may be
that there's some set of conditional compilation directives
such that a .mips3 directive is being turned on by mistake
for your particular platform.  It wouldn't be the first time I
came across Linux kernel code that was allegedly for MIPS
in general, but which was in fact specific to R4000-and-above
CPUs.

> The gcc -v listed out all the options as shown in my original email under
> #3.  Do you know what else I can check?

Well, you can eliminate the specs file and compiler defaults
as suspects if you just generate a file containing just the "la"
instruction  and run "gcc-mips -c foo.S" with no fancy flags,
includes, or make artifacts, and see what instructions it generates.

>
> Thanks and Best Regards,
>
> Lisa
>
>
>
>
>                     "Kevin D.
>                     Kissell"             To:
<Lisa.Hsu@taec.toshiba.com>
>                     <kevink@mips.        cc:
>                     com>                 Subject:     Re: questions on
the
cross-compiler
>
>                     01/04/01
>                     11:47 PM
>
>
>
>
>
>
> Hi Lisa,
>
> Sounds like someone has set the default compiler/assembler
> options in gcc to default to 64-bit ISA code generation, which
> is rather unusual.  Normally, the default should be "mips1",
> which is the lowest-common-denominator 32-bit ISA of the
> R2000/R3000.  The TX39 is more like MIPS II, in fact.  In
> general, in gcc this is controlled by a command line option:
>
> -mips1      R2000/3000/3081
> -mips2      R6000.  R39xx should be a subset
> -mips3      Basic 64-bit: R4x00
> -mips4      R5000/8000/10000/12000
> -mips32    New 32-bit ISA standard
> -mips64    New 64-bit ISA standard
> -mips16    Compressed ISA
>
> So you either need to figure out where in the gcc configuration
> this is being set to "mips3", "mips4", or "mips64" (check the
> specs file that you will find by running "gcc -v"), or you need
> to make -mips1 or -mips2 explicit in your makefile.
>
>             Regards,
>
>             Kevin K.
>
> ----- Original Message -----
> From: <Lisa.Hsu@taec.toshiba.com>
> To: <linux-mips@oss.sgi.com>
> Sent: Friday, January 05, 2001 2:44 AM
> Subject: questions on the cross-compiler
>
>
> >
> > Dear All,
> >
> > I am working on our TX39xx(32-bit MIPS) reference board .  The problem
> > occurs in the assembly code generation for "la" instruction.
> >
> > The line,  "la t3, mips_cputype" ,  generated the following two
assembly
> > codes:
> >
> >      lui          $t3,0x8019
> >      daddiu   $t3,$t3,14712    <---- my system crashed at this 64-bit
> > instruction
> >
> > I would like to know why the "daddiu" instruction is generated instead
of
> > "addiu" for MIP1 code.
> >
> > The following lists my development environment:
> > 1. Cross compiler:  binutils-mips-linux-2.8.1-1.i386 and
> > egcs-mips-linux-1.0.3a-2.i386
> > 2. Linux Kernel source:  linux-2.2.13-20000211
> > 3. The gcc command line display by specify -v option:
> >
> > gcc version egcs-2.90.29 980515 (egcs-1.0.3 release)
> > /usr/lib/gcc-lib/mips-linux/egcs-2.90.29/cpp -lang-asm -v
> > -I/work/adhawk/linux-2.2.13-20000211/include -undef -$ -D__ELF__
> -D__PIC__
> > -D__pic__ -Dunix -Dmips -DR3000 -DMIPSEB -Dlinux -D__ELF__ -D__PIC__
> > -D__pic__ -D__unix__ -D__mips__ -D__R3000__ -D__MIPSEB__ -D__linux__
> > -D__unix -D__mips -D__R3000 -D__MIPSEB -D__linux -Asystem(linux)
> > -Asystem(posix) -Acpu(mips) -Amachine(mips) -D__ASSEMBLER__
> -D__OPTIMIZE__
> > -Wall -Wstrict-prototypes -D__LANGUAGE_ASSEMBLY -D_LANGUAGE_ASSEMBLY
> > -DLANGUAGE_ASSEMBLY -D__SIZE_TYPE__=unsigned int -D__PTRDIFF_TYPE__=int
> > -D_MIPS_FPSET=16 -D_MIPS_ISA=_MIPS_ISA_MIPS1 -D_MIPS_SIM
=_MIPS_SIM_ABI32
> > -D_MIPS_SZINT=32 -D__SIZE_TYPE__=unsigned int -D__SSIZE_TYPE__=int
> > -D__PTRDIFF_TYPE__=int -D_MIPS_SZLONG=32 -D_MIPS_SZPTR=32
> -D_MIPS_SZLONG=3
> 2
> > -D_MIPS_SZPTR=32 -U__mips64 -U__PIC__ -U__pic__ -D__KERNEL__ -DADHAWK
> > head.S
> >
> > I am quite new to the Linux world.  There are definitely something that
I
> > did not setup properly.  If anyone know the reason, your help is highly
> > appreciated.  Also, what are the latest and stable tool-chain for MIP1
> > big-endian development?
> >
> > Thanks,
> >
> > Lisa Hsu
> >
> > Multimedia Application Group
> > TAEC, Toshiba
> > 408-526-2771
> > lisa.hsu@taec.toshiba.com
> >
> >
>
>
>
>
