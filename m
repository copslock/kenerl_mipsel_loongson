Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6OJDmRw005865
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Jul 2002 12:13:48 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6OJDmwx005864
	for linux-mips-outgoing; Wed, 24 Jul 2002 12:13:48 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6OJDNRw005805
	for <linux-mips@oss.sgi.com>; Wed, 24 Jul 2002 12:13:23 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6OJ7IXb029958;
	Wed, 24 Jul 2002 12:07:19 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id MAA09365;
	Wed, 24 Jul 2002 12:07:19 -0700 (PDT)
Received: from mips.com ([172.18.27.100])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g6OJ7Jb21579;
	Wed, 24 Jul 2002 21:07:19 +0200 (MEST)
Message-ID: <3D3EFC14.D8D690F0@mips.com>
Date: Wed, 24 Jul 2002 21:12:20 +0200
From: Carsten Langgaard <carstenl@mips.com>
Organization: MIPS Technologies
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux: RFC: elf_check_arch() rework
References: <Pine.GSO.3.96.1020724182704.27732L-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

We at MIPS are in the process of making an ABI spec for all this, which is the intention that should be used by the tool-vendors.
So please don't change the ELF header defines.
I don't see that is wrong with checking the ISA level, I rather have an error telling me that I can't execute a certain ISA level than eventually getting a reserved
instruction or something worse like something unpredictable.
You are obviously right about the elf_check_arch in the 64-bit part of the kernel is broken.
It's probably just be copied from the 32-bit part without changes, like a lot of the code in the 64-bit kernel is.

Hope that makes some sense.
/Carsten


"Maciej W. Rozycki" wrote:

