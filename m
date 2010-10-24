Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Oct 2010 10:58:35 +0200 (CEST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:45114 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490981Ab0JXI6b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 Oct 2010 10:58:31 +0200
X-Authority-Analysis: v=1.1 cv=+c36koQ5Dcj/1qolKHjtkYAGXvrVJRRiKMp+84F5sLg= c=1 sm=0 a=ccXNFA_Qc9AA:10 a=IkcTkHD0fZMA:10 a=OPBmh+XkhLl+Enan7BmTLg==:17 a=meVymXHHAAAA:8 a=pGLkceISAAAA:8 a=RYkVhDcBD0PC2SrFbbkA:9 a=BM-gy0s0K0Jglb-uxQEA:7 a=FeGByzM751vzCp4v_OauajFIypAA:4 a=QEXdDO2ut3YA:10 a=jeBq3FmKZ4MA:10 a=MSl-tDqOz04A:10 a=IEuA5gfr6qax6BXO:21 a=3KitCgti1AJCMd6c:21 a=OPBmh+XkhLl+Enan7BmTLg==:117
X-Cloudmark-Score: 0
X-Originating-IP: 67.242.120.143
Received: from [67.242.120.143] ([67.242.120.143:47839] helo=[192.168.23.10])
        by hrndva-oedge03.mail.rr.com (envelope-from <rostedt@goodmis.org>)
        (ecelerity 2.2.3.46 r()) with ESMTP
        id 65/98-24070-F25F3CC4; Sun, 24 Oct 2010 08:58:24 +0000
Subject: Re: [RFC 2/2] ftrace/MIPS: Add support for C version of
 recordmcount
From:   Steven Rostedt <rostedt@goodmis.org>
To:     wu zhangjin <wuzhangjin@gmail.com>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, "John F. Reiser" <jreiser@BitWagon.com>
In-Reply-To: <AANLkTinwXjLAYACUfhLYaocHD_vBbiErLN3NjwN8JqSy@mail.gmail.com>
References: <AANLkTinwXjLAYACUfhLYaocHD_vBbiErLN3NjwN8JqSy@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Sun, 24 Oct 2010 04:58:22 -0400
Message-ID: <1287910702.16971.659.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Content-Transfer-Encoding: 8bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28217
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Sun, 2010-10-24 at 02:53 +0800, wu zhangjin wrote:
> (Add John F. Reiser in this loop)
> 
> On 10/23/10, Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Fri, 2010-10-22 at 14:10 -0700, David Daney wrote:
> >> On 10/22/2010 01:58 PM, Wu Zhangjin wrote:
> >> > From: Wu Zhangjin<wuzhangjin@gmail.com>
> >> >
> >> > In some situations(with related kernel config and gcc options), the
> >> > modules may have the same address space as the core kernel space, so
> >> > mcount_regex for modules should also match R_MIPS_26.
> >> >
> >>
> >> I think Steve is rewriting this bit to be a pure C program.  Is this
> >> file even used anymore?  If so for how long?
> >
> > It's already in mainline, but is only supported for x86 for now. Until
> > we verify that it works for other archs (which is up to you guys to
> > verify) the script will still be used.
> >
> > Also, I did not write it, John Reiser did. I just cleaned it up a bit
> > and got it working with the build system.
> 
> Just applied this tmp patch to try the basic function.
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index ce8af84..3bf1c0c 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -9,6 +9,7 @@ config MIPS
>         select HAVE_FUNCTION_TRACE_MCOUNT_TEST
>         select HAVE_DYNAMIC_FTRACE
>         select HAVE_FTRACE_MCOUNT_RECORD
> +       select HAVE_C_RECORDMCOUNT
>         select HAVE_FUNCTION_GRAPH_TRACER
>         select HAVE_KPROBES
>         select HAVE_KRETPROBES
> diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
> index 26e1271..0fb200f 100644
> --- a/scripts/recordmcount.c
> +++ b/scripts/recordmcount.c
> @@ -270,6 +270,7 @@ do_file(char const *const fname)
>         case EM_IA_64:   reltype = R_IA64_IMM64;   gpfx = '_'; break;
>         case EM_PPC:     reltype = R_PPC_ADDR32;   gpfx = '_'; break;
>         case EM_PPC64:   reltype = R_PPC64_ADDR64; gpfx = '_'; break;
> +       case EM_MIPS:    reltype = R_MIPS_26;      gpfx = '_'; break;
>         case EM_S390:    /* reltype: e_class    */ gpfx = '_'; break;
>         case EM_SH:      reltype = R_SH_DIR32;                 break;
>         case EM_SPARCV9: reltype = R_SPARC_64;     gpfx = '_'; break;
> 
> (Note: The above patch is not enough, for the modules with
> -mlong-calls, the reltype should be R_MIPS_HI16, and we may also need
> to add our specific code for sift_rel_mcount() to get the right
> location of the _mcount calling site)
> 
> but failed with the following error:
> 
> $ make ARCH=mips CROSS_COMPILE=mips64el-unknown-linux-gnu-
>   CHK     include/linux/version.h
>   CHK     include/generated/utsrelease.h
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/basic/docproc
> scripts/basic/docproc.c: In function ‘docsect’:
> scripts/basic/docproc.c:336: warning: ignoring return value of
> ‘asprintf’, declared with attribute warn_unused_result
>   Checking missing-syscalls for N32
>   CALL    scripts/checksyscalls.sh
>   Checking missing-syscalls for O32
>   CALL    scripts/checksyscalls.sh
>   CC      kernel/bounds.s
>   GEN     include/generated/bounds.h
>   CC      arch/mips/kernel/asm-offsets.s
>   GEN     include/generated/asm-offsets.h
>   CALL    scripts/checksyscalls.sh
>   CC      scripts/mod/empty.o
>   HOSTCC  scripts/mod/mk_elfconfig
>   MKELF   scripts/mod/elfconfig.h
>   HOSTCC  scripts/mod/file2alias.o
>   HOSTCC  scripts/mod/modpost.o
>   HOSTCC  scripts/mod/sumversion.o
>   HOSTLD  scripts/mod/modpost
>   HOSTCC  scripts/kallsyms
>   HOSTCC  scripts/conmakehash
>   HOSTCC  scripts/bin2c
>   HOSTCC  scripts/recordmcount
>   CC      init/main.o
> /bin/sh: line 1: 21835 Segmentation fault     scripts/recordmcount "init/main.o"
> make[1]: *** [init/main.o] Error 139
> make: *** [init] Error 2
> 
> I traced the problem and found it was triggered by the 201 line of
> scripts/recordmcount.h:
> 
> 198                 if (!mcountsym) {
> 199                         Elf_Sym const *const symp =
> 200                                 &sym0[ELF_R_SYM(_w(relp->r_info))];
> *201                         char const *symname = &str0[w(symp->st_name)];*

I merged the 32bit and 64bit here. It may be my fault on this one ;-)

I'll look into it on Monday. Thanks,

-- Steve

> 202
> 203                         if ('.' == symname[0])
> 204                                 ++symname;  /* ppc64 hack */
> 
> Exactly, it was triggered by: symp->st_name, symp is normal address,
> i.e. 0xa01831f0, but perhaps the content pointed by this address may
> not exist or is not allocated before?
> 
> Did I miss something for MIPS specific support?
> 
> By the way, because MIPS need to cope with its modules
> particularly(differ from the module):
> 
> for kernel:
> 
>     #     10:   03e0082d        move    at,ra
>     #     14:   0c000000        jal     0
>     #                    14: R_MIPS_26   _mcount           --> we
> record this for MIPS kernel
>     #                    14: R_MIPS_NONE *ABS*
>     #                    14: R_MIPS_NONE *ABS*
>     #    18:   00020021        nop
> 
> 
> for module:
> 
>     #       c:  3c030000        lui     v1,0x0
>     #                   c: R_MIPS_HI16  _mcount         --> we record
> this for MIPS module
>     #                   c: R_MIPS_NONE  *ABS*
>     #                   c: R_MIPS_NONE  *ABS*
>     #      10:  64630000        daddiu  v1,v1,0
>     #                   10: R_MIPS_LO16 _mcount
>     #                   10: R_MIPS_NONE *ABS*
>     #                   10: R_MIPS_NONE *ABS*
>     #      14:  03e0082d        move    at,ra
>     #      18:  0060f809        jalr    v1
>     #                     label:
> 
> But I found there was only one argument: /path/to/file.o passed to
> scripts/recordmount:
> 
> scripts/Makefile.build
> 
> 217 cmd_record_mcount = if [ $(@) != "scripts/mod/empty.o" ]; then
>              \
> 218                         $(objtree)/scripts/recordmcount "$(@)";
>              \
> 219                     fi;
> 220 else
> 
> So, should we pass "$(if $(part-of-module),1,0)" to the C version of
> recordmcount?
> 
> Regards,
> Wu Zhangjin