> Hello,
>
>  After noticing I cannot run a trivial ELF64 program because of the
> EF_MIPS_ARCH_3 flag (quite a reasonable setting for a 64-bit executable,
> isn't it?), I concluded a considerable rework of elf_check_arch() is
> needed as what we currently have is inadequate.
>
>  Here is my proposal.  I think binfmt_elf.c for mips and binfmt_elf32.c
> for mips64 should accept all ELF32 binaries either with no ABI mark (as
> produced by most versions of binutils) or with a 32 (aka o32) ABI one and
> binfmt_elf.c for mips64 should accept all ELF32 binaries with an n32 ABI
> mark and all ELF64 ones (which essentially means the 64 aka n64 ABI).
> Everything else (i.e. o64 and EABIs) is rejected.  The patch adds
> necessary ELF file header flag definitions and synchronizes a few wrong
> ones to the binutils' definitions as well.
>
>  It removes the bogus check of architecture flags as they are really
> irrelevant -- the code is intended to handle executable formats and not
> execution of code.  If a user incorporates unsupported opcodes, he'll just
> get SIGILL at one moment.  We may actually check if an architecture is
> supported even no other Linux port seems to care, but then the comparison
> should be against mips_cpu.isa_level and not against hardcoded constants.
>
>  Note, this is an RFC at this stage -- I haven't tested the code
> adequately for an immediate inclusion, even if it looks obvious.  There
> should be no problems with code made with old binutils as unset flags are
> treated as (o)32.
>
>   Maciej
>
> --
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
>
> patch-mips-2.4.19-rc1-20020719-mips64-elf-2
> diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/arch/mips64/kernel/binfmt_elf32.c linux-mips-2.4.19-rc1-20020719/arch/mips64/kernel/binfmt_elf32.c
> --- linux-mips-2.4.19-rc1-20020719.macro/arch/mips64/kernel/binfmt_elf32.c      2002-06-29 03:01:44.000000000 +0000
> +++ linux-mips-2.4.19-rc1-20020719/arch/mips64/kernel/binfmt_elf32.c    2002-07-23 23:15:27.000000000 +0000
> @@ -27,8 +27,26 @@ typedef elf_greg_t elf_gregset_t[ELF_NGR
>  typedef double elf_fpreg_t;
>  typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
>
> -#define elf_check_arch(x)      \
> -       ((x)->e_machine == EM_MIPS)
> +/*
> + * This is used to ensure we don't load something for the wrong architecture.
> + */
> +#define elf_check_arch(hdr)                                            \
> +({                                                                     \
> +       int __res = 1;                                                  \
> +       struct elfhdr *__h = (hdr);                                     \
> +                                                                       \
> +       if (__h->e_machine != EM_MIPS)                                  \
> +               __res = 0;                                              \
> +       if (__h->e_ident[EI_CLASS] != ELFCLASS32)                       \
> +               __res = 0;                                              \
> +       if ((__h->e_flags & EF_MIPS_ABI2) != 0)                         \
> +               __res = 0;                                              \
> +       if (((__h->e_flags & EF_MIPS_ABI) != 0) &&                      \
> +           ((__h->e_flags & EF_MIPS_ABI) != EF_MIPS_ABI_O32))          \
> +               __res = 0;                                              \
> +                                                                       \
> +       __res;                                                          \
> +})
>
>  #define TASK32_SIZE            0x80000000UL
>  #undef ELF_ET_DYN_BASE
> diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/include/asm-mips/elf.h linux-mips-2.4.19-rc1-20020719/include/asm-mips/elf.h
> --- linux-mips-2.4.19-rc1-20020719.macro/include/asm-mips/elf.h 2002-04-25 02:57:43.000000000 +0000
> +++ linux-mips-2.4.19-rc1-20020719/include/asm-mips/elf.h       2002-07-23 22:50:48.000000000 +0000
> @@ -16,10 +16,11 @@
>  #define EF_MIPS_ARCH_3      0x20000000  /* -mips3 code.  */
>  #define EF_MIPS_ARCH_4      0x30000000  /* -mips4 code.  */
>  #define EF_MIPS_ARCH_5      0x40000000  /* -mips5 code.  */
> -#define EF_MIPS_ARCH_32     0x60000000  /* MIPS32 code.  */
> -#define EF_MIPS_ARCH_64     0x70000000  /* MIPS64 code.  */
> -#define EF_MIPS_ARCH_32R2   0x80000000  /* MIPS32 code.  */
> -#define EF_MIPS_ARCH_64R2   0x90000000  /* MIPS64 code.  */
> +#define EF_MIPS_ARCH_32     0x50000000  /* MIPS32 code.  */
> +#define EF_MIPS_ARCH_64     0x60000000  /* MIPS64 code.  */
> +/* The ABI of the file. */
> +#define EF_MIPS_ABI_O32     0x00001000  /* O32 ABI.  */
> +#define EF_MIPS_ABI_O64     0x00002000  /* O32 extended for 64 bit.  */
>
>  typedef unsigned long elf_greg_t;
>  typedef elf_greg_t elf_gregset_t[ELF_NGREG];
> @@ -37,10 +38,12 @@ typedef elf_fpreg_t elf_fpregset_t[ELF_N
>                                                                         \
>         if (__h->e_machine != EM_MIPS)                                  \
>                 __res = 0;                                              \
> -       if (((__h->e_flags & EF_MIPS_ARCH) != EF_MIPS_ARCH_1) &&        \
> -           ((__h->e_flags & EF_MIPS_ARCH) != EF_MIPS_ARCH_2) &&        \
> -           ((__h->e_flags & EF_MIPS_ARCH) != EF_MIPS_ARCH_32) &&       \
> -           ((__h->e_flags & EF_MIPS_ARCH) != EF_MIPS_ARCH_32R2))       \
> +       if (__h->e_ident[EI_CLASS] != ELFCLASS32)                       \
> +               __res = 0;                                              \
> +       if ((__h->e_flags & EF_MIPS_ABI2) != 0)                         \
> +               __res = 0;                                              \
> +       if (((__h->e_flags & EF_MIPS_ABI) != 0) &&                      \
> +           ((__h->e_flags & EF_MIPS_ABI) != EF_MIPS_ABI_O32))          \
>                 __res = 0;                                              \
>                                                                         \
>         __res;                                                          \
> diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/include/asm-mips64/elf.h linux-mips-2.4.19-rc1-20020719/include/asm-mips64/elf.h
> --- linux-mips-2.4.19-rc1-20020719.macro/include/asm-mips64/elf.h       2002-07-22 08:49:30.000000000 +0000
> +++ linux-mips-2.4.19-rc1-20020719/include/asm-mips64/elf.h     2002-07-23 23:12:28.000000000 +0000
> @@ -9,21 +9,23 @@
>  #include <asm/ptrace.h>
>  #include <asm/user.h>
>
> -#ifndef ELF_ARCH
> -/* ELF register definitions */
> -#define ELF_NGREG      45
> -#define ELF_NFPREG     33
> -
> -/* ELF header e_flags defines. MIPS architecture level. */
> +/* ELF header e_flags defines. */
> +/* MIPS architecture level. */
>  #define EF_MIPS_ARCH_1      0x00000000  /* -mips1 code.  */
>  #define EF_MIPS_ARCH_2      0x10000000  /* -mips2 code.  */
>  #define EF_MIPS_ARCH_3      0x20000000  /* -mips3 code.  */
>  #define EF_MIPS_ARCH_4      0x30000000  /* -mips4 code.  */
>  #define EF_MIPS_ARCH_5      0x40000000  /* -mips5 code.  */
> -#define EF_MIPS_ARCH_32     0x60000000  /* MIPS32 code.  */
> -#define EF_MIPS_ARCH_64     0x70000000  /* MIPS64 code.  */
> -#define EF_MIPS_ARCH_32R2   0x80000000  /* MIPS32 code.  */
> -#define EF_MIPS_ARCH_64R2   0x90000000  /* MIPS64 code.  */
> +#define EF_MIPS_ARCH_32     0x50000000  /* MIPS32 code.  */
> +#define EF_MIPS_ARCH_64     0x60000000  /* MIPS64 code.  */
> +/* The ABI of the file. */
> +#define EF_MIPS_ABI_O32     0x00001000  /* O32 ABI.  */
> +#define EF_MIPS_ABI_O64     0x00002000  /* O32 extended for 64 bit.  */
> +
> +#ifndef ELF_ARCH
> +/* ELF register definitions */
> +#define ELF_NGREG      45
> +#define ELF_NFPREG     33
>
>  typedef unsigned long elf_greg_t;
>  typedef elf_greg_t elf_gregset_t[ELF_NGREG];
> @@ -41,14 +43,9 @@ typedef elf_fpreg_t elf_fpregset_t[ELF_N
>                                                                         \
>         if (__h->e_machine != EM_MIPS)                                  \
>                 __res = 0;                                              \
> -       if (sizeof(elf_caddr_t) == 8 &&                                 \
> -           __h->e_ident[EI_CLASS] == ELFCLASS32)                       \
> -               __res = 0;                                              \
> -       if (((__h->e_flags & EF_MIPS_ARCH) != EF_MIPS_ARCH_1) &&        \
> -           ((__h->e_flags & EF_MIPS_ARCH) != EF_MIPS_ARCH_2) &&        \
> -           ((__h->e_flags & EF_MIPS_ARCH) != EF_MIPS_ARCH_32) &&       \
> -           ((__h->e_flags & EF_MIPS_ARCH) != EF_MIPS_ARCH_32R2))       \
> -                __res = 0;                                             \
> +       if ((__h->e_ident[EI_CLASS] == ELFCLASS32) &&                   \
> +           ((__h->e_flags & EF_MIPS_ABI2) == 0))                       \
> +               __res = 0;                                              \
>                                                                         \
>         __res;                                                          \
>  })
> diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020719.macro/include/linux/elf.h linux-mips-2.4.19-rc1-20020719/include/linux/elf.h
> --- linux-mips-2.4.19-rc1-20020719.macro/include/linux/elf.h    2002-07-22 08:49:30.000000000 +0000
> +++ linux-mips-2.4.19-rc1-20020719/include/linux/elf.h  2002-07-23 22:18:54.000000000 +0000
> @@ -37,6 +37,9 @@ typedef __s64 Elf64_Sxword;
>  #define EF_MIPS_NOREORDER 0x00000001
>  #define EF_MIPS_PIC       0x00000002
>  #define EF_MIPS_CPIC      0x00000004
> +#define EF_MIPS_ABI2      0x00000020
> +#define EF_MIPS_32BITMODE 0x00000100
> +#define EF_MIPS_ABI       0x0000f000
>  #define EF_MIPS_ARCH      0xf0000000
>
>  /* These constants define the different elf file types */
